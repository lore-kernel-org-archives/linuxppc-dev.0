Date: Tue, 20 Nov 2001 22:46:04 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: Anton Blanchard <anton@samba.org>
Cc: Bill Fink <billfink@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
In-Reply-To: <20011119111548.F4531@krispykreme>
Message-ID: <Pine.LNX.4.33.0111202216050.17140-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Anton,

On Mon, 19 Nov 2001, Anton Blanchard wrote:

> > The GMAC driver had significantly better performance.  It sustained
> > 663 Mbps for the 60 second test period, and used 63 % of the CPU on
> > the transmitter and 64 % of the CPU on the receiver.  By comparison,
> > the SUNGEM driver only achieved 588 Mbps, and utilized 100 % of the
> > CPU on the transmitter and 86 % of the CPU on the receiver.  Thus,
> > the SUNGEM driver had an 11.3 % lower network performance while
> > using 58.7 % more CPU (and was in fact totally CPU saturated).
>
> It would be interesting to see where the cpu is being used. Could you
> boot with profile=2 and use readprofile to find the worst cpu hogs
> during a run?

Since Ben suspected and there does indeed seem to be an abnormally
large number of interrupts with the SUNGEM driver, I haven't pursued
your suggestion yet.  However, since it sounds like an interesting
tool to have in one's arsenal and I've never used it before, I'll
probably give it a try a little later.

> > I will be trying more tests later using a NetGear GA620T
> > PCI NIC using the ACENIC driver to see if it has better performance.
> > This NetGear NIC is also supposed to support jumbo frames (9K MTU),
> > and I am very interested in determining the presumably significant
> > performance benefits and/or reduced CPU usage associated with using
> > jumbo frames.
>
> On two ppc64 machines I can get up to 100MB/s payload using 1500 byte MTU.
> When using zero copy this drops to 80MB/s (I guess the MIPS cpu on the
> acenic is flat out), but the host cpu usage is much less of course.
>
> With 9K MTU I can get ~122.5MB/s payload which is pretty good.

That's an understatement.  That's damn good!  I hope I can reproduce
that.  What NIC card were you using?  Unfortunately, I just checked
the NetGear web page and they don't seem to have the GA620T anymore.
They now have a GA622T, but I believe that uses a different chip,
which I don't think is supported by the acenic driver.

> PS: Be sure to increase all the /proc/sys/net/.../*mem* sysctl variables.

I had set the /proc/sys/net/core/[rw]mem_max to 1 MB each, which was
sufficient since my test application uses the SO_SNDBUF and SO_RCVBUF
ioctls to explicitly set the TCP transmitter and receiver window sizes.
However, I now also noticed the /proc/sys/net/ipv4/tcp_[rw]mem variables,
for which I found some terse documentation that explained they were
used for automatically selected receive and send buffers for the
TCP socket.  Is there any more extensive documentation anywhere for
how this auto tuning of TCP receive and send buffers is done?

						-Thanks

						-Bill

P.S.  It turns out that my using such a large window size of 768 KB was
      having an adverse impact on performance.  I'm used to doing tests
      across MANs and WANs.  But for the simple case of a local GigE
      switch, where the RTT is only about 0.12 msec, the necessary TCP
      window size (BW*RTT) is only about 15 KB (talk about overkill with
      my 768 KB window size).  I did another test with the GMAC driver
      just using the default TCP send and receive window sizes, and was
      able to achieve about 720 Mbps.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
