Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 1E9F367A80
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 07:47:03 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647506@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'John W. Linville'" <linville@tuxdriver.com>
Date: Tue, 18 Jan 2005 15:45:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Cc: 'Steven Blakeslee' <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: Linux 2.6.10-rc3  8xx: debugging (over-writing)  content of b
	d_in fo structure  in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On my board the oscillator is marked 50.000 and the 50000000 setting works
on my board with Linux 2.4 ...
but I meant to ask in my question: whether (may be) the current 8xx vs 2.6
kernel memory initialization problems
only showing themself at 50Mhz and not at 48Mhz (I am trying to find
explanation why 2.6 works on RPX-Lite -
per Tom and Steve).

-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com]
Sent: Tuesday, January 18, 2005 3:29 PM
To: Povolotsky, Alexander
Cc: 'Mark Chambers'; 'linuxppc-embedded@ozlabs.org'; 'Tom Rini'; 'Steven
Blakeslee'
Subject: Re: Linux 2.6.10-rc3 8xx: debugging (over-writing) content of b
d_in fo structure in the kernel booting code


On Tue, Jan 18, 2005 at 02:08:19PM -0500, Povolotsky, Alexander wrote:
> My board is using:
> 
>         bd->bi_intfreq = 50000000;
>         bd->bi_busfreq = 50000000;
> 
> While RPX-Lite is using
> 
>         bd->bi_intfreq = 48000000;
>         bd->bi_busfreq = 48000000; 
> 
> Is this what makes RPX-Lite work and my (MPC 880) not ?

That, of course, depends on which value is correct for your
board... :-)

When I mentioned in one of our (possibly off-line) exchanges that
_slightly_ incorrect clock speeds might explain how you get a few good
characters from the serial port before you get all that garbage, this
is the kind of descrepancy I was suggesting.  There may be enough
"slop" in the timings of the relatively slow serial port to make
48MHz and 50MHz "close enough" for a few characters.

So, what is the correct number for your board?  Do you know how to
identify an oscillator?  They have a bit of a 'tin can' look to them.
Find the one closest to the CPU on the board, and see what number is
on it.

John
-- 
John W. Linville
linville@tuxdriver.com
