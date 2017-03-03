Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZJNZ4Wr7zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 16:57:02 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v235reSL057835
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 00:57:00 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8dxf22-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Mar 2017 00:56:59 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 15:56:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 686F52BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 16:56:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v235uk1i53674004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 16:56:54 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v235uMrN022460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 16:56:22 +1100
Date: Fri, 3 Mar 2017 16:55:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru
Subject: Re: [PATCH] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170303044718.19253-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170303044718.19253-1-ruscur@russell.cc>
Message-Id: <20170303055557.GA32465@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 03, 2017 at 03:47:18PM +1100, Russell Currey wrote:
>eeh_handle_special_event() is called when an EEH event is detected but
>can't be narrowed down to a specific PE.  This function looks through
>every PE to find one in an erroneous state, then calls the regular event
>handler eeh_handle_normal_event() once it knows which PE has an error.
>
>However, if eeh_handle_normal_event() found that the PE cannot possibly
>be recovered, it will remove the PE and associated devices.  This leads
>to a use after free in eeh_handle_special_event() as it attempts to clear
>the "recovering" state on the PE after eeh_handle_normal_event() returns.
>
>Thus, make sure the PE is valid when attempting to clear state in
>eeh_handle_special_event().
>

>From the changelog, I don't see how the PE is free'd. Could you explain
a bit about it?

>Cc: <stable@vger.kernel.org> #3.10+
>Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
> arch/powerpc/kernel/eeh_driver.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index b94887165a10..492397298a2a 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -983,6 +983,19 @@ static void eeh_handle_special_event(void)
> 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
> 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
> 			eeh_handle_normal_event(pe);
>+
>+			/*
>+			 * eeh_handle_normal_event() can free the PE if it
>+			 * determines that the PE cannot possibly be recovered.
>+			 * Make sure the PE still exists before changing its
>+			 * state.
>+			 */
>+			if (!pe || (pe->type & EEH_PE_INVALID)
>+			    || (pe->state & EEH_PE_REMOVED)) {
>+				pr_warn("EEH: not clearing state on bad PE\n");
>+				continue;
>+			}
>+

It seems not correct. @pe has set to the valid PE in advance, the !pe is
always false? If the PE has been free'd, how can we access @pe->type here
and how can we make sure PE_INVALID and PE_REMOVED flag wasn't overwritten
by somebody else?

> 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
> 		} else {
> 			pci_lock_rescan_remove();

Cheers,
Gavin
