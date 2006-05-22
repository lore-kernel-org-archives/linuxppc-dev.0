Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 66970679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 02:07:14 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by postfix.timesys.com (Postfix) with ESMTP id 3147A806979E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 12:07:15 -0400 (EDT)
Received: from postfix.timesys.com ([127.0.0.1])
	by localhost (postfix.timesys.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24507-05 for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 12:07:13 -0400 (EDT)
Received: from exchange.timesys.com (exchange.timesys.com [192.168.2.250])
	by postfix.timesys.com (Postfix) with ESMTP id F19EA80697A0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 12:07:12 -0400 (EDT)
Subject: Debbugging technique (was: Re: SCC1 as serial console)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <200605221612.53452.laurent.pinchart@tbox.biz>
References: <e65a39032a7d4cdbbf87ecc1daa271cd@pobox.sk>
	<200605221612.53452.laurent.pinchart@tbox.biz>
Content-Type: text/plain
Date: Mon, 22 May 2006 12:00:04 -0400
Message-Id: <1148313604.8242.54.camel@excalibur.timesys.com>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-22 at 16:12 +0200, Laurent Pinchart wrote:
> Do you have a hardware debugger (BDI2000) that you can connect to the 
> processor to see if Linux crashes before initializing the serial
> port ? If not, you will probably have to take a try at led-debugging
> (make some leds blink at various point in the Linux kernel to try to
> find out what happens), but that's really no fun.

If your U-Boot works successfully, here's another technique I've used
recently:

First, on the 8xx (and probably on some other PowerPC's) you'll want to
change the cache mode to "write-through" rather than "copy-back".  On
8xx, there is a kernel configuration option to do this.

If you're lucky and printk() is working internally (even though your
console isn't), you can put printk()s in your code wherever you want and
then use U-Boot to examine printk()'s buffer.  Boot up your kernel with
your debugging code, let it run for a second or two (long enough that
you suspect it has reached the likely problem area), then press the hard
reset button on the board.  This will restart U-Boot.  If necessary,
press a key to stop U-Boot from autobooting.

Next look at the kernel's System.map file and search for
"log_buf" (without quotes).  This is the kernel virtual address of
printk()'s log buffer and will be something like 0xc018469c.  You'll
need to translate this to a physical address.  On PowerPC, usually you
can do this simply by changing the leading "c" to a zero "0".

Now, use U-Boot's "md" (memory display) command to view the log_buf
physical address, e.g.:

                md 0x0018469c

Hopefully, now you'll see printk's log messages and you'll be able to
figure out why your console isn't working.

In my case recently, I was unlucky.  My kernel problem occurred long
before printk() was initialized, so printk() didn't work for me.  When I
examined the log_buf, it was empty.  If this happens to you, then try
the next idea:

Somewhere in the kernel (I chose arch/ppc/syslib/m8xx_setup.c, but it
shouldn't really matter, as long as the file you choose is compiled and
linked as part of your particular kernel configuration), declare a
buffer or two for storing debugging info.  For example:

                char mycharbuff[1024];
                int  myintbuff[256];

Also declare pointers that you can use to write debugging info into the
above arrays:

                char *mycharptr = mycharbuff;
                int  *myintptr  = myintbuff;

Then, wherever you need debugging information in your code, add lines
like:

                mycharptr += sprintf(mycharptr, "Something happened!
                \n");
or
                *myintptr++ = 29;    /* code number of your choosing */

After recompiling your kernel, find your buffer addresses in System.map
as we did previously with log_buf.  Convert the virtual addresses to
physical addresses.  Again run your kernel, hit the hard reset button,
and then use U-Boot's "md" command to examine your custom buffers.
You'll probably determine the problem area fairly quickly after a few
iterations of adding debugging code and examining your custom buffers.

DISCLAIMER:  The sample code I've shown above is not SMP or preemption
safe!  It also doesn't check for buffer overflow!  This is debugging
code, meant to be removed after you've found the problem.  This
simplistic code is often sufficient when debugging simple early-boot
problems that cause the machine to crash within the first few moments
after boot.  If your debugging requirements are more complicated, you'll
want correspondingly more complex debugging code.  E.g. you'll want to
check buffer lengths, you may want to wrap back to the beginning of your
buffer when you hit the end, etc.  You may also need to deal with
SMP/preemption issues.  This code is not to be taken internally.  Your
mileage may vary.  These statements have not been evaluated by the Food
and Drug Administration.  This product is not intended to treat or cure
any disease.  :-)



Good Luck!!!

Walt Wimer
TimeSys Corporation
