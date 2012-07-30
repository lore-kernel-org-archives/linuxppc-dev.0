Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51B9C2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 18:26:51 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Mon, 30 Jul 2012 08:26:43 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A29FEF@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
 <5012F8FD.8030905@freescale.com>
 <A2F0976D-CF30-4A20-8697-0CD1830DD54A@kernel.crashing.org>
In-Reply-To: <A2F0976D-CF30-4A20-8697-0CD1830DD54A@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Saturday, July 28, 2012 5:17 AM
> To: Wood Scott-B07421
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421;
> Li Yang-R58472
> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
>=20
> On Jul 27, 2012, at 3:24 PM, Scott Wood wrote:
>=20
> > On 07/27/2012 05:10 AM, Jia Hongtao-B38951 wrote:
> >> Hi kumar,
> >>
> >> I know "duplicate code from pci_process_bridge_OF_ranges()" is
> >> hard to accept but "refactor the code to have a shared function"
> >> is knotty. Actually this is the reason I didn't do the refactor.
> >
> > Maybe we should keep doing the init early?  We could still have a
> > platform device for the PM stuff, but some init would be done before
> probe.
> >
> > Another possibility is to try to handle swiotlb init later -- possibly
> > by reserving memory for it if the platform indicates it's a possibility
> > that it will be needed, then freeing the memory if it's not needed.
> >
> > -Scott
>=20
> I think the first option seems reasonable.  Can we leave fsl_pci_init()
> as we now have it and just have the platform driver deal with PM restore
> via calling setup_pci_atmu() [probably need to update setup_pci_atmu to
> handle restore case, but seems like minor changes]
>=20
> - k
>=20


I think the second option is better if it's hard to decouple swiotlb
determination from pci init. I believe the better architecture that
PCI init in probe function of platform driver will bring us considerable
advantage. I really like to keep the completion of pci controller
platform driver not only for PM support but also for pci init.

-Hongtao.=20
