Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kmxh656kzF3KJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 13:52:56 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id z70-v6so4878116pgz.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 20:52:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 3/4] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Date: Mon, 14 May 2018 13:52:27 +1000
Message-Id: <20180514035228.21316-4-npiggin@gmail.com>
In-Reply-To: <20180514035228.21316-1-npiggin@gmail.com>
References: <20180514035228.21316-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc toolchain can compile combinations of 32/64 bit and
big/little endian, so it's convenient to consider, e.g.,

  `CC -m64 -mbig-endian`

To be the C compiler for the purpose of invoking it to build target
artifacts. So overriding the the CC variable to include thse flags
works for this purpose.

Unfortunately that is not compatible with the way the proposed new
Kconfig macro language will work.

After previous patches in this series, these flags can be carefully
passed in using flags instead.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v2:
- removed extra -EB in the recordmcount script (thanks mpe)

 arch/powerpc/Makefile   | 16 +++++++++-------
 scripts/recordmcount.pl |  7 +++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 167b26a0780c..6faf1d6ad9dd 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -75,13 +75,15 @@ endif
 endif
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-override LD	+= -EL
+KBUILD_CFLAGS	+= -mlittle-endian
+LDFLAGS		+= -EL
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
-override LD	+= -EB
+KBUILD_CFLAGS += $(call cc-option,-mbig-endian)
+LDFLAGS		+= -EB
 LDEMULATION	:= ppc
 GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
@@ -94,19 +96,19 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
 
-cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
 ifneq ($(cc-name),clang)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
 
+cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 
 ifeq ($(HAS_BIARCH),y)
-override AS	+= -a$(BITS)
-override LD	+= -m elf$(BITS)$(LDEMULATION)
-override CC	+= -m$(BITS)
+KBUILD_CFLAGS	+= -m$(BITS)
+KBUILD_AFLAGS	+= -m$(BITS) -Wl,-a$(BITS)
+LDFLAGS		+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 191eb949d52c..3c67304a7425 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -274,6 +274,13 @@ if ($arch eq "x86_64") {
     if ($bits == 64) {
 	$type = ".quad";
     }
+    if ($endian eq "big") {
+	    $cc .= " -mbig-endian ";
+	    $ld .= " -EB ";
+    } else {
+	    $cc .= " -mlittle-endian ";
+	    $ld .= " -EL ";
+    }
 
 } elsif ($arch eq "arm") {
     $alignment = 2;
-- 
2.17.0
