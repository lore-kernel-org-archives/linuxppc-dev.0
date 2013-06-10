Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1D182C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 08:52:45 +1000 (EST)
Date: Mon, 10 Jun 2013 17:52:33 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
To: Michael Guntsche <michael.guntsche@it-loops.com>
References: <CALG0vJu9-640D=Q-2RoSOnWtR=sERwj0fSCibK+ijprcf-T6Ag@mail.gmail.com>
 <7927838.NMrLdRWptT@pcimr>
 <CALG0vJtjS2wP_s=-iyG1ABKw_ct=B9OdNXY9YCrnkhAnpaN1Zw@mail.gmail.com>
In-Reply-To: <CALG0vJtjS2wP_s=-iyG1ABKw_ct=B9OdNXY9YCrnkhAnpaN1Zw@mail.gmail.com> (from
 michael.guntsche@it-loops.com on Mon Jun 10 12:07:43 2013)
Message-ID: <1370904753.18413.19@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, Rojhalat Ibrahim <imr@rtschenk.de>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2013 12:07:43 PM, Michael Guntsche wrote:
> Good evening,
>=20
> On Mon, Jun 10, 2013 at 1:41 PM, Rojhalat Ibrahim <imr@rtschenk.de> =20
> wrote:
> > Hi Mike,
> >
> > could you please try this patch:
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-May/106624.html
> > http://patchwork.ozlabs.org/patch/244515/
> >
> >    Rojhalat
> >
> >
> > On Saturday 08 June 2013 21:39:37 Michael Guntsche wrote:
> >> After bisecting I found the responsible commit.
> >>
> >> 50d8f87d2b3: powerpc/fsl-pci Make PCIe hotplug work with Freescale
> >> PCIe controllers
> >>
> >> Reverting this commit allowed my board to boot again.
> >>
> >> @Rojhalat: Please have a look at
> >> http://marc.info/?l=3Dlinux-kernel&m=3D137071294204858&w=3D2
> >> for my initial bugreport.
> >>
> >> What I do not understand at all is why this is affecting my =20
> platform.
> >> AFAIK there is no PCIe hardware on it AND I completely disabled =20
> PCIe
> >> support in config.
> >>
> >> Kind regards,
> >> Mike
>=20
> This patch does not fix the problem, during boot the kernel still
> panics. I had a closer look at the commit and the following patch
> fixes it for me....
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =20
> b/arch/powerpc/sysdev/fsl_pci.c
> index 028ac1f..21b687f 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -814,7 +814,7 @@ int __init mpc83xx_add_bridge(struct device_node =20
> *dev)
>                 if (ret)
>                         goto err0;
>         } else {
> -               fsl_setup_indirect_pci(hose, rsrc_cfg.start,
> +               setup_indirect_pci(hose, rsrc_cfg.start,
>                                        rsrc_cfg.start + 4, 0);
>         }

The only difference here is that you're not setting hose->ops to =20
fsl_indirect_pci_ops.  Do you know why that is helping, and what =20
hose->ops is set to instead?

-Scott=
