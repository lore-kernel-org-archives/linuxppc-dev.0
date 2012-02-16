Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A02C11007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 07:32:01 +1100 (EST)
Message-ID: <1329424301.2892.23.camel@pasglop>
Subject: Re: tlb flushing on Power
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2012 07:31:41 +1100
In-Reply-To: <4F3D38D3.4020903@linux.vnet.ibm.com>
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com> <1328735054.2903.29.camel@pasglop>
 <4F356C7E.3070608@linux.vnet.ibm.com> <4F3D38D3.4020903@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-16 at 11:11 -0600, Seth Jennings wrote:

> Just wanted to bump you again about this.  You mentioned that if I wanted to
> do a cpu-local flush of a single tlb entry, that there would have to be a new
> hook.  Is that right?
> 
> I've been looking through the powerpc arch and I thought that I might have
> found the power analog to __flush_tlb_one() for x86 in local_flush_tlb_page()
> with a NULL vma argument.  This doesn't seem to work though, as indicated
> by a crash when I tried it.  After looking in tlbflush.h again, it seems
> that local_flush_tlb_page() is a no-op when CONFIG_PPC_STD_MMU_64 is set,
> as are almost ALL of the tlb flushing functions... which makes no sense to
> me.
> 
> Any help you (or anyone) can give me would be greatly appreciated.

On ppc64 with hash-table MMU, we handle the flushes very differently.
PTEs that are modified are added to a list at the time of the
modification and either flushed immediately if no lazy tlb batching is
in progress or flushed when leaving the lazy tlb op.

This is to avoid a problem where we might otherwise, under some
circumstances, create a new TLB which can be hashed in to the hash table
before the previous one has been flushed out. That would lead to a dup
in the hash table which is architecturally illegal.

This happens via the call to hpte_need_flush() in pte_update().

Unfortunately, it will always consider all kernel mappings as global,
so the per-cpu "optimization" won't be usable in this case, at least
not until we add some kind of additional argument to that function.

Cheers,
Ben.
