Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A14C8DDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 23:27:20 +1100 (EST)
Date: Tue, 16 Dec 2008 21:25:24 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RESEND][PATCH] uio: Add of_platform_driver to uio_pdrv_genirq
Message-ID: <20081216122524.GA29546@linux-sh.org>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, hjk@linutronix.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 11, 2008 at 04:05:37PM +0100, Wolfram Sang wrote:
> Make the generic uio-driver also accessible for of devices. It utilizes the
> standard 'reg' and 'interrupt' properties. A typical usage would look like
> this:
> 
> 	fpga-io@00003000 {
> 		compatible = "generic-uio";
> 		reg = <0x00003000 0x20>;
> 		interrupts = <0xa>;
> 		interrupt-parent = <&fpga_irq_mux>;
> 	};
> 
> To achieve this, the probe function has been refactored, so it can be used by
> platform and of code. Then, the of driver has been added.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

It is pretty poor form to not even bother to Cc the only author of the
code you are modifying, and have no Signed-off-by or Acked-by to even
suggest that it was ever even looked at. This isn't something that ought
to have to be pointed out, either.

In addition to the stuff pointed out by Greg, I don't see what you
actually gain by hacking the OF crap in to this driver. You would be
better off layering the OF driver on top of this, rather than trying to
make them live together in the same file.

See pata_platform/pata_of_platform for an example of how to do this a bit
more sanely.
