Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y1t25pVjzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 21:13:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix compiler store ordering to SLB shadow
 area
In-Reply-To: <20180601085227.45008311@roar.ozlabs.ibm.com>
References: <20180530103122.27674-1-npiggin@gmail.com>
 <87tvqnykf6.fsf@concordia.ellerman.id.au>
 <20180601085227.45008311@roar.ozlabs.ibm.com>
Date: Fri, 01 Jun 2018 21:13:45 +1000
Message-ID: <87sh663gk6.fsf@concordia.ellerman.id.au>
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
> On Fri, 01 Jun 2018 00:22:21 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > The stores to update the SLB shadow area must be made as they appear
>> > in the C code, so that the hypervisor does not see an entry with
>> > mismatched vsid and esid. Use WRITE_ONCE for this.
>> >
>> > GCC has been observed to elide the first store to esid in the update,
>> > which means that if the hypervisor interrupts the guest after storing
>> > to vsid, it could see an entry with old esid and new vsid, which may
>> > possibly result in memory corruption.
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  arch/powerpc/mm/slb.c | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> > index 66577cc66dc9..2f4b33b24b3b 100644
>> > --- a/arch/powerpc/mm/slb.c
>> > +++ b/arch/powerpc/mm/slb.c
>> > @@ -63,14 +63,14 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
>> >  	 * updating it.  No write barriers are needed here, provided
>> >  	 * we only update the current CPU's SLB shadow buffer.
>> >  	 */
>> > -	p->save_area[index].esid = 0;
>> > -	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
>> > -	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
>> > +	WRITE_ONCE(p->save_area[index].esid, 0);
>> > +	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
>> > +	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));  
>> 
>> What's the code-gen for that look like? I suspect it's terrible?
>
> Yeah it's not great.

Actually with GCC 7 the WRITE_ONCE() doesn't make it any worse.

Which is a little suspicious. But it is doing the first store:

	li      r10,0			# r10 = 0
	ld      r29,56(r13)		# r29 = paca->slb_shadow_ptr
	rldicr  r8,r31,4,59		# r8 = index
	rldicr  r9,r9,32,31
	add     r29,r29,r8		# r29 = r29 + index
	oris    r9,r9,65535
	std     r10,16(r29)		# esid = r10 = 0

So I'll just merge this as-is.

cheers
