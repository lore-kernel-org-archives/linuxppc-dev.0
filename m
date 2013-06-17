Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 82EBA2C0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 15:59:06 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
Date: Mon, 17 Jun 2013 05:54:32 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259F85C34@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
 <1371074628.18413.53@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259F74985@039-SN2MPN1-021.039d.mgd.msft.net>
 <1371142282.2028.10@snotra>
In-Reply-To: <1371142282.2028.10@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, June 14, 2013 12:51 AM
> To: Wang Dongsheng-B40534
> Cc: Wood Scott-B07421; benh@kernel.crashing.org;
> johannes@sipsolutions.net; anton@enomsg.org; galak@kernel.crashing.org;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit
> hibernation
>=20
> On 06/13/2013 04:55:43 AM, Wang Dongsheng-B40534 wrote:
> > > > +#else
> > > > +	/* Save SPRGs */
> > > > +	RESTORE_SPRG(0)
> > > > +	RESTORE_SPRG(1)
> > > > +	RESTORE_SPRG(2)
> > > > +	RESTORE_SPRG(3)
> > > > +	RESTORE_SPRG(4)
> > > > +	RESTORE_SPRG(5)
> > > > +	RESTORE_SPRG(6)
> > > > +	RESTORE_SPRG(7)
> > >
> > > Why do we need this on book3e and not on book3s?
> > >
> > Book3e: SPRG1 used save paca, SPRG2 be defined
> > SPRN_SPRG_TLB_EXFRAME,...
> > I think those register should be save, even now some SPRG register not
> > be use.
>=20
> Are those expected/allowed to change as a result of the restore?
>=20
Those registers are used by software, some allowed to change.
Exception handling is used in some registers, see exception-64e.h
These registers can be modified and saved.

> -Scott
