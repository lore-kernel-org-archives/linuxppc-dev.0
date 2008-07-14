Return-Path: <srinivasa@in.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E09FCDDEF0
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 18:32:57 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6E8VO0b005666
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 14:01:24 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6E8V1tb1364128
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 14:01:01 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6E8VN5T028273
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 14:01:24 +0530
From: Srinivasa D S <srinivasa@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
Date: Mon, 14 Jul 2008 14:01:26 +0530
References: <200807071952.27427.srinivasa@in.ibm.com>
	<18554.33417.542066.185326@cargo.ozlabs.ibm.com>
In-Reply-To: <18554.33417.542066.185326@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807141401.26917.srinivasa@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 July 2008 04:02:41 am Paul Mackerras wrote:
> >  Below attached patch  defines this macro for powerpc arch. Please let
> > me know your comments on this.
> >
> > +#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)
>
> The cast is unnecessary since tsk->thread.regs is already a struct
> pt_regs *. 

True.

> Also note that tsk->thread.regs will be NULL for a kernel 
> thread.

Yes, users of task_pt_regs will verify for NULL.  Updated patch attached 
below.

Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>


---
 include/asm-powerpc/processor.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.26-rc9/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6.26-rc9.orig/include/asm-powerpc/processor.h
+++ linux-2.6.26-rc9/include/asm-powerpc/processor.h
@@ -214,6 +214,8 @@ struct thread_struct {
 #define thread_saved_pc(tsk)    \
         ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 
+#define task_pt_regs(tsk)	(tsk)->thread.regs
+
 unsigned long get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)


 
