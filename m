Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428hS71JCGzF36t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 20:47:02 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id w14-v6so11147463plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 03:47:02 -0700 (PDT)
Date: Tue, 11 Sep 2018 20:46:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Don't use compound_order to
 determine host mapping size
Message-ID: <20180911204649.3123600b@roar.ozlabs.ibm.com>
In-Reply-To: <20180911100154.GC25158@fergus>
References: <20180904081601.32703-1-npiggin@gmail.com>
 <20180911100154.GC25158@fergus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 11 Sep 2018 20:01:54 +1000
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Tue, Sep 04, 2018 at 06:16:01PM +1000, Nicholas Piggin wrote:
> > THP paths can defer splitting compound pages until after the actual
> > remap and TLB flushes to split a huge PMD/PUD. This causes radix
> > partition scope page table mappings to get out of synch with the host
> > qemu page table mappings.
> > 
> > This results in random memory corruption in the guest when running
> > with THP. The easiest way to reproduce is use KVM baloon to free up
> > a lot of memory in the guest and then shrink the balloon to give the
> > memory back, while some work is being done in the guest.  
> 
> I'm hitting the WARN_ON you added.  I think I have an old qemu that
> doesn't 2M-align the guest ram and so we get to the level = 0 case
> because of misalignment.  The patch below on top of yours seems to
> work just fine.  In the case where the pte is 2M or 1G but we have
> misalignment, it ORs in address bits from hva into the pte so we get
> to the specific single page we want.
> 
> Care to fold this in and resend?

Thanks for that, I misunderstood the unaligned adjustment case.
Good thing you caught it.

Thanks,
Nick
