Return-Path: <rogerq@ti.com>
Message-ID: <50F821DD.1040609@ti.com>
Date: Thu, 17 Jan 2013 18:07:57 +0200
From: Roger Quadros <rogerq@ti.com>
MIME-Version: 1.0
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support
 multiple PHYs of same type
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com>
In-Reply-To: <1358348462-27693-4-git-send-email-kishon@ti.com>
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

On 01/16/2013 05:00 PM, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, the API's
> for adding PHY and getting PHY has been changed. Now the binding
> information of the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of the
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, get_phy will return the
> approappropriate PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-
>  drivers/power/ab8500_charger.c        |    2 +-
>  drivers/power/isp1704_charger.c       |    2 +-
>  drivers/power/pda_power.c             |    2 +-
>  drivers/power/twl4030_charger.c       |    2 +-
>  drivers/usb/chipidea/udc.c            |    2 +-
>  drivers/usb/dwc3/core.c               |    4 +-
>  drivers/usb/gadget/fsl_udc_core.c     |    2 +-
>  drivers/usb/gadget/mv_udc_core.c      |    2 +-
>  drivers/usb/gadget/omap_udc.c         |    2 +-
>  drivers/usb/gadget/pxa25x_udc.c       |    2 +-
>  drivers/usb/gadget/pxa27x_udc.c       |    2 +-
>  drivers/usb/gadget/s3c-hsudc.c        |    2 +-
>  drivers/usb/host/ehci-fsl.c           |    2 +-
>  drivers/usb/host/ehci-msm.c           |    2 +-
>  drivers/usb/host/ehci-mv.c            |    2 +-
>  drivers/usb/host/ehci-tegra.c         |    2 +-
>  drivers/usb/host/ohci-omap.c          |    2 +-
>  drivers/usb/musb/am35x.c              |    2 +-
>  drivers/usb/musb/blackfin.c           |    2 +-
>  drivers/usb/musb/da8xx.c              |    2 +-
>  drivers/usb/musb/davinci.c            |    2 +-
>  drivers/usb/musb/musb_dsps.c          |    2 +-
>  drivers/usb/musb/omap2430.c           |    2 +-
>  drivers/usb/musb/tusb6010.c           |    2 +-
>  drivers/usb/musb/ux500.c              |    2 +-
>  drivers/usb/otg/ab8500-usb.c          |    3 +-
>  drivers/usb/otg/fsl_otg.c             |    5 ++-
>  drivers/usb/otg/gpio_vbus.c           |    3 +-
>  drivers/usb/otg/isp1301_omap.c        |    3 +-
>  drivers/usb/otg/msm_otg.c             |    3 +-
>  drivers/usb/otg/mv_otg.c              |    3 +-
>  drivers/usb/otg/nop-usb-xceiv.c       |    3 +-
>  drivers/usb/otg/otg.c                 |   67 +++++++++++++++------------------
>  drivers/usb/otg/twl4030-usb.c         |    3 +-
>  drivers/usb/phy/mv_u3d_phy.c          |    3 +-
>  drivers/usb/phy/omap-usb2.c           |   11 ++----
>  drivers/usb/phy/rcar-phy.c            |    3 +-
>  include/linux/usb/phy.h               |   12 +++---
>  39 files changed, 87 insertions(+), 89 deletions(-)

I think it better to leave the existing add/get APIs as they are add add
new APIs that support multiple PHYs. You could probably mark the old
ones as deprecated.

That way you don't need to wait till all users are converted and tested.

e.g. you could name the new APIs as

usb_add_phy_dev(struct usb_phy *phy);
usb_get_phy_dev(struct device *dev, int index);

--
cheers,
-roger
