Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNVny1nhDzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 18:11:34 +1100 (AEDT)
Date: Wed, 15 Feb 2017 16:11:26 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: add support for KPROBES_ON_FTRACE
Message-Id: <20170215161126.104c1db721182e1e75244125@kernel.org>
In-Reply-To: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

On Wed, 15 Feb 2017 00:28:34 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> index e51a045f3d3b..a8f414a0b141 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -70,6 +70,9 @@ static unsigned long can_optimize(struct kprobe *p)
>  	struct instruction_op op;
>  	unsigned long nip = 0;
>  
> +	if (unlikely(kprobe_ftrace(p)))
> +		return 0;
> +

Hmm, this should not be checked in arch-depend code, since it may duplicate
code in each arch. Please try below.

Thanks,

commit 897bb304974c1b0c19a4274fea220b175b07f353
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Wed Feb 15 15:48:14 2017 +0900

    kprobes: Skip preparing optprobe if the probe is ftrace-based
    
    Skip preparing optprobe if the probe is ftrace-based, since
    anyway, it must not be optimized (or already optimized by
    ftrace).
    
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ebb4dad..546a8b1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -746,13 +746,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	arch_remove_optimized_kprobe(op);
 }
 
+static inline
+void __prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
+{
+	if (!kprobe_ftrace(p))
+		arch_prepare_optimized_kprobe(op, p);
+}
+
 /* Try to prepare optimized instructions */
 static void prepare_optimized_kprobe(struct kprobe *p)
 {
 	struct optimized_kprobe *op;
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	arch_prepare_optimized_kprobe(op, p);
+	__prepare_optimized_kprobe(op, p);
 }
 
 /* Allocate new optimized_kprobe and try to prepare optimized instructions */
@@ -766,7 +773,7 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 
 	INIT_LIST_HEAD(&op->list);
 	op->kp.addr = p->addr;
-	arch_prepare_optimized_kprobe(op, p);
+	__prepare_optimized_kprobe(op, p);
 
 	return &op->kp;
 }



-- 
Masami Hiramatsu <mhiramat@kernel.org>
