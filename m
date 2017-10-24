Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLyLv27HRzDqlH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 02:47:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 22/25] powerpc: capture the violated protection key on
 fault
In-Reply-To: <1504910713-7094-31-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-31-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 17:46:55 +0200
Message-ID: <8760b44kgg.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 04b60af..51c89c1 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -97,6 +97,9 @@ struct paca_struct {
>  	struct dtl_entry *dispatch_log_end;
>  #endif /* CONFIG_PPC_STD_MMU_64 */
>  	u64 dscr_default;		/* per-CPU default DSCR */
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	u16 paca_pkey;                  /* exception causing pkey */
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */

I can't see any reason why this should be in the paca.

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a16bc43..ad31f6e 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -153,6 +153,7 @@ static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
>  
>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>  	if (si_code & DSISR_KEYFAULT) {
> +		get_paca()->paca_pkey = get_pte_pkey(current->mm, address);

You seem to be using the paca as a temporary stash so that you don't
have to pass it to _exception().

But that's not what the paca is for, the paca is for per-cpu data not
per-thread data, and (preferably) only for things that need to be
accessed in low-level code where proper per_cpu() variables don't work.

Updating _exception() to take the key would be a mess, because there are
so many callers who don't care about the key. For now we can probably
just do something ~=:

void _exception_pkey(int signr, struct pt_regs *regs, int code, unsigned long addr, int key)
{
	< current body of _exception >

	+ pkey bits
}

void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
{
	_exception_pkey(..., 0);
}


cheers
