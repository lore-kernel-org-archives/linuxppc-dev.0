Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 8FFF92C02C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 10:04:20 +1100 (EST)
Date: Mon, 4 Feb 2013 15:04:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v6 08/15] memory-hotplug: Common APIs to support page
 tables hot-remove
Message-Id: <20130204150417.2b1256b1.akpm@linux-foundation.org>
In-Reply-To: <1357723959-5416-9-git-send-email-tangchen@cn.fujitsu.com>
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-9-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, glommer@parallels.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2013 17:32:32 +0800
Tang Chen <tangchen@cn.fujitsu.com> wrote:

> +static void __meminit
> +remove_pagetable(unsigned long start, unsigned long end, bool direct)
> +{
> +	unsigned long next;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	bool pgd_changed = false;
> +
> +	for (; start < end; start = next) {
> +		pgd = pgd_offset_k(start);
> +		if (!pgd_present(*pgd))
> +			continue;
> +
> +		next = pgd_addr_end(start, end);
> +
> +		pud = (pud_t *)map_low_page((pud_t *)pgd_page_vaddr(*pgd));
> +		remove_pud_table(pud, start, next, direct);
> +		if (free_pud_table(pud, pgd))
> +			pgd_changed = true;
> +		unmap_low_page(pud);
> +	}
> +
> +	if (pgd_changed)
> +		sync_global_pgds(start, end - 1);
> +
> +	flush_tlb_all();
> +}

This generates a compiler warning saying that `next' may be used
uninitialised.

The warning is correct.  If we take that `continue' on the first pass
through the loop, the "start = next" will copy uninitialised data into
`start'.

Is this the correct fix?

--- a/arch/x86/mm/init_64.c~memory-hotplug-common-apis-to-support-page-tables-hot-remove-fix-fix-fix-fix-fix-fix-fix
+++ a/arch/x86/mm/init_64.c
@@ -993,12 +993,12 @@ remove_pagetable(unsigned long start, un
 	bool pgd_changed = false;
 
 	for (; start < end; start = next) {
+		next = pgd_addr_end(start, end);
+
 		pgd = pgd_offset_k(start);
 		if (!pgd_present(*pgd))
 			continue;
 
-		next = pgd_addr_end(start, end);
-
 		pud = (pud_t *)pgd_page_vaddr(*pgd);
 		remove_pud_table(pud, start, next, direct);
 		if (free_pud_table(pud, pgd))
_
