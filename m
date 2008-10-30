Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EC85DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 01:04:02 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9UE3uOH019531
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:03:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9UE3u9g051246
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:03:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9UE3ufI007067
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:03:56 -0400
Date: Thu, 30 Oct 2008 10:03:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: [PATCH] PPC40x: Limit Allocable RAM During Early Mapping
Message-ID: <20081030100353.240e795b@zod.rchland.ibm.com>
In-Reply-To: <1225316474-29035-1-git-send-email-gerickson@nuovations.com>
References: <1225316474-29035-1-git-send-email-gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Oct 2008 14:41:14 -0700
Grant Erickson <gerickson@nuovations.com> wrote:

> If the size of RAM is not an exact power of two, we may not have
> covered RAM in its entirety with large 16 and 4 MiB
> pages. Consequently, restrict the top end of RAM currently allocable
> by updating '__initial_memory_limit_addr' so that calls to the LMB to
> allocate PTEs for "tail" coverage with normal-sized pages (or other
> reasons) do not attempt to allocate outside the allowed range.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> ---
> 
> This bug was discovered in the course of working on CONFIG_LOGBUFFER support
> (see http://ozlabs.org/pipermail/linuxppc-dev/2008-October/064685.html).
> However, the bug is triggered quite easily independent of that feature
> by placing a memory limit via the 'mem=' kernel command line that results in
> a memory size that is not equal to an exact power of two.
> 
> For example, on the AMCC PowerPC 405EXr "Haleakala" board with 256 MiB
> of RAM, mmu_mapin_ram() normally covers RAM with precisely 16 16 MiB
> large pages. However, if a memory limit of 256 MiB - 20 KiB (as might
> be the case for CONFIG_LOGBUFFER) is put in place with
> "mem=268414976", then large pages only cover (16 MiB * 15) + (4 MiB *
> 3) = 252 MiB with a 4 MiB - 20 KiB "tail" to cover with normal, 4 KiB
> pages via map_page().
> 
> Unfortunately, if __initial_memory_limit_addr is not updated from its
> initial value of 0x1000 0000 (256 MiB) to reflect what was actually
> mapped via mmu_mapin_ram(), the following happens during the "tail"
> mapping when the first PTE is allocated at 0xFFF A000 (rather than the
> desired 0xFBF F000):
> 
>     mapin_ram
>         mmu_mapin_ram
>         map_page
>             pte_alloc_kernel
>                 pte_alloc_one_kernel
>                     early_get_page
>                         lmb_alloc_base
>                     clear_page
>                         clear_pages
>                             dcbz    0,page  <-- BOOM!
> 
> a non-recoverable page fault.

Nice catch.  I was looking to see if 44x had the same problem, but I
don't think it does because we simply over-map DRAM there.  Does that
seem correct to you, or am I missing something on 44x that would cause
this same problem?

josh
