Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDD761A02CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 13:20:55 +1100 (EST)
In-Reply-To: <20141010102033.49af46f4@bahia.local>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc/vphn: fix endian issue in NUMA device node code
Message-Id: <20141015022055.ABDF214012A@ozlabs.org>
Date: Wed, 15 Oct 2014 13:20:55 +1100 (EST)
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 08:20:33 UTC, Greg Kurz wrote:
> On Tue,  7 Oct 2014 20:28:23 +1100 (EST)
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > On Fri, 2014-03-10 at 09:13:17 UTC, Greg Kurz wrote:
> > > The associativity domain numbers are obtained from the hypervisor through
> > > registers and written into memory by the guest: the packed array passed to
> > > vphn_unpack_associativity() is then native-endian, unlike what was assumed
> > > in the following commit:
> > > 
> > > This patch does two things:
> > > - extract values from the packed array with shifts, in order to be endian
> > >   neutral
> > > - convert the resulting values to be32 as expected
> > 
> > So to unpack them, can't we just iterate over those six 64-bit values, which if
> > we load them as 64-bit values will be back in cpu endian?
> 
> Hi Michael,
> 
> Do you mean something like the following ?

Not exactly, but that's certainly a lot simpler than the original patch.
 
> Sure it also works and is a lot simplier... but it adds an extra loop. Also,
> if the 3 first elements of the array contain 12 VPHN_FIELD_MSB fields, then
> we don't even need to swap the remaining elements: only the parsing code
> knows.
>
> On the other hand, I understand this is not a hot path... so what should we
> do ?

So I prefer this to your original patch. I know the original was cool and
tricky but it was also complicated :)

What I was thinking of was that the actual parsing code, in vphn_unpack_associativity()
would do the 64-bit loads. That will require changing the parsing loop quite a
bit, but I think it might be worth it.

So can you resend this version with a proper changelog, and I'll merge that
straight away as a bug fix. Then if you can look at reworking the parsing loop
to avoid all the endian swapping on the input side that'd be great.

cheers
