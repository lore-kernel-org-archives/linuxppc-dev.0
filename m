Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FBF0DDEA3
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 09:26:47 +1100 (EST)
Date: Wed, 28 Feb 2007 22:26:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] Define FIXED_PORT flag for serial_core
Message-ID: <20070228222630.GA11999@flint.arm.linux.org.uk>
References: <20070220031717.GI17818@localhost.localdomain>
	<20070220031951.56492DDD09@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070220031951.56492DDD09@ozlabs.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2007 at 02:19:51PM +1100, David Gibson wrote:
> Therefore, this patch defines a UPF_FIXED_PORT flag for the uart_port
> structure.  If this flag is set when the serial port is configured,
> any attempts to alter the port's type, io address, irq or base clock
> with setserial are ignored.

I've been wondering about this, and it is questionable whether we
should allow any serial port which isn't owned by the legacy platform
device (the one called "serial8250", iow by the 8250 driver itself)
to have the base addresses and interrupts changed.

IOW, we apply this "fixed port" to any port registered by probe
modules external to the 8250 driver itself, such as PCI, PNP, etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
