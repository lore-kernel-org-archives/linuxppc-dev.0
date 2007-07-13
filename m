Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77CD1DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:24:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6DJOh8I009465
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 15:24:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6DJOhuG269188
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 13:24:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6DJOgSw019191
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 13:24:43 -0600
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070713120226.797117e2.akpm@linux-foundation.org>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
	<20070713120226.797117e2.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 13 Jul 2007 14:24:41 -0500
Message-Id: <1184354681.6456.56.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
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

On Fri, 2007-07-13 at 12:02 -0700, Andrew Morton wrote:
> On Fri, 13 Jul 2007 09:02:16 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > This is a resend of a patch David sent out on May 7.  Without it, the
> > PowerPC 44x port in 2.6.22 and on is broken.  I've rebased it off of
> > Linus' current tree.  Please consider pushing this soon.
> > 
> > josh
> > 
> > 
> > At present, various parts of the serial code use unsigned long to
> > define resource addresses.  This is a problem, because some 32-bit
> > platforms have physical addresses larger than 32-bits, and have mmio
> > serial uarts located above the 4GB point.
> > 
> > This patch changes the type of mapbase in both struct uart_port and
> > struct plat_serial8250_port to resource_size_t, which can be
> > configured to be 64 bits on such platforms.  The mapbase in
> > serial_struct can't safely be changed, because that structure is user
> > visible.
> 
> This is something we should do, but I have recollections of Russell
> identifying problems with this patch, or at least an earlier version of it?

I can't recall myself if there were problems or not.  I thought David
had worked that out with Russell, but I could be mistaken.

> > Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 
> This should have had Signed-off-by:you as well.

Oops, for the rebase I suppose, yes.  Is the one below enough or do you
want me to resubmit?

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
