Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A740140094
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 19:01:51 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 8 May 2014 10:01:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D88FC1B08051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 10:01:54 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4891ghE25428030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 09:01:43 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4891dcE016229
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 03:01:41 -0600
Message-ID: <1399539689.2906.16.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH] powerpc: fix wrong sp saved in save_stack_trace()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 08 May 2014 17:01:29 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I found stack trace couldn't be saved sometimes. After some
investigation, it seems that when function trace is enabled, 

void save_stack_trace(struct stack_trace *trace)
{
        unsigned long sp;

        asm("mr %0,1" : "=r" (sp));

        save_context_stack(trace, sp, current, 1);
}

is compiled into: 

c0000000000432c0 <.save_stack_trace>:
c0000000000432c0:       7c 08 02 a6     mflr    r0
c0000000000432c4:       f8 01 00 10     std     r0,16(r1)
c0000000000432c8:       f8 21 ff 81     stdu    r1,-128(r1)
c0000000000432cc:       f8 61 00 70     std     r3,112(r1)
c0000000000432d0:       4b fc 77 bd     bl      c00000000000aa8c
<._mcount>
c0000000000432d4:       60 00 00 00     nop
c0000000000432d8:       7c 24 0b 78     mr      r4,r1

c0000000000432dc:       e8 ad 02 78     ld      r5,632(r13)
c0000000000432e0:       e8 61 00 70     ld      r3,112(r1)
c0000000000432e4:       38 c0 00 01     li      r6,1
c0000000000432e8:       38 21 00 80     addi    r1,r1,128
c0000000000432ec:       e8 01 00 10     ld      r0,16(r1)
c0000000000432f0:       7c 08 03 a6     mtlr    r0
c0000000000432f4:       4b ff fe 5c     b       c000000000043150
<.save_context_stack>
c0000000000432f8:       60 00 00 00     nop
c0000000000432fc:       60 42 00 00     ori     r2,r2,0

new stack frame -128(r1) is created to call ._mcount, and this new r1 is
copied into sp as the stack pointer, which then could be overwritten by
save_context_stack's prolog. 

I don't know how to specify in C that the embedded asm be compiled after
r1 being added back to the original value. But as a workaround, maybe we
could move this embedded asm into save_context_stack(). 

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/stacktrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 3d30ef1..5c0b461 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -22,6 +22,9 @@
 static void save_context_stack(struct stack_trace *trace, unsigned long sp,
 			struct task_struct *tsk, int savesched)
 {
+	if (tsk == current)
+		asm("mr %0,1" : "=r" (sp));
+
 	for (;;) {
 		unsigned long *stack = (unsigned long *) sp;
 		unsigned long newsp, ip;
@@ -48,11 +51,7 @@ static void save_context_stack(struct stack_trace *trace, unsigned long sp,
 
 void save_stack_trace(struct stack_trace *trace)
 {
-	unsigned long sp;
-
-	asm("mr %0,1" : "=r" (sp));
-
-	save_context_stack(trace, sp, current, 1);
+	save_context_stack(trace, 0, current, 1);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
