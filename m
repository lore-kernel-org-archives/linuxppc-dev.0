Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 47E27B7D0A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 09:38:59 +1000 (EST)
Date: Tue, 6 Apr 2010 00:03:01 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 33/37] sound/soc: use .dev.of_node instead of .node in
	struct of_device
Message-ID: <20100405230301.GF32401@fluff.org.uk>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180649.4824.10368.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100311180649.4824.10368.stgit@angua>
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, linux-ide@vger.kernel.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com,
	sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
	jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	monstr@monstr.eu, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 11:06:50AM -0700, Grant Likely wrote:
> .node is being removed
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  sound/soc/fsl/mpc8610_hpcd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
> index ef67d1c..d7e1b9a 100644
> --- a/sound/soc/fsl/mpc8610_hpcd.c
> +++ b/sound/soc/fsl/mpc8610_hpcd.c
> @@ -202,7 +202,7 @@ static struct snd_soc_ops mpc8610_hpcd_ops = {
>  static int mpc8610_hpcd_probe(struct of_device *ofdev,
>  	const struct of_device_id *match)
>  {
> -	struct device_node *np = ofdev->node;
> +	struct device_node *np = ofdev->dev.of_node;
>  	struct device_node *codec_np = NULL;
>  	struct device_node *guts_np = NULL;
>  	struct device_node *dma_np = NULL;

This looks like one case where an inline function would have been a
help.


-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
