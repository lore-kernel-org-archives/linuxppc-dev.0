Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbyHC5DGQzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 14:28:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
In-Reply-To: <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 14:28:39 +1000
Message-ID: <87inhgb4zs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Hi Ben,
>
> Le 24/07/2017 =C3=A0 06:28, Benjamin Herrenschmidt a =C3=A9crit :
>> Instead of comparing the whole CPU mask every time, let's
>> keep a counter of how many bits are set in the mask. Thus
>> testing for a local mm only requires testing if that counter
>> is 1 and the current CPU bit is set in the mask.
>
>
> I'm trying to see if we could merge this patch with what I'm trying to=20
> do to mark a context as requiring global TLBIs.
> In http://patchwork.ozlabs.org/patch/796775/
> I'm introducing a 'flags' per memory context, using one bit to say if=20
> the context needs global TLBIs.
> The 2 could co-exist, just checking... Do you think about using the=20
> actual active_cpus count down the road, or is it just a matter of=20
> knowing if there are more than one active cpus?

Currently it's just an optimisation to save comparing the full cpumask
every time to detect if we can go local vs broadcast.

So if you increment it then it will mean we do broadcast, which is what
you need.

It's possible in future we might try to do something more complicated,
like send targeted IPIs etc. But if we ever do that we can adapt CXL
then.

cheers
