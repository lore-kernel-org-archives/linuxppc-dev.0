Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRW5h5VlCzDvfJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 00:35:20 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so10377159pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 05:35:20 -0800 (PST)
Date: Mon, 28 Nov 2016 00:35:05 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Kernel build issues with upstream binutils
Message-ID: <20161128003505.61590f63@roar.ozlabs.ibm.com>
In-Reply-To: <20161127090430.5039d436@kryten>
References: <20161127090430.5039d436@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 27 Nov 2016 09:04:30 +1100
Anton Blanchard <anton@samba.org> wrote:

> Hi,
> 
> A recent binutils commit:
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1a9ccd70f9a75dc6b48d340059f28ef3550c107b
> 
> has broken kernel builds:
> 
> /home/anton/gcc.install/bin/ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
> /home/anton/gcc.install/bin/ld: final link failed: Bad value
> 
> I guess we have an issue with our linker script.

We may need something like this (not boot tested). I'll have a better look
tomorrow.

---
 arch/powerpc/boot/zImage.lds.S | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 861e721..8963544 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -7,6 +7,13 @@ OUTPUT_ARCH(powerpc:common)
 #endif
 ENTRY(_zimage_start)
 EXTERN(_zimage_start)
+
+PHDRS
+{
+  text PT_LOAD FLAGS(5);          /* R_E */
+  data PT_LOAD FLAGS(6);          /* RW_ */
+}
+
 SECTIONS
 {
   .text      :
@@ -15,7 +22,7 @@ SECTIONS
     *(.text)
     *(.fixup)
     _etext = .;
-  }
+  } :text
   . = ALIGN(4096);
   .data    :
   {
@@ -25,7 +32,7 @@ SECTIONS
 #ifndef CONFIG_PPC64_BOOT_WRAPPER
     *(.got2)
 #endif
-  }
+  } :data
   .dynsym : { *(.dynsym) }
   .dynstr : { *(.dynstr) }
   .dynamic :
@@ -34,7 +41,6 @@ SECTIONS
     *(.dynamic)
   }
   .hash : { *(.hash) }
-  .interp : { *(.interp) }
   .rela.dyn :
   {
 #ifdef CONFIG_PPC64_BOOT_WRAPPER
@@ -86,4 +92,9 @@ SECTIONS
     *(COMMON)
     _end = . ;
   }
+
+  /DISCARD/ :
+  {
+    *(.interp)
+  }
 }
-- 
2.10.2
