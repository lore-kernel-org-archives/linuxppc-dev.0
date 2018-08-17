Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sN7h2594zDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 22:39:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HCcU81096321
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 08:39:41 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kwtte8jrm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 08:39:41 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 17 Aug 2018 08:39:41 -0400
Date: Fri, 17 Aug 2018 09:39:34 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/process: Constify the number of insns
 printed by show instructions functions.
References: <718cc9c9bd1d4bb2b4c2596f1a7ee00334e77055.1534192631.git.christophe.leroy@c-s.fr>
 <ae227d64c78e893b63ed71d911e016cb88212459.1534192631.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae227d64c78e893b63ed71d911e016cb88212459.1534192631.git.christophe.leroy@c-s.fr>
Message-Id: <20180817123934.GB7458@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Tue, Aug 14, 2018 at 08:59:20AM +0000, Christophe Leroy wrote:
> instructions_to_print var is assigned value 16 and there is no
> way to change it.
> 
> This patch replaces it by a constant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  arch/powerpc/kernel/process.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index c722ce4ca1c0..6317f2ed04ab 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1259,17 +1259,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
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
> @@ -1306,9 +1305,9 @@ void show_user_instructions(struct pt_regs *regs)
>  	char buf[96]; /* enough for 8 times 9 + 2 chars */
>  	int l = 0;
>  
> -	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
> +	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
> -	for (i = 0; i < instructions_to_print; i++) {
> +	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
>  		int instr;
>  
>  		if (!(i % 8) && (i > 0)) {
> -- 
> 2.13.3
> 

-- 
Murilo
