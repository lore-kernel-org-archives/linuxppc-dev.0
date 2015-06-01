Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B07DA1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 16:41:39 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 7BEB1140E3E
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jun 2015 16:41:39 +1000 (AEST)
Message-ID: <1433140899.24546.14.camel@neuling.org>
Subject: Re: [PATCH] cxl: Set up and enable PSL Timebase
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com, linuxppc-dev@ozlabs.org, vaibhav@linux.vnet.ibm.com
Date: Mon, 01 Jun 2015 16:41:39 +1000
In-Reply-To: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-28 at 15:12 +0200, Philippe Bergheaud wrote:
> This patch configures the PSL Timebase function and enables it,
> after the CAPP has been initialized by OPAL. Failures are reported
> and ignored.

Needs an Signed-off-by. =20

Comments inline.

> ---
>  drivers/misc/cxl/cxl.h |    5 +++++
>  drivers/misc/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
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
> index fc938de..afd89cc 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -360,6 +360,38 @@ static int init_implementation_adapter_regs(struct c=
xl *adapter, struct pci_dev
>  	return 0;
>  }
> =20
> +#define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
> +
> +static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *d=
ev)
> +{
> +	u64 psl_tb;
> +	int delta;
> +	unsigned int retry =3D 0;
> +
> +	/*
> +	 * Setup PSL Timebase Control and Status register
> +	 * with the recommended Timebase Sync Count value
> +	 */
> +	cxl_p1_write(adapter, CXL_PSL_TB_CTLSTAT, TBSYNC_CNT(2)); =20

2? =20

> +
> +	/* Enable PSL Timebase */
> +	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
> +	/* Wait until CORE TB and PSL TB difference <=3D 16usecs */

How many tries does this normally take? =20

Should we have a sleep in here to wait for it to sync rather than just
coming back around right away?

> +	do {
> +		if (retry++ > 5) {
> +			pr_err("PSL: Timebase sync: giving up!\n");
> +			return 1;

Please use negative error codes here.  -EIO?

> +		}
> +		psl_tb =3D cxl_p1_read(adapter, CXL_PSL_Timebase);
> +		delta =3D mftb() - psl_tb;
> +		if (delta < 0)
> +			delta =3D -delta;
> +	} while (cputime_to_usecs(delta) > 16);
> +
> +	dev_info(&dev->dev, "PSL: Timebase synced\n");
> +	return 0;
> +}
> +
>  static int init_implementation_afu_regs(struct cxl_afu *afu)
>  {
>  	/* read/write masks for this slice */
> @@ -995,6 +1027,9 @@ static struct cxl *cxl_init_adapter(struct pci_dev *=
dev)
>  	if ((rc =3D pnv_phb_to_cxl(dev, OPAL_PHB_CAPI_MODE_CAPI)))
>  		goto err3;
> =20
> +	/* Don't care if this one fails: */
> +	cxl_setup_psl_timebase(adapter, dev);

And check it here.

Thanks,
Mikey

> +
>  	if ((rc =3D cxl_register_psl_err_irq(adapter)))
>  		goto err3;
> =20
