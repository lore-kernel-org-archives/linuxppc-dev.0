Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1C3E7DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 06:34:24 +1000 (EST)
Date: Mon, 25 Jun 2007 15:43:41 -0500
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org, linuxppc-dev@ozlabs.org,
	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH v2] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070625204341.GA8865@lixom.net>
References: <20070625010311.GA31355@lixom.net>
	<20070625171221.GA6684@lixom.net>
	<20070625193909.GA26021@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625193909.GA26021@infradead.org>
From: olof@lixom.net (Olof Johansson)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 08:39:09PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 25, 2007 at 12:12:21PM -0500, Olof Johansson wrote:
> > Driver for the CompactFlash slot on the PA Semi Electra eval board. It's
> > a simple device sitting on localbus, with interrupts and detect/voltage
> > control over GPIO.
> > 
> > The driver is implemented as an of_platform driver, and adds localbus
> > as a bus being probed by the of_platform framework.
> 
> Looks good to me. The only odd thing is the inconsistant use of
> #ifdef CONFIG_PCMCIA in setup.c.

Thanks, and thanks for the review.

The ifdef is needed since for CONFIG_PCMCIA=n builds, the bus notifier
isn't available. I wanted to do the bus notifier registration explicitly
before the of_platform bus probe to avoid later surprises due to reordered
initcalls in case it was split up in it's own initcall.

I could add the code under ifdef as well, but it didn't seem too
critical. Once the second major board comes along I'll probably move it
out to a per-board file, there's no real need for it just yet.


-Olof
