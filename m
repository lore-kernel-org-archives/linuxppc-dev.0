Return-Path: <david-b@pacbell.net>
Received: from smtp128.sbc.mail.sp1.yahoo.com (smtp128.sbc.mail.sp1.yahoo.com
	[69.147.65.187]) by ozlabs.org (Postfix) with SMTP id 9EFF6DDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 16:19:08 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 22:19:03 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<200810221452.46786.david-b@pacbell.net>
	<20081022222940.GA14636@oksana.dev.rtsoft.ru>
In-Reply-To: <20081022222940.GA14636@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810222219.04768.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> > 
> > So have it live in the __init text section...
> 
> Won't work, unfortunately. I2C devices are created by the
> i2c controllers, via drivers/of_i2c.c  of_register_i2c_devices().

And I'm pointing out a way to have the normal I2C core code
flow do that creation.  OF shouldn't need to be so much of a
special case.


> There is a good reason to do so, the code needs to know
> controller's OF node to walk down and register the child nodes
> (devices). See drivers/i2c/busses/i2c-mpc.c -- it calls
> of_register_i2c_devices() at the end of the probe().

I don't get it.  (But then, so much of the OF support seems
needlessly convoluted to me ... on top of seeming to be
insufficient for configuring board-specific details.)

There's an OF device tree, distinct from the Linux driver
model tree.  Why should there be any obstacle to accessing
records from that tree before the relevant driver model nodes
have been created?  Remember that the various board_info
structs get registered before the driver model nodes for
which they are templates.  Just translate the OF tree data
to those templates(*), then register them.

I understand that it's currently structured differetnly
than that ... consulting the OF tree "late" not early.
But that's still newish, and from what I've heard so far
it doesn't seem like the best structure either... nothing
seems to plug in smoothly.

- Dave

(*) The role of the board_info structs is very similar
    to the role of OF device attributes.  As is the role
    of the platform_data ... except that's more specific
    to the chip involved (and its driver), and expects
    any callbacks to be in C code not FORTH.
