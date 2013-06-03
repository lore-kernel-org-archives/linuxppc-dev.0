Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 225B52C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 02:42:17 +1000 (EST)
Date: Mon, 3 Jun 2013 11:42:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940099.14679.14@snotra>
 <20130531064102.GB16514@pek-khao-d1.corp.ad.wrs.com>
 <1369995080.3928.140.camel@pasglop>
 <20130601105936.GA1850@pek-khao-d1.corp.ad.wrs.com>
 <1370087236.3766.43.camel@pasglop>
 <20130602000720.GA22546@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130602000720.GA22546@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Sat Jun  1 19:07:20 2013)
Message-ID: <1370277723.21388.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2013 07:07:20 PM, Kevin Hao wrote:
> On Sat, Jun 01, 2013 at 09:47:16PM +1000, Benjamin Herrenschmidt =20
> wrote:
> > On Sat, 2013-06-01 at 18:59 +0800, Kevin Hao wrote:
> >
> > > The effect of this change is that the isa_io_base will be 0 and =20
> the IO
> > > resource are equal to the virtual address of the IO space. But =20
> the IO
> > > functions such as outx/inx should work as well. This is why I ask =20
> the
> > > above question. What do you think about this? Are there any =20
> subtle bugs
> > > that will be triggered by this?
> >
> > I don't see any obvious reason why that wouldn't work but like =20
> anything
> > in that area, it needs a bit of testing & hammering to be sure ;-)
>=20
> Agreed.

Please include QEMU in your testing, as that was where breakage was =20
observed that caused us to add the default primary.

> > In fact it would work on pmac32 as well since those generally don't =20
> have
> > legacy crap either.
> >
> > So I have no fundamental objection, it just needs testing. My worry =20
> is
> > that we need to make sure we don't break old chrp and I don't have =20
> any
> > to test with.
>=20
> Don't worry, my patch just drop the picking of primary bus for several
> fsl boards. All these changes are in board specific file, so it should
> have no affect to other boards at all.

Is anything actually fixed by this?

-Scott=
