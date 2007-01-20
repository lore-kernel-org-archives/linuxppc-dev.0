Return-Path: <rmcguire@uwbt.com>
Received: from mail19b.g19.rapidsite.net (mail19b.g19.rapidsite.net
	[204.202.242.88]) by ozlabs.org (Postfix) with SMTP id 9C952DDE36
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 14:07:04 +1100 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1169168402.24872.linuxppc-embedded@ozlabs.org>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
Date: Fri, 19 Jan 2007 19:06:56 -0800
Message-ID: <000001c73c40$0cbaf120$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1169168402.24872.linuxppc-embedded@ozlabs.org>
Cc: Bruce_Leonard@selinc.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce,

Did you ever get linux to boot up?

I am wondering if I am having similar problems on my system, though it is
based on the MPC8360E. Serial port code and clocking is the same between
these systems, at least it should be.

I am using Linux 2.6.19.2, and U-boot 1.1.6-dirty, though I think it
'mostly' U-boot 1.2.0 equivalent code, as 1.2.0 was released about a day
after I downloaded it.

I also can generate a 8360.blob file, and when I attempt to boot into the
kernel, it hangs with ZERO serial output, even though early serial is
defined.

-Russ

> > Per Grant's suggestion I changed it to:
> > 'dtc -I dts -O dtb -V 0x10 mpc8349emitx.dts > 8349.blob'
> > 
> I get a 0 length 8349.blob file using the above.  Have you tried -f?
> 
> Kim

Hummmmm, interesting.  I get a blob of about 4K when I do it.  Oh, ooops. 
Sorry.  I did have to modify the *.dts file to get it to compile.  There 
was an error because there wasn't a 'linux,boot-cpu' entry in the cpu 
node.

Adding the '-V 0x10' changed the behavior and I now seem to be hanging in 
__delay() in serial8250_console_putchar().  Seems maybe the kernel is (at 
least partially) up but I've got no console port.  There may have been a 
version issue.  The DTC I'm using defaluted to a version 3 of the device 
tree.  I think I'm getting further in the kernel booting process (haven't 
had a chance to really debug it yet) than I was now that I'm telling DCT 
to generate a version 0x10 device tree.

I'm thinking this is a u-boot/*.dts file problem.  The *.dts files isn't 
complete and/or u-boot 1.1.6. isn't finishing filling in the device tree 
as expected.  I think now my problem is that the *.dts file expects u-boot 
to fill in the 'clock-frequency' node in the serial ports and it's not 
doing so.  Timur indicates 1.1.6 doesn't support this board and I should 
move to 1.2.  Kumar also suggested this (even though I thought he was 
suggesting I go backwards ;) sorry for the confusion Kumar) so I think 
I'll give it a try.  I appreciate all the help from here, but since it 
seems more u-boot-ish than kernel I'm going to switch this to the u-boot 
list.  Seems more appropriate.  If I find there are problems with the 
*.dts file, I'll push that back here since they're part of the kernel 
tree.

Thanks again for the help.

Bruce
