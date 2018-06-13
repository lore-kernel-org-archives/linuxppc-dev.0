Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4159Ly59YxzF0f7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 12:15:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/5] powerpc: Fix inverted active predicate for
 setting the EBB regset
In-Reply-To: <20180607152534.29427-2-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
 <20180607152534.29427-2-pedromfc@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2018 12:15:04 +1000
Message-ID: <87fu1rtot3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com> writes:

> Currently, the ebb_set function for writing to the EBB regset returns
> ENODATA when ebb is active in the thread, and copies in the data when
> it is inactive. This patch inverts the condition so that it matches
> ebb_get and ebb_active.
> ---
>  arch/powerpc/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Pedro,

Thanks for looking into this, how did you detect this? Do you have a
test case?

I don't think Anshuman wrote it this way on purpose, but added him to Cc
in case he remembers.

But I don't think this fix is necessarily right. If we are setting the
EBB regs via ptrace then it doesn't matter if they were previously in
use or not, we should just set them. What *does* matter is that at the
end of the function we set used_ebb to true, because otherwise the
values we have set will not actually be used when the process is
rescheduled.

cheers

> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index d23cf632edf0..6618570c6d56 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1701,7 +1701,7 @@ static int ebb_set(struct task_struct *target,
>  	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
>  		return -ENODEV;
>  
> -	if (target->thread.used_ebb)
> +	if (!target->thread.used_ebb)
>  		return -ENODATA;
>  
>  	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> -- 
> 2.13.6
