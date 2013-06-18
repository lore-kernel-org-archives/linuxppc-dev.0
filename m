Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2471C2C02A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:22:12 +1000 (EST)
Date: Mon, 17 Jun 2013 19:22:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1371513683.9073.6@snotra> <1371514650.21896.160.camel@pasglop>
In-Reply-To: <1371514650.21896.160.camel@pasglop> (from
 benh@kernel.crashing.org on Mon Jun 17 19:17:30 2013)
Message-ID: <1371514923.9073.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2013 07:17:30 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-06-17 at 19:01 -0500, Scott Wood wrote:
> > I really doubt the exception scratch registers need to be saved --
> > we're not trying to restore into the middle of an exception
> > prolog/epilog.
> >
> > book3s has the PACA as well and they don't save it.  Don't we rely =20
> on
> > things like boot-time memory allocations happening in the same place
> > when we resume?  extlb is part of the PACA, so the same applies.
>=20
> I doubt we seriously tested hibernation :-) The PACA SPR should
> definitely be saved/restored.

OK.  It's not obvious to me how much the entire mechanism depends on =20
things like boot time allocations being the same each time -- if we do =20
depend on that in general, then the PACA shouldn't change on a =20
particular CPU, right?

Is it possible to restore on a different CPU than we saved on?  If so, =20
could restoring the PACA leave us pointing to a different CPU's PACA?

-Scott=
