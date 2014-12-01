Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1288A1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 20:17:31 +1100 (AEDT)
Message-ID: <1417425450.25107.3.camel@concordia>
Subject: Re: [PATCH REPOST 3/3] powerpc/vphn: move endianness fixing to
 vphn_unpack_associativity()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Mon, 01 Dec 2014 20:17:30 +1100
In-Reply-To: <20141128093919.700f1874@bahia.local>
References: <20141117174216.7717.10926.stgit@bahia.local>
 <20141117174244.7717.83028.stgit@bahia.local>
 <1417045163.5089.67.camel@kernel.crashing.org>
 <20141127102812.7d1e625b@bahia.local>
 <1417139348.2852.17.camel@kernel.crashing.org>
 <20141128093919.700f1874@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-28 at 09:39 +0100, Greg Kurz wrote:
> On Fri, 28 Nov 2014 12:49:08 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > In a second pass, we parse that stream, one 16-bytes at a time, and
> > we could do so with a simple loop of be16_to_cpup(foo++). I wouldn't
> > bother with the cast to 32-bit etc... if you encounter a 32-bit case,
> > you just fetch another 16-bit and do value = (old << 16) | new
> > 
> > I think that should lead to something more readable, no ?
> 
> Of course ! This is THE way to go. Thanks Ben ! :)
> 
> An while we're here, I have a question about VPHN_ASSOC_BUFSIZE. The
> H_HOME_NODE_ASSOCIATIVITY spec says that the stream:
> - is at most 64 * 6 = 384 bits long

That's from "Each of the registers R4-R9 ..."

> - may contain 16-bit numbers

"... is divided into 4 fields each 2 bytes long."

> - is padded with "all ones"
> 
> The stream could theoretically contain up to 384 / 16 = 24 domain numbers.

Yes I think that's right, based on:

"The high order bit of each 2 byte field is a length specifier:

1: The associativity domain number is contained in the low order 15 bits of the field,"

But then there's also:

"0: The associativity domain number is contained in the low order 15 bits of
the current field concatenated with the 16 bits of the next sequential field)"

> The current code expects no more than 12 domain numbers... and strangely
> seems to correlate the size of the output array to the size of the input
> one as noted in the comment:
> 
>  "6 64-bit registers unpacked into 12 32-bit associativity values"
> 
> My understanding is that the resulting array is be32 only because it is
> supposed to look like the ibm,associativity property from the DT... and
> I could find no clue that this property is limited to 12 values. Have I
> missed something ?

I don't know for sure, but I strongly suspect it's just confused about the two
options above. Probably when it was tested they only ever saw 12 32-bit values,
and so that assumption was allowed to stay in the code.

I'd be quite happy if you wanted to pull the parsing logic out into a separate
file, so we could write some userspace tests of it.

cheers
