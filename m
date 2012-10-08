Return-Path: <andi@firstfloor.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 10FEB2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2012 15:37:03 +1100 (EST)
From: Andi Kleen <andi@firstfloor.org>
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH 8/10] memory-hotplug : remove page table of x86_64
 architecture
References: <506E43E0.70507@jp.fujitsu.com> <506E4799.30407@jp.fujitsu.com>
Date: Sun, 07 Oct 2012 21:37:00 -0700
In-Reply-To: <506E4799.30407@jp.fujitsu.com> (Yasuaki Ishimatsu's message of
 "Fri, 5 Oct 2012 11:36:09 +0900")
Message-ID: <m2d30tvatv.fsf@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com> writes:
> +			}
> +
> +			/*
> +			 * We use 2M page, but we need to remove part of them,
> +			 * so split 2M page to 4K page.
> +			 */
> +			pte = alloc_low_page(&pte_phys);

What happens when the allocation fails?

alloc_low_page seems to be buggy there too, it would __pa a NULL 
pointer.

> +		if (pud_large(*pud)) {
> +			if ((addr & ~PUD_MASK) == 0 && next <= end) {
> +				set_pud(pud, __pud(0));
> +				pages++;
> +				continue;
> +			}
> +
> +			/*
> +			 * We use 1G page, but we need to remove part of them,
> +			 * so split 1G page to 2M page.
> +			 */
> +			pmd = alloc_low_page(&pmd_phys);

Same here

> +			__split_large_page((pte_t *)pud, addr, (pte_t *)pmd);
> +
> +			spin_lock(&init_mm.page_table_lock);
> +			pud_populate(&init_mm, pud, __va(pmd_phys));
> +			spin_unlock(&init_mm.page_table_lock);
> +		}
> +
> +		pmd = map_low_page(pmd_offset(pud, 0));
> +		phys_pmd_remove(pmd, addr, end);
> +		unmap_low_page(pmd);
> +		__flush_tlb_all();
> +	}
> +	__flush_tlb_all();

This doesn't flush the other CPUs doesn't it?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
