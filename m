Date: Wed, 13 Dec 2000 12:15:54 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Brian Ford <ford@vss.fsi.com>
Cc: Graham Stoney <greyham@research.canon.com.au>, Dan Malek <dan@mvista.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001213121554.B17129@brixi.research.canon.com.au>
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0012120933330.24199-100000@eos>; from ford@vss.fsi.com on Tue, Dec 12, 2000 at 10:32:53AM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ Dan's already answered the caching question wrt the 8260, so... ]

On Tue, Dec 12, 2000 at 10:32:53AM -0600, Brian Ford wrote:
> The best solution to the "couldn't allocate an skbuf" seems to be the one
> taken by Donald Becker in the tulip driver called the "buffer deficit
> scheme."  I am studying this to see if I can replicate it.

Right; I found a reference where he describes it at:
    http://www.tux.org/hypermail/linux-net/1998-Oct/0256.html

This does indeed sound better; the only sticky part I can think of is setting
the FCC/FEC to keep giving you Rx interrupts even when there are no buffer
descriptors to put the incoming packets in, because the ring hasn't been
refilled after running out of memory.  Maybe that Just Works though, I dunno;
I think you'd want to test the code in a low memory environment to be sure it
can actually recover from running completely out of Rx skbuf's.

It's cool to see some others looking at this stuff in addition to Dan's
most excellent work so far.  Shoulders of giants and all that.

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
