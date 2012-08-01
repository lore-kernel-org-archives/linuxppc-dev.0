Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AEB672C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 12:25:00 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Li Yang-R58472
 <r58472@freescale.com>
Subject: RE: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 1 Aug 2012 02:24:51 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A2B327@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <ACC8975F-CA31-4AA0-9824-4C3F6C70CD45@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A289D8@039-SN1MPN1-002.039d.mgd.msft.net>
 <5012F8FD.8030905@freescale.com>
 <A2F0976D-CF30-4A20-8697-0CD1830DD54A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29FEF@039-SN1MPN1-002.039d.mgd.msft.net>
 <536EC8A2-60D9-4991-8D38-092C4C8B698F@kernel.crashing.org>
 <CADRPPNThb68v9h6Dy4qOxv2pwYLg=Zvuk_6+jM4HUxDbuzfhAQ@mail.gmail.com>
 <0080192C-3C13-40DA-BE8A-4FCE67F79E04@kernel.crashing.org>
In-Reply-To: <0080192C-3C13-40DA-BE8A-4FCE67F79E04@kernel.crashing.org>
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
> Sent: Tuesday, July 31, 2012 9:38 PM
> To: Li Yang-R58472
> Cc: Jia Hongtao-B38951; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> Li Yang-R58472
> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
>=20
> On Jul 31, 2012, at 2:21 AM, Li Yang wrote:
>=20
> > On Mon, Jul 30, 2012 at 10:46 PM, Kumar Gala <galak@kernel.crashing.org=
>
> wrote:
> >>
> >> On Jul 30, 2012, at 3:26 AM, Jia Hongtao-B38951 wrote:
> >>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>>> Sent: Saturday, July 28, 2012 5:17 AM
> >>>> To: Wood Scott-B07421
> >>>> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; Wood Scott-
> B07421;
> >>>> Li Yang-R58472
> >>>> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> >>>> initialization code
> >>>>
> >>>>
> >>>> On Jul 27, 2012, at 3:24 PM, Scott Wood wrote:
> >>>>
> >>>>> On 07/27/2012 05:10 AM, Jia Hongtao-B38951 wrote:
> >>>>>> Hi kumar,
> >>>>>>
> >>>>>> I know "duplicate code from pci_process_bridge_OF_ranges()" is
> >>>>>> hard to accept but "refactor the code to have a shared function"
> >>>>>> is knotty. Actually this is the reason I didn't do the refactor.
> >>>>>
> >>>>> Maybe we should keep doing the init early?  We could still have a
> >>>>> platform device for the PM stuff, but some init would be done
> before
> >>>> probe.
> >>>>>
> >>>>> Another possibility is to try to handle swiotlb init later --
> possibly
> >>>>> by reserving memory for it if the platform indicates it's a
> possibility
> >>>>> that it will be needed, then freeing the memory if it's not needed.
> >>>>>
> >>>>> -Scott
> >>>>
> >>>> I think the first option seems reasonable.  Can we leave
> fsl_pci_init()
> >>>> as we now have it and just have the platform driver deal with PM
> restore
> >>>> via calling setup_pci_atmu() [probably need to update setup_pci_atmu
> to
> >>>> handle restore case, but seems like minor changes]
> >>>>
> >>>> - k
> >>>>
> >>>
> >>>
> >>> I think the second option is better if it's hard to decouple swiotlb
> >>> determination from pci init. I believe the better architecture that
> >>> PCI init in probe function of platform driver will bring us
> considerable
> >>> advantage. I really like to keep the completion of pci controller
> >>> platform driver not only for PM support but also for pci init.
> >>>
> >>> -Hongtao.
> >>>
> >>
> >> Shifting of swiotlb init has a lot more issues.  Why do we need to do
> the PCI init in probe?
> >
> > The ordering issues are introduced by swiotlb.  And the ideal way is
> > to solve the problem within swiotlb instead of changing PCI to
> > workaround it.  Take the implementation of x86 as reference it's
> > possible to be addressed bu allocating first and free later approach.
> >
> > It is common sense that the initialization of a device is in the probe
> > function of the driver of the device.  And the change will provide
> > better unification of PCI controller code.  The PCI controller is
> > generic enough not to be taken care of at the platform area.
> >
> > Leo
>=20
> Than lets look at going with that approach.. Be careful with impact on
> other users of swiotlb on PPC, I believe one 44x board uses swiotlb.
>=20
> - k

I will be careful with this approach.
I have already noticed 44x. Thank you all the same.

-Hongtao.
