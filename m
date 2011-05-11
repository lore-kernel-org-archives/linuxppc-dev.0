Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5DEEB6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:06:15 +1000 (EST)
Received: by iym7 with SMTP id 7so686725iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:06:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <ed4319ec825be60a30d7ce5fd50654cde2c5829d.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<ed4319ec825be60a30d7ce5fd50654cde2c5829d.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:05:53 +0200
Message-ID: <BANLkTi=RnHdA8jVvJCQPH6edH++cPPW_wQ@mail.gmail.com>
Subject: Re: [PATCH 27/37] powerpc fsl_msi: don't abuse platform_data for
	driver_data
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 7:30 AM, Milton Miller <miltonm@bga.com> wrote:
> The msi platform device driver was abusing dev.platform_data for its
> platform_driver_data. =A0Use the correct pointer for storage.
>
> Platform_data is supposed to be for platforms to communicate to drivers
> parameters that are not otherwise discoverable. =A0Its lifetime matches
> the platform_device not the platform device driver. =A0It is generally
> not needed for drivers that only support systems with device trees.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ---
> =A0arch/powerpc/sysdev/fsl_msi.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.=
c
> index d5679dc..077776c 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -253,7 +253,7 @@ unlock:
>
> =A0static int fsl_of_msi_remove(struct platform_device *ofdev)
> =A0{
> - =A0 =A0 =A0 struct fsl_msi *msi =3D ofdev->dev.platform_data;
> + =A0 =A0 =A0 struct fsl_msi *msi =3D platform_get_drvdata(ofdev);
> =A0 =A0 =A0 =A0int virq, i;
> =A0 =A0 =A0 =A0struct fsl_msi_cascade_data *cascade_data;
>
> @@ -327,7 +327,7 @@ static int __devinit fsl_of_msi_probe(struct platform=
_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&dev->dev, "No memory for MSI stru=
cture\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 dev->dev.platform_data =3D msi;
> + =A0 =A0 =A0 platform_set_drvdata(dev, msi);
>
> =A0 =A0 =A0 =A0msi->irqhost =3D irq_alloc_host(dev->dev.of_node, IRQ_HOST=
_MAP_LINEAR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0NR_MSI_IRQS, &fsl_msi_host_ops, 0);
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
