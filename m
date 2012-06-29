Return-Path: <B35336@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE9B91007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 20:33:53 +1000 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Date: Fri, 29 Jun 2012 10:33:45 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA05D87E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
 <20120627102138.GB10476@localhost.localdomain>
 <1340797732.3732.46.camel@pasglop>
 <20120628033815.GA11387@localhost.localdomain>
 <1340880651.20977.83.camel@pasglop>
 <D2BA086B-6EB3-4853-B901-FA37DCCDC134@kernel.crashing.org>
In-Reply-To: <D2BA086B-6EB3-4853-B901-FA37DCCDC134@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linuxppc-dev@lists.ozlabs.org
 list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+chenhui.zhao=3Dfreescale.=
com@lists.ozlabs.org] On Behalf
> Of Kumar Gala
> Sent: Friday, June 29, 2012 2:30 AM
> To: Zhao Chenhui-B35336
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org list; linux-kernel@v=
ger.kernel.org list
> Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase syn=
c
>=20
>=20
> On Jun 28, 2012, at 5:50 AM, Benjamin Herrenschmidt wrote:
>=20
> > On Thu, 2012-06-28 at 11:38 +0800, Zhao Chenhui wrote:
> >>
> >>
> >> The bootloader have done a timebase sync. If we do not need KEXEC or
> >> HOTPLUG_CPU feature, it is unnecessary to do it again at boot time of
> >> kernel. I only compile the timebase sync routines
> >> when users enable KEXEC or HOTPLUG_CPU.
> >
> > Still, how much are you really saving ? Is it worth the added mess and
> > loss of test coverage ?
> >
> > We have too many conditional stuff like that already.
> >
> > Cheers,
> > Ben.
> >
>=20
> I'd also be interested to know how long it actually takes to do time base=
 sync this way.  Since you
> are freezing the timers for some period how long does it really take betw=
een the freeze/unfreeze in
> mpc85xx_give_timebase()
>=20
> +	mpc85xx_timebase_freeze(1);
> ...
> +	mpc85xx_timebase_freeze(0);
>=20
> You can use ATBL/U as a way to see # of cycles taken.
>=20
> - k

I measured it using ATBL on MPC8572DS with 1.5GHz core frequency and 600MHz=
 CCB frequency.
The average of 10 times is 1019 clock. It seems that most of the time spent=
 by isync and msync.

-Chenhui
