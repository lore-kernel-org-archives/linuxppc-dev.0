Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3B452C0161
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 06:47:13 +1100 (EST)
Date: Tue, 2 Apr 2013 14:46:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C3248C@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Tue Apr  2 04:28:10 2013)
Message-ID: <1364931991.24520.17@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 04:28:10 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 30, 2013 12:34 AM
> > To: Jia Hongtao-B38951
> > Cc: Wood Scott-B07421; David Laight; linuxppc-dev@lists.ozlabs.org;
> > Stuart Yoder
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/29/2013 03:03:51 AM, Jia Hongtao-B38951 wrote:
> > > BTW, I'm still not sure how to deal with LD instruction with =20
> update.
> >
> > You would need to do the update yourself.  Or just say that's a =20
> case you
> > don't handle, and return 0.
> >
> > Again, please check for the size of the load operation.
> >
> > -Scott
>=20
> For informing error to the process that hold the stall instruction
> we need to do:
> 1. Verify the instruction is load.
> 2. Fill the rd register with ~0UL.
> 3. Deal with the load instruction with update.
>=20
> Here is the problems:
> 1. So many load instructions to handle. There are dozens of load =20
> instructions
>    and most of them with different op code. Like:

If you don't want to handle all of them, then don't, but in case you =20
run into an instruction you don't handle, don't skip it -- just let the =20
normal machine check handler run.

>=20
>    lbz: 1 0 0 0 1 0
>    lhz: 1 0 1 0 0 0
>    lwz: 1 0 0 0 0 0
>    ld : 1 1 1 0 1 0
>    ...
>=20
>    Is there any available API for verifying the load instruction?

I don't know of anything in terms of an *API*... after all, you're not =20
just "verifying" it, you're extracting information to determine how to =20
emulate the instruction.

As for code you could borrow from, there's KVM emulation and probably =20
other places.

> 2. For different size of load operation could we just fill the rd =20
> register with
>    ~0UL?

Who knows in what ways the compiler is making assumptions about the =20
upper bits being zero after an lbz, etc...

> 3. A load instruction with update could not just verified by op code. =20
> I'd like
>    to leave it along. I think we could not fix but just inform the =20
> error by
>    filling the rd with ~0UL. Could you explain why should we care =20
> about the update?

If you're emulating the instruction, you need to handle all of that =20
instruction's effects.  If you're not going to emulate the instruction, =20
don't skip it.

-Scott=
