Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 351F72C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:01:36 +1000 (EST)
Date: Mon, 17 Jun 2013 19:01:23 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng-B40534 <B40534@freescale.com>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259F85C34@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Mon Jun 17 00:54:32 2013)
Message-ID: <1371513683.9073.6@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
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

On 06/17/2013 12:54:32 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, June 14, 2013 12:51 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; benh@kernel.crashing.org;
> > johannes@sipsolutions.net; anton@enomsg.org; =20
> galak@kernel.crashing.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit
> > hibernation
> >
> > On 06/13/2013 04:55:43 AM, Wang Dongsheng-B40534 wrote:
> > > > > +#else
> > > > > +	/* Save SPRGs */
> > > > > +	RESTORE_SPRG(0)
> > > > > +	RESTORE_SPRG(1)
> > > > > +	RESTORE_SPRG(2)
> > > > > +	RESTORE_SPRG(3)
> > > > > +	RESTORE_SPRG(4)
> > > > > +	RESTORE_SPRG(5)
> > > > > +	RESTORE_SPRG(6)
> > > > > +	RESTORE_SPRG(7)
> > > >
> > > > Why do we need this on book3e and not on book3s?
> > > >
> > > Book3e: SPRG1 used save paca, SPRG2 be defined
> > > SPRN_SPRG_TLB_EXFRAME,...
> > > I think those register should be save, even now some SPRG =20
> register not
> > > be use.
> >
> > Are those expected/allowed to change as a result of the restore?
> >
> Those registers are used by software, some allowed to change.
> Exception handling is used in some registers, see exception-64e.h
> These registers can be modified and saved.

I really doubt the exception scratch registers need to be saved -- =20
we're not trying to restore into the middle of an exception =20
prolog/epilog.

book3s has the PACA as well and they don't save it.  Don't we rely on =20
things like boot-time memory allocations happening in the same place =20
when we resume?  extlb is part of the PACA, so the same applies.

Granted, this isn't performance critical so it may seem better to =20
save/restore just in case, but there's value in not unnecessarily =20
deviating from what book3s does.

-Scott=
