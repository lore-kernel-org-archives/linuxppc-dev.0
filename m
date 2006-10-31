Return-Path: <hugh_dickins@symantec.com>
Received: from excu-mxob-2.symantec.com (excu-mxob-2.symantec.com
	[198.6.49.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "excu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DF1867B9B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 06:49:17 +1100 (EST)
Received: from excu-mxob-1.symantec.com (excu-mxob-1.symantec.com
	[198.6.49.12])
	by excu-mxob-2.symantec.com (8.13.7/8.13.7) with ESMTP id
	k9VIdcVt018227
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 10:39:39 -0800
Date: Tue, 31 Oct 2006 18:39:31 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/5] ppc64: make current preempt safe
Message-ID: <Pine.LNX.4.64.0610311834580.26470@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Repeated -j20 kernel builds on a G5 Quad running an SMP PREEMPT kernel
would often collapse within a day, some exec failing with "Bad address".
In each case examined, load_elf_binary was doing a kernel_read, but
generic_file_aio_read's access_ok saw current->thread.fs.seg as USER_DS
instead of KERNEL_DS.

objdump of filemap.o shows gcc 4.1.0 emitting "mr r5,r13 ... ld r9,416(r5)"
here for get_paca()->__current, instead of the expected and much more usual
"ld r9,416(r13)"; I've seen other gcc4s do the same, but perhaps not gcc3s.

So, if the task is preempted and rescheduled on a different cpu in between
the mr and the ld, r5 will be looking at a different paca_struct from the
one it's now on, pick up the wrong __current, and perhaps the wrong seg.
Presumably much worse could happen elsewhere, though that split is rare.

Other architectures appear to be safe (x86_64's read_pda is more limiting
than get_paca), but ppc64 needs to force "current" into one instruction.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
I think this patch should go into both 2.6.19 and 2.6.18-stable.

 include/asm-powerpc/current.h |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 2.6.19-rc4/include/asm-powerpc/current.h	2006-03-20 05:53:29.000000000 +0000
+++ linux/include/asm-powerpc/current.h	2006-10-30 19:27:05.000000000 +0000
@@ -14,7 +14,17 @@ struct task_struct;
 #ifdef __powerpc64__
 #include <asm/paca.h>
 
-#define current		(get_paca()->__current)
+static inline struct task_struct *get_current(void)
+{
+	struct task_struct *task;
+
+	__asm__ __volatile__("ld %0,%1(13)"
+	: "=r" (task)
+	: "i" (offsetof(struct paca_struct, __current)));
+
+	return task;
+}
+#define current	get_current()
 
 #else
 
