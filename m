Return-Path: <rogerq@ti.com>
Message-ID: <50FD4034.5040402@ti.com>
Date: Mon, 21 Jan 2013 15:18:44 +0200
From: Roger Quadros <rogerq@ti.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 6/6] USB: MUSB: OMAP: get PHY by phandle for dt boot
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-7-git-send-email-kishon@ti.com>
In-Reply-To: <1358348462-27693-7-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-doc@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 stern@rowland.harvard.edu, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, rob.herring@calxeda.com, horms@verge.net.au,
 haojian.zhuang@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, b-cousson@ti.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, balbi@ti.com, cbou@mail.ru, rob@landley.net,
 dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/2013 05:01 PM, Kishon Vijay Abraham I wrote:
> The OMAP glue has been modified to get PHY by phandle for dt boot.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/musb/omap2430.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 3628a50..08709cf 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -346,7 +346,12 @@ static int omap2430_musb_init(struct musb *musb)
>  	 * up through ULPI.  TWL4030-family PMICs include one,
>  	 * which needs a driver, drivers aren't always needed.
>  	 */
> -	musb->xceiv = devm_usb_get_phy(dev, 0);
> +	if (dev->parent->of_node)
> +		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
> +		    "usb_phy", 0);

Why dev->parent and not just dev?

> +	else
> +		musb->xceiv = devm_usb_get_phy(dev, 0);
> +
>  	if (IS_ERR_OR_NULL(musb->xceiv)) {
>  		pr_err("HS USB OTG: no transceiver configured\n");
>  		return -ENODEV;
> 

--
cheers,
-roger
