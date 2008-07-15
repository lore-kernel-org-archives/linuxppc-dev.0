Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8B6ADDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 19:17:25 +1000 (EST)
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Srinivasa D S <srinivasa@in.ibm.com>
In-Reply-To: <200807151436.55912.srinivasa@in.ibm.com>
References: <200807071952.27427.srinivasa@in.ibm.com>
	<200807141401.26917.srinivasa@in.ibm.com>
	<1216026417.7549.270.camel@pasglop>
	<200807151436.55912.srinivasa@in.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Jul 2008 19:15:57 +1000
Message-Id: <1216113357.7740.95.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-15 at 14:36 +0530, Srinivasa D S wrote:
> On Monday 14 July 2008 02:36:57 pm Benjamin Herrenschmidt wrote:
> 
> > > Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
> >
> > Can you send a cleanup patch against powerpc.git instead ?
> >
> 
> Resending the patch against powerpc.git tree.

Nah, your initial patch is there already :-) I'm just asking for a
cleanup one that removes the useless cast.

Cheers,
Ben.

> 
> Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>
> 
> 
> ---
>  include/asm-powerpc/processor.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: powerpc.git/include/asm-powerpc/processor.h
> ===================================================================
> --- powerpc.git.orig/include/asm-powerpc/processor.h
> +++ powerpc.git/include/asm-powerpc/processor.h
> @@ -234,6 +234,8 @@ struct thread_struct {
>  #define thread_saved_pc(tsk)    \
>          ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
>  
> +#define task_pt_regs(tsk)	((tsk)->thread.regs)
> +
>  unsigned long get_wchan(struct task_struct *p);
>  
>  #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
