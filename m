Return-Path: <stern+495b41de@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 8010FDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 13:51:54 +1100 (EST)
Date: Tue, 23 Dec 2008 21:45:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] USB: Driver for Freescale QUICC Engine USB Host Controller
In-Reply-To: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.44L0.0812232140400.8076-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Dec 2008, Anton Vorontsov wrote:

> This patch adds support for the FHCI USB controller, as found
> in the Freescale MPC836x and MPC832x processors. It can support
> Full or Low speed modes.
> 
> Quite a lot the hardware is doing by itself (SOF generation, CRC
> generation and checking), though scheduling and retransmission is on
> software's shoulders.
> 
> This controller does not integrate the root hub, so this driver also
> fakes one-port hub. External hub is required to support more than
> one device.

It looks like the kernel this was written for is several versions out 
of date.  The driver is missing some critical calls to functions like 
usb_hcd_link_urb_to_ep().

Alan Stern
