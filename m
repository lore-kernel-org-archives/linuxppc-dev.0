Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from localhost.localdomain (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2815DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 23:03:02 +1100 (EST)
Date: Tue, 20 Feb 2007 13:06:34 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] Use resource_size_t for serial port IO addresses
Message-ID: <20070220130634.72b9a02b@localhost.localdomain>
In-Reply-To: <20070220031951.5D53BDDD0E@ozlabs.org>
References: <20070220031717.GI17818@localhost.localdomain>
	<20070220031951.5D53BDDD0E@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 Feb 2007 14:19:51 +1100 (EST)
David Gibson <david@gibson.dropbear.id.au> wrote:

> At present, various parts of the serial code use unsigned long to
> define resource addresses.  This is a problem, because some 32-bit
> platforms have physical addresses larger than 32-bits, and have mmio
> serial uarts located above the 4GB point.
> 
> This patch changes the type of mapbase in both struct uart_port and
> struct plat_serial8250_port to resource_size_t, which can be
> configured to be 64 bits on such platforms.  The mapbase in
> serial_struct can't safely be changed, because that structure is user
> visible.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Acked-by: Alan Cox <alan@redhat.com>
