Return-Path: <srs0=m2dg=bp=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFkV71RPwzDrJH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 14:35:11 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yFkV65lmxz8vqB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 14:35:10 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yFkV61F1yz9sPk
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 14:35:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9G3Y2xv112007
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2017 23:35:01 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dm9pt2n6q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2017 23:35:01 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 16 Oct 2017 04:35:00 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9G3YuED28639484
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 03:34:57 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9G3YvxK020006
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 14:34:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3] powerpc/xmon: Support dumping software pagetables
In-Reply-To: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
References: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
Date: Mon, 16 Oct 2017 09:04:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9p7hijp.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> From: Balbir Singh <bsingharora@gmail.com>
>
> It would be nice to be able to dump page tables in a particular
> context.
>
> eg: dumping vmalloc space:
>
>   0:mon> dv 0xd00037fffff00000
>   pgd  @ 0xc0000000017c0000
>   pgdp @ 0xc0000000017c00d8 = 0x00000000f10b1000
>   pudp @ 0xc0000000f10b13f8 = 0x00000000f10d0000
>   pmdp @ 0xc0000000f10d1ff8 = 0x00000000f1102000
>   ptep @ 0xc0000000f1102780 = 0xc0000000f1ba018e
>   Maps physical address = 0x00000000f1ba0000
>   Flags = Accessed Dirty Read Write
>
> This patch does not replicate the complex code of dump_pagetable and
> has no support for bolted linear mapping, thats why I've it's called
> dump virtual page table support. The format of the PTE can be expanded
> even further to add more useful information about the flags in the PTE
> if required.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> [mpe: Bike shed the output format, show the pgdir]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/xmon/xmon.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a41392dec822..d84bead0ac28 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -127,6 +127,7 @@ static void byterev(unsigned char *, int);
>  static void memex(void);
>  static int bsesc(void);
>  static void dump(void);
> +static void show_pte(unsigned long);
>  static void prdump(unsigned long, long);
>  static int ppc_inst_dump(unsigned long, long, int);
>  static void dump_log_buf(void);
> @@ -234,6 +235,7 @@ Commands:\n\
>  #endif
>    "\
>    dr	dump stream of raw bytes\n\
> +  dv	dump virtual address translation \n\
>    dt	dump the tracing buffers (uses printk)\n\
>    dtc	dump the tracing buffers for current CPU (uses printk)\n\
>  "
> @@ -2639,6 +2641,9 @@ dump(void)
>  		dump_log_buf();
>  	} else if (c == 'o') {
>  		dump_opal_msglog();
> +	} else if (c == 'v') {
> +		/* dump virtual to physical translation */
> +		show_pte(adrs);
>  	} else if (c == 'r') {
>  		scanhex(&ndump);
>  		if (ndump == 0)
> @@ -2972,6 +2977,112 @@ static void show_task(struct task_struct *tsk)
>  		tsk->comm);
>  }
>  
> +void format_pte(void *ptep, unsigned long pte)
> +{
> +	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);;
> +	printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
> +
> +	printf("Flags = %s%s%s%s%s\n",
> +	       (pte & _PAGE_ACCESSED) ? "Accessed " : "",
> +	       (pte & _PAGE_DIRTY)    ? "Dirty " : "",
> +	       (pte & _PAGE_READ)     ? "Read " : "",
> +	       (pte & _PAGE_WRITE)    ? "Write " : "",
> +	       (pte & _PAGE_EXEC)     ? "Exec " : "");
> +}
> +
> +static void show_pte(unsigned long addr)
> +{
> +	unsigned long tskv = 0;
> +	struct task_struct *tsk = NULL;
> +	struct mm_struct *mm;
> +	pgd_t *pgdp, *pgdir;
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +
> +	if (!scanhex(&tskv))
> +		mm = &init_mm;
> +	else
> +		tsk = (struct task_struct *)tskv;
> +
> +	if (tsk == NULL)
> +		mm = &init_mm;
> +	else
> +		mm = tsk->active_mm;
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
> +	if (mm == &init_mm) {
> +		pgdp = pgd_offset_k(addr);
> +		pgdir = pgd_offset_k(0);
> +	} else {
> +		pgdp = pgd_offset(mm, addr);
> +		pgdir = pgd_offset(mm, 0);
> +	}
> +
> +	if (pgd_none(*pgdp)) {
> +		printf("no linux page table for address\n");
> +		return;
> +	}
> +
> +	printf("pgd  @ 0x%016lx\n", pgdir);
> +
> +	if (pgd_huge(*pgdp)) {
> +		format_pte(pgdp, pgd_val(*pgdp));
> +		return;
> +	}
> +	printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
> +
> +	pudp = pud_offset(pgdp, addr);
> +
> +	if (pud_none(*pudp)) {
> +		printf("No valid PUD\n");
> +		return;
> +	}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +	if (pud_huge(*pudp)) {
> +		format_pte(pudp, pud_val(*pudp));
> +		return;
> +	}
> +#endif

For page table walking code we don't need to put #ifdef here. Also how
should we handle address that we map at pmd level even if hugetlb page
is disabled ? (kernel linear mapping). Also where do we handle THP
mapping ? You may want to look at __find_linux_pte() to write a page
table walking code. or better use the helper.

-aneesh
