Return-Path: <greg@kroah.com>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA6E32C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 00:41:23 +1000 (EST)
Date: Tue, 18 Sep 2012 15:34:28 +0100
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Message-ID: <20120918143428.GE15432@kroah.com>
References: <1345630620-32070-1-git-send-email-Shengzhou.Liu@freescale.com>
 <6E81CB63-79F1-4C45-87A6-28048351FF84@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E81CB63-79F1-4C45-87A6-28048351FF84@kernel.crashing.org>
Cc: linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2012 at 12:35:09AM -0500, Kumar Gala wrote:
> 
> On Aug 22, 2012, at 5:17 AM, Shengzhou Liu wrote:
> 
> > when missing USB PHY clock, kernel booting up will hang during USB
> > initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> > CPU hanging in this case.
> > 
> > Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> > ---
> > v2 changes: use spin_event_timeout() instead.
> > 
> > drivers/usb/host/ehci-fsl.c |   58 +++++++++++++++++++++++++++++-------------
> > drivers/usb/host/ehci-fsl.h |    1 +
> > include/linux/fsl_devices.h |    1 +
> > 3 files changed, 42 insertions(+), 18 deletions(-)
> 
> Greg,
> 
> Any issues picking this fix up for v3.6 inclusion?

Yes, I will not as there is a v3 out there that I want some review on
before I can take it...

thanks,

greg k-h
