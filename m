Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtH9F5ly4zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 03:56:33 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 25 Apr 2016 03:46:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E64E53578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 03:46:21 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3OHkD2b4915622
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 03:46:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3OHjmmj005716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 03:45:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Mike Marciniszyn <infinipath@intel.com>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
In-Reply-To: <1461399949.3135.52.camel@kernel.crashing.org>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461278876.3135.18.camel@kernel.crashing.org>
 <20160422160927.GB12897@obsidianresearch.com>
 <1461399949.3135.52.camel@kernel.crashing.org>
Date: Sun, 24 Apr 2016 23:03:10 +0530
Message-ID: <87shyanc89.fsf@skywalker.in.ibm.com>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Fri, 2016-04-22 at 10:09 -0600, Jason Gunthorpe wrote:
>> On Fri, Apr 22, 2016 at 08:47:56AM +1000, Benjamin Herrenschmidt
>> wrote:
>> > 
>> > On Wed, 2016-04-20 at 03:58 -0400, Aneesh Kumar K.V wrote:
>> > > 
>> > > The driver was requesting for a writethrough mapping. But with
>> > > thoses
>> > > flags we will end up with a SAO mapping because we now have
>> > > memory
>> > > conherence always enabled. ie, the existing mapping will end up
>> > > with
>> > > a WIMG value 0b1110 which is Strong Access Order.
>> > > 
>> > > Update this to use cache inhibitted guarded mapping
>> > Why guarded ? If it's performance sensitive (and the driver has
>> > appropriate barriers where needed), you will get write combining
>> > without guarded, you won't with it.
>> This driver uses uncached write combining on x86
>
> Right so if you want something similar on power, use the _wc variant,
> and make sure you have the appropriate barriers when you need to
> break combining.
>
> Cheers,
> Ben.

The code after change looks like below

#if defined(__powerpc__)
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
#endif

	/*
	 * don't allow them to later change to readable with mprotect (for when
	 * not initially mapped readable, as is normally the case)
	 */
	vma->vm_flags &= ~VM_MAYREAD;
	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND;

	/* We used PAT if wc_cookie == 0 */
	if (!dd->wc_cookie)
		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);

So it uses pgprot_noncached_wc if (!dd->wc_cookie). Hence I was thinking
it needs more stricter mapping otherwise.

-aneesh
