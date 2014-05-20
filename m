Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0BA1A089A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:56:14 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 21:56:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 33AF12CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:56:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4KBtqUN11206984
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:55:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4KBu7H3029544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 21:56:08 +1000
Date: Tue, 20 May 2014 21:56:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
Message-ID: <20140520115606.GB20397@shangw>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537B3B97.3020100@suse.de>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 01:25:11PM +0200, Alexander Graf wrote:
>
>On 20.05.14 10:30, Gavin Shan wrote:
>>If we detects frozen state on PE that has been passed to guest, we
>>needn't handle it. Instead, we rely on the guest to detect and recover
>>it. The patch avoid EEH event on the frozen passed PE so that the guest
>>can have chance to handle that.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>How does the guest learn about this failure? We'd need to inject an
>error into it, no?
>

When error is existing in HW level, 0xFF's will be turned on reading
PCI config space or memory BARs. Guest retrieves the failure state,
which is captured by HW automatically, via RTAS call
"ibm,read-slot-reset-state2" when seeing 0xFF's on reading PCI config
space or memory BARs. If "ibm,read-slot-reset-state2" reports errors in HW,
the guest kernel starts to recovery.

It can be called as "passive" reporting. There possible has one case that
the error can't be reported for ever: No device driver binding to the VFIO
PCI device and no access to device's config space and memory BARs. However,
it doesn't matter. As we don't use the device, we needn't detect and recover
the error at all.

>I think what you want is an irqfd that the in-kernel eeh code
>notifies when it sees a failure. When such an fd exists, the kernel
>skips its own error handling.
>

Yeah, it's a good idea and something for me to improve in phase II. We
can discuss for more later. For now, what I have in my head is something
like this:

      [ Host ] -> Error detected -> irqfd (or eventfd) -> QEMU 
                                                           |
                                   -------------(A)---------
                                   |
                        Send one EEH event to guest kernel
                                   |
                        Guest kernel starts the recovery

(A): I didn't figure out one convienent way to do the EEH event injection yet.

Thanks,
Gavin

>>---
>>  arch/powerpc/kernel/eeh.c                 | 8 ++++++++
>>  arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>index 9c6b899..6543f05 100644
>>--- a/arch/powerpc/kernel/eeh.c
>>+++ b/arch/powerpc/kernel/eeh.c
>>@@ -400,6 +400,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>>  	if (ret > 0)
>>  		return ret;
>>+	/*
>>+	 * If the PE has been passed to guest, we won't check the
>>+	 * state. Instead, let the guest handle it if the PE has
>>+	 * been frozen.
>>+	 */
>>+	if (eeh_pe_passed(pe))
>>+		return 0;
>>+
>>  	/* If we already have a pending isolation event for this
>>  	 * slot, we know it's bad already, we don't need to check.
>>  	 * Do this checking under a lock; as multiple PCI devices
>>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>index 1b5982f..03a3ed2 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>@@ -890,7 +890,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>>  				opal_pci_eeh_freeze_clear(phb->opal_id, frozen_pe_no,
>>  					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>  				ret = EEH_NEXT_ERR_NONE;
>>-			} else if ((*pe)->state & EEH_PE_ISOLATED) {
>>+			} else if ((*pe)->state & EEH_PE_ISOLATED ||
>>+				   eeh_pe_passed(*pe)) {
>>  				ret = EEH_NEXT_ERR_NONE;
>>  			} else {
>>  				pr_err("EEH: Frozen PHB#%x-PE#%x (%s) detected\n",
>
