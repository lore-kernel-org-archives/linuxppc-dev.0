Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2775DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 17:51:15 +1100 (EST)
Date: Tue, 24 Feb 2009 01:51:12 -0500
From: Kyle McMartin <kyle@infradead.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] powerpc: avoid generating .eh_frame sections with gcc-4.4
Message-ID: <20090224065112.GA6690@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kyle@redhat.com, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	roland@redhat.com
Reply-To: kyle@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kyle McMartin <kyle@redhat.com>

On ppc64 (at least) gcc-4.4 is defaulting to generating .eh_frame
sections, which are, for the kernel, fairly pointless. Additionally, on
ppc64 this generates a relocation format which the kernel module loader
does not currently support (R_PPC64_REL32.)

Alexandre Oliva verifies that -fno-dwarf2-cfi-asm prevents this
.eh_frame section from being generated.

These seem to be used for unwinding, but it doesn't look like we
currently use them anywhere. (In fact, we explicitly dump them in the
x86_64 linker script.)

If these .eh_frame sections are eventually used, adding a per-arch
CONFIG_WANT_UNWIND check would be trivial.

(This was reported against Fedora, which appears to be the only distro
doing any building against gcc-4.4 at present: RH bz#486545.)

Signed-off-by: Kyle McMartin <kyle@redhat.com>
Cc: roland@redhat.com
Cc: aoliva@redhat.com

---
diff --git a/Makefile b/Makefile
index df6ce3e..d66a512 100644
--- a/Makefile
+++ b/Makefile
@@ -566,6 +566,11 @@ KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 # disable pointer signed / unsigned warnings in gcc 4.0
 KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
 
+# gcc-4.4 defaults to generating .eh_frame sections, but we aren't
+# interested in those currently. additionally, it causes issues on some
+# architectures.
+KBUILD_CFLAGS += $(call cc-option,-fno-dwarf2-cfi-asm)
+
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 # But warn user when we do so
 warn-assign = \
