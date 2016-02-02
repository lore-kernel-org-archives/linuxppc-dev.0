Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B6DB1A0065
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 09:45:48 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 08:45:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8335F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 09:45:36 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12MjSJb59637964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 09:45:36 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12Mj3Q6019860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 09:45:04 +1100
Date: Wed, 3 Feb 2016 09:44:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com, paulus@samba.org
Subject: Re: [PATCH 1/2] powerpc/eeh: Check for EEH availability in
 eeh_add_device_early()
Message-ID: <20160202224438.GA6888@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1453234700-27593-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453234700-27593-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 19, 2016 at 06:18:19PM -0200, Guilherme G. Piccoli wrote:
>The function eeh_add_device_early() is used to perform EEH initialization in
>devices added later on the system, like in hotplug/DLPAR scenarios. Since the
>commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
>a new check was introduced in this function - Cell has no EEH capabilities
>which led to kernel oops if hotplug was performed, so checking for
>eeh_enabled() was introduced to avoid the issue.
>
>However, in architectures that EEH is present like pSeries or PowerNV, we might
>reach a case in which no PCI devices are present on boot and so EEH is not
>initialized. Then, if a device is added via DLPAR for example,
>eeh_add_device_early() fails because eeh_enabled() is false.
>
>Also, we can hit a kernel oops on pSeries arch if eeh_add_device_early() fails:
>if we have no PCI devices on machine at boot time, and then we add a PCI device
>via DLPAR operation, the function query_ddw() triggers the oops on NULL pointer
>dereference in the line "cfg_addr = edev->config_addr;". It happens because
>config_addr in edev is NULL, since the function eeh_add_device_early() was not
>completed successfully.
>
>This patch just changes the way the arch checking is done in function
>eeh_add_device_early(): we don't use eeh_enabled() anymore, but instead we
>introduce the function eeh_available() that checks the running architecture
>by using the macro machine_is(). If we are running on pSeries or PowerNV, the
>EEH mechanism is available (even if not initialized yet). This way, we don't
>try to enable EEH on Cell and we don't hit the oops on DLPAR either.
>
>Fixes: 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/eeh.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 40e4d4a..69031d7 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -1056,6 +1056,23 @@ int eeh_init(void)
> core_initcall_sync(eeh_init);
>
> /**
>+ * eeh_available - Checks for the availability of EEH based on running
>+ * architecture.
>+ *
>+ * This routine should be used in case we need to check if EEH is
>+ * available in some situation, regardless if EEH is enabled or not.
>+ * For example, if we hotplug-add a PCI device on a machine with no
>+ * other PCI device, EEH won't be enabled, yet it's available if the
>+ * arch supports it.
>+ */
>+static inline bool eeh_available(void)
>+{
>+	if (machine_is(pseries) || machine_is(powernv))
>+		return true;
>+	return false;
>+}
>+

As I was told by somebody else before, the comments for static function
needn't to be exported.

>+/**
>  * eeh_add_device_early - Enable EEH for the indicated device node
>  * @pdn: PCI device node for which to set up EEH
>  *
>@@ -1072,7 +1089,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
> 	struct pci_controller *phb;
> 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>
>-	if (!edev || !eeh_enabled())
>+	if (!edev || !eeh_available())
> 		return;
>
> 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))

The change here seems not correct enough. Before the changes, eeh_add_device_early()
does nothing if EEH is disabled on pSeries. With the changes applied, the EEH device
(edev) will be scanned even EEH is disabled on pSeries.

>From the code changes, I didn't figure out the real problem you try to fix. Cell
platform doesn't have flag EEH_PROBE_MODE_DEVTREE. So the function does nothing
on Cell platform except calling into pdn_to_eeh_dev(). I'm not sure if the kernel
crashed in pdn_to_eeh_dev() on Cell platform?

Thanks,
Gavin
