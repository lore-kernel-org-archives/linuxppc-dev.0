Date: Mon, 10 Jul 2000 16:48:21 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: toa@pop.agri.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
In-Reply-To: <20000710160513.21541@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000710164335.14195C-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Jul 2000, Benjamin Herrenschmidt wrote:

> >
> >It doesn't compile per se, in pmac_backlight.c asm/pmu.h & asm/adb.h
> >should be linux/pmu.h & linux/adb.h. This isn't a tragedy.
>
> That's strange, it did compile for me without I push. Looks like bk
> didn't push the latest version, or something got screwed up... I'll check
> that tonight.

Why is pmac_backlight.c compiled in for CONFIG_ALL_PPC?  Isn't it
PowerBook only thing?

>
> >More problems I get on booting on a wallstreet I. A panic occurs in
> >combination with mesh. Have to figure out. I removed mesh and 53c94 from
> >the kernel and now it boots.
> >
> >A patched 7200 fails completely to boot, it stops on displaying
> >'booting....'. This kernel is patched with mftb patch from Takashi,
> >pci-resource & serial-console patch from Michel. (Otherwise a 7200 would
> >not boot)
> >
> >In the sccstool I read in prom.c Calc BAT..... this may cause trouble if
> >the framebuffer is really badly aligned.......
> >TODO: Check 601 case...
> >
> >How can I help?
>
> Well, you can check disabling that (and the call that sets up this BAT in
> head.S) but don't forget, if you do that, to also declare
> bootx_text_mapped to 0 before leaving prom.c

601's BAT doesn't have G bit.  Maybe that's the problem?


Takashi Oe


--- linuxppc_2_3-vanilla/arch/ppc/kernel/Makefile	Mon Jul 10 02:18:42 2000
+++ linuxppc_2_3-nubus/arch/ppc/kernel/Makefile	Mon Jul 10 05:53:54 2000
@@ -55,7 +55,7 @@
 endif

 ifdef CONFIG_PMAC_PBOOK
-O_OBJS += sleep.o
+O_OBJS += sleep.o pmac_backlight.o
 endif

 ifdef CONFIG_SMP
@@ -99,8 +99,7 @@
 ifeq ($(CONFIG_ALL_PPC),y)
   O_OBJS += pmac_pic.o pmac_setup.o pmac_time.o feature.o pmac_pci.o prom.o \
 	chrp_setup.o chrp_time.o chrp_pci.o open_pic.o indirect_pci.o \
-	prep_pci.o i8259.o prep_nvram.o prep_time.o residual.o \
-	pmac_backlight.o
+	prep_pci.o i8259.o prep_nvram.o prep_time.o residual.o
   OX_OBJS += prep_setup.o
 endif
 ifeq ($(CONFIG_GEMINI),y)
--- linuxppc_2_3-vanilla/arch/ppc/kernel/prom.c	Mon Jul 10 02:18:43 2000
+++ linuxppc_2_3-nubus/arch/ppc/kernel/prom.c	Mon Jul 10 05:51:03 2000
@@ -867,7 +925,7 @@
 	} else {
 		/* 601 */
 		addr &= 0xFF800000UL;
-		RELOC(disp_BATU) = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | PP_RWXX) | 4;
+		RELOC(disp_BATU) = addr | (_PAGE_NO_CACHE | PP_RWXX) | 4;
 		RELOC(disp_BATL) = addr | BL_8M | 0x40;
 		// -- todo
 	}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
