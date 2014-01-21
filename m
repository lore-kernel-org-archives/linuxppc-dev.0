Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0157.outbound.protection.outlook.com [207.46.163.157])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23B372C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:40:26 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "bhelgaas@google.com"
 <bhelgaas@google.com>
Subject: RE: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
Date: Tue, 21 Jan 2014 05:40:17 +0000
Message-ID: <fac9007cecb54cad99d371ac08698467@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
 <4984978.bktZCpdLkC@vostro.rjw.lan>
 <5ca123d4b32b49719cd9e8506916a9cf@BN1PR03MB188.namprd03.prod.outlook.com>
In-Reply-To: <5ca123d4b32b49719cd9e8506916a9cf@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any more comments? :)

Thanks,
-Dongsheng

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+b40534=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Dongsheng.Wang@freescale.com
> Sent: Wednesday, January 08, 2014 3:13 PM
> To: Rafael J. Wysocki
> Cc: linuxppc-dev@lists.ozlabs.org; galak@codeaurora.org; Wood Scott-B0742=
1;
> linux-pci@vger.kernel.org; bhelgaas@google.com
> Subject: RE: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementati=
on
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Wednesday, January 08, 2014 4:42 AM
> > To: Wang Dongsheng-B40534
> > Cc: bhelgaas@google.com; Wood Scott-B07421; galak@codeaurora.org; Zang =
Roy-
> > R61911; linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementa=
tion
> >
> > On Tuesday, January 07, 2014 04:04:08 PM Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > The new suspend/resume implementation, send pme turnoff message
> > > in suspend, and send pme exit message in resume.
> > >
> > > Add a PME handler, to response PME & message interrupt.
> > >
> > > Change platform_driver->suspend/resume to syscore->suspend/resume.
> >
> > Can you please first describe the problem you're trying to address?
> >
> If we do nothing in suspend/resume, some platform PCIe ip-block can't gua=
rantee
> the link back to L0 state from sleep, then, when we read the EP device wi=
ll hang.
> Only we send pme turnoff message in pci controller suspend, and send pme =
exit
> message in resume, the link state will be normal.
>=20
> When we send pme turnoff message in pci controller suspend, the links wil=
l into
> l2/l3
> ready, then, host cannot communicate with ep device, but pci-driver will =
call
> back EP
> device to save them state. So we need to change platform_driver->suspend/=
resume
> to
> syscore->suspend/resume.
>=20
> Thanks,
> -Dongsheng
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
