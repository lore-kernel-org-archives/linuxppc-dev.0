Date: Sat, 1 Mar 2003 00:22:38 +0000
From: John Levon <levon@movementarian.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: oprofile-list@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: porting oprofile to ppc
Message-ID: <20030301002238.GC31673@compsoc.man.ac.uk>
References: <1046474835.1090.303.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1046474835.1090.303.camel@cube>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 28, 2003 at 06:27:15PM -0500, Albert Cahalan wrote:

> I run both 2.4.xx and 2.5.xx kernels, compiled from
> source. Neither one has any performance monitoring
> hooks ready to use. I could add them. What is needed?

I suggest you start with 2.5 kernels. ppc64 has some oprofile code in
the kernel: the first step is to copy that code into ppc32 and make it
work. That will give you the basic timer interrupt functionality.

> I notice that RTC support conflicts with the /dev/rtc
> driver. Couldn't it use the driver? Sometimes the RTC

No.

> I'm not a Qt fan. Can I avoid it? All my stuff is GNOME,
> plain X11, or non-GUI. Somehow libqt.so.2.3.1 did get
> installed though.

It's completely unnecessary for you to deal with, in any way.

> The 7400 chip additionally gives me a set of performance
> monitoring registers, with read-only access from user code.
> There are four counters, PMC1 to PMC4, and control registers.
> I can freeze the counters in kernel mode, in user mode,
> and according to a flag that may be used to mark a process.

The crucial thing for perfctr support is that it is able to provide an
interrupt when it overflows. Then you (in-kernel) call
oprofile_add_sample() to record the EIP etc.

You may need to tweak the certain details of how the perctrs are
represented in oprofile userspace, but this is something we can work
through. Your first step is to get the ppc64-style support going and
working properly.

Hope that helps,
john

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
