Return-Path: <srs0=gx01=bp=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFmgB38xRzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:13:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yFmgB1MXJz8tMZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:13:10 +1100 (AEDT)
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yFmg851d2z9t2c
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 16:13:08 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id i35so8870858uah.9
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2017 22:13:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9p7hijp.fsf@linux.vnet.ibm.com>
References: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
 <87o9p7hijp.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:13:04 +1100
Message-ID: <CAKTCnzmRfNQNWt-basO+N8A6c=H2XJ=J1H4Z9fftRArgXWkmOw@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/xmon: Support dumping software pagetables
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 2:34 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> From: Balbir Singh <bsingharora@gmail.com>
>>
>> It would be nice to be able to dump page tables in a particular
>> context.
>>
>> eg: dumping vmalloc space:
>>
>>   0:mon> dv 0xd00037fffff00000
>>   pgd  @ 0xc0000000017c0000
>>   pgdp @ 0xc0000000017c00d8 = 0x00000000f10b1000
>>   pudp @ 0xc0000000f10b13f8 = 0x00000000f10d0000
>>   pmdp @ 0xc0000000f10d1ff8 = 0x00000000f1102000
>>   ptep @ 0xc0000000f1102780 = 0xc0000000f1ba018e
>>   Maps physical address = 0x00000000f1ba0000
>>   Flags = Accessed Dirty Read Write
>>
>> This patch does not replicate the complex code of dump_pagetable and
>> has no support for bolted linear mapping, thats why I've it's called
>> dump virtual page table support. The format of the PTE can be expanded
>> even further to add more useful information about the flags in the PTE
>> if required.
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> [mpe: Bike shed the output format, show the pgdir]
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/xmon/xmon.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index a41392dec822..d84bead0ac28 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -127,6 +127,7 @@ static void byterev(unsigned char *, int);
>>  static void memex(void);
>>  static int bsesc(void);
>>  static void dump(void);
>> +static void show_pte(unsigned long);
>>  static void prdump(unsigned long, long);
>>  static int ppc_inst_dump(unsigned long, long, int);
>>  static void dump_log_buf(void);
>> @@ -234,6 +235,7 @@ Commands:\n\
>>  #endif
>>    "\
>>    dr dump stream of raw bytes\n\
>> +  dv dump virtual address translation \n\
>>    dt dump the tracing buffers (uses printk)\n\
>>    dtc        dump the tracing buffers for current CPU (uses printk)\n\
>>  "
>> @@ -2639,6 +2641,9 @@ dump(void)
>>               dump_log_buf();
>>       } else if (c == 'o') {
>>               dump_opal_msglog();
>> +     } else if (c == 'v') {
>> +             /* dump virtual to physical translation */
>> +             show_pte(adrs);
>>       } else if (c == 'r') {
>>               scanhex(&ndump);
>>               if (ndump == 0)
>> @@ -2972,6 +2977,112 @@ static void show_task(struct task_struct *tsk)
>>               tsk->comm);
>>  }
>>
>> +void format_pte(void *ptep, unsigned long pte)
>> +{
>> +     printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);;
>> +     printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
>> +
>> +     printf("Flags = %s%s%s%s%s\n",
>> +            (pte & _PAGE_ACCESSED) ? "Accessed " : "",
>> +            (pte & _PAGE_DIRTY)    ? "Dirty " : "",
>> +            (pte & _PAGE_READ)     ? "Read " : "",
>> +            (pte & _PAGE_WRITE)    ? "Write " : "",
>> +            (pte & _PAGE_EXEC)     ? "Exec " : "");
>> +}
>> +
>> +static void show_pte(unsigned long addr)
>> +{
>> +     unsigned long tskv = 0;
>> +     struct task_struct *tsk = NULL;
>> +     struct mm_struct *mm;
>> +     pgd_t *pgdp, *pgdir;
>> +     pud_t *pudp;
>> +     pmd_t *pmdp;
>> +     pte_t *ptep;
>> +
>> +     if (!scanhex(&tskv))
>> +             mm = &init_mm;
>> +     else
>> +             tsk = (struct task_struct *)tskv;
>> +
>> +     if (tsk == NULL)
>> +             mm = &init_mm;
>> +     else
>> +             mm = tsk->active_mm;
>> +
>> +     if (setjmp(bus_error_jmp) != 0) {
>> +             catch_memory_errors = 0;
>> +             printf("*** Error dumping pte for task %p\n", tsk);
>> +             return;
>> +     }
>> +
>> +     catch_memory_errors = 1;
>> +     sync();
>> +
>> +     if (mm == &init_mm) {
>> +             pgdp = pgd_offset_k(addr);
>> +             pgdir = pgd_offset_k(0);
>> +     } else {
>> +             pgdp = pgd_offset(mm, addr);
>> +             pgdir = pgd_offset(mm, 0);
>> +     }
>> +
>> +     if (pgd_none(*pgdp)) {
>> +             printf("no linux page table for address\n");
>> +             return;
>> +     }
>> +
>> +     printf("pgd  @ 0x%016lx\n", pgdir);
>> +
>> +     if (pgd_huge(*pgdp)) {
>> +             format_pte(pgdp, pgd_val(*pgdp));
>> +             return;
>> +     }
>> +     printf("pgdp @ 0x%016lx = 0x%016lx\n", pgdp, pgd_val(*pgdp));
>> +
>> +     pudp = pud_offset(pgdp, addr);
>> +
>> +     if (pud_none(*pudp)) {
>> +             printf("No valid PUD\n");
>> +             return;
>> +     }
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +     if (pud_huge(*pudp)) {
>> +             format_pte(pudp, pud_val(*pudp));
>> +             return;
>> +     }
>> +#endif
>
> For page table walking code we don't need to put #ifdef here.

OK.. I designed this for both, I'll take the #ifdef out for kernel page tables.

 Also how
> should we handle address that we map at pmd level even if hugetlb page
> is disabled ? (kernel linear mapping). Also where do we handle THP
> mapping ? You may want to look at __find_linux_pte() to write a page
> table walking code. or better use the helper.

I wanted to avoid using __find_linux_pte in xmon(), it needs irq's disabled.
I found the interface a bit cumbersome. If I fix the #ifdef's and make the
walking code 64 bit only I think we should be OK? Do you agree?

Balbir Singh.

>
> -aneesh
>
