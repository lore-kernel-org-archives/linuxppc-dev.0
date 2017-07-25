Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGxf43V2bzDqmP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 22:01:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
In-Reply-To: <20170725103439.5a8851b5@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
 <87h8y2j6bf.fsf@concordia.ellerman.id.au>
 <20170725103439.5a8851b5@roar.ozlabs.ibm.com>
Date: Tue, 25 Jul 2017 22:00:59 +1000
Message-ID: <87zibs6804.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Mon, 24 Jul 2017 23:46:44 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > On Mon, 24 Jul 2017 14:28:02 +1000
>> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> >  
>> >> Instead of comparing the whole CPU mask every time, let's
>> >> keep a counter of how many bits are set in the mask. Thus
>> >> testing for a local mm only requires testing if that counter
>> >> is 1 and the current CPU bit is set in the mask.  
>> ...
>> >
>> > Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
>> > If it's <= then it should be similar load and compare, no?  
>> 
>> Do we make a machine with that few CPUs? ;)
>> 
>> I don't think it's worth special casing, all the distros run with much
>> much larger NR_CPUs than that.
>
> Not further special-casing, but just casing it based on NR_CPUS
> rather than BOOK3S.

The problem is the mm_context_t is defined based on BookE vs BookS etc.
not based on NR_CPUS.

So we'd have to add the atomic_t to all mm_context_t's, but #ifdef'ed
based on NR_CPUS.

But then some platforms don't support SMP, so it's a waste there. The
existing cpumask check compiles to ~= nothing on UP.

cheers
