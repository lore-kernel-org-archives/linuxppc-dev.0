Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id A9DDADDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:17:35 +1100 (EST)
In-Reply-To: <20070118124031.3d5e0079.kim.phillips@freescale.com>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
MIME-Version: 1.0
Message-ID: <OFFF3222ED.48527A84-ON88257267.00787606-88257267.007A6E89@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 18 Jan 2007 14:17:16 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kim Phillips <kim.phillips@freescale.com> wrote on 01/18/2007 10:40:31 AM:

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
