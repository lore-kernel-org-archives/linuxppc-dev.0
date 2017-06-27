Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxfNR5rC4zDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:34:15 +1000 (AEST)
Subject: Re: [PATCH v4 2/9] powerpc/kprobes: Move kprobes over to
 patch_instruction
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org
References: <20170627074903.19324-1-bsingharora@gmail.com>
 <20170627074903.19324-3-bsingharora@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <78d13458-f8ae-c538-3565-ff8a7ef6309a@c-s.fr>
Date: Tue, 27 Jun 2017 10:34:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170627074903.19324-3-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/06/2017 à 09:48, Balbir Singh a écrit :
> arch_arm/disarm_probe use direct assignment for copying
> instructions, replace them with patch_instruction
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Didn't Michael picked it up already ?

Christophe

> ---
>   arch/powerpc/kernel/kprobes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 01addfb..a52bae8 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -164,7 +164,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
>   
>   void arch_arm_kprobe(struct kprobe *p)
>   {
> -	*p->addr = BREAKPOINT_INSTRUCTION;
> +	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
>   	flush_icache_range((unsigned long) p->addr,
>   			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>   }
> @@ -172,7 +172,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
>   
>   void arch_disarm_kprobe(struct kprobe *p)
>   {
> -	*p->addr = p->opcode;
> +	patch_instruction(p->addr, p->opcode);
>   	flush_icache_range((unsigned long) p->addr,
>   			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
>   }
> 
