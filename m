Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGfQQ6JxjzDqxJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 10:34:54 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y25so4283205pfk.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:34:54 -0700 (PDT)
Date: Tue, 25 Jul 2017 10:34:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
Message-ID: <20170725103439.5a8851b5@roar.ozlabs.ibm.com>
In-Reply-To: <87h8y2j6bf.fsf@concordia.ellerman.id.au>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
 <87h8y2j6bf.fsf@concordia.ellerman.id.au>
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

On Mon, 24 Jul 2017 23:46:44 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Mon, 24 Jul 2017 14:28:02 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >  
> >> Instead of comparing the whole CPU mask every time, let's
> >> keep a counter of how many bits are set in the mask. Thus
> >> testing for a local mm only requires testing if that counter
> >> is 1 and the current CPU bit is set in the mask.  
> ...
> >
> > Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
> > If it's <= then it should be similar load and compare, no?  
> 
> Do we make a machine with that few CPUs? ;)
> 
> I don't think it's worth special casing, all the distros run with much
> much larger NR_CPUs than that.

Not further special-casing, but just casing it based on NR_CPUS
rather than BOOK3S.

Thanks,
Nick
