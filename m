Date: Mon, 13 Mar 2000 13:32:57 -0500 (EST)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Byte swapped inw/outw again....
In-Reply-To: <20000306094259.D74832EB20@elph.research.canon.com.au>
Message-ID: <Pine.LNX.3.96.1000313131056.12701A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Folks,

Another driver port with inw/outw issues again.  I've looked through the
linuxppc-dev archive and I'm not quite seeing the answer to my question
(below).

I'm porting a driver for a WLAN card whose interface is all 16-bit
registers.  Sometimes the reads/writes are strictly a 16-bit integer
quantity where the byte swapping in inw/outw wouldn't be too much of a
problem.  Other times we're reading/writing buffer contents from/to the
card 2-bytes at a time (swapping in this case is exceptionally bad).

When writing the driver originally on the x86 I put in xxx_to_cpu and
cpu_to_xxx calls everywhere assuming that the inw/outw words would be
coming up byteswapped on the PPC and other platforms.  Now, after I
realize that inw/outw are trying to do the byte swapping....my code is
swapping them back and we're _still_ backwards.  ;-)

What I'd like to do is set/unset or undef/define an item such that the
inw/outw I'm using _will not_ do the byte swapping.  On reading the code
and looking through the archives, I get the feeling there is a RIGHT way
to do this.  I just haven't been able to figure it out precisely.

It would be easy to hack w/ driver local macros or something...I'd just
like to do it right for once.

Any help would be much appreciated.

Best Regards,
-Mark

On Mon, 6 Mar 2000, Graham Stoney wrote:
>
> Hi gang,
>
> I've written a brief HOWTO with info from the last few months from this
> mailing list, and I'd be very interested in any feedback anyone could offer.
> It's on the web at:
>     http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html
>
> I'm especially interested in any gross inaccuracies it may contain!
> If you spot one, please drop me some email.
>
> Thanks,
> Graham
>
>


Mark S. Mathews

AbsoluteValue Software     Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
