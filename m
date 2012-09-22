Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0EADB2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2012 00:39:19 +1000 (EST)
Subject: Re: [PATCH v3] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20120921164342.GA31272@kroah.com>
Date: Sat, 22 Sep 2012 09:39:15 -0500
Message-Id: <E182B82C-A53B-4013-9D3B-0271268A6A96@kernel.crashing.org>
References: <1347958359-20153-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20120921164342.GA31272@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2012, at 11:43 AM, Greg KH wrote:

> On Tue, Sep 18, 2012 at 04:52:39PM +0800, Shengzhou Liu wrote:
>> when missing USB PHY clock, kernel booting up will hang during USB
>> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
>> CPU hanging in this case.
>>=20
>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>> ---
>> v3 change: no check for UTMI PHY.
>> v2 change: use spin_event_timeout() instead.
>>=20
>> drivers/usb/host/ehci-fsl.c |   57 =
+++++++++++++++++++++++++++++-------------
>> drivers/usb/host/ehci-fsl.h |    1 +
>> include/linux/fsl_devices.h |    1 +
>> 3 files changed, 41 insertions(+), 18 deletions(-)
>=20
> This is already applied, right?
>=20
> greg k-h

It appears that v2 of the patch is applied to your usb-next branch.

in drivers/usb/host/ehci-fsl.c

V2:
@@ -262,23 +266,34 @@ static void ehci_fsl_setup_phy(struct usb_hcd =
*hcd,
        case FSL_USB2_PHY_NONE:
                break;
        }
+
+       if ((pdata->controller_ver) && ((phy_mode =3D=3D =
FSL_USB2_PHY_ULPI) ||
+                       (phy_mode =3D=3D FSL_USB2_PHY_UTMI))) {

V3:

@@ -262,23 +266,33 @@  static void ehci_fsl_setup_phy(struct usb_hcd =
*hcd,

 	case FSL_USB2_PHY_NONE:
 		break;
 	}

+
+	if (pdata->controller_ver && (phy_mode =3D=3D =
FSL_USB2_PHY_ULPI)) {
+		/* check PHY_CLK_VALID to get phy clk valid */


- k=
