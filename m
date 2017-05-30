Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcW781bTNzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 21:08:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/fadump: add reschedule point while releasing
 memory
In-Reply-To: <149552604332.732.5139791860101612990.stgit@hbathini.in.ibm.com>
References: <149552604332.732.5139791860101612990.stgit@hbathini.in.ibm.com>
Date: Tue, 30 May 2017 21:08:16 +1000
Message-ID: <87zidu4n6n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> Around 95% of memory is reserved by fadump/capture kernel. All this
> memory is freed, one page at a time, on writing '1' to the node
> /sys/kernel/fadump_release_mem. On systems with large memory, this
> can take a long time to complete, leading to soft lockup warning
> messages. To avoid this, add reschedule points at regular intervals.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/fadump.c |   60 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 11 deletions(-)

I'm not sure this needs to be this complicated?

Can we just do something like:

	for (i = 0, addr = begin; addr < end; addr += PAGE_SIZE, i++) {
		/*
		 * exclude the dump reserve area. Will reuse it for next
		 * fadump registration.
		 */
		if (addr <= ra_end && ((addr + PAGE_SIZE) > ra_start))
			continue;

		free_reserved_page(pfn_to_page(addr >> PAGE_SHIFT));

		if (time_after(jiffies, time_limit)) {
			cond_resched();
			time_limit = jiffies + HZ;
		}
	}

cheers
