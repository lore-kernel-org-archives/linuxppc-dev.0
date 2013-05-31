Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB79F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 09:27:33 +1000 (EST)
Date: Fri, 31 May 2013 18:27:21 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] powerpc/mpc85xx: remove the unneeded pci init
 functions for corenet ds board
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130531064348.GC16514@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Fri May 31 01:43:49 2013)
Message-ID: <1370042841.13614.19@snotra>
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

On 05/31/2013 01:43:49 AM, Kevin Hao wrote:
> On Thu, May 30, 2013 at 01:54:59PM -0500, Scott Wood wrote:
> > On 05/30/2013 05:20:34 AM, Kevin Hao wrote:
> > >On Tue, May 28, 2013 at 05:52:09PM -0500, Scott Wood wrote:
> > >> On 05/21/2013 07:04:58 AM, Kevin Hao wrote:
> > >> >It also seems that we don't support ISA on all the current
> > >corenet ds
> > >> >boards. So picking a primary bus seems useless, remove that
> > >function
> > >> >too.
> > >>
> > >> IIRC that was due to some bugs in the PPC PCI code in the =20
> absence of
> > >> any primary bus.
> > >
> > >Do you know more about these bugs?
> >
> > Not off the top of my head -- either search the archives or ask Ben.
> >
> > >>  fsl_pci_assign_primary() will arbitrarily pick one
> > >> to be primary if there's no ISA.  Have the bugs been fixed?
> > >
> > >I know there should be some reason that we put the
> > >fsl_pci_assign_primary()
> > >here. But frankly I am not sure what bugs this workaround try to
> > >fix. For these
> > >corenet boards picking one to be primary has no effect to the
> > >64bit kernel.
> > >And for 32bit kernel, the only effect of this is that isa_io_base
> > >is set to the
> > >io virtual base of the primary bus. But the isa_io_base only make
> > >sense when
> > >we do have a isa bus, so that we can access some well-known io
> > >ports directly
> > >by using outx/inx. But if we don't have isa bus on the board, the
> > >value of
> > >isa_io_base should make no sense at all. So we really don't need
> > >to pick a
> > >fake primary bus. Of course I may miss something, correct me if I
> > >am wrong. :-)
> >
> > outx/inx can also be used for PCI I/O BARs.
>=20
> Yes, I know there is also PIO. But the value of isa_io_base doesn't
> have any effect for this.

See this e-mail for some of the issues I was referring to with =20
isa_io_base being zero:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-June/098586.html

Reading it again I'm not so sure that the problem is so much that we =20
need a primary, as that somewhat bad things happen on non-primary =20
buses, such as the possibility of assigning a zero BAR.  Some hardware =20
(including QEMU's PCI emulation) cares about this, though most =20
doesn't.  We only have one PCI bus under QEMU, so when we started =20
picking an arbitrary bus to be primary, the problem went away because =20
there was only one bus and therefore there was no non-primary bus.

-Scott=
