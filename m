Message-ID: <2965658600EF2F41A0BEE2200DC0EE510499B0A7@ca1xpr01.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@kla-tencor.com>
To: "'Dan Malek'" <dan@embeddededge.com>,
	Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Where to Put Ethernet MAC Addresses?
Date: Wed, 1 Oct 2003 13:43:43 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I personally favor the "roll your own MAC address from the serial number"
approach but it does have the drawback that you must have unique serial #'s
on the boards.  If the serial numbers are entered (or not entered) by lazy
humans you could potentially have two devices with the same MAC address on a
network.  I also select as the first 3 bytes of the MAC address the address
assigned to a defunct company and the lower 3 bytes derived from the serial
number.

Another approach is to use a Dallas Semiconductor (now Maxim) 1-wire
interface part.  They all have unique 48 bit addresses lasered in them to
support the 1 wire protocol.  If you use one of their parts as a RTC or
temperature sensor or whatever you can get a unique MAC address for free.
On the other hand that 1 wire protocol is a pain in a running real-time
system if you're driving it from software and a GPIO pin.

Marc W. Howard

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Wednesday, October 01, 2003 1:27 PM
To: Kent Borg
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to Put Ethernet MAC Addresses?



Kent Borg wrote:

> What are the various right ways to do this?

As Gary mentioned, most are handled in some way by the boot rom.
Many people put them in the boot rom flash (or rom if anyone uses
that anymore), and on PowerPC we use the first level linux bootloader
to recover this information and create some form of data record
that is passed to the kernel driver for further initialization
if necessary.

User 'init' scripts are usually too late, especially if you want
to use tftp in the rom for debug, or dhcp discovery.

There isn't any standard way, sometimes in flash, sometimes in
serial EEPROM along with other data.  Sometimes the mac address
is derived from the serial number.  It all depends upon what you
have available and how you may want to upgrade programmable devices
with new software in the field (you normally don't want to be erasing
mac addresses or serial numbers or such information as part of
programming new boot rom code).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
