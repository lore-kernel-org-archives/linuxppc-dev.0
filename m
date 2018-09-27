Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LQFk2NrHzF33Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 16:41:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, benh@kernel.crashing.org, Breno Leitao <leitao@debian.org>,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/tm: Avoid possible userspace r1 corruption on
 reclaim
In-Reply-To: <cc2f3d4526039cf71e4dac1c0a231e27d59cb4c0.camel@neuling.org>
References: <20180925093647.23723-1-mikey@neuling.org>
 <87d0t14wiz.fsf@concordia.ellerman.id.au>
 <cc2f3d4526039cf71e4dac1c0a231e27d59cb4c0.camel@neuling.org>
Date: Thu, 27 Sep 2018 16:41:45 +1000
Message-ID: <87d0szv3va.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:
> On Tue, 2018-09-25 at 22:00 +1000, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>> > Current we store the userspace r1 to PACATMSCRATCH before finally
>> > saving it to the thread struct.
>> > 
>> > In theory an exception could be taken here (like a machine check or
>> > SLB miss) that could write PACATMSCRATCH and hence corrupt the
>> > userspace r1. The SLB fault currently doesn't touch PACATMSCRATCH, but
>> > others do.
>> > 
>> > We've never actually seen this happen but it's theoretically
>> > possible. Either way, the code is fragile as it is.
>> > 
>> > This patch saves r1 to the kernel stack (which can't fault) before we
>> > turn MSR[RI] back on. PACATMSCRATCH is still used but only with
>> > MSR[RI] off. We then copy r1 from the kernel stack to the thread
>> > struct once we have MSR[RI] back on.
>> > 
>> > Suggested-by: Breno Leitao <leitao@debian.org>
>> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>> > ---
>> >  arch/powerpc/kernel/tm.S | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
>> > index 701b0f5b09..8207816a1e 100644
>> > --- a/arch/powerpc/kernel/tm.S
>> > +++ b/arch/powerpc/kernel/tm.S
>> > @@ -178,6 +178,12 @@ _GLOBAL(tm_reclaim)
>> >  
>> >  	std	r11, GPR11(r1)			/* Temporary stash */
>> >  
>> > +	/* Move r1 to kernel stack in case PACATMSCRATCH is used once
>> > +	 * we turn on RI
>> > +	 */
>> 
>> I see we still need to send you to Comment Formatting Re-Education Camp.
>
> The rest of that file has they style, so I'm just keeping with that.  I can
> submit a patch later to fix them all up.

Sure, but let's not add new ones.

And yeah fixing them all up in another patch would be good.

cheers
