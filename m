Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id EF54610C6BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:30:15 +1000 (EST)
Received: by gxk28 with SMTP id 28so182225gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:30:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1284573958-8397-5-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-5-git-send-email-nacc@us.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:29:52 -0600
Message-ID: <AANLkTiksxVLipGuSwN6xCPV23LNpP8Am-223_ZbN8T+a@mail.gmail.com>
Subject: Re: [PATCH 04/15] vio: put device on device_register failure
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
> The kernel doc for device_register (and device_initialize) very clearly
> state to call put_device not kfree after calling, even on error.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/kernel/vio.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index fa3469d..72db4b0 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -1254,8 +1254,7 @@ struct vio_dev *vio_register_device_node(struct dev=
ice_node *of_node)
> =A0 =A0 =A0 =A0if (device_register(&viodev->dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: failed to register de=
vice %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, =
dev_name(&viodev->dev));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX free TCE table */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(viodev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_device(&viodev->dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0}
>
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
