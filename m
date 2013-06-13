Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BF862C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 02:49:28 +1000 (EST)
Date: Thu, 13 Jun 2013 11:49:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
To: Rojhalat Ibrahim <imr@rtschenk.de>
References: <1370971739.18413.27@snotra> <34279395.MbRViMjbAR@pcimr>
 <1371073826.18413.52@snotra> <7706620.VNI3PE9pqO@pcimr>
In-Reply-To: <7706620.VNI3PE9pqO@pcimr> (from imr@rtschenk.de on Thu Jun 13
 02:21:24 2013)
Message-ID: <1371142157.2028.9@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Guntsche <michael.guntsche@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2013 02:21:24 AM, Rojhalat Ibrahim wrote:
> On Wednesday 12 June 2013 16:50:26 Scott Wood wrote:
> > On 06/12/2013 03:19:30 AM, Rojhalat Ibrahim wrote:
> > > On Tuesday 11 June 2013 12:28:59 Scott Wood wrote:
> > > > Yes, I figured it was non-PCIe because the code change that you =20
> said
> > > > helped was on the non-PCIe branch of the if/else.  Generally =20
> it's
> > >
> > > good
> > >
> > > > to explicitly mention the chip you're using, though.
> > > >
> > > > fsl_setup_indirect_pci should be renamed to =20
> fsl_setup_indirect_pcie.
> > > > Your patch above should be applied, and fsl_setup_indirect_pcie
> > >
> > > should
> > >
> > > > be moved into the booke/86xx ifdef to avoid an unused function
> > >
> > > warning.
> > >
> > > > -Scott
> > >
> > > How about this patch? It uses setup_indirect_pci for the PCI case =20
> in
> > > mpc83xx_add_bridge. Additionally it adds a check in
> > > fsl_setup_indirect_pci
> > > to only use the modified read function in case of PCIe.
> >
> > If we're adding the check to fsl_setup_indirect_pci, there's no =20
> need to
> > change the 83xx call back to setup_indirect_pci.  I see that 85xx is
> > also callirng fsl_setup_indirect_pci for both; it'd be good to be
> > consistent.
> >
> > In any case, can you send a proper patch with a signoff and commit
> > message?
> >
> > -Scott
>=20
> Where is it called for 85xx? As far as I can tell =20
> fsl_setup_indirect_pci is
> called exactly once in fsl_add_bridge and nowhere else (after =20
> applying the
> proposed patch).

fsl_add_bridge() is where it's called for 85xx.

> For 83xx the decision between PCI and PCIe has already been made at
> the point where the setup function is called. So IMO it doesn't make =20
> sense
> to call fsl_setup_indirect_pci and do the check again. Moreover PCIe =20
> on 83xx
> uses a completely different set of functions.

My concern is consistency.  E.g. if 85xx is using =20
fsl_setup_indirect_pci for both, but 83xx isn't, then a developer using =20
83xx could end up breaking 85xx by introducing another PCIe dependency =20
in fsl_setup_indirect_pci.  Or an 85xx developer could put something =20
non-PCIe-related in fsl_setup_indirect_pci that 83xx would benefit from.

Alternatively, you could call it fsl_setup_indirect_pcie, and move the =20
PCIe check into fsl_add_bridge().

-Scott=
