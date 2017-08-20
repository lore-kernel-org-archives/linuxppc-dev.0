Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZwkk611mzDqfg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 22:15:26 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id i12so4685696pgr.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 05:15:26 -0700 (PDT)
Date: Sun, 20 Aug 2017 21:11:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
Message-ID: <20170820121155.GA624@tigerII.localdomain>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (08/18/17 00:05), Laurent Dufour wrote:
[..]
> +	/*
> +	 * MPOL_INTERLEAVE implies additional check in mpol_misplaced() which
> +	 * are not compatible with the speculative page fault processing.
> +	 */
> +	pol = __get_vma_policy(vma, address);
> +	if (!pol)
> +		pol = get_task_policy(current);
> +	if (pol && pol->mode == MPOL_INTERLEAVE)
> +		goto unlock;

include/linux/mempolicy.h defines

struct mempolicy *get_task_policy(struct task_struct *p);
struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
		unsigned long addr);

only for CONFIG_NUMA configs.

	-ss
