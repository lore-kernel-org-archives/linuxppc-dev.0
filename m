Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 974BA2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 22:56:22 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Stuart Yoder <b08248@gmail.com>
Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Wed, 27 Feb 2013 11:56:08 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3C2691@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
 <CALRxmdBBO2AoAnKSTNNTYhHZ9fitJKWWeZMUj1ObtFhsZS5iSw@mail.gmail.com>
In-Reply-To: <CALRxmdBBO2AoAnKSTNNTYhHZ9fitJKWWeZMUj1ObtFhsZS5iSw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> From: Stuart Yoder [mailto:b08248@gmail.com]
> Sent: Wednesday, February 27, 2013 4:03 AM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Wood Scott-B07421; Joerg Roedel; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
>=20
> Have not got through the entire file, but have a few comments...
>=20
> +/*
> + * Set the PAACE type as primary and set the coherency required domain
> + * attribute
> + */
> +static void pamu_setup_default_xfer_to_host_ppaace(struct paace
> +*ppaace) {
> +       set_bf(ppaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_PRIMARY);
> +
> +       set_bf(ppaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +              PAACE_M_COHERENCE_REQ);
> +}
> +
> +/*
> + * Set the PAACE type as secondary and set the coherency required
> +domain
> + * attribute.
> + */
> +static void pamu_setup_default_xfer_to_host_spaace(struct paace
> +*spaace) {
> +       set_bf(spaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_SECONDARY);
> +       set_bf(spaace->domain_attr.to_host.coherency_required,
> PAACE_DA_HOST_CR,
> +              PAACE_M_COHERENCE_REQ);
> +}
>=20
> Can we change the names of the above functions...   I know there is some
> history
> with the name, but "xfer_to_host" is confusing.
>=20
> Maybe just call them:
>=20
> pamu_init_paace()
> pamu_init_spaace()
>=20
[Sethi Varun-B16395] ok, will change the function names.

> > +/**
> > + * pamu_config_spaace() - Sets up SPAACE entry for specified
> > +subwindow
> > + *
> > + * @liodn:  Logical IO device number
> > + * @subwin_cnt:  number of sub-windows associated with dma-window
> > + * @subwin_addr: starting address of subwindow
> > + * @subwin_size: size of subwindow
> > + * @omi: Operation mapping index
> > + * @rpn: real (true physical) page number
> > + * @snoopid: snoop id for hardware coherency -- if ~snoopid =3D=3D 0 t=
hen
> > + *                       snoopid not defined
> > + * @stashid: cache stash id for associated cpu
> > + * @enable: enable/disable subwindow after reconfiguration
> > + * @prot: sub window permissions
> > + *
> > + * Returns 0 upon success else error code < 0 returned  */ int
> > +pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin_addr,
> > +                      phys_addr_t subwin_size, u32 omi, unsigned long
> rpn,
> > +                      u32 snoopid, u32 stashid, int enable, int prot)
> > +{
> > +       struct paace *paace;
> > +
> > +       /* setup sub-windows */
> > +       if (!subwin_cnt) {
> > +               pr_err("Invalid subwindow count\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       paace =3D pamu_get_ppaace(liodn);
> > +       if (subwin_addr > 0 && subwin_addr < subwin_cnt && paace) {
>=20
> Why is the comparison subwin_addr < subwin_cnt?   Seems wrong...
>=20
[Sethi Varun-B16395] It's actually the subwindow index. I will rename the v=
ariable.

> > +               paace =3D pamu_get_spaace(paace, subwin_addr - 1);
> > +
> > +               if (paace && !(paace->addr_bitfields & PAACE_V_VALID))
> {
> > +                       pamu_setup_default_xfer_to_host_spaace(paace);
> > +                       set_bf(paace->addr_bitfields, SPAACE_AF_LIODN,
> liodn);
> > +               }
> > +       }
> > +
> > +       if (!paace) {
> > +               pr_err("Invalid liodn entry\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       if (!enable && prot =3D=3D PAACE_AP_PERMS_DENIED) {
> > +               if (subwin_addr > 0)
> > +                       set_bf(paace->addr_bitfields, PAACE_AF_V,
> > +                                PAACE_V_INVALID);
> > +               else
> > +                       set_bf(paace->addr_bitfields, PAACE_AF_AP,
> > +                                prot);
> > +               mb();
> > +               return 0;
> > +       }
>=20
> Can you add a comment to the above if statement...when is this function
> called with PAACE_AP_PERMS_DENIED?
>=20
[Sethi Varun-B16395] Actually, this piece of code is redundant in case of t=
he window based API. I will remove this. PAACE_AP_PERMS_DENIED is primarily=
 used for disabling the primary subwindow.

-Varun
