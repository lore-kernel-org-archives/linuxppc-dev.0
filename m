Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34ED6B6F12
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Feb 2011 07:30:59 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1MKPeXG013540
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2011 13:25:40 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p1MKUlps117564
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2011 13:30:47 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p1MKUlM4020686
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2011 13:30:47 -0700
Subject: powerpc/ptrace:  Fix bug in signal handling
From: Michael Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Feb 2011 14:30:45 -0600
Message-ID: <1298406645.9824.3.camel@w500>
Mime-Version: 1.0
Cc: anton@samba.org
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
the thread
        
Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>
-------

--- ptrace-signal.orig/arch/powerpc/kernel/ptrace.c	2011-02-20 12:15:57.000000000 -0600
+++ ptrace-signal/arch/powerpc/kernel/ptrace.c	2011-02-21 12:39:17.000000000 -0600
@@ -234,11 +234,23 @@
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
 
-	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  target->thread.regs,
-				  0, offsetof(struct pt_regs, msr));
+	if (!FULL_REGS(target->thread.regs)) {
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  target->thread.regs,
+					  0, sizeof(long)*PT_R14);
+		if (!ret)
+			ret = user_regset_copyout_poison(&pos, &count, &kbuf, &ubuf,
+						  sizeof(long)*PT_R14, offsetof(struct pt_regs, nip));
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
@@ -645,11 +657,24 @@
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
-
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
 
+	if(!FULL_REGS(target->thread.regs)) {
+		if (kbuf) {
+			for (; count > 0 && pos < PT_R14; --count)
+				*k++ = regs[pos++];
+			for (; count > 0 && pos < PT_R31; --count,pos++)
+				*k++ = 0xdeadbeef;
+		} else { 
+			for (; count > 0 && pos < PT_R14; --count)
+				if (__put_user((compat_ulong_t) regs[pos++], u++))
+					return -EFAULT;
+			for (; count > 0 && pos < PT_R31; --count,pos++)
+				if (__put_user((compat_ulong_t) 0xdeadbeef, u++))
+					return -EFAULT;
+		}
+	}
 	if (kbuf)
 		for (; count > 0 && pos < PT_MSR; --count)
 			*k++ = regs[pos++];
--- ptrace-signal.orig/include/linux/regset.h	2011-02-20 12:15:57.000000000 -0600
+++ ptrace-signal/include/linux/regset.h	2011-02-21 12:39:17.000000000 -0600
@@ -240,6 +240,32 @@
 	}
 	return 0;
 }
+static inline int user_regset_copyout_poison(unsigned int *pos,
+					   unsigned int *count,
+					   void **kbuf, void __user **ubuf,
+					   const int start_pos,
+					   const int end_pos)
+{
+	long poison_data[17] = { [0 ... 16] = 0xdeadbeefdeadbeefUL };
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
