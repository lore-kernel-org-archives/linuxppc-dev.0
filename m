Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 54E62B70B7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Aug 2011 18:56:31 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 26022-04 for <linuxppc-dev@ozlabs.org>;
	Thu, 11 Aug 2011 09:56:26 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Optimize __arch_swab32 and __arch_swab16
Date: Thu, 11 Aug 2011 09:56:26 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AE27@saturn3.aculab.com>
In-Reply-To: <m34o1ouyix.fsf@hase.home>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Andreas Schwab" <schwab@redhat.com>,
	"Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>=20
> > unsigned short my__arch_swab16(unsigned short value)
> > {
> > 	__asm__("rlwimi %0,%0,16,0x00ff0000"
> > 		: "+r" (value));
>=20
> You are creating a value that does not fit in a short.

Which is a problem because the compiler could schedule
it be written back to real memory between the instructions.

Actually the generated code would be better if the swap16()
functions operated on 'unsigned int' fields - since it would
save the compiler from doing a lot of shifts/masks elsewhere.

For instance there is likely to be a mask with 0xffff prior
to the call to swab16().

Since one use of these is for htons() (etc), when
the host is the correct endianness these are #defines that
do nothing - so out of range values aren't masked.
So it seems to me that defining:
   unsigned int swab(unsigned int);
would be fine - except it clashes with standard headers :-(

	David
