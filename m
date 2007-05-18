Return-Path: <david-b@pacbell.net>
Received: from smtp110.sbc.mail.re2.yahoo.com (smtp110.sbc.mail.re2.yahoo.com
	[68.142.229.95]) by ozlabs.org (Postfix) with SMTP id 7AE52DDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 05:00:36 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 12:00:31 -0700
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<464DCD0E.9000706@freescale.com>
	<20070518183140.4644ffc6@hyperion.delvare>
In-Reply-To: <20070518183140.4644ffc6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705181200.31445.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 May 2007, Jean Delvare wrote:
> On Fri, 18 May 2007 10:58:06 -0500, Scott Wood wrote:
> > Jean Delvare wrote:
> > > On Thu, 17 May 2007 14:32:11 -0500, Scott Wood wrote:
> > > 
> > >>(and the 
> > >>i2c code in Linux should be fixed to allow drivers to specify multiple 
> > >>match names).
> > > 
> > > 
> > > Back when David proposed his new-style i2c code, I had the same
> > > objection. But we addressed the need differently. If you look at struct
> > > i2c_board_info, you'll see two string fields, driver_name and type. The
> > > former specifies the driver name, the second specifies the exact device
> > > variant. For drivers which support several device variants, the
> > > platform code should fill both fields.
> > 
> > But that still requires the platform to know the driver name, rather 
> > than matching any driver which knows about the type.

Given that the platform (== board/system) may care about the upper layer
of the driver (APIs exposed) not just the lower one (talking-to-hardware),
that seems like a reasonable tradeoff.  It wouldn't want to use the driver
which provides the wrong programming interface!

Plus, to repeat, there is no notion of "type" in I2C.   So in order to
talk about a "type based matching" algorithm you'd have to define one...


> > This prevents the  
> > use of OS-independent device trees (such as in Open Firmware), which 
> > cannot know specific Linux driver names, without something hacky like a 
> > type-to-driver table in the device tree code.
> 
> Oh well, this was also the reason why I objected to David's approach in
> the first place. If you dig back in the i2c list archive, you'll find
> that I was asking for exactly the same thing you do now: that each i2c
> driver would export a list of supported devices, and the i2c-core would
> match a device name against that list (independent of the driver name.)
> It felt more flexible, but I wondered how useful it would be in
> practice, and finally gave up and David had the last word. If you had
> shown up back then rather than now...

With concrete suggestions and patches.  I'd have to dig back in the
list archives to see the details of what was said at that time, but
I don't recall any suggestions being rejected unless they dropped
essential functionality.  (There was one notion to key driver binding
purely on device address, for example...)

- Dave
