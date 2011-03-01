Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1CA1B70FC
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2011 07:26:51 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p21K7kdr014028
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2011 15:07:46 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A317D38C803F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 15:26:45 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p21KQkq9153230
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2011 15:26:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p21KQj4O002938
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2011 15:26:45 -0500
Subject: [PATCH] powerpc/ptrace: remove BUG_ON when full register set not
	available
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Mar 2011 14:26:44 -0600
Message-ID: <1299011204.28753.8.camel@w500>
Mime-Version: 1.0
Cc: mikey@neuling.org, anton@samba.org
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some cases during a threaded core dump not all 
the threads will have a full register set.  This
will cause problems when the sigkill is sent to
the thread.  To solve this problem a poison value
(0xdeadbeef) will be placed in the buffer in place 
of the actual register values.  This will affect
gpr14 to gpr31.

Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>

----------

--- ptracev2.orig/include/linux/regset.h	2011-02-20 12:15:57.000000000 -0600
+++ ptracev2/include/linux/regset.h	2011-02-28 13:33:36.685302349 -0600
@@ -240,6 +240,34 @@ static inline int user_regset_copyout(un
 	}
 	return 0;
 }
+/* want the count to be the registers 14-31 inclusive */
+#define POISON_REG_CNT (PT_R31-PT_R14+1)
+static inline int user_regset_copyout_poison(unsigned int *pos,
+					   unsigned int *count,
+					   void **kbuf, void __user **ubuf,
+					   const int start_pos,
+					   const int end_pos)
+{
+	long poison_data[POISON_REG_CNT] = { [0 ... POISON_REG_CNT-1] = 0xdeadbeefdeadbeefUL };
+
+	if (*count == 0)
+		return 0;
+	BUG_ON(*pos < start_pos);
+	if (end_pos < 0 || *pos < end_pos) {
+		unsigned int copy = (end_pos < 0 ? *count
+				     : min(*count, end_pos - *pos));
+		if (*kbuf) {
+			memset(*kbuf, 0xdeadbeef, copy);
+			*kbuf += copy;
+		} else if (__copy_to_user(*ubuf,poison_data, copy))
+			return -EFAULT;
+		else
+			*ubuf += copy;
+		*pos += copy;
+		*count -= copy;
+	}
+	return 0;
+}
 
 static inline int user_regset_copyin(unsigned int *pos, unsigned int *count,
 				     const void **kbuf,
--- ptracev2.orig/arch/powerpc/kernel/ptrace.c	2011-02-20 12:15:57.000000000 -0600
+++ ptracev2/arch/powerpc/kernel/ptrace.c	2011-03-01 13:49:12.686354353 -0600
@@ -234,11 +234,29 @@ static int gpr_get(struct task_struct *t
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  target->thread.regs,
-				  0, offsetof(struct pt_regs, msr));
+	if (!FULL_REGS(target->thread.regs)) {
+                /* Don't have the full register set. Copy out register r0-r13 */
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  target->thread.regs,
+					  0, sizeof(long)*PT_R14);
+
+		/* Dont want to change the actual register values so rather than read the */
+		/* actual register copy a poison value into the buffer instead		  */
+		if (!ret)
+			ret = user_regset_copyout_poison(&pos, &count, &kbuf, &ubuf,
+						  sizeof(long)*PT_R14, offsetof(struct pt_regs, nip));
+
+		/* Copy out the rest of the registers as usual */
+		if (!ret)
+			ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+						  target->thread.regs,
+						  offsetof(struct pt_regs, nip), offsetof(struct pt_regs, msr));
+		
+	} else 
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  target->thread.regs,
+					  0, offsetof(struct pt_regs, msr));
 	if (!ret) {
 		unsigned long msr = get_user_msr(target);
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
@@ -645,11 +663,29 @@ static int gpr32_get(struct task_struct 
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
-
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
 
+	if(!FULL_REGS(target->thread.regs)) {
+		if (kbuf) {
+                	/* Don't have the full register set. Copy out register r0-r13 */
+			for (; count > 0 && pos < PT_R14; --count)
+				*k++ = regs[pos++];
+
+			/* Dont want to change the actual register values so rather than read the */
+			/* actual register copy a poison value into the buffer instead		  */
+			for (; count > 0 && pos <= PT_R31; --count,pos++)
+				*k++ = 0xdeadbeef;
+
+		} else { 
+			for (; count > 0 && pos < PT_R14; --count)
+				if (__put_user((compat_ulong_t) regs[pos++], u++))
+					return -EFAULT;
+			for (; count > 0 && pos <= PT_R31; --count,pos++)
+				if (__put_user((compat_ulong_t) 0xdeadbeef, u++))
+					return -EFAULT;
+		}
+	}
 	if (kbuf)
 		for (; count > 0 && pos < PT_MSR; --count)
 			*k++ = regs[pos++];
