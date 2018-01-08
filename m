Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFq756LdSzF0cK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 09:04:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 npiggin@gmail.com, anton@samba.org, mikey@neuling.org, oohall@gmail.com
Subject: Re: [PATCH 03/11] powerpc/64s: Simple RFI macro conversions
In-Reply-To: <20180108210123.GA9895@fergus.ozlabs.ibm.com>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-3-mpe@ellerman.id.au>
 <20180108170951.GB6176@hirez.programming.kicks-ass.net>
 <20180108210123.GA9895@fergus.ozlabs.ibm.com>
Date: Tue, 09 Jan 2018 09:04:10 +1100
Message-ID: <871sj09fdx.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Jan 08, 2018 at 06:09:51PM +0100, Peter Zijlstra wrote:
>> On Tue, Jan 09, 2018 at 03:54:45AM +1100, Michael Ellerman wrote:
>> > diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
>> > index 42a4b237df5f..34a5adeff084 100644
>> > --- a/arch/powerpc/kvm/book3s_rmhandlers.S
>> > +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
>> > @@ -46,6 +46,9 @@
>> >  
>> >  #define FUNC(name)		name
>> >  
>> > +#define RFI_TO_KERNEL	RFI
>> > +#define RFI_TO_GUEST	RFI
>> > +
>> >  .macro INTERRUPT_TRAMPOLINE intno
>> >  
>> >  .global kvmppc_trampoline_\intno
>> 
>> Leftovers? The previous patch seems to define all that in common
>> headers, why redefine here again?
>
> Not leftovers - this is for the sake of 32-bit compiles.  There is
> code in this file and in book3s_segment.S which gets used both for
> 32-bit and 64-bit kernels, and this is supplying a definition on
> 32-bit platforms.  Without this, 32-bit builds that have PR KVM
> configured will fail.

Yep.

I was going to put all the RFI macros in a single header, and we could
then have the dummy versions in there as would the usual pattern. But at
this stage it would just complicate life for people doing distro
backports, so I'll do that as a cleanup once it's all merged.

cheers
