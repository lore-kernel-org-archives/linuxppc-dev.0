Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5076FB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 02:58:48 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 65F16DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 02:58:47 +1000 (EST)
Date: Thu, 9 Jul 2009 09:58:44 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx: add support for mpc83xx memory controller
Message-ID: <20090709165844.GB29383@ovro.caltech.edu>
References: <20090708161954.GC14979@ovro.caltech.edu>
	<3887C2A7-3566-43A9-A863-4670B039E5DA@kernel.crashing.org>
	<20090708193355.GE2827@ovro.caltech.edu>
	<6CF38C94-45EB-4FD7-B8E0-B9899F4EEF90@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6CF38C94-45EB-4FD7-B8E0-B9899F4EEF90@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 08, 2009 at 03:58:02PM -0500, Kumar Gala wrote:
>
> On Jul 8, 2009, at 2:33 PM, Ira W. Snyder wrote:
>
>> On Wed, Jul 08, 2009 at 01:09:39PM -0500, Kumar Gala wrote:
>>>
>>> On Jul 8, 2009, at 11:19 AM, Ira W. Snyder wrote:
>>>
>>>> Add support for the Freescale MPC83xx memory controller to the
>>>> existing
>>>> driver for the Freescale MPC85xx memory controller. The only
>>>> difference
>>>> between the two processors are in the CS_BNDS register parsing code.
>>>>
>>>> The L2 cache controller does not exist on the MPC83xx, but the OF
>>>> subsystem
>>>> will not use the driver if the device is not present in the OF  
>>>> device
>>>> tree.
>>>>
>>>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>>>> ---
>>>>
>>>> This was tested on an MPC8349EMDS-based board.
>>>>
>>>> I don't really like how the MCE disable works on mpc85xx (clearing  
>>>> the
>>>> HID1 register), but this can be revisited when mpc86xx support gets
>>>> added. It sucks to have this happen before the probe() routine is
>>>> called
>>>> and we know what kind of hardware we're actually running on.
>>>>
>>>> drivers/edac/Kconfig        |    6 +++---
>>>> drivers/edac/mpc85xx_edac.c |   38 +++++++++++++++++++++++++++
>>>> +----------
>>>> drivers/edac/mpc85xx_edac.h |    3 +++
>>>> 3 files changed, 34 insertions(+), 13 deletions(-)
>>>
>>> [snip]
>>>
>>>> /************************ MC SYSFS parts
>>>> ***********************************/
>>>>
>>>> @@ -738,7 +740,8 @@ static irqreturn_t mpc85xx_mc_isr(int irq, void
>>>> *dev_id)
>>>> 	return IRQ_HANDLED;
>>>> }
>>>>
>>>> -static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
>>>> +static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci,
>>>> +					  const struct of_device_id *match)
>>>> {
>>>> 	struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
>>>> 	struct csrow_info *csrow;
>>>> @@ -784,18 +787,26 @@ static void __devinit  
>>>> mpc85xx_init_csrows(struct
>>>> mem_ctl_info *mci)
>>>> 	}
>>>>
>>>> 	for (index = 0; index < mci->nr_csrows; index++) {
>>>> -		u32 start;
>>>> -		u32 end;
>>>> +		u32 start, end, extra;
>>>>
>>>> 		csrow = &mci->csrows[index];
>>>> 		cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
>>>> 				  (index * MPC85XX_MC_CS_BNDS_OFS));
>>>> -		start = (cs_bnds & 0xfff0000) << 4;
>>>> -		end = ((cs_bnds & 0xfff) << 20);
>>>> +
>>>> +		if (match->data && match->data == MPC83xx) {
>>>> +			start = (cs_bnds & 0x00ff0000) << 8;
>>>> +			end   = (cs_bnds & 0x000000ff) << 24;
>>>> +			extra = 0x00ffffff;
>>>> +		} else {
>>>> +			start = (cs_bnds & 0x0fff0000) << 4;
>>>> +			end   = (cs_bnds & 0x00000fff) << 20;
>>>> +			extra = 0x000fffff;
>>>> +		}
>>>
>>> I don't understand this at all.. The only difference between 83xx &  
>>> 85xx
>>> is that we should have an extra 4-bits for 36-bit physical addresses.
>>>
>>> We should be able to write this code in such a way that it works for
>>> both 83xx & 85xx.
>>>
>>>                start = (cs_bnds & 0xffff0000) >> 16;
>>>                end = (cs_bnds & 0xffff);
>>>
>>> 		if (start == end)
>>> 			continue;
>>> 		start <<= (20 - PAGE_SHIFT);
>>> 		end <<= (20 - PAGE_SHIFT);
>>> 		end |= (1 << (20 - PAGE_SHIFT)) - 1;
>>>
>>
>> Sorry, I don't know a thing about PAGE_SHIFT. Looking in
>> arch/powerpc/platforms/Kconfig.cputype, PPC_85xx doesn't seem to imply 
>> a
>> change in PAGE_SIZE, which changes the PAGE_SHIFT in
>> arch/powerpc/include/asm/page.h.
>>
>> Also, are you sure you cannot use 4K pages on an 85xx? If you can use 
>> 4K
>> pages on 85xx, then PAGE_SHIFT == 12, and your solution breaks.
>>
>> I admit I don't know much about all of the different powerpc  
>> platforms.
>
> PAGE_SHIFT is the same.. I was folding in the code from below the diff:
>
>                 csrow->first_page = start >> PAGE_SHIFT;
>                 csrow->last_page = end >> PAGE_SHIFT;
>
> into the calculation of start/end.  I know PAGE_SHIFT is a minimum 12 on 
> any PPC based system (and at this point its always 12 on 85xx/83xx).  The 
> idea is to ensure that when shift start/end up that it still fits in 
> 32-bits.  This is to handle the case of >4G of memory.
>

Hello Kumar,

I must not understand something going on here. Your proposed code
doesn't work at all on my board. The
/sys/devices/system/edac/mc/mc0/size_mb doesn't come out correctly.

The attached patch DOES work on my board, but I'm confident that it does
NOT work on a system with PAGE_SIZE != 4096. Any idea what I did wrong?

If I'm reading things correctly:
csrow->first_page	full address of the first page (NOT pfn)
csrow->last_page	full address of the last  page (NOT pfn)
csrow->nr_pages		number of pages

The EDAC subsystem does csrow->nr_pages * PAGE_SIZE to get the size_mb
sysfs value.

If csrow->first_page and csrow->last_page ARE supposed to be the pfn,
then I think the original code got it wrong, and the calculation for
csrow->nr_pages needs to be changed.

Thanks,
Ira


>From a442c2e5a1cfbe29ea9d2ea7d45237677ff7899d Mon Sep 17 00:00:00 2001
From: Ira W. Snyder <iws@ovro.caltech.edu>
Date: Wed, 8 Jul 2009 08:59:16 -0700
Subject: [PATCH] edac: mpc85xx: add support for mpc83xx memory controller

Add support for the Freescale MPC83xx memory controller to the existing
driver for the Freescale MPC85xx memory controller. The only difference
between the two processors are in the CS_BNDS register parsing code, which
has been changed so it will work on both processors.

The L2 cache controller does not exist on the MPC83xx, but the OF subsystem
will not use the driver if the device is not present in the OF device tree.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/edac/Kconfig        |    6 +++---
 drivers/edac/mpc85xx_edac.c |   30 ++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 4339b1a..78303f9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -176,11 +176,11 @@ config EDAC_I5100
 	  San Clemente MCH.
 
 config EDAC_MPC85XX
-	tristate "Freescale MPC85xx"
-	depends on EDAC_MM_EDAC && FSL_SOC && MPC85xx
+	tristate "Freescale MPC83xx / MPC85xx"
+	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
 	help
 	  Support for error detection and correction on the Freescale
-	  MPC8560, MPC8540, MPC8548
+	  MPC8349, MPC8560, MPC8540, MPC8548
 
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index b4f5c63..e4832b4 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -43,7 +43,9 @@ static u32 orig_pci_err_en;
 #endif
 
 static u32 orig_l2_err_disable;
+#ifdef CONFIG_MPC85xx
 static u32 orig_hid1[2];
+#endif
 
 /************************ MC SYSFS parts ***********************************/
 
@@ -790,18 +792,19 @@ static void __devinit mpc85xx_init_csrows(struct mem_ctl_info *mci)
 		csrow = &mci->csrows[index];
 		cs_bnds = in_be32(pdata->mc_vbase + MPC85XX_MC_CS_BNDS_0 +
 				  (index * MPC85XX_MC_CS_BNDS_OFS));
-		start = (cs_bnds & 0xfff0000) << 4;
-		end = ((cs_bnds & 0xfff) << 20);
-		if (start)
-			start |= 0xfffff;
-		if (end)
-			end |= 0xfffff;
+
+		start = (cs_bnds & 0xffff0000) >> 16;
+		end   = (cs_bnds & 0x0000ffff);
 
 		if (start == end)
 			continue;	/* not populated */
 
-		csrow->first_page = start >> PAGE_SHIFT;
-		csrow->last_page = end >> PAGE_SHIFT;
+		start <<= PAGE_SHIFT;
+		end   <<= PAGE_SHIFT;
+		end    |= (1 << PAGE_SHIFT) - 1;
+
+		csrow->first_page = start;
+		csrow->last_page = end;
 		csrow->nr_pages = csrow->last_page + 1 - csrow->first_page;
 		csrow->grain = 8;
 		csrow->mtype = mtype;
@@ -986,6 +989,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8560-memory-controller", },
 	{ .compatible = "fsl,mpc8568-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
+	{ .compatible = "fsl,mpc8349-memory-controller", },
 	{},
 };
 
@@ -1001,13 +1005,13 @@ static struct of_platform_driver mpc85xx_mc_err_driver = {
 		   },
 };
 
-
+#ifdef CONFIG_MPC85xx
 static void __init mpc85xx_mc_clear_rfxe(void *data)
 {
 	orig_hid1[smp_processor_id()] = mfspr(SPRN_HID1);
 	mtspr(SPRN_HID1, (orig_hid1[smp_processor_id()] & ~0x20000));
 }
-
+#endif
 
 static int __init mpc85xx_mc_init(void)
 {
@@ -1040,26 +1044,32 @@ static int __init mpc85xx_mc_init(void)
 		printk(KERN_WARNING EDAC_MOD_STR "PCI fails to register\n");
 #endif
 
+#ifdef CONFIG_MPC85xx
 	/*
 	 * need to clear HID1[RFXE] to disable machine check int
 	 * so we can catch it
 	 */
 	if (edac_op_state == EDAC_OPSTATE_INT)
 		on_each_cpu(mpc85xx_mc_clear_rfxe, NULL, 0);
+#endif
 
 	return 0;
 }
 
 module_init(mpc85xx_mc_init);
 
+#ifdef CONFIG_MPC85xx
 static void __exit mpc85xx_mc_restore_hid1(void *data)
 {
 	mtspr(SPRN_HID1, orig_hid1[smp_processor_id()]);
 }
+#endif
 
 static void __exit mpc85xx_mc_exit(void)
 {
+#ifdef CONFIG_MPC85xx
 	on_each_cpu(mpc85xx_mc_restore_hid1, NULL, 0);
+#endif
 #ifdef CONFIG_PCI
 	of_unregister_platform_driver(&mpc85xx_pci_err_driver);
 #endif
-- 
1.5.4.3
