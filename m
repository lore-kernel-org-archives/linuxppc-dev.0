Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
From: David Woodhouse <dwmw2@infradead.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Mark Chambers <markc@mail.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
In-Reply-To: <60394D06-F6B8-11D8-918A-003065F9B7DC@embeddededge.com>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain>
	 <000f01c48a95$e18e5c20$0301a8c0@chuck2>
	 <FE902A72-F6AB-11D8-918A-003065F9B7DC@embeddededge.com>
	 <001a01c48abe$0fccb5f0$0301a8c0@chuck2>
	 <60394D06-F6B8-11D8-918A-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Message-Id: <1093483666.3777.1579.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Thu, 26 Aug 2004 02:27:46 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-08-25 at 13:01 -0400, Dan Malek wrote:
> The kernel XIP from Flash isn't very hard to implement,
> it is just very board configuration dependent.  All you
> need is a proper linker command file for your board
> and a couple of start up MMU hacks......for PowerPC.

It's a little bit harder than that if you want to actually write to the
same flash chip you're running from. :)

Not a _lot_ harder though -- you just put the flash-mangling routines
into a separate section in RAM and disabling interrupts while you're in
them (you can poll for interrupts, suspend pending writes/erases and
handle the interrupts without particularly evil latencies).

I did it a long time ago -- just couldn't ever see the point in merging
it.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
