Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ppc32: Fix compile of sha1-powerpc-asm.S
Date: Tue, 26 Feb 2013 13:20:05 +1100
Message-Id: <1361845205-30606-1-git-send-email-tony@bakeyournoodle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building with CRYPTO_SHA1_PPC enabled we fail with:
---
powerpc/crypto/sha1-powerpc-asm.S: Assembler messages:
powerpc/crypto/sha1-powerpc-asm.S:116: Error: can't resolve `0' {*ABS* section} - `STACKFRAMESIZE' {*UND* section}
powerpc/crypto/sha1-powerpc-asm.S:116: Error: expression too complex
powerpc/crypto/sha1-powerpc-asm.S:178: Error: unsupported relocation against STACKFRAMESIZE
---

Use INT_FRAME_SIZE instead.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/crypto/sha1-powerpc-asm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

FWIW the SHA1_PPC makes about a 20% difference on my 32bit board

diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto/sha1-powerpc-asm.S
index a5f8264..125e165 100644
--- a/arch/powerpc/crypto/sha1-powerpc-asm.S
+++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
@@ -113,7 +113,7 @@
 	STEPUP4((t)+16, fn)
 
 _GLOBAL(powerpc_sha_transform)
-	PPC_STLU r1,-STACKFRAMESIZE(r1)
+	PPC_STLU r1,-INT_FRAME_SIZE(r1)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
 
@@ -175,5 +175,5 @@ _GLOBAL(powerpc_sha_transform)
 
 	REST_8GPRS(14, r1)
 	REST_10GPRS(22, r1)
-	addi	r1,r1,STACKFRAMESIZE
+	addi	r1,r1,INT_FRAME_SIZE
 	blr
-- 
1.8.1.2
