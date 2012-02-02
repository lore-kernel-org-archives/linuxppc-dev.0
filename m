Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0B8B8104785
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2012 06:18:08 +1100 (EST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 757DD21742
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 14:18:06 -0500 (EST)
Date: Thu, 2 Feb 2012 11:14:12 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2] powerpc/usb: fix issue of CPU halt when missing USB
 PHY clock
Message-ID: <20120202191412.GB3027@kroah.com>
References: <1328152994-2879-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4F2A7604.9060102@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F2A7604.9060102@mvista.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2012 at 03:39:48PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 02-02-2012 7:23, Shengzhou Liu wrote:
> 
> >when missing USB PHY clock, kernel booting up will halt during USB
> >initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> >CPU hang in this case.
> 
> >Signed-off-by: Shengzhou Liu<Shengzhou.Liu@freescale.com>
> [...]
> 
> >diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
> >index 4918062..dd3dc47 100644
> >--- a/drivers/usb/host/ehci-fsl.h
> >+++ b/drivers/usb/host/ehci-fsl.h
> >@@ -45,5 +45,6 @@
> >  #define FSL_SOC_USB_PRICTRL	0x40c	/* NOTE: big-endian */
> >  #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
> >  #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
> >+#define CTRL_PHY_CLK_VALID      (1 << 17)
> 
>    Indent the macro value with tabs please.

I fixed this by hand.
