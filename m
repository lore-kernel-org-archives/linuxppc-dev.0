Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xjQx4GGnzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 08:52:41 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a3-v6so10344043pgt.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 15:52:40 -0700 (PDT)
Date: Fri, 1 Jun 2018 08:52:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Segher Boessenkool
 <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix compiler store ordering to SLB shadow
 area
Message-ID: <20180601085227.45008311@roar.ozlabs.ibm.com>
In-Reply-To: <87tvqnykf6.fsf@concordia.ellerman.id.au>
References: <20180530103122.27674-1-npiggin@gmail.com>
 <87tvqnykf6.fsf@concordia.ellerman.id.au>
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

On Fri, 01 Jun 2018 00:22:21 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The stores to update the SLB shadow area must be made as they appear
> > in the C code, so that the hypervisor does not see an entry with
> > mismatched vsid and esid. Use WRITE_ONCE for this.
> >
> > GCC has been observed to elide the first store to esid in the update,
> > which means that if the hypervisor interrupts the guest after storing
> > to vsid, it could see an entry with old esid and new vsid, which may
> > possibly result in memory corruption.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/mm/slb.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> > index 66577cc66dc9..2f4b33b24b3b 100644
> > --- a/arch/powerpc/mm/slb.c
> > +++ b/arch/powerpc/mm/slb.c
> > @@ -63,14 +63,14 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
> >  	 * updating it.  No write barriers are needed here, provided
> >  	 * we only update the current CPU's SLB shadow buffer.
> >  	 */
> > -	p->save_area[index].esid = 0;
> > -	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
> > -	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
> > +	WRITE_ONCE(p->save_area[index].esid, 0);
> > +	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
> > +	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));  
> 
> What's the code-gen for that look like? I suspect it's terrible?

Yeah it's not great.

> 
> Should we just do it in inline-asm I wonder?

There should be no fundamental correctness reason why we can't store
to a volatile with a byteswap store. The other option we could do is
add a compiler barrier() between each store. The reason I didn't is
that in theory we don't need to invalidate all memory contents here,
but in practice probably the end result code generation would be
better.

Thanks,
Nick
