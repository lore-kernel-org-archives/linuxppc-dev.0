Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgNvP3X4tzDq6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:36:49 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 10:36:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0CB7B2BB005E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:36:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u370aXYW51839178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 10:36:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u370a8nA019442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 10:36:09 +1000
Date: Thu, 7 Apr 2016 10:35:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com, ruscur@russell.cc
Subject: Re: [PATCH 1/2 v2] Revert "powerpc/eeh: Fix crash in
 eeh_add_device_early() on Cell"
Message-ID: <20160407003540.GA16777@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2016 at 09:20:04PM -0300, Guilherme G. Piccoli wrote:
>This reverts commit 89a51df5ab1d38b257300b8ac940bbac3bb0eb9b.
>
>The function eeh_add_device_early() is used to perform EEH initialization in
>devices added later on the system, like in hotplug/DLPAR scenarios. Since the
>commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
>a new check was introduced in this function - Cell has no EEH capabilities
>which led to kernel oops if hotplug was performed, so checking for
>eeh_enabled() was introduced to avoid the issue.
>
>However, in architectures that EEH is present like pSeries or PowerNV, we might
>reach a case in which no PCI devices are present on boot time and so EEH is not
>initialized. Then, if a device is added via DLPAR for example,
>eeh_add_device_early() fails because eeh_enabled() is false, and EEH end up
>not being enabled at all.
>
>This reverts the aforementioned patch since a new verification was introduced by
>the commit d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
>and so the original Cell issue does not happen anymore.
>
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/eeh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 6544017..6758484 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1068,7 +1068,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
> 	struct pci_controller *phb;
> 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>
>-	if (!edev || !eeh_enabled())
>+	if (!edev)
> 		return;
>
> 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
>-- 
>2.1.0
>
