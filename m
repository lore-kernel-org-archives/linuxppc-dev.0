Return-Path: <anton@ozlabs.org>
Date: Thu, 11 Feb 2010 11:56:26 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Improve 64bit copy_tofrom_user
Message-ID: <20100211005626.GG3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Here is a patch from Paul Mackerras that improves the ppc64 copy_tofrom_user.
The loop now does 32 bytes at a time and as well as pairing loads and stores.

A quick test case that reads 8kB over and over shows the improvement:

POWER6: 53% faster
POWER7: 51% faster


#define _XOPEN_SOURCE 500
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define BUFSIZE (8 * 1024)
#define ITERATIONS 10000000

int main()
{
	char tmpfile[] = "/tmp/copy_to_user_testXXXXXX";
	int fd;
	char *buf[BUFSIZE];
	unsigned long i;

	fd = mkstemp(tmpfile);
	if (fd < 0) {
		perror("open");
		exit(1);
	}

	if (write(fd, buf, BUFSIZE) != BUFSIZE) {
		perror("open");
		exit(1);
	}

	for (i = 0; i < 10000000; i++) {
		if (pread(fd, buf, BUFSIZE, 0) != BUFSIZE) {
			perror("pread");
			exit(1);
		}
	}

	unlink(tmpfile);

	return 0;
}


Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/lib/copyuser_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/copyuser_64.S	2009-02-27 14:09:46.000000000 +1100
+++ powerpc.git/arch/powerpc/lib/copyuser_64.S	2010-02-11 11:12:37.646821713 +1100
@@ -44,37 +44,55 @@ BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
 END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
-	srdi	r7,r5,4
-20:	ld	r9,0(r4)
-	addi	r4,r4,-8
-	mtctr	r7
-	andi.	r5,r5,7
-	bf	cr7*4+0,22f
-	addi	r3,r3,8
-	addi	r4,r4,8
-	mr	r8,r9
-	blt	cr1,72f
-21:	ld	r9,8(r4)
-70:	std	r8,8(r3)
-22:	ldu	r8,16(r4)
-71:	stdu	r9,16(r3)
+	blt	cr1,.Ldo_tail		/* if < 16 bytes to copy */
+	srdi	r0,r5,5
+	cmpdi	cr1,r0,0
+20:	ld	r7,0(r4)
+220:	ld	r6,8(r4)
+	addi	r4,r4,16
+	mtctr	r0
+	andi.	r0,r5,0x10
+	beq	22f
+	addi	r3,r3,16
+	addi	r4,r4,-16
+	mr	r9,r7
+	mr	r8,r6
+	beq	cr1,72f
+21:	ld	r7,16(r4)
+221:	ld	r6,24(r4)
+	addi	r4,r4,32
+70:	std	r9,0(r3)
+270:	std	r8,8(r3)
+22:	ld	r9,0(r4)
+222:	ld	r8,8(r4)
+71:	std	r7,16(r3)
+271:	std	r6,24(r3)
+	addi	r3,r3,32
 	bdnz	21b
-72:	std	r8,8(r3)
+72:	std	r9,0(r3)
+272:	std	r8,8(r3)
+	andi.	r5,r5,0xf
 	beq+	3f
-	addi	r3,r3,16
+	addi	r4,r4,16
 .Ldo_tail:
-	bf	cr7*4+1,1f
-23:	lwz	r9,8(r4)
+	addi	r3,r3,16
+	bf	cr7*4+0,246f
+244:	ld	r9,0(r4)
+	addi	r4,r4,8
+245:	std	r9,0(r3)
+	addi	r3,r3,8
+246:	bf	cr7*4+1,1f
+23:	lwz	r9,0(r4)
 	addi	r4,r4,4
 73:	stw	r9,0(r3)
 	addi	r3,r3,4
 1:	bf	cr7*4+2,2f
-44:	lhz	r9,8(r4)
+44:	lhz	r9,0(r4)
 	addi	r4,r4,2
 74:	sth	r9,0(r3)
 	addi	r3,r3,2
 2:	bf	cr7*4+3,3f
-45:	lbz	r9,8(r4)
+45:	lbz	r9,0(r4)
 75:	stb	r9,0(r3)
 3:	li	r3,0
 	blr
@@ -220,7 +238,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 131:
 	addi	r3,r3,8
 120:
+320:
 122:
+322:
 124:
 125:
 126:
@@ -229,9 +249,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 129:
 133:
 	addi	r3,r3,8
-121:
 132:
 	addi	r3,r3,8
+121:
+321:
+344:
 134:
 135:
 138:
@@ -303,18 +325,22 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 183:
 	add	r3,r3,r7
 	b	1f
+371:
 180:
 	addi	r3,r3,8
 171:
 177:
 	addi	r3,r3,8
-170:
-172:
+370:
+372:
 176:
 178:
 	addi	r3,r3,4
 185:
 	addi	r3,r3,4
+170:
+172:
+345:
 173:
 174:
 175:
@@ -341,11 +367,19 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_
 	.section __ex_table,"a"
 	.align	3
 	.llong	20b,120b
+	.llong	220b,320b
 	.llong	21b,121b
+	.llong	221b,321b
 	.llong	70b,170b
+	.llong	270b,370b
 	.llong	22b,122b
+	.llong	222b,322b
 	.llong	71b,171b
+	.llong	271b,371b
 	.llong	72b,172b
+	.llong	272b,372b
+	.llong	244b,344b
+	.llong	245b,345b
 	.llong	23b,123b
 	.llong	73b,173b
 	.llong	44b,144b
