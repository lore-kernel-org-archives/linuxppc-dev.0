Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0103.outbound.protection.outlook.com [157.56.110.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481901A0D1E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 11:00:27 +1000 (AEST)
Message-ID: <1430528414.16357.201.camel@freescale.com>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Date: Fri, 1 May 2015 20:00:14 -0500
In-Reply-To: <553FD904.8000309@c-s.fr>
References: <20150203113927.8604D1A5F14@localhost.localdomain>
 <20150325013023.GA7588@home.buserror.net> <553FD904.8000309@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-28 at 21:01 +0200, christophe leroy wrote:
> 
> 
> Le 25/03/2015 02:30, Scott Wood a écrit :
> 
> > On Tue, Feb 03, 2015 at 12:39:27PM +0100, LEROY Christophe wrote:
> > > The C version of csum_add() as defined in include/net/checksum.h gives the
> > > following assembly:
> > >        0:       7c 04 1a 14     add     r0,r4,r3
> > >        4:       7c 64 00 10     subfc   r3,r4,r0
> > >        8:       7c 63 19 10     subfe   r3,r3,r3
> > >        c:       7c 63 00 50     subf    r3,r3,r0
> > > 
> > > include/net/checksum.h also offers the possibility to define an arch specific
> > > function.
> > > This patch provides a ppc32 specific csum_add() inline function.
> > What makes it 32-bit specific?
> > 
> > 
> As far as I understand, the 64-bit will do a 64 bit addition, so we
> will have to handle differently the carry, can't just be an addze like
> in 32-bit.

OK.  Before I couldn't find where this was ifdeffed to 32-bit, but it's
in patch 1/2.

> The generated code is most likely different on ppc64. I have no ppc64
> compiler so I can't check what gcc generates for the following code:
> 
> __wsum csum_add(__wsum csum, __wsum addend)
> {
> 	u32 res = (__force u32)csum;
> 	res += (__force u32)addend;
> 	return (__force __wsum)(res + (res < (__force u32)addend));
> }
> 
> Can someone with a ppc64 compiler tell what we get ?

With CONFIG_GENERIC_CPU:

   0xc000000000001af8 <+0>:	add     r3,r3,r4
   0xc000000000001afc <+4>:	cmplw   cr7,r3,r4
   0xc000000000001b00 <+8>:	mfcr    r4
   0xc000000000001b04 <+12>:	rlwinm  r4,r4,29,31,31
   0xc000000000001b08 <+16>:	add     r3,r4,r3
   0xc000000000001b0c <+20>:	clrldi  r3,r3,32
   0xc000000000001b10 <+24>:	blr

The mfcr is particularly nasty, at least on our chips.

With CONFIG_CPU_E6500:

   0xc000000000001b30 <+0>:	add     r3,r3,r4
   0xc000000000001b34 <+4>:	cmplw   cr7,r3,r4
   0xc000000000001b38 <+8>:	mfocrf  r4,1
   0xc000000000001b3c <+12>:	rlwinm  r4,r4,29,31,31
   0xc000000000001b40 <+16>:	add     r3,r4,r3
   0xc000000000001b44 <+20>:	clrldi  r3,r3,32
   0xc000000000001b48 <+24>:	blr

Ideal (short of a 64-bit __wsum) would probably be something like (untested):

	add	r3,r3,r4
	srdi	r5,r3,32
	add	r3,r3,r5
	clrldi	r3,r3,32

Or in C code (which would let the compiler schedule it better):

static inline __wsum csum_add(__wsum csum, __wsum addend)
{
        u64 res = (__force u64)csum;
        res += (__force u32)addend;
        return (__force __wsum)((u32)res + (res >> 32));
}

-Scott
