Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPtx76Kn9zDw5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 09:22:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
In-Reply-To: <20161124122713.GC14394@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
 <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
 <20161124122713.GC14394@gate.crashing.org>
Date: Fri, 25 Nov 2016 09:22:16 +1100
Message-ID: <87d1hktt5z.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Thu, Nov 24, 2016 at 04:37:50PM +1100, Oliver O'Halloran wrote:
>> On Thu, Nov 24, 2016 at 1:38 AM, Segher Boessenkool
>> <segher@kernel.crashing.org> wrote:
>> > On Thu, Nov 24, 2016 at 12:08:40AM +1100, Nicholas Piggin wrote:
>> >> Question, are there any fundamental reasons we shouldn't use the ELFv2
>> >> ABI to build big endian kernels if the compiler supports it?
>> >
>> > No one uses ELFv2 for BE in production, and it isn't thoroughly tested
>> > at all, not even regularly tested.  "Not supported", as far as GCC is
>> > concerned (or any of the distros AFAIK).
>> 
>> Is this actually unsupported by gcc?
>
> It may or may not work.  We of course try to keep it working, or make
> it work if it doesn't now.  But it isn't regularly tested, and it isn't
> a target that is considered for the release criteria (see
> https://gcc.gnu.org/gcc-7/criteria.html -- powerpc64{,le}-linux, i.e.
> ABIv1 for BE, ABIv2 for LE).

It doesn't actually say that though. It just says
powerpc64-unknown-linux-gnu. So how is someone, say the musl folks,
supposed to know that BE ABIv2 is not supported?

cheers
