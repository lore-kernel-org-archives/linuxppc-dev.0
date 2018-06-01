Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yHlx5VSXzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 07:39:25 +1000 (AEST)
Date: Fri, 1 Jun 2018 16:38:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: Fix compiler store ordering to SLB shadow
 area
Message-ID: <20180601213851.GW17342@gate.crashing.org>
References: <20180530103122.27674-1-npiggin@gmail.com>
 <87tvqnykf6.fsf@concordia.ellerman.id.au>
 <20180601085227.45008311@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601085227.45008311@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 01, 2018 at 08:52:27AM +1000, Nicholas Piggin wrote:
> On Fri, 01 Jun 2018 00:22:21 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Nicholas Piggin <npiggin@gmail.com> writes:
> > > -	p->save_area[index].esid = 0;
> > > -	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
> > > -	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
> > > +	WRITE_ONCE(p->save_area[index].esid, 0);
> > > +	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
> > > +	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));  
> > 
> > What's the code-gen for that look like? I suspect it's terrible?
> 
> Yeah it's not great.
> 
> > 
> > Should we just do it in inline-asm I wonder?

That is my recommendation: that will work for all compiler versions.

> There should be no fundamental correctness reason why we can't store
> to a volatile with a byteswap store.

There are may operations that are *not* correct to merge into a volatile
memory access, and which are fine is different for every arch.  GCC
simply disallows combining anything into any volatile memory by default.
This is kind of fine because volatile already means "I want this to go
slow", in common cases ;-)

I'll see what I can do to make the byteswap load/stores work with volatile
(for powerpc).

> The other option we could do is
> add a compiler barrier() between each store. The reason I didn't is
> that in theory we don't need to invalidate all memory contents here,
> but in practice probably the end result code generation would be
> better.

Something like

	p->save_area[index].esid = 0;
	asm("" : : "m"(p->save_area[index].esid));
	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
	asm("" : : "m"(p->save_area[index].vsid));
	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));

should do the trick (and once again for the second write to esid, if you
want to be sure it is not optimised away).


Segher
