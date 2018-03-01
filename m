Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsDgk2RgyzF1dj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 12:02:55 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id h19so874947pfd.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 17:02:54 -0800 (PST)
Date: Wed, 28 Feb 2018 17:02:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] powerpc: Keep const vars out of writable .sdata
Message-ID: <20180301010249.GA18370@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>

Newer gcc will support "-mno-readonly-in-sdata"[1], which makes sure that
the optimization on PPC32 for variables getting moved into the .sdata
section will not apply to const variables (which must be in .rodata).

This was originally noticed in mm/rodata_test.c when rodata_test_data
was not static:

c0695034 g     O .data	00000004 rodata_test_data

After this patch with an updated compiler, this is correctly in .rodata.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82411

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ccd2556bdb53..c7628e973084 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -141,7 +141,9 @@ AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
+
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
+CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
