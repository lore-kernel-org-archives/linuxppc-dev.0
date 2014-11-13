Return-Path: <Peter.Chen@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0127.outbound.protection.outlook.com [207.46.100.127])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A53631A0100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 17:45:37 +1100 (AEDT)
Date: Thu, 13 Nov 2014 13:05:15 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Felipe Balbi <balbi@ti.com>, <leoli@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <suresh.gupta@freescale.com>
Subject: Re: [PATCH] usb: phy: fsl: Fix build errors
Message-ID: <20141113050510.GA7693@shlinux2>
References: <1415803146-6510-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1415803146-6510-1-git-send-email-balbi@ti.com>
Cc: antoine.tenart@free-electrons.com,
 Linux USB Mailing List <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 12, 2014 at 08:39:06AM -0600, Felipe Balbi wrote:
> commit e47d925 (usb: move the OTG state from
> the USB PHY to the OTG structure) moved the
> OTG state from struct usb_phy to struct usb_otg.
> 
> Unfortunately, even though I fixed quite a few
> build regressions with that patch already, this
> one was still missing.
> 
> Note that this driver still has other randconfig
> build problems which I'll leave for driver author
> to fix, as that's less trivial.

Add more guys who may use this driver.

> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> The following build error are left for Freescale folks
> since they seem to be a broken for quite a long time.
> 
> drivers/usb/phy/phy-fsl-usb.c: In function ‘usb_otg_start’:
> drivers/usb/phy/phy-fsl-usb.c:918:3: error: ‘_fsl_readl’ undeclared (first use in this function)
>    _fsl_readl = _fsl_readl_be;
>    ^
> drivers/usb/phy/phy-fsl-usb.c:918:3: note: each undeclared identifier is reported only once for each function it appears in
> drivers/usb/phy/phy-fsl-usb.c:918:16: error: ‘_fsl_readl_be’ undeclared (first use in this function)
>    _fsl_readl = _fsl_readl_be;
>                 ^
> drivers/usb/phy/phy-fsl-usb.c:919:3: error: ‘_fsl_writel’ undeclared (first use in this function)
>    _fsl_writel = _fsl_writel_be;
>    ^
> drivers/usb/phy/phy-fsl-usb.c:919:17: error: ‘_fsl_writel_be’ undeclared (first use in this function)
>    _fsl_writel = _fsl_writel_be;
>                  ^
> drivers/usb/phy/phy-fsl-usb.c:921:16: error: ‘_fsl_readl_le’ undeclared (first use in this function)
>    _fsl_readl = _fsl_readl_le;
>                 ^
> drivers/usb/phy/phy-fsl-usb.c:922:17: error: ‘_fsl_writel_le’ undeclared (first use in this function)
>    _fsl_writel = _fsl_writel_le;
>                  ^
>  drivers/usb/phy/phy-fsl-usb.c | 14 +++++++-------
>  drivers/usb/phy/phy-fsl-usb.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
> index b7f36b2..ab38aa3 100644
> --- a/drivers/usb/phy/phy-fsl-usb.c
> +++ b/drivers/usb/phy/phy-fsl-usb.c
> @@ -274,7 +274,7 @@ void b_srp_end(unsigned long foo)
>  	fsl_otg_dischrg_vbus(0);
>  	srp_wait_done = 1;
>  
> -	if ((fsl_otg_dev->phy.state == OTG_STATE_B_SRP_INIT) &&
> +	if ((fsl_otg_dev->phy.otg->state == OTG_STATE_B_SRP_INIT) &&
>  	    fsl_otg_dev->fsm.b_sess_vld)
>  		fsl_otg_dev->fsm.b_srp_done = 1;
>  }
> @@ -624,7 +624,7 @@ static int fsl_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
>  			/* Mini-A cable connected */
>  			struct otg_fsm *fsm = &otg_dev->fsm;
>  
> -			otg.state = OTG_STATE_UNDEFINED;
> +			otg->state = OTG_STATE_UNDEFINED;
>  			fsm->protocol = PROTO_UNDEF;
>  		}
>  	}
> @@ -682,7 +682,7 @@ static int fsl_otg_set_power(struct usb_phy *phy, unsigned mA)
>  {
>  	if (!fsl_otg_dev)
>  		return -ENODEV;
> -	if (phy->otg.state == OTG_STATE_B_PERIPHERAL)
> +	if (phy->otg->state == OTG_STATE_B_PERIPHERAL)
>  		pr_info("FSL OTG: Draw %d mA\n", mA);
>  
>  	return 0;
> @@ -715,7 +715,7 @@ static int fsl_otg_start_srp(struct usb_otg *otg)
>  {
>  	struct fsl_otg *otg_dev;
>  
> -	if (!otg || otg.state != OTG_STATE_B_IDLE)
> +	if (!otg || otg->state != OTG_STATE_B_IDLE)
>  		return -ENODEV;
>  
>  	otg_dev = container_of(otg->usb_phy, struct fsl_otg, phy);
> @@ -990,10 +990,10 @@ int usb_otg_start(struct platform_device *pdev)
>  	 * Also: record initial state of ID pin
>  	 */
>  	if (fsl_readl(&p_otg->dr_mem_map->otgsc) & OTGSC_STS_USB_ID) {
> -		p_otg->phy->otg.state = OTG_STATE_UNDEFINED;
> +		p_otg->phy.otg->state = OTG_STATE_UNDEFINED;
>  		p_otg->fsm.id = 1;
>  	} else {
> -		p_otg->phy->otg.state = OTG_STATE_A_IDLE;
> +		p_otg->phy.otg->state = OTG_STATE_A_IDLE;
>  		p_otg->fsm.id = 0;
>  	}
>  
> @@ -1048,7 +1048,7 @@ static int show_fsl_usb2_otg_state(struct device *dev,
>  	/* State */
>  	t = scnprintf(next, size,
>  		      "OTG state: %s\n\n",
> -		      usb_otg_state_string(fsl_otg_dev->phy.state));
> +		      usb_otg_state_string(fsl_otg_dev->phy.otg->state));
>  	size -= t;
>  	next += t;
>  
> diff --git a/drivers/usb/phy/phy-fsl-usb.h b/drivers/usb/phy/phy-fsl-usb.h
> index 5986c96..2314995 100644
> --- a/drivers/usb/phy/phy-fsl-usb.h
> +++ b/drivers/usb/phy/phy-fsl-usb.h
> @@ -298,7 +298,7 @@
>  /* SE0 Time Before SRP */
>  #define TB_SE0_SRP	(2)	/* b_idle,minimum 2 ms, section:5.3.2 */
>  
> -#define SET_OTG_STATE(otg_ptr, newstate)	((otg_ptr)->state = newstate)
> +#define SET_OTG_STATE(phy, newstate)	((phy)->otg->state = newstate)
>  
>  struct usb_dr_mmap {
>  	/* Capability register */
> -- 
> 2.1.0.GIT
> 

-- 

Best Regards,
Peter Chen
