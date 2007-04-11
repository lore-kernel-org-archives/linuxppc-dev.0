Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Apr 2007 16:13:19 +1000
Subject: [PATCH 2/2] powerpc: Alignment exception uses __get/put_user_inatomic
Message-Id: <20070411061756.3DD1CDDF16@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the alignment exception handler use the new _inatomic variants
of __get/put_user. This fixes erroneous warnings in the very rare
cases where we manage to have copy_tofrom_user_inatomic() trigger
an alignment exception.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/align.c |   56 ++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

Index: linux-work/arch/powerpc/kernel/align.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/align.c	2007-04-11 10:23:41.000000000 +1000
+++ linux-work/arch/powerpc/kernel/align.c	2007-04-11 10:24:43.000000000 +1000
@@ -241,7 +241,7 @@
 	if (user_mode(regs) && !access_ok(VERIFY_WRITE, p, size))
 		return -EFAULT;
 	for (i = 0; i < size / sizeof(long); ++i)
-		if (__put_user(0, p+i))
+		if (__put_user_inatomic(0, p+i))
 			return -EFAULT;
 	return 1;
 }
@@ -288,7 +288,8 @@
 		} else {
 			unsigned long pc = regs->nip ^ (swiz & 4);
 
-			if (__get_user(instr, (unsigned int __user *)pc))
+			if (__get_user_inatomic(instr,
+						(unsigned int __user *)pc))
 				return -EFAULT;
 			if (swiz == 0 && (flags & SW))
 				instr = cpu_to_le32(instr);
@@ -324,27 +325,31 @@
 			       ((nb0 + 3) / 4) * sizeof(unsigned long));
 
 		for (i = 0; i < nb; ++i, ++p)
-			if (__get_user(REG_BYTE(rptr, i ^ bswiz), SWIZ_PTR(p)))
+			if (__get_user_inatomic(REG_BYTE(rptr, i ^ bswiz),
+						SWIZ_PTR(p)))
 				return -EFAULT;
 		if (nb0 > 0) {
 			rptr = &regs->gpr[0];
 			addr += nb;
 			for (i = 0; i < nb0; ++i, ++p)
-				if (__get_user(REG_BYTE(rptr, i ^ bswiz),
-					       SWIZ_PTR(p)))
+				if (__get_user_inatomic(REG_BYTE(rptr,
+								 i ^ bswiz),
+							SWIZ_PTR(p)))
 					return -EFAULT;
 		}
 
 	} else {
 		for (i = 0; i < nb; ++i, ++p)
-			if (__put_user(REG_BYTE(rptr, i ^ bswiz), SWIZ_PTR(p)))
+			if (__put_user_inatomic(REG_BYTE(rptr, i ^ bswiz),
+						SWIZ_PTR(p)))
 				return -EFAULT;
 		if (nb0 > 0) {
 			rptr = &regs->gpr[0];
 			addr += nb;
 			for (i = 0; i < nb0; ++i, ++p)
-				if (__put_user(REG_BYTE(rptr, i ^ bswiz),
-					       SWIZ_PTR(p)))
+				if (__put_user_inatomic(REG_BYTE(rptr,
+								 i ^ bswiz),
+							SWIZ_PTR(p)))
 					return -EFAULT;
 		}
 	}
@@ -398,7 +403,8 @@
 
 		if (cpu_has_feature(CPU_FTR_PPC_LE) && (regs->msr & MSR_LE))
 			pc ^= 4;
-		if (unlikely(__get_user(instr, (unsigned int __user *)pc)))
+		if (unlikely(__get_user_inatomic(instr,
+						 (unsigned int __user *)pc)))
 			return -EFAULT;
 		if (cpu_has_feature(CPU_FTR_REAL_LE) && (regs->msr & MSR_LE))
 			instr = cpu_to_le32(instr);
@@ -474,16 +480,16 @@
 		p = (unsigned long) addr;
 		switch (nb) {
 		case 8:
-			ret |= __get_user(data.v[0], SWIZ_PTR(p++));
-			ret |= __get_user(data.v[1], SWIZ_PTR(p++));
-			ret |= __get_user(data.v[2], SWIZ_PTR(p++));
-			ret |= __get_user(data.v[3], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[0], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[1], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[2], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __get_user(data.v[4], SWIZ_PTR(p++));
-			ret |= __get_user(data.v[5], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[4], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[5], SWIZ_PTR(p++));
 		case 2:
-			ret |= __get_user(data.v[6], SWIZ_PTR(p++));
-			ret |= __get_user(data.v[7], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[6], SWIZ_PTR(p++));
+			ret |= __get_user_inatomic(data.v[7], SWIZ_PTR(p++));
 			if (unlikely(ret))
 				return -EFAULT;
 		}
@@ -551,16 +557,16 @@
 		p = (unsigned long) addr;
 		switch (nb) {
 		case 8:
-			ret |= __put_user(data.v[0], SWIZ_PTR(p++));
-			ret |= __put_user(data.v[1], SWIZ_PTR(p++));
-			ret |= __put_user(data.v[2], SWIZ_PTR(p++));
-			ret |= __put_user(data.v[3], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[0], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[1], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[2], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[3], SWIZ_PTR(p++));
 		case 4:
-			ret |= __put_user(data.v[4], SWIZ_PTR(p++));
-			ret |= __put_user(data.v[5], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[4], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[5], SWIZ_PTR(p++));
 		case 2:
-			ret |= __put_user(data.v[6], SWIZ_PTR(p++));
-			ret |= __put_user(data.v[7], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[6], SWIZ_PTR(p++));
+			ret |= __put_user_inatomic(data.v[7], SWIZ_PTR(p++));
 		}
 		if (unlikely(ret))
 			return -EFAULT;
