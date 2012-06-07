Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id AD52DB6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 18:46:11 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 20980-08 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  7 Jun 2012 09:45:59 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Date: Thu, 7 Jun 2012 09:41:35 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F3B@saturn3.aculab.com>
In-Reply-To: <1339051173.24838.10.camel@pasglop>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Michael Neuling" <mikey@neuling.org>
Cc: michael@ellerman.id.au, olof@lixom.net, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Linuxppc-dev=20
> [mailto:linuxppc-dev-bounces+david.laight=3Daculab.com@lists.ozl
abs.org] On Behalf Of Benjamin Herrenschmidt
> Sent: 07 June 2012 07:40
> To: Michael Neuling
> Cc: michael@ellerman.id.au; paulus@samba.org; Anton=20
> Blanchard; olof@lixom.net; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc: Optimise the 64bit optimised=20
> __clear_user
>=20
> On Thu, 2012-06-07 at 16:05 +1000, Michael Neuling wrote:
>=20
> > One problem with this is when we construct the=20
> instructions, like using
> > anything from ppc-opcode.h.  eg. using PPC_POPCNTB would=20
> need to go from:
> >     PPC_POPCNTB(r3,r3)=20
> > to:
> >     PPC_POPCNTB(3,3)=20
> > Which is less readable IMHO.
>=20
> Yes, I know. Not much to do about this, but it might still be=20
> worth it,
> how much time wasted due to mixing up or with ori in asm somewhere ?
>=20
> One option would be to #define R3 (or _r3) for use in those macros so
> we still have something nicer than just "3"... oh well.

You then need to catch all the other bugs where a register
is being used instead of a constant.
Time to make the assembler require %r0 (etc)

	David
