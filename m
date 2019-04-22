Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D041BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 15:53:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF6B2077C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 15:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF6B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nrhk0CJgzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 01:53:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nrg20BV5zDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 01:51:56 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBD2C307D867;
 Mon, 22 Apr 2019 15:51:52 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 730DE5D9D4;
 Mon, 22 Apr 2019 15:51:44 +0000 (UTC)
Date: Mon, 22 Apr 2019 11:51:42 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 09/31] mm: VMA sequence count
Message-ID: <20190422155142.GD3450@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-10-ldufour@linux.ibm.com>
 <20190418224857.GI11645@redhat.com>
 <d217e71c-7d55-ce1a-6461-ce1de732fb57@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d217e71c-7d55-ce1a-6461-ce1de732fb57@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 22 Apr 2019 15:51:53 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 Haiyan Song <haiyanx.song@intel.com>, npiggin@gmail.com, sj38.park@gmail.com,
 dave@stgolabs.net, kemi.wang@intel.com, kirill@shutemov.name,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 19, 2019 at 05:45:57PM +0200, Laurent Dufour wrote:
> Hi Jerome,
> 
> Thanks a lot for reviewing this series.
> 
> Le 19/04/2019 à 00:48, Jerome Glisse a écrit :
> > On Tue, Apr 16, 2019 at 03:45:00PM +0200, Laurent Dufour wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > Wrap the VMA modifications (vma_adjust/unmap_page_range) with sequence
> > > counts such that we can easily test if a VMA is changed.
> > > 
> > > The calls to vm_write_begin/end() in unmap_page_range() are
> > > used to detect when a VMA is being unmap and thus that new page fault
> > > should not be satisfied for this VMA. If the seqcount hasn't changed when
> > > the page table are locked, this means we are safe to satisfy the page
> > > fault.
> > > 
> > > The flip side is that we cannot distinguish between a vma_adjust() and
> > > the unmap_page_range() -- where with the former we could have
> > > re-checked the vma bounds against the address.
> > > 
> > > The VMA's sequence counter is also used to detect change to various VMA's
> > > fields used during the page fault handling, such as:
> > >   - vm_start, vm_end
> > >   - vm_pgoff
> > >   - vm_flags, vm_page_prot
> > >   - vm_policy
> > 
> > ^ All above are under mmap write lock ?
> 
> Yes, changes are still made under the protection of the mmap_sem.
> 
> > 
> > >   - anon_vma
> > 
> > ^ This is either under mmap write lock or under page table lock
> > 
> > So my question is do we need the complexity of seqcount_t for this ?
> 
> The sequence counter is used to detect write operation done while readers
> (SPF handler) is running.
> 
> The implementation is quite simple (here without the lockdep checks):
> 
> static inline void raw_write_seqcount_begin(seqcount_t *s)
> {
> 	s->sequence++;
> 	smp_wmb();
> }
> 
> I can't see why this is too complex here, would you elaborate on this ?
> 
> > 
> > It seems that using regular int as counter and also relying on vm_flags
> > when vma is unmap should do the trick.
> 
> vm_flags is not enough I guess an some operation are not impacting the
> vm_flags at all (resizing for instance).
> Am I missing something ?
> 
> > 
> > vma_delete(struct vm_area_struct *vma)
> > {
> >      ...
> >      /*
> >       * Make sure the vma is mark as invalid ie neither read nor write
> >       * so that speculative fault back off. A racing speculative fault
> >       * will either see the flags as 0 or the new seqcount.
> >       */
> >      vma->vm_flags = 0;
> >      smp_wmb();
> >      vma->seqcount++;
> >      ...
> > }
> 
> Well I don't think we can safely clear the vm_flags this way when the VMA is
> unmap, I think it is used later when cleaning is doen.
> 
> Later in this series, the VMA deletion is managed when the VMA is unlinked
> from the RB Tree. That is checked using the vm_rb field's value, and managed
> using RCU.
> 
> > Then:
> > speculative_fault_begin(struct vm_area_struct *vma,
> >                          struct spec_vmf *spvmf)
> > {
> >      ...
> >      spvmf->seqcount = vma->seqcount;
> >      smp_rmb();
> >      spvmf->vm_flags = vma->vm_flags;
> >      if (!spvmf->vm_flags) {
> >          // Back off the vma is dying ...
> >          ...
> >      }
> > }
> > 
> > bool speculative_fault_commit(struct vm_area_struct *vma,
> >                                struct spec_vmf *spvmf)
> > {
> >      ...
> >      seqcount = vma->seqcount;
> >      smp_rmb();
> >      vm_flags = vma->vm_flags;
> > 
> >      if (spvmf->vm_flags != vm_flags || seqcount != spvmf->seqcount) {
> >          // Something did change for the vma
> >          return false;
> >      }
> >      return true;
> > }
> > 
> > This would also avoid the lockdep issue described below. But maybe what
> > i propose is stupid and i will see it after further reviewing thing.
> 
> That's true that the lockdep is quite annoying here. But it is still
> interesting to keep in the loop to avoid 2 subsequent write_seqcount_begin()
> call being made in the same context (which would lead to an even sequence
> counter value while write operation is in progress). So I think this is
> still a good thing to have lockdep available here.

Ok so i had to read everything and i should have read everything before
asking all of the above. It does look good in fact, what worried my in
this patch is all the lockdep avoidance as it is usualy a red flags.

But after thinking long and hard i do not see how to easily solve that
one as unmap_page_range() is in so many different path... So what is done
in this patch is the most sane thing. Sorry for the noise.

So for this patch:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
