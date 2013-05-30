Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A73B2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 04:55:12 +1000 (EST)
Date: Thu, 30 May 2013 13:54:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
References: <1369137900-5748-1-git-send-email-haokexin@gmail.com>
 <1369137900-5748-2-git-send-email-haokexin@gmail.com>
 <1369781529.18630.25@snotra>
 <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130530102034.GB18702@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu May 30 05:20:34 2013)
Message-ID: <1369940099.14679.14@snotra>
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

On 05/30/2013 05:20:34 AM, Kevin Hao wrote:
> On Tue, May 28, 2013 at 05:52:09PM -0500, Scott Wood wrote:
> > On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> > >It also seems that we don't support ISA on all the current corenet =20
> ds
> > >boards. So picking a primary bus seems useless, remove that =20
> function
> > >too.
> >
> > IIRC that was due to some bugs in the PPC PCI code in the absence of
> > any primary bus.
>=20
> Do you know more about these bugs?

Not off the top of my head -- either search the archives or ask Ben.

> >  fsl_pci_assign_primary() will arbitrarily pick one
> > to be primary if there's no ISA.  Have the bugs been fixed?
>=20
> I know there should be some reason that we put the =20
> fsl_pci_assign_primary()
> here. But frankly I am not sure what bugs this workaround try to fix. =20
> For these
> corenet boards picking one to be primary has no effect to the 64bit =20
> kernel.
> And for 32bit kernel, the only effect of this is that isa_io_base is =20
> set to the
> io virtual base of the primary bus. But the isa_io_base only make =20
> sense when
> we do have a isa bus, so that we can access some well-known io ports =20
> directly
> by using outx/inx. But if we don't have isa bus on the board, the =20
> value of
> isa_io_base should make no sense at all. So we really don't need to =20
> pick a
> fake primary bus. Of course I may miss something, correct me if I am =20
> wrong. :-)

outx/inx can also be used for PCI I/O BARs.

-Scott=
