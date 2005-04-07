Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id AF55867A6B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 03:10:28 +1000 (EST)
Date: Thu, 7 Apr 2005 10:10:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
Message-ID: <20050407171026.GO3396@smtp.west.cox.net>
References: <4240b916050404033230db0551@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4240b916050404033230db0551@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 04, 2005 at 11:32:39AM +0100, Jerome Glisse wrote:

> Once again i face an error that i got with a previous
> 2.6 kernel (i already posted about this in january
> i think).
[snip]
> Anyway what puzzle me is that it seems i am the
> only one to face this ? Am i alone :) ?

I think you're the only person building a zImage for a 32bit kernel with
a 64bit toolchain for MULTIPLATFORM, yes. :)

This is a valid problem, however.  Does the following also work for you?

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6.10/arch/ppc/boot/simple/Makefile
===================================================================
--- linux-2.6.10.orig/arch/ppc/boot/simple/Makefile
+++ linux-2.6.10/arch/ppc/boot/simple/Makefile
@@ -118,10 +118,13 @@ zimageinitrd-$(pcore)			:= zImage.initrd
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
