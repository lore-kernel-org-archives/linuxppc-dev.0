Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67])
	by bilbo.ozlabs.org (Postfix) with SMTP id 6B8E6B7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 10:34:37 +1000 (EST)
Date: Thu, 20 Aug 2009 20:27:53 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC
	driver.
Message-ID: <20090820202753.46eaf974@lappy.seanm.ca>
In-Reply-To: <1250813957-1786-1-git-send-email-fkan@amcc.com>
References: <1250813957-1786-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 Aug 2009 17:19:17 -0700
Feng Kan <fkan@amcc.com> wrote:

> Fix ECC Correction bug where the byte offset location were double
> fliped causing correction routine to toggle the wrong byte location
> in the ECC segment. The ndfc_calculate_ecc routine change the order
> of getting the ECC code.
>         /* The NDFC uses Smart Media (SMC) bytes order */
>         ecc_code[0] = p[2];
>         ecc_code[1] = p[1];
>         ecc_code[2] = p[3];
> But in the Correction algorithm when calculating the byte offset
> location, the b1 is used as the upper part of the address. Which
> again reverse the order making the final byte offset address 
> location incorrect.
> 	byte_addr = (addressbits[b1] << 4) + addressbits[b0];
> The order is change to read it in straight and let the correction
> function to revert it to SMC order.
> 
> Signed-off-by: Feng Kan <fkan@amcc.com>
> Acked-by: Victor Gallardo <vgallardo@amcc.com>
> Acked-by: Prodyut Hazarika <phazarika@amcc.com>
> ---
>  drivers/mtd/nand/ndfc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/ndfc.c b/drivers/mtd/nand/ndfc.c
> index 5906c40..d9d3e6e 100644
> --- a/drivers/mtd/nand/ndfc.c
> +++ b/drivers/mtd/nand/ndfc.c
> @@ -101,8 +101,8 @@ static int ndfc_calculate_ecc(struct mtd_info
> *mtd, wmb();
>  	ecc = in_be32(ndfc->ndfcbase + NDFC_ECC);
>  	/* The NDFC uses Smart Media (SMC) bytes order */
> -	ecc_code[0] = p[2];
> -	ecc_code[1] = p[1];
> +	ecc_code[0] = p[1];
> +	ecc_code[1] = p[2];
>  	ecc_code[2] = p[3];
>  
>  	return 0;

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
   Sean
