Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGXWh4j6qzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:09:15 +1100 (AEDT)
Message-ID: <1508238182.16112.475.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Corentin Labbe
 <clabbe.montjoie@gmail.com>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Tue, 17 Oct 2017 14:03:02 +0300
In-Reply-To: <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
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

On Mon, 2017-10-16 at 19:33 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 16 Oct 2017 18:28:17 +0200
> 
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding
> size
> determination a bit safer according to the Linux coding style
> convention.


This patch does one style in favor of the other.

At the end it's Jarkko's call, though I would NAK this as I think some
one already told this to you for some other similar patch(es).


I even would suggest to stop doing this noisy stuff, which keeps people
busy for nothing.

> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/char/tpm/st33zp24/i2c.c      | 3 +--
>  drivers/char/tpm/st33zp24/spi.c      | 3 +--
>  drivers/char/tpm/st33zp24/st33zp24.c | 3 +--
>  drivers/char/tpm/tpm_crb.c           | 2 +-
>  drivers/char/tpm/tpm_i2c_atmel.c     | 2 +-
>  drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 +-
>  drivers/char/tpm/tpm_ibmvtpm.c       | 2 +-
>  drivers/char/tpm/tpm_tis.c           | 2 +-
>  drivers/char/tpm/tpm_tis_spi.c       | 3 +--
>  9 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c
> b/drivers/char/tpm/st33zp24/i2c.c
> index be5d1abd3e8e..d0cb25688485 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -245,8 +245,7 @@ static int st33zp24_i2c_probe(struct i2c_client
> *client,
>  		return -ENODEV;
>  	}
>  
> -	phy = devm_kzalloc(&client->dev, sizeof(struct
> st33zp24_i2c_phy),
> -			   GFP_KERNEL);
> +	phy = devm_kzalloc(&client->dev, sizeof(*phy), GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/st33zp24/spi.c
> b/drivers/char/tpm/st33zp24/spi.c
> index 0fc4f20b5f83..c952df9244c8 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -358,8 +358,7 @@ static int st33zp24_spi_probe(struct spi_device
> *dev)
>  		return -ENODEV;
>  	}
>  
> -	phy = devm_kzalloc(&dev->dev, sizeof(struct
> st33zp24_spi_phy),
> -			   GFP_KERNEL);
> +	phy = devm_kzalloc(&dev->dev, sizeof(*phy), GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c
> b/drivers/char/tpm/st33zp24/st33zp24.c
> index 4d1dc8b46877..0686a129268c 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -533,8 +533,7 @@ int st33zp24_probe(void *phy_id, const struct
> st33zp24_phy_ops *ops,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> -	tpm_dev = devm_kzalloc(dev, sizeof(struct st33zp24_dev),
> -			       GFP_KERNEL);
> +	tpm_dev = devm_kzalloc(dev, sizeof(*tpm_dev), GFP_KERNEL);
>  	if (!tpm_dev)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 7b3c2a8aa9de..343c46e8560f 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -557,7 +557,7 @@ static int crb_acpi_add(struct acpi_device
> *device)
>  	if (sm == ACPI_TPM2_MEMORY_MAPPED)
>  		return -ENODEV;
>  
> -	priv = devm_kzalloc(dev, sizeof(struct crb_priv),
> GFP_KERNEL);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c
> b/drivers/char/tpm/tpm_i2c_atmel.c
> index 95ce2e9ccdc6..2d0df930a76d 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -165,7 +165,7 @@ static int i2c_atmel_probe(struct i2c_client
> *client,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> -	priv = devm_kzalloc(dev, sizeof(struct priv_data),
> GFP_KERNEL);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c
> b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index c6428771841f..5983d52eb6d9 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -551,7 +551,7 @@ static int i2c_nuvoton_probe(struct i2c_client
> *client,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> -	priv = devm_kzalloc(dev, sizeof(struct priv_data),
> GFP_KERNEL);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
> b/drivers/char/tpm/tpm_ibmvtpm.c
> index b18148ef2612..a4b462a77b99 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -608,7 +608,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> *vio_dev,
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> -	ibmvtpm = kzalloc(sizeof(struct ibmvtpm_dev), GFP_KERNEL);
> +	ibmvtpm = kzalloc(sizeof(*ibmvtpm), GFP_KERNEL);
>  	if (!ibmvtpm)
>  		goto cleanup;
>  
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ebd0e75a3e4d..0a3af60bab2a 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -294,7 +294,7 @@ static int tpm_tis_init(struct device *dev, struct
> tpm_info *tpm_info)
>  	if (rc)
>  		return rc;
>  
> -	phy = devm_kzalloc(dev, sizeof(struct tpm_tis_tcg_phy),
> GFP_KERNEL);
> +	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>  	if (phy == NULL)
>  		return -ENOMEM;
>  
> diff --git a/drivers/char/tpm/tpm_tis_spi.c
> b/drivers/char/tpm/tpm_tis_spi.c
> index 424ff2fde1f2..7cabb12d0b3a 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -200,8 +200,7 @@ static int tpm_tis_spi_probe(struct spi_device
> *dev)
>  {
>  	struct tpm_tis_spi_phy *phy;
>  
> -	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
> -			   GFP_KERNEL);
> +	phy = devm_kzalloc(&dev->dev, sizeof(*phy), GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
