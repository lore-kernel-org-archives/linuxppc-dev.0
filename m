Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 620A51A098B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 10:22:21 +1000 (AEST)
Received: from mail-pd0-x232.google.com (mail-pd0-x232.google.com
 [IPv6:2607:f8b0:400e:c02::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E215D1401CD
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 10:22:19 +1000 (AEST)
Received: by pdrh1 with SMTP id h1so36192508pdr.0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:22:17 -0700 (PDT)
Message-ID: <1439597991.29526.32.camel@axtens.net>
Subject: Re: [PATCH V2] cxl: Set up and enable PSL Timebase
From: Daniel Axtens <dja@axtens.net>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com,
 vaibhav@linux.vnet.ibm.com
Date: Sat, 15 Aug 2015 10:19:51 +1000
In-Reply-To: <1433944919-8013-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1433944919-8013-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-zcfCsIBJUClEEaiJ550Q"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-zcfCsIBJUClEEaiJ550Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I was trying to test Timebase Sync today and realised that it hasn't
been applied to mpe's next tree, and that it no longer applies cleanly.

Would you be able to respin it please?

I also have some minor comments inline.

On Wed, 2015-06-10 at 16:01 +0200, Philippe Bergheaud wrote:
> This patch configures the PSL Timebase function and enables it,
> after the CAPP has been initialized by OPAL.
>=20
This changelog should go after a line like this:
---
> V2:
>  - Clear CXL_PSL_ErrIVTE_tberror bit
>  - Define the sync count unit
>  - Wait 1ms before each test
>  - Use negative error code
>  - Do not ignore errors
>  - Except if timebase is not supported by OPAL
>  - Be silent on success
>=20
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/cxl.h |    5 ++++
>  drivers/misc/cxl/pci.c |   57 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 61 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index a1cee47..38a7cf9 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -82,8 +82,10 @@ static const cxl_p1_reg_t CXL_PSL_AFUSEL  =3D {0x00B0}=
;
>  /* 0x00C0:7EFF Implementation dependent area */
>  static const cxl_p1_reg_t CXL_PSL_FIR1      =3D {0x0100};
>  static const cxl_p1_reg_t CXL_PSL_FIR2      =3D {0x0108};
> +static const cxl_p1_reg_t CXL_PSL_Timebase  =3D {0x0110};
>  static const cxl_p1_reg_t CXL_PSL_VERSION   =3D {0x0118};
>  static const cxl_p1_reg_t CXL_PSL_RESLCKTO  =3D {0x0128};
> +static const cxl_p1_reg_t CXL_PSL_TB_CTLSTAT =3D {0x0140};
>  static const cxl_p1_reg_t CXL_PSL_FIR_CNTL  =3D {0x0148};
>  static const cxl_p1_reg_t CXL_PSL_DSNDCTL   =3D {0x0150};
>  static const cxl_p1_reg_t CXL_PSL_SNWRALLOC =3D {0x0158};
> @@ -151,6 +153,9 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     =3D {0x=
0A0};
>  #define CXL_PSL_SPAP_Size_Shift 4
>  #define CXL_PSL_SPAP_V    0x0000000000000001ULL
> =20
> +/****** CXL_PSL_Control ************************************************=
****/
> +#define CXL_PSL_Control_tb 0x0000000000000001ULL
> +
>  /****** CXL_PSL_DLCNTL *************************************************=
****/
>  #define CXL_PSL_DLCNTL_D (0x1ull << (63-28))
>  #define CXL_PSL_DLCNTL_C (0x1ull << (63-29))
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index fc938de..ea1a79f 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -360,6 +360,55 @@ static int init_implementation_adapter_regs(struct c=
xl *adapter, struct pci_dev
>  	return 0;
>  }
> =20
> +#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
> +#define _2048_250MHZ_CYCLES 1
> +
I'm not quite clear what these macros do or mean, and I'm also a little
bit uncomfortable with them just sitting in the middle of the file.

In particular, what does _2048_250MHZ_CYCLES mean?

> +static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *d=
ev)
> +{
> +	u64 psl_tb;
> +	int delta;
> +	unsigned int retry =3D 0;
> +	struct device_node *np;
> +
> +	if (!(np =3D pnv_pci_to_phb_node(dev)))
> +		return -ENODEV;
> +
> +	/* Do not fail when CAPP timebase sync is not supported by OPAL */
> +	of_node_get(np);
> +	if (! of_get_property(np, "ibm,capp-timebase-sync", NULL)) {
> +		of_node_put(np);
> +		pr_err("PSL: Timebase sync: OPAL support missing\n");
> +		return 0;
> +	}
> +	of_node_put(np);
Do we need to grab a reference to the node?
> +
> +	/*
> +	 * Setup PSL Timebase Control and Status register
> +	 * with the recommended Timebase Sync Count value
> +	 */
> +	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT,
> +		     TBSYNC_CNT(2 * _2048_250MHZ_CYCLES));
> +
> +	/* Enable PSL Timebase */
> +	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
> +	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
> +
Is there a reason we need to write 0s to PSL control before we write the
timebase control value?

> +	/* Wait until CORE TB and PSL TB difference <=3D 16usecs */
> +	do {
> +		msleep(1);
> +		if (retry++ > 5) {
> +			pr_err("PSL: Timebase sync: giving up!\n");
> +			return -EIO;
> +		}
> +		psl_tb =3D cxl_p1_read(adapter, CXL_PSL_Timebase);
> +		delta =3D mftb() - psl_tb;
> +		if (delta < 0)
> +			delta =3D -delta;
> +	} while (cputime_to_usecs(delta) > 16);
> +
> +	return 0;
> +}
> +
>  static int init_implementation_afu_regs(struct cxl_afu *afu)
>  {
>  	/* read/write masks for this slice */
> @@ -952,9 +1001,12 @@ static struct cxl *cxl_alloc_adapter(struct pci_dev=
 *dev)
>  	return adapter;
>  }
> =20
> +#define CXL_PSL_ErrIVTE_tberror (0x1ull << (63-31))
> +
Again, could we put this somewhere else, rather than in the middle of
the file?
>  static int sanitise_adapter_regs(struct cxl *adapter)
>  {
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
> +	/* Clear PSL tberror bit by writing 1 to it */
> +	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, CXL_PSL_ErrIVTE_tberror);
>  	return cxl_tlb_slb_invalidate(adapter);
>  }
> =20
> @@ -995,6 +1047,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *=
dev)
>  	if ((rc =3D pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_CAPI)))
>  		goto err3;
> =20
> +	if ((rc =3D cxl_setup_psl_timebase(adapter, dev)))
> +		goto err3;
> +
This bit will no longer apply cleanly. I *think* this should go in the
adapter config path (the part that's done on both setup and recovery).
>  	if ((rc =3D cxl_register_psl_err_irq(adapter)))
>  		goto err3;
> =20

--=20
Regards,
Daniel

--=-zcfCsIBJUClEEaiJ550Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVzoWoAAoJEPC3R3P2I92Fa+sP/3IRNLr5ztJLHkJn1kUQ7jQA
rCz1uV3HDRrFY6vGu8QySohc+RtmNpLx0dVlEtIXjiruKSN4KQ2tqIGyocW9ckGc
BVqD33gWHEsfgNoXw2oVlrnNI/0qcX4e0rAXj8HUO2qy4PKdqxAA445/ehgFU9kA
QaJZZ+112luN/IMyS1IUf5j4XwJFCZ4QKjWUwuvBCvLELuP+12LG4JFJo3D+kHR0
BEY6WgfSEeJjp/wizCvtLPXinNxo6V1wqC7wpOfaicSC+HjwQksjGHBMNOczO86S
C5DZoTZoEYHYijkg/BKjpZy7Un4ZzBpc24I90mWkQMAWVeeCR5K6Wiw8VfbOudK0
mlV7EjVwQ3bySSv9d3nb3BFMIXUWuXzgRDy+eDQqfJzS2uv/ETO80X3xJCVWofOa
38nA41eF1mjDMlGqitdGJ1p7CiN8rhnz9awvMXgN/DQVfN9S4DNw6IPVN/s9Iezq
PGYM/SlS0QvgdIerO/QhRhgMeJNuZNqzXcZeSfOeFlKBCvOdevDk4FOz5WAhVOii
hA0OkAUl10OJO39goYfYFzAiYd+B8wEy5C3Qt+OwV1Vqzp5Tgsm9MO518m4UlWxl
gl62bfGz/iQPi2eqyYh1YJZwZg1m0hhOtbjIP9AnTDhB+zSXfmfHxYO2mbDkt2jv
zae9QwH9SvdlosJmChIk
=02FK
-----END PGP SIGNATURE-----

--=-zcfCsIBJUClEEaiJ550Q--
