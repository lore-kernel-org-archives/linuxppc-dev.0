Date: Mon, 19 Nov 2001 11:15:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Message-ID: <20011119111548.F4531@krispykreme>
References: <Pine.LNX.4.33.0111180047090.20750-100000@gwiz.nasa.atd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111180047090.20750-100000@gwiz.nasa.atd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

> The GMAC driver had significantly better performance.  It sustained
> 663 Mbps for the 60 second test period, and used 63 % of the CPU on
> the transmitter and 64 % of the CPU on the receiver.  By comparison,
> the SUNGEM driver only achieved 588 Mbps, and utilized 100 % of the
> CPU on the transmitter and 86 % of the CPU on the receiver.  Thus,
> the SUNGEM driver had an 11.3 % lower network performance while
> using 58.7 % more CPU (and was in fact totally CPU saturated).

It would be interesting to see where the cpu is being used. Could you
boot with profile=2 and use readprofile to find the worst cpu hogs
during a run?

> I will be trying more tests later using a NetGear GA620T
> PCI NIC using the ACENIC driver to see if it has better performance.
> This NetGear NIC is also supposed to support jumbo frames (9K MTU),
> and I am very interested in determining the presumably significant
> performance benefits and/or reduced CPU usage associated with using
> jumbo frames.

On two ppc64 machines I can get up to 100MB/s payload using 1500 byte MTU.
When using zero copy this drops to 80MB/s (I guess the MIPS cpu on the
acenic is flat out), but the host cpu usage is much less of course.

With 9K MTU I can get ~122.5MB/s payload which is pretty good.

PS: Be sure to increase all the /proc/sys/net/.../*mem* sysctl variables.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
