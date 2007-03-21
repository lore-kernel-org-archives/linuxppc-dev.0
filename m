Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 679D8DDEE0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:48:06 +1100 (EST)
Date: Wed, 21 Mar 2007 23:48:03 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
In-Reply-To: <200703211347.50221.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.60.0703212337000.7211@poirot.grange>
References: <20070319105352.771599000@sipsolutions.net>
	<1174315651.5044.4.camel@localhost.localdomain>
	<Pine.LNX.4.60.0703192236420.10137@poirot.grange>
	<200703211347.50221.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Mar 2007, David Brownell wrote:

> (*) Most of the I2C based RTCs rely on kernel command line parameters,
>     because of the vagaries of I2C.  "New style" I2C drivers will replace
>     command line declarations ("rv5c386 RTC on bus 0 at address 0x32")
>     with ones in the board specific init logic.

[OT] I know very well what you mean! After my recent patch i2c-pxa driver 
on PXA27x CPUs supports both i2c buses. Now, there are chips, like pcf8574 
that specify 16 (!) addresses in their normal list. Which means, to use it 
on a pxa27x with one such chip on 1 address and to avoid scanning them all 
and flooding your log with terrifying error messages (smth like "retries 
exhausted", I think), you have to specify an "ignore" list on the kernel 
command line / modprobe parameter with a list of (16 - 1)*2 + 16*2 = 62 
comma separated values (e.g., if it's on 0,0x20: 
ignore=0,0x21,...1,0x20,1,0x21,...)!... Which even exceeds max length of 
the ignore array. So, I had to double its length. Of course, changes like 
that I don't submit to the mainline:-)))

Looking forward to your reworked i2c.

Thanks
Guennadi
---
Guennadi Liakhovetski
