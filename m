Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29F97DE15C
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 04:21:07 +1000 (EST)
Date: Fri, 29 Aug 2008 22:20:44 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Message-ID: <20080829222044.53c56bca@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0808291121180.4447-100000@netrider.rowland.org>
References: <1219963406.13162.368.camel@pasglop>
	<Pine.LNX.4.44L0.0808291121180.4447-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: linux-usb@vger.kernel.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Fri, 29 Aug 2008 11:26:07 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> пишет:

> On Fri, 29 Aug 2008, Benjamin Herrenschmidt wrote:
> 
> > I suppose some embedded platforms don't use CONFIG_PM, is this
> > still a requirement for autosuspend ? Or do that happen always on
> > an empty port nowadays ?
> 
> ohci-hcd doesn't automatically suspend the root hub if CONFIG_PM isn't
> set.  However it isn't necessary to set CONFIG_SLEEP,
> CONFIG_HIBERNATION, or CONFIG_USB_SUSPEND.

That is good to know. 

But even assuming PM set, common use-case of
embedded systems to have stuff on USB bus that is never plugged off;
and in case of compiled-in ehci and ohci there is just 

Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using ppc-of-ehci and address 2
usb 1-1: device descriptor read/all, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1

(not touching PM here to be clear)

even 1-second delay would be enough for root hub to be hosed... So, is
the patch (with all the issues addressed) acceptable for mainline?

Thanks, 
-Vitaly
