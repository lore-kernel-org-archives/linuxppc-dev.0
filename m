Return-Path: <lucien.xin@gmail.com>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426qv257v5zF3TM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 20:15:23 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id b30-v6so5373791pla.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Sep 2018 03:15:23 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Roopa Prabhu <roopa@cumulusnetworks.com>
Subject: [PATCH net] powerpc: use big endian to hash len and proto in
 csum_ipv6_magic
Date: Sat,  8 Sep 2018 18:15:12 +0800
Message-Id: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function csum_ipv6_magic doesn't convert len and proto to big
endian before doing ipv6 csum hash, which is not consistent with
RFC and other arches.

Jianlin found it when ICMPv6 packets from other hosts were dropped
in the powerpc64 system.

This patch is to fix it by using instruction 'lwbrx' to do this
conversion in powerpc32/64 csum_ipv6_magic.

Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 arch/powerpc/lib/checksum_32.S | 4 ++++
 arch/powerpc/lib/checksum_64.S | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index aa22406..7d3446e 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -325,6 +325,10 @@ _GLOBAL(csum_ipv6_magic)
 	adde	r0, r0, r9
 	lwz	r11, 12(r4)
 	adde	r0, r0, r10
+	STWX_BE	r5, 0, r1
+	lwz	r5, 0(r1)
+	STWX_BE	r6, 0, r1
+	lwz	r6, 0(r1)
 	add	r5, r5, r6	/* assumption: len + proto doesn't carry */
 	adde	r0, r0, r11
 	adde	r0, r0, r5
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 886ed94..302e732 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -439,6 +439,10 @@ EXPORT_SYMBOL(csum_partial_copy_generic)
 _GLOBAL(csum_ipv6_magic)
 	ld	r8, 0(r3)
 	ld	r9, 8(r3)
+	STWX_BE	r5, 0, r1
+	lwz	r5, 0(r1)
+	STWX_BE	r6, 0, r1
+	lwz	r6, 0(r1)
 	add	r5, r5, r6
 	addc	r0, r8, r9
 	ld	r10, 0(r4)
-- 
2.1.0
