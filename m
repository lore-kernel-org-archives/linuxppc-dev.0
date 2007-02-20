Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from localhost.localdomain (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDF63DDF9D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 23:03:19 +1100 (EST)
Date: Tue, 20 Feb 2007 13:07:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] Define FIXED_PORT flag for serial_core
Message-ID: <20070220130701.00503673@localhost.localdomain>
In-Reply-To: <20070220031951.56492DDD09@ozlabs.org>
References: <20070220031717.GI17818@localhost.localdomain>
	<20070220031951.56492DDD09@ozlabs.org>
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

> At present, the serial core always allows setserial in userspace to
> change the port address, irq and base clock of any serial port.  That
> makes sense for legacy ISA ports, but not for (say) embedded ns16550
> compatible serial ports at peculiar addresses.  In these cases, the
> kernel code configuring the ports must know exactly where they are,
> and their clocking arrangements (which can be unusual on embedded
> boards).  It doesn't make sense for userspace to change these
> settings.
> 
> Therefore, this patch defines a UPF_FIXED_PORT flag for the uart_port
> structure.  If this flag is set when the serial port is configured,
> any attempts to alter the port's type, io address, irq or base clock
> with setserial are ignored.
> 
> In addition this patch uses the new flag for on-chip serial ports
> probed in arch/powerpc/kernel/legacy_serial.c, and for other
> hard-wired serial ports probed by drivers/serial/of_serial.c.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
>
Acked-by: Alan Cox <alan@redhat.com>
