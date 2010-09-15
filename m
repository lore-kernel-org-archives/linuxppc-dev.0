Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id CA9BF10C719
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:38:21 +1000 (EST)
Received: by gxk28 with SMTP id 28so185144gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:38:18 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1284573958-8397-16-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:37:58 -0600
Message-ID: <AANLkTi=K+KudbVAqZGA9fXXWq-vXirh9SuSTEHSh=kgC@mail.gmail.com>
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wro=
te:
> Without this change drivers, such as ibmvscsi, fail to load with the
> previous change.

Shouldn't this patch be ordered before the previous change then to
preserve bisectability?

Also, patch descriptions should be explicit about what the "previous
change" refers to.  Once this is committed, git log may very well
insert other changes from other branches between this commit and
whatever "previous change" refers to.

g.

> ---
> =A0arch/powerpc/kernel/vio.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index 3c3083f..e8d73de 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1259,6 +1259,9 @@ struct vio_dev *vio_register_device_node(struct dev=
ice_node *of_node)
> =A0 =A0 =A0 =A0viodev->dev.parent =3D &vio_bus_device.dev;
> =A0 =A0 =A0 =A0viodev->dev.bus =3D &vio_bus_type;
> =A0 =A0 =A0 =A0viodev->dev.release =3D vio_dev_release;
> + =A0 =A0 =A0 =A0/* needed to ensure proper operation of coherent allocat=
ions
> + =A0 =A0 =A0 =A0 * later, in case driver doesn't set it explicitly */
> + =A0 =A0 =A0 =A0dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
>
> =A0 =A0 =A0 =A0/* register with generic device framework */
> =A0 =A0 =A0 =A0if (device_register(&viodev->dev)) {
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
