Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWrt76L9tzDrCV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 22:11:11 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u185so1260134pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:11:11 -0700 (PDT)
Date: Tue, 15 Aug 2017 22:10:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Suraj Jitindar Singh <surajjs@ozlabs.au.ibm.com>, kvm-ppc@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 3/9] powerpc/powernv: Remove real mode access limit
 for early allocations
Message-ID: <20170815221054.39ba5c9e@roar.ozlabs.ibm.com>
In-Reply-To: <1502716387.4493.27.camel@au1.ibm.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
 <20170813013346.14002-3-npiggin@gmail.com>
 <87h8xaqpp8.fsf@concordia.ellerman.id.au>
 <1502716387.4493.27.camel@au1.ibm.com>
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

On Mon, 14 Aug 2017 23:13:07 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Mon, 2017-08-14 at 22:49 +1000, Michael Ellerman wrote:
> > > -     /*
> > > -      * We limit the allocation that depend on ppc64_rma_size
> > > -      * to first_memblock_size. We also clamp it to 1GB to
> > > -      * avoid some funky things such as RTAS bugs.  
> > 
> > That comment about RTAS is 7 years old, and I'm pretty sure it was a
> > historical note when it was written.
> > 
> > I'm inclined to drop it and if we discover new bugs with RTAS on Power9
> > then we can always put it back.  
> 
> Arent' we using a 32-bit RTAS ? (Afaik there's a 64-bit one, we just
> never used it ..). In this case we need to at least clamp to 2G (no
> trust RTAS doing unsigned properly).

Is there any allocation not covered by RTAS_INSTANTIATE_MAX?

Thanks,
Nick
