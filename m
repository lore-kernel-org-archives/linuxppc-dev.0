Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9869EB71BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 11:10:45 +1000 (EST)
Subject: Re: [PATCH] agp/uninorth: Fix lockups with radeon KMS and >1x.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
In-Reply-To: <1305814119-32288-1-git-send-email-michel@daenzer.net>
References: <1305814119-32288-1-git-send-email-michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 11:10:33 +1000
Message-ID: <1305853833.7481.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Dave Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-19 at 16:08 +0200, Michel Dänzer wrote:
> From: Michel Dänzer <daenzer@vmware.com>
> 
> This was based on a description by Ben Herrenschmidt:
> 
> > I've removed that SBA reset from the normal TLB invalidation path and
> > left it only once after turning AGP on.
> 
> About six months ago, he said:
> 
> > I did it a bit differently, but yeah, you get the idea. I'm doing a
> > patch series so don't bother pushing things too hard yet.
> 
> But I haven't seen anything from him about this since then, and people are
> regularly hitting these lockups, so here we are...
> 
> Signed-off-by: Michel Dänzer <daenzer@vmware.com>

Oops. I do have a pile of patches, but I never got something "stable"
enough and got distracted by more important stuff. Dave, please merge
this for now.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks !

Cheers,
Ben.

> ---
>  drivers/char/agp/uninorth-agp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
> index 47c2218..55af723 100644
> --- a/drivers/char/agp/uninorth-agp.c
> +++ b/drivers/char/agp/uninorth-agp.c
> @@ -80,7 +80,7 @@ static void uninorth_tlbflush(struct agp_memory *mem)
>  			       ctrl | UNI_N_CFG_GART_INVAL);
>  	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, ctrl);
>  
> -	if (uninorth_rev <= 0x30) {
> +	if (!mem && uninorth_rev <= 0x30) {
>  		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
>  				       ctrl | UNI_N_CFG_GART_2xRESET);
>  		pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
