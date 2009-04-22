Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 755A6DE0A6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 04:38:18 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n3MIcCu2026768
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 13:38:12 -0500
Message-Id: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: removing get_immrbase()??
Date: Wed, 22 Apr 2009 13:38:12 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm not sure if we can actually get away with completely removing  
get_immrbase() but I figured I'd give everyone something to flame me  
about.  The current users are:

CPM/QE related users.

arch/powerpc/include/asm/cpm1.h:#define IMAP_ADDR		(get_immrbase())

	only used drivers/net/fs_enet/fs_enet-main.c which seems evil.

arch/powerpc/platforms/8xx/mpc885ads.h:#define CPM_MAP_ADDR		 
(get_immrbase() + MPC8xx_CPM_OFFSET)
	not used

arch/powerpc/sysdev/cpm1.c:	mpc8xx_immr = ioremap(get_immrbase(),  
0x4000);
	not sure? ideas?

arch/powerpc/include/asm/cpm2.h:#define CPM_MAP_ADDR (get_immrbase() +  
0x80000)
arch/powerpc/sysdev/cpm2.c:	cpm2_immr = ioremap(get_immrbase(),  
CPM_MAP_SIZE);
	these two are related and seem like we could look for "fsl,cpm2"

arch/powerpc/platforms/83xx/misc.c:	restart_reg_base =  
ioremap(get_immrbase() + 0x900, 0xff);
arch/powerpc/platforms/83xx/misc.c:	__be32 __iomem *spcr =  
ioremap(get_immrbase() + SPCR_OFFSET, 4);
arch/powerpc/platforms/83xx/mpc836x_mds.c:			immap =  
ioremap(get_immrbase() + 0x14a8, 8);
arch/powerpc/platforms/83xx/suspend.c:	rcw_regs =  
ioremap(get_immrbase() + IMMR_RCW_OFFSET,
arch/powerpc/platforms/83xx/suspend.c:	immrbase = get_immrbase();
arch/powerpc/platforms/83xx/usb.c:	immap = ioremap(get_immrbase(),  
0x1000);
arch/powerpc/platforms/83xx/usb.c:	immap = ioremap(get_immrbase(),  
0x1000);
arch/powerpc/platforms/83xx/usb.c:	immap = ioremap(get_immrbase(),  
0x1000);
	83xx cruft -- needs more investigation:


arch/powerpc/platforms/86xx/mpc8610_hpcd.c:	clkdvdr =  
ioremap(get_immrbase() + 0xe0800, sizeof(u32));
arch/powerpc/platforms/86xx/mpc86xx_smp.c:	mcm_vaddr =  
ioremap(get_immrbase() + MPC86xx_MCM_OFFSET,
	86xx: the first can be fixed to use guts, the second can be fixed to  
use the new "fsl,mcm" that I proposed:

arch/powerpc/sysdev/fsl_pci.c:	immr_base = get_immrbase();
	This one is a bit more problematic but can use the new "fsl,mcm-law",  
"fsl,ecm-law"

- k
