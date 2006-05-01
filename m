Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 12448679E7
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 May 2006 17:11:55 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: Linux 2.6 sources for MPC852T processor
Date: Mon, 1 May 2006 09:14:36 +0200
References: <20060426025008.C8A7D773@resin02.mta.everyone.net>
	<0606BE3C-7751-4E71-B724-FEFE2FF252C8@embeddededge.com>
	<20060430165325.GB4631@dmt>
In-Reply-To: <20060430165325.GB4631@dmt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605010914.36728.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I did the following:

 $ patch -p1 <tlbfix-mt.patch

(This is the patch you sent me)

 $ cg-seek v2.6.16
 Warning: uncommitted local changes, trying to bring them along
 patching file arch/ppc/8xx_io/Kconfig
 patching file arch/ppc/8xx_io/Makefile
 The next patch would create the file arch/ppc/8xx_io/cpm_spi.c,
 which already exists!  Skipping patch.
 1 out of 1 hunk ignored -- saving rejects to file 
arch/ppc/8xx_io/cpm_spi.c.rej
 patching file arch/ppc/Kconfig
 Hunk #2 succeeded at 927 (offset -16 lines).
 patching file arch/ppc/kernel/head_8xx.S
 patching file arch/ppc/platforms/Makefile
 Hunk #1 succeeded at 37 (offset -1 lines).
 The next patch would create the file arch/ppc/platforms/prtppc.h,
 which already exists!  Skipping patch.
 1 out of 1 hunk ignored -- saving rejects to file 
arch/ppc/platforms/prtppc.h.rej
 The next patch would create the file arch/ppc/platforms/prtppc_serial.h,
 which already exists!  Skipping patch.
 1 out of 1 hunk ignored -- saving rejects to file 
arch/ppc/platforms/prtppc_serial.h.rej
 The next patch would create the file arch/ppc/platforms/prtppc_setup.c,
 which already exists!  Skipping patch.
 1 out of 1 hunk ignored -- saving rejects to file 
arch/ppc/platforms/prtppc_setup.c.rej
 patching file arch/ppc/syslib/m8xx_setup.c
 patching file drivers/input/keyboard/Kconfig
 patching file drivers/input/keyboard/Makefile
 patching file drivers/usb/Kconfig
 patching file drivers/usb/host/isp116x.h
 patching file drivers/video/Kconfig
 patching file drivers/video/Makefile
 The next patch would create the file include/asm-ppc/cpm_spi.h,
 which already exists!  Skipping patch.
 1 out of 1 hunk ignored -- saving rejects to file 
include/asm-ppc/cpm_spi.h.rej
 patching file include/asm-ppc/mpc8xx.h
 patching file include/asm-ppc/ppc_sys.h
 patching file include/asm-ppc/serial.h
 Adding file arch/ppc/8xx_io/cpm_spi.c
 Adding file arch/ppc/platforms/prtppc.h
 Adding file arch/ppc/platforms/prtppc_serial.h
 Adding file arch/ppc/platforms/prtppc_setup.c
 Adding file include/asm-ppc/cpm_spi.h
 On commit 7705a8792b0fc82fd7d4dd923724606bbfd9fb20

All the abve is BSP stuff and drivers for our board, plus macrelo's patch.
To verify, I did:

 $ cg-diff arch/ppc/kernel/head_8xx.S

 diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
 --- a/arch/ppc/kernel/head_8xx.S
 +++ b/arch/ppc/kernel/head_8xx.S
 @@ -357,9 +357,7 @@ InstructionTLBMiss: 
 
         . = 0x1200
  DataStoreTLBMiss:
 -#ifdef CONFIG_8xx_CPU6
         stw     r3, 8(r0)
 -#endif
         DO_8xx_CPU6(0x3f80, r3)
         mtspr   SPRN_M_TW, r10  /* Save a couple of working registers */
         mfcr    r10
 @@ -419,9 +417,7 @@ DataStoreTLBMiss:
         lwz     r11, 0(r0)
         mtcr    r11
         lwz     r11, 4(r0)
 -#ifdef CONFIG_8xx_CPU6
         lwz     r3, 8(r0)
 -#endif
         rfi 
 
  /* This is an instruction TLB error on the MPC8xx.  This could be due
  
Looks good.

 $ make uImage

Kernel doesn't boot, no output produced :-(

Greetings,

-- 
David Jander
