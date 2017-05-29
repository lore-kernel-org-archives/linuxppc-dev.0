Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbr713qZmzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 18:50:53 +1000 (AEST)
Subject: Re: [PATCH v1 2/8] powerpc/kprobes: Move kprobes over to
 patch_instruction
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-3-bsingharora@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f5ce15b1-2c50-cad6-36f1-c7e7bc8c4f2d@c-s.fr>
Date: Mon, 29 May 2017 10:50:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170525033650.10891-3-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> arch_arm/disarm_probe use direct assignment for copying
> instructions, replace them with patch_instruction
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>   arch/powerpc/kernel/kprobes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 160ae0f..5e1fa86 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
>   
>   void arch_arm_kprobe(struct kprobe *p)
>   {
> -	*p->addr = BREAKPOINT_INSTRUCTION;
> +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
>   	flush_icache_range((unsigned long) p->addr,
>   			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>   }
> @@ -166,7 +166,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
>   
>   void arch_disarm_kprobe(struct kprobe *p)
>   {
> -	*p->addr = p->opcode;
> +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);

Shouldn't it be the following instead ?

patch_instruction(p->addr, p->opcode);

Christophe


>   	flush_icache_range((unsigned long) p->addr,
>   			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>   }
> 
