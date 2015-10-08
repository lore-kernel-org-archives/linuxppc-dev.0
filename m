Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 545A71A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:06:53 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16D49140D8A
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:06:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:06:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F4892CE8052
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:06:49 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9846TBO45809728
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:06:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9846Giq019859
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 15:06:16 +1100
Date: Thu, 8 Oct 2015 15:05:52 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/5] powerpc/eeh: Don't unfreeze PHB PE after reset
Message-ID: <20151008040551.GA22416@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1444187529-32217-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20151007232014.GA5040@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151007232014.GA5040@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 08, 2015 at 10:20:14AM +1100, Gavin Shan wrote:
>On Wed, Oct 07, 2015 at 02:12:05PM +1100, Gavin Shan wrote:
>>On PowerNV platform, the PE is kept in frozen state until the PE
>>reset is completed to avoid recursive EEH error caused by MMIO
>>access during the period of EEH reset. The PE's frozen state is
>>cleared after BARs of PCI device included in the PE are restored
>>and enabled. However, we needn't clear the frozen state for PHB PE
>>explicitly at this point as there is no real PE for PHB PE. As the
>>PHB PE is always binding with PE#0, we actually clear PE#0, which
>>is wrong. It doesn't incur any problem though.
>>
>>This checks if the PE is PHB PE and doesn't clear the frozen state
>>if it is.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>Michael, please ignore this series for now. One or two patches are
>still missed. Also, this series needs respin.
>

v2 was just sent out. Please look at v2 instead of this one.

Thanks,
Gavin

>>---
>> arch/powerpc/kernel/eeh_driver.c | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>>index 89eb4bc..3a626ed 100644
>>--- a/arch/powerpc/kernel/eeh_driver.c
>>+++ b/arch/powerpc/kernel/eeh_driver.c
>>@@ -587,10 +587,16 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
>> 	eeh_ops->configure_bridge(pe);
>> 	eeh_pe_restore_bars(pe);
>>
>>-	/* Clear frozen state */
>>-	rc = eeh_clear_pe_frozen_state(pe, false);
>>-	if (rc)
>>-		return rc;
>>+	/*
>>+	 * If it's PHB PE, the frozen state on all available PEs should have
>>+	 * been cleared by the PHB reset. Otherwise, we unfreeze the PE and its
>>+	 * child PEs because they might be in frozen state.
>>+	 */
>>+	if (!(pe->type & EEH_PE_PHB)) {
>>+		rc = eeh_clear_pe_frozen_state(pe, false);
>>+		if (rc)
>>+			return rc;
>>+	}
>>
>> 	/* Give the system 5 seconds to finish running the user-space
>> 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
>>-- 
>>2.1.0
>>
