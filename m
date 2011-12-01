Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 5/8] powerpc/boot: Add extended precision shifts to the boot
 wrapper.
Date: Thu,  1 Dec 2011 18:39:21 +1100
Message-Id: <1322725164-4391-6-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The upcomming currituck patches will need to do 64-bit shifts which will
fail with undefined symbol without this patch.

I looked at linking against libgcc but we can't guarantee that libgcc
was compiled with soft-float.  Also Using ../lib/div64.S or
../kernel/misc_32.S, this will break the build as the .o's need to be
built with different flags for the bootwrapper vs the kernel.  So for
now the easyest option is to just copy code from
arch/powerpc/kernel/misc_32.S  I don't think this code changes too often ;P

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/div64.S |   52 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/div64.S b/arch/powerpc/boot/div64.S
index d271ab5..bbcb8a4 100644
--- a/arch/powerpc/boot/div64.S
+++ b/arch/powerpc/boot/div64.S
@@ -57,3 +57,55 @@ __div64_32:
 	stw	r8,4(r3)
 	mr	r3,r6		# return the remainder in r3
 	blr
+
+/*
+ * Extended precision shifts.
+ *
+ * Updated to be valid for shift counts from 0 to 63 inclusive.
+ * -- Gabriel
+ *
+ * R3/R4 has 64 bit value
+ * R5    has shift count
+ * result in R3/R4
+ *
+ *  ashrdi3: arithmetic right shift (sign propagation)	
+ *  lshrdi3: logical right shift
+ *  ashldi3: left shift
+ */
+	.globl __ashrdi3
+__ashrdi3:
+	subfic	r6,r5,32
+	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	slw	r6,r3,r6	# t1 = count > 31 ? 0 : MSW << (32-count)
+	rlwinm	r8,r7,0,32	# t3 = (count < 32) ? 32 : 0
+	sraw	r7,r3,r7	# t2 = MSW >> (count-32)
+	or	r4,r4,r6	# LSW |= t1
+	slw	r7,r7,r8	# t2 = (count < 32) ? 0 : t2
+	sraw	r3,r3,r5	# MSW = MSW >> count
+	or	r4,r4,r7	# LSW |= t2
+	blr
+
+	.globl __ashldi3
+__ashldi3:
+	subfic	r6,r5,32
+	slw	r3,r3,r5	# MSW = count > 31 ? 0 : MSW << count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	srw	r6,r4,r6	# t1 = count > 31 ? 0 : LSW >> (32-count)
+	slw	r7,r4,r7	# t2 = count < 32 ? 0 : LSW << (count-32)
+	or	r3,r3,r6	# MSW |= t1
+	slw	r4,r4,r5	# LSW = LSW << count
+	or	r3,r3,r7	# MSW |= t2
+	blr
+
+	.globl __lshrdi3
+__lshrdi3:
+	subfic	r6,r5,32
+	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	slw	r6,r3,r6	# t1 = count > 31 ? 0 : MSW << (32-count)
+	srw	r7,r3,r7	# t2 = count < 32 ? 0 : MSW >> (count-32)
+	or	r4,r4,r6	# LSW |= t1
+	srw	r3,r3,r5	# MSW = MSW >> count
+	or	r4,r4,r7	# LSW |= t2
+	blr
-- 
1.7.6.4
