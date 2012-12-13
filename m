Return-Path: <anton@samba.org>
Date: Thu, 13 Dec 2012 11:43:12 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, amodra@gmail.com
Subject: [PATCH] powerpc: Avoid load of static chain register when calling
 nested functions through a pointer on 64bit
Message-ID: <20121213114312.3343d9d9@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The ppc64 ABI has a static chain register (r11) which is only used
when calling nested functions through a pointer. Considering that
we take a dim view of nested functions in the kernel, we have a lot
of unnecessary overhead here.

gcc 4.7 has an option to disable loading of r11 so lets use it.

If hell freezes over and hipsters manage to litter the kernel
with nested functions, gcc will give us an error message and
won't simply compile bad code:

    You cannot take the address of a nested function if you use
    the -mno-pointers-to-nested-functions option.

Furthermore our kernel module trampolines don't setup the static
chain register so adding this option and forcing gcc to error out
makes even more sense.

Signed-off-by: Anton Blanchard <anton@samba.org>
--- 

Index: b/arch/powerpc/Makefile
===================================================================
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -85,6 +85,7 @@ endif
 
 CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
+CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
 
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
