In-Reply-To: <8525687A.0059AAA1.00@D51MTA03.pok.ibm.com>
Date: Thu, 3 Feb 2000 18:28:21 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Speed tests - G4-400 and PIII-600
Message-Id: <20000203182821.009176@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Feb 3, 2000,  <jlquinn@us.ibm.com> wrote:


>How intensive is the computation on the image?  If you are running through
>a large image with short computations at each pixel, you may be limited by
>memory bandwidth.  Both of those machines have 100Mhz busses, right?  In
>this case, you'd be roughly even at the start from a raw hardware viewpoint
>and then the fact that x86 tends to receive more optimization work in the
>compiler might push it into the lead.

Something else that can affect performances on PowerPC when doing large
quantities of data manipulations is the way datas are fetched/stored in
memory. I think Intel processors do a good job with byte and short
accesses while the PPC loves when everything is naturally aligned and all
accesses are done in 32 bits quantities. A bunch of pixel manipulation
code I've seen in the past few years tends to use byte access to the
pixel datas in memory. This can be very inefficient.

Unfortunately, most of the existing code is written by programmers that
either don't care or optimize for their x86 box...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
