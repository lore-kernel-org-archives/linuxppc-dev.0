Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGN2Y24ZGzDqwh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 23:46:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
In-Reply-To: <20170724212533.195cb92b@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <20170724212533.195cb92b@roar.ozlabs.ibm.com>
Date: Mon, 24 Jul 2017 23:46:44 +1000
Message-ID: <87h8y2j6bf.fsf@concordia.ellerman.id.au>
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

> On Mon, 24 Jul 2017 14:28:02 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> Instead of comparing the whole CPU mask every time, let's
>> keep a counter of how many bits are set in the mask. Thus
>> testing for a local mm only requires testing if that counter
>> is 1 and the current CPU bit is set in the mask.
...
>
> Also does it make sense to define it based on NR_CPUS > BITS_PER_LONG?
> If it's <= then it should be similar load and compare, no?

Do we make a machine with that few CPUs? ;)

I don't think it's worth special casing, all the distros run with much
much larger NR_CPUs than that.

cheers
