Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj1Pg71YPzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 05:06:31 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v56J49eh064897
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 15:06:25 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2awv2s5mc4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 15:06:24 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Jun 2017 05:06:22 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v56J6Boh55902412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 05:06:19 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v56J5k2k030660
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jun 2017 05:05:47 +1000
Date: Wed, 7 Jun 2017 00:35:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr,
 paulus@samba.org
Subject: Re: [PATCH v3 2/9] powerpc/kprobes: Move kprobes over to
 patch_instruction
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-3-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606042945.24997-3-bsingharora@gmail.com>
Message-Id: <20170606190529.GF19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Balbir,

On 2017/06/06 02:29PM, Balbir Singh wrote:
> arch_arm/disarm_probe use direct assignment for copying
> instructions, replace them with patch_instruction
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index fc43435..b49f8f0 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
> 
>  void arch_arm_kprobe(struct kprobe *p)
>  {
> -	*p->addr = BREAKPOINT_INSTRUCTION;
> +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
>  	flush_icache_range((unsigned long) p->addr,
>  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));

Do we still need flush_icache_range() after patch_instruction()?

- Naveen

>  }
> @@ -166,7 +166,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
> 
>  void arch_disarm_kprobe(struct kprobe *p)
>  {
> -	*p->addr = p->opcode;
> +	patch_instruction(p->addr, p->opcode);
>  	flush_icache_range((unsigned long) p->addr,
>  			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>  }
> -- 
> 2.9.4
> 
