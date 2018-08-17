Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sN242z4LzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 22:34:52 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HCY9AQ023962
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 08:34:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kwwjfa5w6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 08:34:49 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 17 Aug 2018 06:34:48 -0600
Date: Fri, 17 Aug 2018 09:34:41 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/process: fix nested output in
 show_user_instructions()
References: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
Message-Id: <20180817123441.GA7458@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Tue, Aug 14, 2018 at 08:59:18AM +0000, Christophe Leroy wrote:
> When two processes crash at the same time, we sometimes encounter
> nesting in the middle of a line:
> 
> [    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
> [    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
> [    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
> [    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79

My smoke test passed with the two patches.

Perhaps adding an output sample of how messages would look like after your patch
could be an enhancement to the commit message.

Otherwise:

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> This patch fixes it by preparing complete lines in a buffer and
> printing it at once.
> 
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/process.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..c722ce4ca1c0 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1303,32 +1303,33 @@ void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
>  	int i;
> +	char buf[96]; /* enough for 8 times 9 + 2 chars */
> +	int l = 0;
>  
>  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>  
> -	pr_info("%s[%d]: code: ", current->comm, current->pid);
> -
>  	for (i = 0; i < instructions_to_print; i++) {
>  		int instr;
>  
>  		if (!(i % 8) && (i > 0)) {
> -			pr_cont("\n");
> -			pr_info("%s[%d]: code: ", current->comm, current->pid);
> +			pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
> +			l = 0;
>  		}
>  
>  		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
> -			pr_cont("XXXXXXXX ");
> +			l += sprintf(buf + l, "XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> -				pr_cont("<%08x> ", instr);
> +				l += sprintf(buf + l, "<%08x> ", instr);
>  			else
> -				pr_cont("%08x ", instr);
> +				l += sprintf(buf + l, "%08x ", instr);
>  		}
>  
>  		pc += sizeof(int);
>  	}
>  
> -	pr_cont("\n");
> +	if (l)
> +		pr_info("%s[%d]: code: %s\n", current->comm, current->pid, buf);
>  }
>  
>  struct regbit {
> -- 
> 2.13.3
> 

-- 
Murilo
