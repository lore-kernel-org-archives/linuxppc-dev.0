Date: Tue, 20 Nov 2001 01:34:32 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bill Fink <billfink@mindspring.com>,
	Anton Blanchard <anton@samba.org>, <linuxppc-dev@lists.linuxppc.org>,
	"David S. Miller" <davem@redhat.com>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
In-Reply-To: <20011119125459.20923@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.33.0111200110210.28304-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Nov 2001, Benjamin Herrenschmidt wrote:

> >> The GMAC driver had significantly better performance.  It sustained
> >> 663 Mbps for the 60 second test period, and used 63 % of the CPU on
> >> the transmitter and 64 % of the CPU on the receiver.  By comparison,
> >> the SUNGEM driver only achieved 588 Mbps, and utilized 100 % of the
> >> CPU on the transmitter and 86 % of the CPU on the receiver.  Thus,
> >> the SUNGEM driver had an 11.3 % lower network performance while
> >> using 58.7 % more CPU (and was in fact totally CPU saturated).
>
> This is weird and unexpected as GMAC will request interrupt for each
> transmitted packet while sungem won't
>
> However, I noticed that sungem is getting a lot of rxmac and txmac
> interrupts, I'll investigate this a bit more.
>
> (Could you check the difference of /proc/interrupts between a test
> with gmac and a test with sungem ?)

Hi Ben,

OK.  Here's the GMAC test:

 60 second test:  4698.401 MB at 656.7557 Mbps (63 % TX, 63 % RX)

 Transmitter before and after:

 41:        191   OpenPIC   Level     eth0
 41:     476734   OpenPIC   Level     eth0

 Receiver before and after:

 41:        264   OpenPIC   Level     eth0
 41:    1157318   OpenPIC   Level     eth0

And here's the SUNGEM test:

 60 second test:  4223.125 MB at 590.4346 Mbps (100 % TX, 87 % RX)

 Transmitter before and after:

 41:        193   OpenPIC   Level     eth0
 41:    4673225   OpenPIC   Level     eth0

 Receiver before and after:

 41:        229   OpenPIC   Level     eth0
 41:    3610859   OpenPIC   Level     eth0

Taking the GMAC case, 4698.401 MB works out to 3284421 1500-byte MTU
packets (not counting TCP/IP overhead), so it would appear that the
GMAC driver is doing some type of interrupt coalescing and that the
SUNGEM driver isn't.

> Note that I just updated sungem in my rsync tree, it now has all of
> the power management and ethtool/miitool support.
> I plan to replace gmac with sungem completely, so it would be nice to
> figure out where that problem comes from.

I'd consider it much more than nice.  Since the whole point of GigE
is better performance, taking such a huge peformance/CPU hit would
be extremely bad.  OTOH, I probably won't be using the built-in GigE
hardware anyway because of its apparent performance ceiling of about
660 Mbps and its lack of jumbo frame support.

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
