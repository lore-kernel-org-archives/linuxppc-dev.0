Message-ID: <3AF747C4.9C2D74A5@mvista.com>
Date: Mon, 07 May 2001 21:11:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: Gabriel Paubert <paubert@iram.es>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1> <3AF740C0.F65FBCB8@mvista.com> <047301c0d75c$2da00a00$4b00000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Chen wrote:

> .... Perhaps there are other places that returns
> from an interrupt?

No, that's a common return path that should catch all cases.
There may be something else wrong with the Ethernet driver itself.
When I updated it to the 2.4_devel baseline, there were some weird
cache management calls that didn't make sense.  My updates were to
use the standard non-coherent cache management functions, and I
changed the logic to make sense (to me :-).  From this quick update,
I noticed it would be nice to make the transmit more efficient
and higher performance by handling multiple frames, but it should
function properly.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
