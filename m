Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWJV41LcrzDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 00:51:55 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id l64so11056349pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 07:51:55 -0700 (PDT)
Date: Tue, 15 Aug 2017 00:51:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit
 for early allocations
Message-ID: <20170815005140.65ac7c7a@roar.ozlabs.ibm.com>
In-Reply-To: <1502716250.4493.25.camel@au1.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
 <1502716250.4493.25.camel@au1.ibm.com>
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

On Mon, 14 Aug 2017 23:10:50 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Mon, 2017-08-14 at 22:49 +1000, Michael Ellerman wrote:
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >   
> > > This removes the RMA limit on powernv platform, which constrains
> > > early allocations such as PACAs and stacks. There are still other
> > > restrictions that must be followed, such as bolted SLB limits, but
> > > real mode addressing has no constraints.  
> 
> For radix, should we consider making the PACAs chip/node local ?

Yes that's the main goal of the series. I had NUMAization patches
at the end. Just dropped them for now because some of them need
toplogy information that's not available (that's why I was asking
about moving unflattening earlier in boot, but we may be able to
move allocations later too).

Thanks,
Nick
