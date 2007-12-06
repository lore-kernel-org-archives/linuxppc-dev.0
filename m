Return-Path: <david-b@pacbell.net>
Received: from smtp108.sbc.mail.mud.yahoo.com (smtp108.sbc.mail.mud.yahoo.com
	[68.142.198.207]) by ozlabs.org (Postfix) with SMTP id BE7A2DE129
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:22:47 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] usb: Remove broken optimisation in OHCI IRQ handler
Date: Thu, 6 Dec 2007 08:55:27 -0800
References: <20071125225542.880F2DDF13@ozlabs.org>
In-Reply-To: <20071125225542.880F2DDF13@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712060855.27977.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 25 November 2007, Benjamin Herrenschmidt wrote:
> While there, any reason why we do the read of the interenable register
> and mask ? Is that actually useful in practice ? I haven't removed it
> but it might be a good candidate if we want to save on MMIO reads.

The code uses that register to keep track of which IRQs are enabled
or disabled, and those enabled IRQs are changed from time to time.

I don't know of any good reason not to keep an in-memory copy of the
resulting mask, though I'd keep an eye out for chip errata.

- Dave
