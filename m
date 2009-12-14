Return-Path: <neilc@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5467EB6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 01:09:11 +1100 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id nBEE8wBX017047
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:08:58 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id nBEE8w2L1331314
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:08:58 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id nBEE8wb3009072
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2009 14:08:58 GMT
Message-ID: <4B2646F9.4000203@linux.vnet.ibm.com>
Date: Mon, 14 Dec 2009 14:08:57 +0000
From: Neil Campbell <neilc@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: handle VSX alignment faults correctly in
	little-endian mode
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the handling of VSX alignment faults in little-endian
mode (the current code assumes the processor is in big-endian mode).

The patch also makes the handlers clear the top 8 bytes of the register
when handling an 8 byte VSX load.

This is based on 2.6.32.

Signed-off-by: Neil Campbell <neilc@linux.vnet.ibm.com>
Cc: <stable@kernel.org>
---
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index a5b632e..f0c624f 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -642,10 +642,14 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
  */
 static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
 		       unsigned int areg, struct pt_regs *regs,
-		       unsigned int flags, unsigned int length)
+		       unsigned int flags, unsigned int length,
+		       unsigned int elsize)
 {
 	char *ptr;
+	unsigned long *lptr;
 	int ret = 0;
+	int sw = 0;
+	int i, j;
 
 	flush_vsx_to_thread(current);
 
@@ -654,19 +658,35 @@ static int emulate_vsx(unsigned char __user *addr, unsigned int reg,
 	else
 		ptr = (char *) &current->thread.vr[reg - 32];
 
-	if (flags & ST)
-		ret = __copy_to_user(addr, ptr, length);
-        else {
-		if (flags & SPLT){
-			ret = __copy_from_user(ptr, addr, length);
-			ptr += length;
+	lptr = (unsigned long *) ptr;
+
+	if (flags & SW)
+		sw = elsize-1;
+
+	for (j = 0; j < length; j += elsize) {
+		for (i = 0; i < elsize; ++i) {
+			if (flags & ST)
+				ret |= __put_user(ptr[i^sw], addr + i);
+			else
+				ret |= __get_user(ptr[i^sw], addr + i);
 		}
-		ret |= __copy_from_user(ptr, addr, length);
+		ptr  += elsize;
+		addr += elsize;
 	}
-	if (flags & U)
-		regs->gpr[areg] = regs->dar;
-	if (ret)
+
+	if (!ret) {
+		if (flags & U)
+			regs->gpr[areg] = regs->dar;
+
+		/* Splat load copies the same data to top and bottom 8 bytes */
+		if (flags & SPLT)
+			lptr[1] = lptr[0];
+		/* For 8 byte loads, zero the top 8 bytes */
+		else if (!(flags & ST) && (8 == length))
+			lptr[1] = 0;
+	} else
 		return -EFAULT;
+
 	return 1;
 }
 #endif
@@ -767,16 +787,25 @@ int fix_alignment(struct pt_regs *regs)
 
 #ifdef CONFIG_VSX
 	if ((instruction & 0xfc00003e) == 0x7c000018) {
-		/* Additional register addressing bit (64 VSX vs 32 FPR/GPR */
+		unsigned int elsize;
+
+		/* Additional register addressing bit (64 VSX vs 32 FPR/GPR) */
 		reg |= (instruction & 0x1) << 5;
 		/* Simple inline decoder instead of a table */
+		/* VSX has only 8 and 16 byte memory accesses */
+		nb = 8;
 		if (instruction & 0x200)
 			nb = 16;
-		else if (instruction & 0x080)
-			nb = 8;
-		else
-			nb = 4;
+
+		/* Vector stores in little-endian mode swap individual
+		   elements, so process them separately */
+		elsize = 4;
+		if (instruction & 0x80)
+			elsize = 8;
+
 		flags = 0;
+		if (regs->msr & MSR_LE)
+			flags |= SW;
 		if (instruction & 0x100)
 			flags |= ST;
 		if (instruction & 0x040)
@@ -787,7 +816,7 @@ int fix_alignment(struct pt_regs *regs)
 			nb = 8;
 		}
 		PPC_WARN_EMULATED(vsx);
-		return emulate_vsx(addr, reg, areg, regs, flags, nb);
+		return emulate_vsx(addr, reg, areg, regs, flags, nb, elsize);
 	}
 #endif
 	/* A size of 0 indicates an instruction we don't support, with
