Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H8TH0NxYzF3Pw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 09:10:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LKODua086256
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:25:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mn4u4pk57-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:25:13 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 21 Sep 2018 14:25:12 -0600
Date: Fri, 21 Sep 2018 17:25:05 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] powerpc/process: fix interleaved output in
 show_user_instructions()
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
 <8f4de3aa04f00d67fdb5aaf90f41242197310d4d.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8f4de3aa04f00d67fdb5aaf90f41242197310d4d.1536327756.git.christophe.leroy@c-s.fr>
Message-Id: <20180921202505.GB19940@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 01:47:31PM +0000, Christophe Leroy wrote:
> When two processes crash at the same time, we sometimes encounter
> interleaving in the middle of a line:
> 
> [    4.365317] init[1]: segfault (11) at 0 nip 0 lr 0 code 1
> [    4.370452] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.372042] init[74]: segfault (11) at 10a74 nip 1000c198 lr 100078c8 code 1 in sh[10000000+14000]
> [    4.386829] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.391542] init[1]: code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [    4.400863] init[74]: code: 90010024 bf61000c 91490a7c 3fa01002 3be00000 7d3e4b78 3bbd0c20 3b600000
> [    4.409867] init[74]: code: 3b9d0040 7c7fe02e 2f830000 419e0028 <89230000> 2f890000 41be001c 4b7f6e79
> 
> This patch fixes it by preparing complete lines in a buffer and
> printing it at once.
> 
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: no change
>  v2: Using seq_buf and reworked the loop to avoid redundant prints.
> 
>  arch/powerpc/kernel/process.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e108e1ef2b85..2a39f7aca846 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -43,6 +43,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/elf-randomize.h>
>  #include <linux/pkeys.h>
> +#include <linux/seq_buf.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> @@ -1303,33 +1304,33 @@ static void show_instructions(struct pt_regs *regs)
>  void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
> -	int i;
> +	int n = instructions_to_print;
> +	struct seq_buf s;
> +	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  
>  	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>  
> -	pr_info("%s[%d]: code: ", current->comm, current->pid);
> +	seq_buf_init(&s, buf, sizeof(buf));
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> -		int instr;
> +	while (n) {
> +		int i;
>  
> -		if (!(i % 8) && (i > 0)) {
> -			pr_cont("\n");
> -			pr_info("%s[%d]: code: ", current->comm, current->pid);
> -		}
> +		seq_buf_clear(&s);
>  
> -		if (probe_kernel_address((const void *)pc, instr)) {
> -			pr_cont("XXXXXXXX ");
> -		} else {
> -			if (regs->nip == pc)
> -				pr_cont("<%08x> ", instr);
> -			else
> -				pr_cont("%08x ", instr);
> +		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
> +			int instr;
> +
> +			if (probe_kernel_address((const void *)pc, instr)) {
> +				seq_buf_puts(&s, "XXXXXXXX ");
> +				continue;
> +			}
> +			seq_buf_printf(&s, regs->nip == pc ? "<%08x> " : "%08x ", instr);
>  		}
>  
> -		pc += sizeof(int);
> +		if (!seq_buf_has_overflowed(&s))
> +			pr_info("%s[%d]: code: %s\n", current->comm,
> +				current->pid, s.buffer);
>  	}
> -
> -	pr_cont("\n");
>  }
>  
>  struct regbit {
> -- 
> 2.13.3
> 

-- 
Murilo
