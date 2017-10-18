Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHSsb6pTszDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 10:28:03 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id t188so5093510pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:28:03 -0700 (PDT)
Date: Thu, 19 Oct 2017 10:27:52 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
Message-ID: <20171019102752.7d9075ec@MiWiFi-R3-srv>
In-Reply-To: <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:45:08 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Handle Data and  Instruction exceptions caused by memory
> protection-key.
> 
> The CPU will detect the key fault if the HPTE is already
> programmed with the key.
> 
> However if the HPTE is not  hashed, a key fault will not
> be detected by the  hardware. The   software will detect
> pkey violation in such a case.


This bit is not clear.

> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/fault.c |   37 ++++++++++++++++++++++++++++++++-----
>  1 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 4797d08..a16bc43 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -145,6 +145,23 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
>  	return __bad_area(regs, address, SEGV_MAPERR);
>  }
>  
> +static int bad_page_fault_exception(struct pt_regs *regs, unsigned long address,
> +					int si_code)
> +{
> +	int sig = SIGBUS;
> +	int code = BUS_OBJERR;
> +
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (si_code & DSISR_KEYFAULT) {
> +		sig = SIGSEGV;
> +		code = SEGV_PKUERR;
> +	}
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
> +	_exception(sig, regs, code, address);
> +	return 0;
> +}
> +
>  static int do_sigbus(struct pt_regs *regs, unsigned long address,
>  		     unsigned int fault)
>  {
> @@ -391,11 +408,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  		return 0;
>  
>  	if (unlikely(page_fault_is_bad(error_code))) {
> -		if (is_user) {
> -			_exception(SIGBUS, regs, BUS_OBJERR, address);
> -			return 0;
> -		}
> -		return SIGBUS;
> +		if (!is_user)
> +			return SIGBUS;
> +		return bad_page_fault_exception(regs, address, error_code);
>  	}
>  
>  	/* Additional sanity check(s) */
> @@ -492,6 +507,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (unlikely(access_error(is_write, is_exec, vma)))
>  		return bad_area(regs, address);
>  
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> +			is_exec, 0))
> +		return __bad_area(regs, address, SEGV_PKUERR);


Hmm.. this is for the missing entry in the HPT and software detecting the
fault you mentioned above? Why do we need this case?

> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
> +
> +	/* handle_mm_fault() needs to know if its a instruction access
> +	 * fault.
> +	 */

comment style

> +	if (is_exec)
> +		flags |= FAULT_FLAG_INSTRUCTION;
>  	/*
>  	 * If for any reason at all we couldn't handle the fault,
>  	 * make sure we exit gracefully rather than endlessly redo

Balbir Singh.
