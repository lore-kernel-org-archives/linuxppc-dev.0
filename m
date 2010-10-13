Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id A2AFBB70D0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 14:44:41 +1100 (EST)
Received: by gxk3 with SMTP id 3so2291932gxk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 20:44:40 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 12 Oct 2010 21:44:37 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 5/5] mtd: m25p80: add support to parse the
	partitions by OF node
Message-ID: <20101013034437.GE7254@angua.secretlab.ca>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
Cc: kumar.gala@freescale.com, david-b@pacbell.net, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 12, 2010 at 06:18:34PM +0800, Mingkai Hu wrote:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

dwmw2: what are your thoughts on this one?

g.



> ---
> v4:
>  - Updated to latest kernel base(Linux 2.6.36-rc7).
>  - Made changes according to Grant's comments.
> 
>  drivers/mtd/devices/m25p80.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 6f512b5..9d20738 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -924,6 +924,11 @@ static int __devinit m25p_probe(struct spi_device *spi)
>  			nr_parts = data->nr_parts;
>  		}
>  
> +		if (nr_parts <= 0 && spi->dev.of_node) {
> +			nr_parts = of_mtd_parse_partitions(&spi->dev,
> +					spi->dev.of_node, &parts);
> +		}
> +
>  		if (nr_parts > 0) {
>  			for (i = 0; i < nr_parts; i++) {
>  				DEBUG(MTD_DEBUG_LEVEL2, "partitions[%d] = "
> -- 
> 1.6.4
> 
> 
