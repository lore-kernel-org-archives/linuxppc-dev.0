Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 510462C029E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 05:47:56 +1100 (EST)
Date: Tue, 5 Mar 2013 12:47:42 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B38951@freescale.com on Tue Mar  5 04:12:30 2013)
Message-ID: <1362509262.25308.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
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

On 03/05/2013 04:12:30 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, March 05, 2013 7:46 AM
> > To: Stuart Yoder
> > Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; Kumar Gala
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/04/2013 10:16:10 AM, Stuart Yoder wrote:
> > > On Mon, Mar 4, 2013 at 2:40 AM, Jia Hongtao <B38951@freescale.com>
> > > wrote:
> > > > A PCIe erratum of mpc85xx may causes a core hang when a link of =20
> PCIe
> > > > goes down. when the link goes down, Non-posted transactions =20
> issued
> > > > via the ATMU requiring completion result in an instruction =20
> stall.
> > > > At the same time a machine-check exception is generated to the =20
> core
> > > > to allow further processing by the handler. We implements the
> > > handler
> > > > which skips the instruction caused the stall.
> > >
> > > Can you explain at a high level how just skipping an instruction
> > > solves
> > > anything?   If you just skip a load/store and continue like =20
> nothing is
> > > wrong, isn't your system possibly in a really bad state.
> >
> > If the instruction was a load, we probably at least want to fill the
> > destination register with 0xffffffff or similar.
>=20
> You discuss this with Liu Shuo about a year ago.
> here is the log:
>=20
> "
> On 02/01/2012 02:18 AM, shuo.liu@freescale.com wrote:
> > v3 : Skip the instruction only. Don't access the user space memory =20
> in
> >      mechine check.
>=20
> It may be the least bad option for now, but be aware that there's a
> small chance that this will cause a leak of sensitive information =20
> (such
> as a piece of a crypto key that happened to be sitting in the register
> to be loaded into).

Yes, that's (one reason) why you'd want to fill in a known value.  Note =20
the "for now". :-)

-Scott=
