Return-Path: <galibert@dspnet.fr.eu.org>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by ozlabs.org (Postfix) with ESMTP id 9840CDDE49
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 02:15:23 +1000 (EST)
Date: Thu, 5 Apr 2007 18:15:13 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070405161513.GA40360@dspnet.fr.eu.org>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404122154.GF31973@thunk.org> <4613CF6A.2090407@zytor.com>
	<20070404174153.GI31973@thunk.org>
	<20070404181531.GA9388@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404181531.GA9388@flint.arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 07:15:32PM +0100, Russell King wrote:
> *However* you still run into the issue that you do not know how many
> serial ports you will need to register a tty driver with the tty layer.
> Solve that technical problem and the idea of having a single namespace
> for chosen serial ports and 8250 ports suddenly becomes realistic.

Ok, so that I understand correctly, your problem is with the
tty_register_driver interface as used in
serial_core:uart_register_driver, correct?

Looking at the function, I understand why.
{alloc,register}_chrdev_region is very, very not designed to be
fully dynamic it seems.

  OG.
