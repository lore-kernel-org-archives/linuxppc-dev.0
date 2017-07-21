Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDcff43TQzDqvB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 03:08:26 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LH82Vs089206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 13:08:24 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2buh1s5btk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 13:08:24 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 21 Jul 2017 11:08:23 -0600
Date: Fri, 21 Jul 2017 10:08:18 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] powerpc/xmon: support dumping software pagetables
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20170721052406.28960-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170721052406.28960-1-bsingharora@gmail.com>
Message-Id: <20170721170818.GC5529@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2017 at 03:24:05PM +1000, Balbir Singh wrote:
> It would be nice to be able to dump page tables in a
> particular context
> 
> Example use cases
> 
> Dumping PTE contents to see the keys (useful for debugging)
> 
> c0000000ba48c880 c0000000bab438b0   2677   2675 T  2 protection_keys
> 0:mon> ds c0000000ba48c880 0x7ffff7f70000
> translating tsk c0000000ba48c880, addr 7ffff7f70000
> G: 0xb95b6400   U: 0xb6334000   M: 0xb6543000   PA: 0x012c0000, PTE: 0xd4800000012c0504
> 
> Dumping vmalloc space
> 
> 0:mon> ds 0 d000000000000000
> translating tsk           (null), addr d000000000000000
> G: 0x3d450400   U: 0xbc184000   M: 0x3d460000   PA: 0x7e010000, PTE: 0xc08000007e01018e
> 
> I did not replicate the complex code of dump_pagetable and have no support
> for bolted linear mapping, thats why I've called it software pagetable
> dumping support. The format of the PTE can be expanded to add more useful
> information about the flags in the PTE if required.

yes. a nice way of dumping all the flags in the PTE will be handy.
especially; my favorite, protection key values.

> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/xmon/xmon.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 08e367e..8aedfff 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -126,6 +126,7 @@ static void byterev(unsigned char *, int);
>  static void memex(void);
>  static int bsesc(void);
>  static void dump(void);
> +static void show_pte(unsigned long);
>  static void prdump(unsigned long, long);
>  static int ppc_inst_dump(unsigned long, long, int);
>  static void dump_log_buf(void);
> @@ -233,6 +234,7 @@ Commands:\n\
>  #endif
>    "\
>    dr	dump stream of raw bytes\n\
> +  ds	dump software PTEs\n\
>    dt	dump the tracing buffers (uses printk)\n\
>  "
>  #ifdef CONFIG_PPC_POWERNV
> @@ -2528,6 +2530,9 @@ dump(void)
>  	} else if (c == 't') {
>  		ftrace_dump(DUMP_ALL);
>  		tracing_on();
> +	} else if (c == 's') {
> +		/* dump software pte */
> +		show_pte(adrs);
>  	} else if (c == 'r') {
>  		scanhex(&ndump);
>  		if (ndump == 0)
> @@ -2860,7 +2865,99 @@ static void show_task(struct task_struct *tsk)
>  		state, task_thread_info(tsk)->cpu,
>  		tsk->comm);
>  }
> +void format_pte(unsigned long pte)
> +{
> +	unsigned long pa = pte & PTE_RPN_MASK;
> +
> +	printf("PA: 0x%08lx, PTE: 0x%08lx\n", pa, pte);
> +}
> +
> +static void show_pte(unsigned long tskv)
> +{
> +	unsigned long addr = 0;
> +	struct task_struct *tsk = NULL;
> +	struct mm_struct *mm;
> +	pgd_t *pgdp;
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +
> +	tsk = (struct task_struct *)tskv;
> +	if (tsk == NULL)
> +		mm = &init_mm;
> +	else
> +		mm = tsk->active_mm;
> +
> +	if (mm == NULL)
> +		mm = &init_mm;
> +
> +	if (!scanhex(&addr))
> +		printf("need address to translate\n");
> +
> +	if (setjmp(bus_error_jmp) != 0) {
> +		catch_memory_errors = 0;
> +		printf("*** Error dumping pte for task %p\n", tsk);
> +		return;
> +	}
> +
> +	catch_memory_errors = 1;
> +	sync();
> +
> +	if (mm == &init_mm)
> +		pgdp = pgd_offset_k(addr);
> +	else
> +		pgdp = pgd_offset(mm, addr);
> +
> +	if (pgd_none(*pgdp)) {
> +		printf("no linux page table for address\n");
> +		return;
> +	}
> 
> +	if (pgd_huge(*pgdp)) {
> +		format_pte(pgd_val(*pgdp));
> +		return;
> +	}
> +	printf("G: 0x%8lx\t", pgd_val(*pgdp));
> +
> +	pudp = pud_offset(pgdp, addr);
> +
> +	if (pud_none(*pudp)) {
> +		printf("No valid PUD\n");
> +		return;
> +	}
> +
> +	if (pud_huge(*pudp)) {
> +		format_pte(pud_val(*pudp));
> +		return;
> +	}
> +	printf("U: 0x%8lx\t", pud_val(*pudp));
> +
> +	pmdp = pmd_offset(pudp, addr);
> +
> +	if (pmd_none(*pmdp)) {
> +		printf("No valid PMD\n");
> +		return;
> +	}
> +
> +	if (pmd_huge(*pmdp)) {
> +		format_pte(pmd_val(*pmdp));
> +		return;
> +	}
> +	printf("M: 0x%8lx\t", pmd_val(*pmdp));
> +
> +	/* pte_offset_map is the same as pte_offset_kernel */
> +	ptep = pte_offset_kernel(pmdp, addr);
> +	if (pte_none(*ptep)) {
> +		printf("no valid PTE\n");
> +		return;
> +	}
> +
> +	format_pte(pte_val(*ptep));
> +

These two lines below always go togather. A nice macro
#define sync_delay() { sync(); __delay(200); }
can help.

> +	sync();
> +	__delay(200);


> +	catch_memory_errors = 0;


> +}
>  static void show_tasks(void)
>  {
>  	unsigned long tskv;
> -- 
> 2.9.4

-- 
Ram Pai
