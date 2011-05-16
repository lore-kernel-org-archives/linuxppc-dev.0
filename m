Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2613B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 02:21:59 +1000 (EST)
Received: from mail56-tx2 (localhost.localdomain [127.0.0.1])	by
	mail56-tx2-R.bigfish.com (Postfix) with ESMTP id 9C91112580A3	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2011 16:21:48 +0000 (UTC)
Received: from TX2EHSMHS021.bigfish.com (unknown [10.9.14.246])	by
	mail56-tx2.bigfish.com (Postfix) with ESMTP id B24BBB50053	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2011 16:21:45 +0000 (UTC)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
	az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	p4GGLgge027566	for
	<linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2011 11:21:42 -0500 (CDT)
Message-ID: <4DD14F15.5070902@freescale.com>
Date: Mon, 16 May 2011 11:21:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Updating the define_machine() structure at runtime?
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I would like to get some opinions on the following.

I'm working on extending our existing board definition files to support our
ePAPR reference hypervisor.  Because our hypervisor provides a virtual PIC, we
need to have different functions for define_machine() structure that related to
the PIC, but most everything else can stay the same.

define_machine(p4080_hv) {
	.name			= "P4080DS HV",
	.probe			= p4080hv_probe,
	.setup_arch		= corenet_ds_setup_arch,
	.init_IRQ		= fsl_hv_pic_init,
#ifdef CONFIG_PCI
	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
#endif
	.get_irq		= ehv_pic_get_irq,
	.restart		= fsl_hv_restart,
	.power_off		= fsl_hv_halt,
	.halt			= fsl_hv_halt,
	.calibrate_decr		= generic_calibrate_decr,
	.progress		= udbg_progress,
};

Rather than create two such structures for each board that can support the
hypervisor (one with HV support, one without), I would like to do the following
instead.  What do you all think?

define_machine(p4080_ds) {
	.name			= "P4080 DS",
	.probe			= p4080_ds_probe,
	...
	.get_irq		= mpic_get_coreint_irq,
};

static int __init p4080_ds_probe(void)
{
	...
#ifdef CONFIG_FSL_HYPERVISOR
	if (of_flat_dt_is_compatible(root, "fsl,P4080DS-hv")) {
		mach_p4080_ds.get_irq = ehv_pic_get_irq;
		...
		return 1;
	} else
		return 0;
#endif	


-- 
Timur Tabi
Linux kernel developer at Freescale
