Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPdkh5RK1zDw6H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 23:27:24 +1100 (AEDT)
Date: Thu, 24 Nov 2016 06:27:13 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
Message-ID: <20161124122713.GC14394@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
 <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2016 at 04:37:50PM +1100, Oliver O'Halloran wrote:
> On Thu, Nov 24, 2016 at 1:38 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Thu, Nov 24, 2016 at 12:08:40AM +1100, Nicholas Piggin wrote:
> >> Question, are there any fundamental reasons we shouldn't use the ELFv2
> >> ABI to build big endian kernels if the compiler supports it?
> >
> > No one uses ELFv2 for BE in production, and it isn't thoroughly tested
> > at all, not even regularly tested.  "Not supported", as far as GCC is
> > concerned (or any of the distros AFAIK).
> 
> Is this actually unsupported by gcc?

It may or may not work.  We of course try to keep it working, or make
it work if it doesn't now.  But it isn't regularly tested, and it isn't
a target that is considered for the release criteria (see
https://gcc.gnu.org/gcc-7/criteria.html -- powerpc64{,le}-linux, i.e.
ABIv1 for BE, ABIv2 for LE).

It is supported as in, "it is a feature a user can enable".  It is
unsupported as in, "we do not know if it works".

> The ppc64 musl libc port is ABI v2 only so they use it on BE too.

Interesting!  I've never seen a PowerPC musl in the wild though.

> Buildroot forces ABI v2 to be used
> for all of userspace when musl is selected as the libc for this reason
> so it's not completely used in the wild. It's still pretty niche
> though...

The point remains that the kernel will be the only non-niche user of
ABIv2 on BE if they choose to use it.  I don't expect many problems,
but it is uncharted territory.  YMMV, etc.

We (GCC) of course will be happy if you (Linux) wants to be guinea pig
for this.  But don't say we didn't warn you ;-)


Segher
