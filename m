Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id B3B532BF23
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2005 01:52:25 +1100 (EST)
Date: Mon, 10 Jan 2005 07:52:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050110145219.GB2226@smtp.west.cox.net>
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16865.39960.274092.996530@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2005 at 08:03:20AM +1100, Paul Mackerras wrote:
> Jerome Glisse writes:
> 
> > With 2.6.10 i get a compilation error with disable_6xx_mmu
> 
> What kind of machine is this?  Could you send me your .config?
> 
> I suspect that maybe we aren't defining CONFIG_6XX for PPC970
> machines.

Indeed.  It might make most sense to do something like:

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.40/arch/ppc/boot/simple/Makefile	2005-01-03 16:49:19 -07:00
+++ edited/arch/ppc/boot/simple/Makefile	2005-01-10 07:51:34 -07:00
@@ -112,11 +112,15 @@
          end-$(pcore)			:= pcore
    cacheflag-$(pcore)			:= -include $(clear_L2_L3)
 
+# PPC_PREP can be set to y on a PPC970 configuration, which isn't a real
+# machine.
+ifeq ($(CONFIG_6xx),y)
       zimage-$(CONFIG_PPC_PREP)		:= zImage-PPLUS
 zimageinitrd-$(CONFIG_PPC_PREP)		:= zImage.initrd-PPLUS
      extra.o-$(CONFIG_PPC_PREP)		:= prepmap.o
         misc-$(CONFIG_PPC_PREP)		+= misc-prep.o mpc10x_memory.o
          end-$(CONFIG_PPC_PREP)		:= prep
+endif
 
          end-$(CONFIG_SANDPOINT)	:= sandpoint
    cacheflag-$(CONFIG_SANDPOINT)	:= -include $(clear_L2_L3)

-- 
Tom Rini
http://gate.crashing.org/~trini/
