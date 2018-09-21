Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H7g11ZP6zF3R1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 08:33:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LKODlI086265
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:25:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mn4u4pksb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:25:49 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 21 Sep 2018 14:25:48 -0600
Date: Fri, 21 Sep 2018 17:25:40 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/3] powerpc/process: Constify the number of insns
 printed by show instructions functions.
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
 <3fdf75eed98b1fa22da77e675692a86a7a9986a7.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3fdf75eed98b1fa22da77e675692a86a7a9986a7.1536327756.git.christophe.leroy@c-s.fr>
Message-Id: <20180921202540.GC19940@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 01:47:33PM +0000, Christophe Leroy wrote:
> instructions_to_print var is assigned value 16 and there is no
> way to change it.
> 
> This patch replaces it by a constant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: no change
>  v2: no change
> 
>  arch/powerpc/kernel/process.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 2a39f7aca846..7d86b4f7949e 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1261,17 +1261,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	return last;
>  }
>  
> -static int instructions_to_print = 16;
> +#define NR_INSN_TO_PRINT	16
>  
>  static void show_instructions(struct pt_regs *regs)
>  {
>  	int i;
> -	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> -			sizeof(int));
> +	unsigned long pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
>  	printk("Instruction dump:");
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> +	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
>  		int instr;
>  
>  		if (!(i % 8))
> @@ -1304,11 +1303,11 @@ static void show_instructions(struct pt_regs *regs)
>  void show_user_instructions(struct pt_regs *regs)
>  {
>  	unsigned long pc;
> -	int n = instructions_to_print;
> +	int n = NR_INSN_TO_PRINT;
>  	struct seq_buf s;
>  	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  
> -	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
> +	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
>  	seq_buf_init(&s, buf, sizeof(buf));
>  
> -- 
> 2.13.3
> 

-- 
Murilo
