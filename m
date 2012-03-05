Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C7EE9B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 04:57:14 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Mon, 5 Mar 2012 10:57:10 -0700
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E932BC90050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 12:56:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q25HuhFh3457166
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2012 12:56:43 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q25HuhOD013912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2012 14:56:43 -0300
Message-ID: <4F54FE51.8070709@linux.vnet.ibm.com>
Date: Mon, 05 Mar 2012 11:56:33 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: tlb flushing on Power
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F32B354.7030306@linux.vnet.ibm.com> <1328735054.2903.29.camel@pasglop>
 <4F356C7E.3070608@linux.vnet.ibm.com> <4F3D38D3.4020903@linux.vnet.ibm.com>
 <1329424301.2892.23.camel@pasglop>
In-Reply-To: <1329424301.2892.23.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

Hey Ben,

Thanks for the help!  I was wondering if you could take a look at something
for me.

I've been working on this staging driver (zsmalloc memory allocator)
that does virtual mapping of two pages.

I have a github repo with the driver and the unsubmitted changes.  I'm
trying to make to get the pte/tlb stuff working in a portable way:

git://github.com/spartacus06/linux.git (portable branch)

The experimental commits are the top 5 and the branch is based on
Greg's staging-next + frontswap-v11 patches.

Could you take a look at the zs_map_object() and zs_unmap_object()
in drivers/staging/zsmalloc/zsmalloc-main.c and see if they should
work for PPC64?

I'm using set_pte_at() to map.  Then I'm using and ptep_get_and_clear()
and local_flush_tlb_kernel_page() to unmap (I #defined 
local_flush_tlb_kernel_page() to local_flush_tlb_page() for PPC64 which
is a no-op).

It will work most of the time, but then I'll get a crash and the 
mapped memory won't be what I expect.  I know the cause lies in the
virtual mapping because if I reduce the max_zspage_order to
1, preventing the "else" branch in zs_[un]map_object() from being
called, everything is stable.

Any feedback you (or others) can provide would be appreciated!

Thanks,
Seth

On 02/16/2012 02:31 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-02-16 at 11:11 -0600, Seth Jennings wrote:
> 
>> Just wanted to bump you again about this.  You mentioned that if I wanted to
>> do a cpu-local flush of a single tlb entry, that there would have to be a new
>> hook.  Is that right?
>>
>> I've been looking through the powerpc arch and I thought that I might have
>> found the power analog to __flush_tlb_one() for x86 in local_flush_tlb_page()
>> with a NULL vma argument.  This doesn't seem to work though, as indicated
>> by a crash when I tried it.  After looking in tlbflush.h again, it seems
>> that local_flush_tlb_page() is a no-op when CONFIG_PPC_STD_MMU_64 is set,
>> as are almost ALL of the tlb flushing functions... which makes no sense to
>> me.
>>
>> Any help you (or anyone) can give me would be greatly appreciated.
> 
> On ppc64 with hash-table MMU, we handle the flushes very differently.
> PTEs that are modified are added to a list at the time of the
> modification and either flushed immediately if no lazy tlb batching is
> in progress or flushed when leaving the lazy tlb op.
> 
> This is to avoid a problem where we might otherwise, under some
> circumstances, create a new TLB which can be hashed in to the hash table
> before the previous one has been flushed out. That would lead to a dup
> in the hash table which is architecturally illegal.
> 
> This happens via the call to hpte_need_flush() in pte_update().
> 
> Unfortunately, it will always consider all kernel mappings as global,
> so the per-cpu "optimization" won't be usable in this case, at least
> not until we add some kind of additional argument to that function.
> 
> Cheers,
> Ben.
> 
> 
