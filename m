Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gNxX0YGlzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 16:41:19 +1000 (AEST)
Subject: Re: [PATCH v3 9/9] powerpc/traps: Add line prefix in
 show_instructions()
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Joe Perches <joe@perches.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-10-muriloo@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
Date: Wed, 1 Aug 2018 08:41:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180731145020.14009-10-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> Remove "Instruction dump:" line by adding a prefix to display current->comm
> and current->pid, along with the instructions dump.
> 
> The prefix can serve as a glue that links the instructions dump to its
> originator, allowing messages to be interleaved in the logs.
> 
> Before this patch, a page fault looked like:
> 
>    pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
>    Instruction dump:
>    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> After this patch, it looks like:
> 
>    pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e5100 code 2 in pandafault[10000000+10000]
>    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Does the script scripts/decode_stacktrace.sh also works with this format 
change ?

> ---
>   arch/powerpc/kernel/process.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e78799a8855a..d12143e7d8f9 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1265,16 +1265,19 @@ static int instructions_to_print = 16;
>   void show_instructions(struct pt_regs *regs)
>   {
>   	int i;
> +	const char *prefix = KERN_INFO "%s[%d]: code: ";
>   	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
>   			sizeof(int));
>   
> -	printk("Instruction dump:");
> +	printk(prefix, current->comm, current->pid);
>   
>   	for (i = 0; i < instructions_to_print; i++) {
>   		int instr;
>   
> -		if (!(i % 8))
> +		if (!(i % 8) && (i > 0)) {
>   			pr_cont("\n");
> +			printk(prefix, current->comm, current->pid);
> +		}
>   
>   #if !defined(CONFIG_BOOKE)
>   		/* If executing with the IMMU off, adjust pc rather
> 
