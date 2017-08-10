Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xT0sp25YQzDr0G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 07:01:01 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7AL0Ccb117119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 17:00:59 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c8t68y5p0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 17:00:59 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Aug 2017 17:00:58 -0400
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 24/25] powerpc: Deliver SEGV signal on pkey violation
In-reply-to: <1501459946-11619-25-git-send-email-linuxram@us.ibm.com>
Date: Thu, 10 Aug 2017 18:00:50 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87378zkuil.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> The value of the AMR register at the time of exception
> is made available in gp_regs[PT_AMR] of the siginfo.
>
> The value of the pkey, whose protection got violated,
> is made available in si_pkey field of the siginfo structure.

Should the IAMR also be made available?

Also, should the AMR and IAMR be accesible to userspace (e.g., to GDB)
via ptrace and the core file?

> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -500,6 +500,11 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
>  				   (unsigned long) &frame->tramp[2]);
>  	}
>
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (__put_user(get_paca()->paca_amr, &frame->mc_gregs[PT_AMR]))
> +		return 1;
> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  	return 0;
>  }

frame->mc_gregs[PT_AMR] has 32 bits, but paca_amr has 64 bits. Does this
work as intended?

> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index c83c115..86a4262 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -174,6 +174,10 @@ static long setup_sigcontext(struct sigcontext __user *sc,
>  	if (set != NULL)
>  		err |=  __put_user(set->sig[0], &sc->oldmask);
>
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	err |= __put_user(get_paca()->paca_amr, &sc->gp_regs[PT_AMR]);
> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
>  	return err;
>  }

Isn't a corresponding change needed in restore_sigcontext? And in the
corresponding TM versions setup_tm_sigcontexts and restore_tm_sigcontexts?

Ditto for the equivalent functions in signal_32.c.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
