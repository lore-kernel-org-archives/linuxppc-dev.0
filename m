Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 971B0DDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:08:25 +1000 (EST)
Date: Fri, 13 Jul 2007 12:02:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
Message-Id: <20070713120226.797117e2.akpm@linux-foundation.org>
In-Reply-To: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, rmk@arm.linux.org.uk,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Jul 2007 09:02:16 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> This is a resend of a patch David sent out on May 7.  Without it, the
> PowerPC 44x port in 2.6.22 and on is broken.  I've rebased it off of
> Linus' current tree.  Please consider pushing this soon.
> 
> josh
> 
> 
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

This is something we should do, but I have recollections of Russell
identifying problems with this patch, or at least an earlier version of it?

> Signed-off-by: David Gibson <dwg@au1.ibm.com>

This should have had Signed-off-by:you as well.
