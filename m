Date: Wed, 30 Jun 2004 13:35:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: looking for .config file for RPXlite board for 2.6 kernel
In-Reply-To: <20040630171458.GA15960@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0406301326160.10682@localhost.localdomain>
References: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
 <20040630171458.GA15960@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 30 Jun 2004, Tom Rini wrote:

> On Wed, Jun 30, 2004 at 11:12:18AM -0400, Robert P. J. Day wrote:
>
>>
>>   ok, in the interests of my mental health, i've grabbed an rpxlite
>> board off the shelf, and am going to see how far i can boot it with
>> the current 2.6 kernel.
>
> 'make rpxlite_defconfig' and then enable SERIAL_CPM and select SMC1 and
> SCC1 (you are correct, AFAIK, about the right console being SMC1, but
> this is the board I've been using and mentioning that it doesn't quite
> get right).  WRT having to pass in console=, etc, iff you have
> CONFIG_VT=n, which I believe is in the defconfig, you don't need to pass
> anything.

i did eventually find the defconfig files for PPC, and grabbed the
rpxlite one and have been playing with it for a while.  every
combination i've tried so far has given me only:
=============
Linux/PPC load: ... various load lines, trying console mostly ...
Uncompressing Linux...done.
Now booting the kernel
=============
and that's it.  i assumed that my fundamental problem was just not
getting the system console configured properly.  i've confirmed
through the bootloader that, yes, SMC1 is my monitor serial port.

so, based on what you've suggested, i've gone into (somewhere i've
already been many times :-):

Device Drivers
   Character devices
     Serial drivers


and i've selected:

[*] CPM2 SCC/SMC serial port support
[ ]   Support for console on CPM2 SCC/SMC serial port (NEW)
[*]   Support for SCC1 serial port
[ ]   Support for SCC2 serial port (NEW)
[ ]   Support for SCC3 serial port (NEW)
[ ]   Support for SCC4 serial port (NEW)
[*]   Support for SMC1 serial port
[ ]   Support for SMC2 serial port (NEW)

and left everything else alone, and it's building now.  if this still
hangs after "Now booting the kernel," maybe you can just send me a
copy of your .config file to diff.  i can't believe this isn't
something really trivial i'm screwing up.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
