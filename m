Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9034C67B85
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 01:46:51 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 8/10]  Add  tsi108 8250 serial support
From: Adrian Cox <adrian@humboldt.co.uk>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673069C3C3D@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 15:25:28 +0100
Message-Id: <1150295128.6552.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre.Bounine@tundra.com, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-13 at 13:39 +0800, Zang Roy-r61911 wrote:

> The reason is that the serial port on tsi108/9 is a bit difference with the 
> standard 8250 serial port. the patch deal with the difference.
> The prefixed ">" is caused by "Fw" the email. Sorry for that. The following 
> is the original patch.

The problem I see is that the code uses a CONFIG option, to change the
behaviour of the generic 8250 driver. What happens if somebody adds a
PCI serial card to a tsi108 based machine?

Perhaps you should define a new value for uart_8250_port.port.iotype,
and add code to serial_in and serial_out to handle the IIR register.

-- 
Adrian Cox <adrian@humboldt.co.uk>
