Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ1sz0LndzDvYL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 14:35:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
In-Reply-To: <20161125133559.21461ca1@roar.ozlabs.ibm.com>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
 <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
 <20161124122713.GC14394@gate.crashing.org>
 <87d1hktt5z.fsf@concordia.ellerman.id.au>
 <20161124231716.GB30675@gate.crashing.org>
 <20161125121300.111a70c0@roar.ozlabs.ibm.com>
 <8737igtip8.fsf@concordia.ellerman.id.au>
 <20161125133559.21461ca1@roar.ozlabs.ibm.com>
Date: Fri, 25 Nov 2016 14:35:02 +1100
Message-ID: <87zikos049.fsf@concordia.ellerman.id.au>
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

> On Fri, 25 Nov 2016 13:08:19 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > On Thu, 24 Nov 2016 17:17:16 -0600
>> > Segher Boessenkool <segher@kernel.crashing.org> wrote:
>> >  
>> >> On Fri, Nov 25, 2016 at 09:22:16AM +1100, Michael Ellerman wrote:  
>> >> > >> >> Question, are there any fundamental reasons we shouldn't use the ELFv2
>> >> > >> >> ABI to build big endian kernels if the compiler supports it?    
>> >> > >> >
>> >> > >> > No one uses ELFv2 for BE in production, and it isn't thoroughly tested
>> >> > >> > at all, not even regularly tested.  "Not supported", as far as GCC is
>> >> > >> > concerned (or any of the distros AFAIK).    
>> >> > >> 
>> >> > >> Is this actually unsupported by gcc?    
>> >> > >
>> >> > > It may or may not work.  We of course try to keep it working, or make
>> >> > > it work if it doesn't now.  But it isn't regularly tested, and it isn't
>> >> > > a target that is considered for the release criteria (see
>> >> > > https://gcc.gnu.org/gcc-7/criteria.html -- powerpc64{,le}-linux, i.e.
>> >> > > ABIv1 for BE, ABIv2 for LE).    
>> >> > 
>> >> > It doesn't actually say that though. It just says
>> >> > powerpc64-unknown-linux-gnu. So how is someone, say the musl folks,
>> >> > supposed to know that BE ABIv2 is not supported?    
>> >> 
>> >> Because their target is powerpc64*-*-linux-musl instead?  It is not on
>> >> the release criteria list, it is not something we make any claims about.
>> >> 
>> >> How would you know -m32 -mlittle is not well tested at all?  It is in much
>> >> the same boat: unusual combinations of options, and unusual configurations,
>> >> are not well tested.  You have to build a separate C library just to get
>> >> started with it, that should tell you there are some rough waters ahead!
>> >> 
>> >> Which isn't to say you should not do this -- just think twice before
>> >> doing so.  And wear a life vest.  
>> >
>> > Other than curiosity, only two reasons for the kernel to enable it:
>> > either it helps end users, or it allows us to get rid of elfv1 support
>> > (eventually). Both would require gcc to have some base amount of testing.  
>> 
>> I think it might be worth adding as option, as long as it's not too
>> intrusive. We could then put it in our CI and at least keep an eye on
>> whether it continues to work.
>
> If you're willing to take it, sure. I'll resubmit it with a default-n
> config option hidden away somewhere.

I think so, unless we find that the size of the patch grows once we
start testing it more.

>> Using ABIv1 does have user visible effects, ie. dot symbols show up in
>> traces and so on. So getting rid of that would be nice.
>> 
>> Having said that, perf and other tools are currently built to assume
>> BE==ABIv1, so breaking that assumption would possibly cause more
>> trouble.
>
> We can make it clear it's experimental/not supported, but things like
> that could probably be cleaned up slowly. They should depend on elf
> version rather than endian anyway.

They should, but that assumes you have the vmlinux ELF, or some other
way to query the ABI of the kernel which may not always be the case. But
it's probably solvable.

>> I guess the other question is when did ABIv2 land in the toolchain, ie.
>> how many years do we have to wait until we can mandate it.
>
> I think gcc 4.9, binutils 2.24, early 2014.
>
> But if we've never been testing with those older toolchains we're a bit
> behind the 8 ball. Still, the second best time to plant the tree is now...

True and true.

cheers
