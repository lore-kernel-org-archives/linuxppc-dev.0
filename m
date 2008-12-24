Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4F2B7DDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 06:11:45 +1100 (EST)
Date: Wed, 24 Dec 2008 22:11:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] USB: Driver for Freescale QUICC Engine USB Host Controller
Message-ID: <20081224191143.GA11060@oksana.dev.rtsoft.ru>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
	<Pine.LNX.4.44L0.0812232140400.8076-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <Pine.LNX.4.44L0.0812232140400.8076-100000@netrider.rowland.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 23, 2008 at 09:45:09PM -0500, Alan Stern wrote:
> On Wed, 24 Dec 2008, Anton Vorontsov wrote:
> 
> > This patch adds support for the FHCI USB controller, as found
> > in the Freescale MPC836x and MPC832x processors. It can support
> > Full or Low speed modes.
> > 
> > Quite a lot the hardware is doing by itself (SOF generation, CRC
> > generation and checking), though scheduling and retransmission is on
> > software's shoulders.
> > 
> > This controller does not integrate the root hub, so this driver also
> > fakes one-port hub. External hub is required to support more than
> > one device.
> 
> It looks like the kernel this was written for is several versions out 
> of date.

Yeah, originally it was written for 2.6.10. Though the driver I
posted is for the linux-next, and it works quite well w/o the
{un,}link_urb calls. ;-)

> The driver is missing some critical calls to functions like 
> usb_hcd_link_urb_to_ep().

Fixed.

Thanks for review!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
