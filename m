Date: Mon, 11 Dec 2000 11:45:33 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Brian Ford <ford@vss.fsi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001211114533.A2691@brixi.research.canon.com.au>
References: <Pine.GSO.4.21.0012071148420.515-100000@eos> <Pine.GSO.4.21.0012071210280.515-100000@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0012071210280.515-100000@eos>; from ford@vss.fsi.com on Thu, Dec 07, 2000 at 12:11:07PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Brian,

On Thu, Dec 07, 2000 at 12:11:07PM -0600, Brian Ford wrote:
> I am trying to do some kernel profiling on my EST8260 to determine the
> bottle neck in TCP and UDP thruput, but I can't seem to get any profile
> information.

When I first attempted a similar thing with the 2.2 kernel on our 855T based
board, I found that the trivial do_profile routine needed to collect data for
/proc/profile kernel profiling wasn't implemented for the ppc architecture.
As far as I can see, it still isn't implemented on linux-2.4.0-test11, but it
is in the linuxppc_2_3 tree at http://www.fsmlabs.com/linuxppcbk.html .
I really wish the seperate architecture maintainers had got together to
eliminate all the duplicated do_profile functions like I did in my 2.2 patch
at:
    http://members.nbci.com/greyhams/linux/patches/2.2/profile.patch

Unfortunately I guess it was easier for the PPC guys to just copy the
do_profile function (yet again!) like everyone else did.  Oh well, maybe in
2.5...

Back to TCP, I found I could improve raw TCP throughput by 15-20% on the 855T
by DMAing received data directly into the kernel socket buffers.  The
improvement in performance from eliminating the extra copy between the ring
buffer and socket buffer isn't staggering, since the CPU still needs to do
a pass through the data to calculate the IP checksum, which unfortunately the
855T's FEC can't do for me.  Nevertheless, it does make things a little faster
and I would imagine a similar technique would work on the 8260; you can get a
feel for what is involved from my 2.2 FEC speedup patch at:
    http://members.nbci.com/greyhams/linux/patches/2.2/fecdmaskb.patch

Good luck!
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
