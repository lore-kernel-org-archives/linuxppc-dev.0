Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2DAC12C0087
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2012 03:28:01 +1000 (EST)
Date: Mon, 24 Sep 2012 10:27:52 -0700
From: Greg KH <greg@kroah.com>
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: [PATCH v3] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Message-ID: <20120924172752.GC32691@kroah.com>
References: <1347958359-20153-1-git-send-email-Shengzhou.Liu@freescale.com>
 <20120921164342.GA31272@kroah.com>
 <E182B82C-A53B-4013-9D3B-0271268A6A96@kernel.crashing.org>
 <20120922144853.GA10935@kroah.com>
 <3F453DDFF675A64A89321A1F352810217FFC51@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3F453DDFF675A64A89321A1F352810217FFC51@039-SN1MPN1-004.039d.mgd.msft.net>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2012 at 02:44:19PM +0000, Liu Shengzhou-B36685 wrote:
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: 2012年9月22日 22:49
> > To: Kumar Gala
> > Cc: Liu Shengzhou-B36685; linuxppc-dev@lists.ozlabs.org; linux-
> > usb@vger.kernel.org
> > Subject: Re: [PATCH v3] powerpc/usb: fix bug of CPU hang when missing
> > USB PHY clock
> > 
> > On Sat, Sep 22, 2012 at 09:39:15AM -0500, Kumar Gala wrote:
> > >
> > > On Sep 21, 2012, at 11:43 AM, Greg KH wrote:
> > >
> > > > On Tue, Sep 18, 2012 at 04:52:39PM +0800, Shengzhou Liu wrote:
> > > >> when missing USB PHY clock, kernel booting up will hang during USB
> > > >> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> > > >> CPU hanging in this case.
> > > >>
> > > >> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > > >> ---
> > > >> v3 change: no check for UTMI PHY.
> > > >> v2 change: use spin_event_timeout() instead.
> > > >>
> > > >> drivers/usb/host/ehci-fsl.c |   57 +++++++++++++++++++++++++++++--
> > -----------
> > > >> drivers/usb/host/ehci-fsl.h |    1 +
> > > >> include/linux/fsl_devices.h |    1 +
> > > >> 3 files changed, 41 insertions(+), 18 deletions(-)
> > > >
> > > > This is already applied, right?
> > > >
> > > > greg k-h
> > >
> > > It appears that v2 of the patch is applied to your usb-next branch.
> > >
> > > in drivers/usb/host/ehci-fsl.c
> > >
> > > V2:
> > > @@ -262,23 +266,34 @@ static void ehci_fsl_setup_phy(struct usb_hcd
> > *hcd,
> > >         case FSL_USB2_PHY_NONE:
> > >                 break;
> > >         }
> > > +
> > > +       if ((pdata->controller_ver) && ((phy_mode ==
> > FSL_USB2_PHY_ULPI) ||
> > > +                       (phy_mode == FSL_USB2_PHY_UTMI))) {
> > >
> > > V3:
> > >
> > > @@ -262,23 +266,33 @@  static void ehci_fsl_setup_phy(struct usb_hcd
> > *hcd,
> > >
> > >  	case FSL_USB2_PHY_NONE:
> > >  		break;
> > >  	}
> > >
> > > +
> > > +	if (pdata->controller_ver && (phy_mode == FSL_USB2_PHY_ULPI)) {
> > > +		/* check PHY_CLK_VALID to get phy clk valid */
> > 
> > Ok, can someone please make the incremental patch that I need to apply
> > here and send it to me?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi greg,
> 
> I have sent the below incremental patch to you, please squash it into the previous patch v2, which had been applied in your usb-next branch. 
> http://patchwork.ozlabs.org/patch/186443/

Given that this is a git tree, "squashing" patches does not work at all.
I'll just apply it as-is.

thanks,

greg k-h
