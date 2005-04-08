Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 99A0367B21
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 01:34:08 +1000 (EST)
Date: Fri, 8 Apr 2005 08:34:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>, Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050408153407.GZ3396@smtp.west.cox.net>
References: <4240b916050404033230db0551@mail.gmail.com>
	<20050407171026.GO3396@smtp.west.cox.net>
	<4240b91605040803137e9e7ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4240b91605040803137e9e7ddc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.6.12-rc2] ppc32: Fix building 32bit kernel for 64bit
	machines (Was: Re: linux 2.6.12-rc1-bk5 compilation error)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 08, 2005 at 11:13:19AM +0100, Jerome Glisse wrote:
> > I think you're the only person building a zImage for a 32bit kernel with
> > a 64bit toolchain for MULTIPLATFORM, yes. :)
> 
> I should move to 64bits :)
>  
> > This is a valid problem, however.  Does the following also work for you?
> 
> It partly works (correct the problem with disable_6xx_mmu)
> but i still have to the following for resolving __flush_disable_L1
> 
> I changed the makefile in arch/ppc/kernel to have this :
> obj-$(CONFIG_POWER4) += cpu_setup_power4.o
> into :
> obj-$(CONFIG_POWER4) += l2cr.o cpu_setup_power4.o

OK, I think the following is a better workaround for that (based on
arch/ppc/platforms/pmac_sleep.S):

When building a ppc32 MULTIPLATFORM kernel for a 64bit pmac, we try and
build certain files or use certain functions that make no sense in that
context.  This catches the last of these.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.orig/arch/ppc/platforms/pmac_cache.S
+++ linux-2.6/arch/ppc/platforms/pmac_cache.S
@@ -28,6 +28,9 @@
  */
 
 _GLOBAL(flush_disable_caches)
+#ifndef CONFIG_6xx
+	blr
+#else
 BEGIN_FTR_SECTION
 	b	flush_disable_745x
 END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
@@ -323,3 +326,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	mtmsr	r11		/* restore DR and EE */
 	isync
 	blr
+#endif	/* CONFIG_6xx */
--- linux-2.6.orig/arch/ppc/boot/simple/Makefile
+++ linux-2.6/arch/ppc/boot/simple/Makefile
@@ -123,10 +123,13 @@ zimageinitrd-$(pcore)			:= zImage.initrd
          end-$(pcore)			:= pcore
    cacheflag-$(pcore)			:= -include $(clear_L2_L3)
 
+# Really only valid if CONFIG_6xx=y
       zimage-$(CONFIG_PPC_PREP)		:= zImage-PPLUS
 zimageinitrd-$(CONFIG_PPC_PREP)		:= zImage.initrd-PPLUS
+ifeq ($(CONFIG_6xx),y)
      extra.o-$(CONFIG_PPC_PREP)		:= prepmap.o
         misc-$(CONFIG_PPC_PREP)		+= misc-prep.o mpc10x_memory.o
+endif
          end-$(CONFIG_PPC_PREP)		:= prep
 
          end-$(CONFIG_SANDPOINT)	:= sandpoint

-- 
Tom Rini
http://gate.crashing.org/~trini/
