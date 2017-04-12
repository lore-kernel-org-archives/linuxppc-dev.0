Return-Path: <rashmicy@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2rPX385tzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 14:22:55 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so2899246pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 21:22:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] powerpc/mm: add phys addr to linux page table dump
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170331013749.17874-1-oohall@gmail.com>
 <20170331013749.17874-2-oohall@gmail.com>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
From: Rashmica Gupta <rashmicy@gmail.com>
Message-ID: <a36aef1c-9310-2123-56a8-9eeea9540f0d@gmail.com>
Date: Wed, 12 Apr 2017 14:22:50 +1000
MIME-Version: 1.0
In-Reply-To: <20170331013749.17874-2-oohall@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 31/03/17 12:37, Oliver O'Halloran wrote:
> The current page table dumper scans the linux page tables and coalesces
> mappings with adjacent virtual addresses and similar PTE flags. This
> behaviour is somewhat broken when you consider the IOREMAP space where
> entirely unrelated mappings will appear to be contiguous.  This patch
> modifies the range coalescing so that only ranges that are both physically
> and virtually contiguous are combined. This patch also adds to the dump
> output the physical address at the start of each range.
>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>   arch/powerpc/mm/dump_linuxpagetables.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index e7cbfd5a0940..85e6a45bd7ee 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -56,6 +56,8 @@ struct pg_state {
>   	struct seq_file *seq;
>   	const struct addr_marker *marker;
>   	unsigned long start_address;
> +	unsigned long start_pa;
> +	unsigned long last_pa;
>   	unsigned int level;
>   	u64 current_flags;
>   };
> @@ -265,7 +267,9 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
>   	const char *unit = units;
>   	unsigned long delta;
>   
> -	seq_printf(st->seq, "0x%016lx-0x%016lx   ", st->start_address, addr-1);
> +	seq_printf(st->seq, "0x%016lx-0x%016lx ", st->start_address, addr-1);
> +	seq_printf(st->seq, "%016lx ", st->start_pa);
> +
>   	delta = (addr - st->start_address) >> 10;
>   	/* Work out what appropriate unit to use */
>   	while (!(delta & 1023) && unit[1]) {
> @@ -280,11 +284,15 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   	       unsigned int level, u64 val)
>   {
>   	u64 flag = val & pg_level[level].mask;
> +	u64 pa = val & PTE_RPN_MASK;
> +
>   	/* At first no level is set */
>   	if (!st->level) {
>   		st->level = level;
>   		st->current_flags = flag;
>   		st->start_address = addr;
> +		st->start_pa = pa;
> +		st->last_pa = pa;
>   		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
>   	/*
>   	 * Dump the section of virtual memory when:
> @@ -292,9 +300,11 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   	 *   - we change levels in the tree.
>   	 *   - the address is in a different section of memory and is thus
>   	 *   used for a different purpose, regardless of the flags.
> +	 *   - the pa of this page is not adjacent to the last inspected page
>   	 */
>   	} else if (flag != st->current_flags || level != st->level ||
> -		   addr >= st->marker[1].start_address) {
> +		   addr >= st->marker[1].start_address ||
> +		   pa != st->last_pa + PAGE_SIZE) {
>   
>   		/* Check the PTE flags */
>   		if (st->current_flags) {
> @@ -318,8 +328,12 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
>   		}
>   		st->start_address = addr;
> +		st->start_pa = pa;
> +		st->last_pa = pa;
>   		st->current_flags = flag;
>   		st->level = level;
> +	} else {
> +		st->last_pa = pa;
>   	}
>   }
>   
Makes sense to me!
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
