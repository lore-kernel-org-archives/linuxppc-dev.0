Message-Id: <5.1.0.14.2.20020510074516.0229ffe8@falcon.si.com>
Date: Fri, 10 May 2002 07:53:14 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Why system panic after sometimes? 
In-Reply-To: <20020510113725.CF7FB1195C@denx.denx.de>
References: <Your message of "Fri, 10 May 2002 17:58:21 +0800." <20020510095821.44488.qmail@web15005.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry to be replying to a reply, but I inadvertently deleted the first one
in this thread...

A panic due to a FPM emulation trap is almost always a memory read
problem.  Your processor is erroneously reading the value 0xFFxxxxxx, which
is a floating point instruction.  This causes a floating point emulation
trap to occur because your 8xx processor doesn't have hardware floating point.

Your memory subsystem is not stable.  Check the usual suspects: burst cache
line reading with marginal UPM parameters is #1, #2, and #3.  I would guess
that a board design problem is #4 and bad memory is #5.  Since you run for
longer periods of time, burst cache line reading is less likely in your
case (this usually shows up right away, during the boot process of linux).

Good luck, you are going to need it :-(
gvb


At 01:37 PM 5/10/2002 +0200, Wolfgang Denk wrote:

>Hello,
>
>in message <20020510095821.44488.qmail@web15005.mail.bjs.yahoo.com> you wrote:
> >
> > I am sorry i have not described clear.
> > We use HardHat CDK1.2's cross compile.
>
>This is pretty old, but should work for this purpose.
>
> > We have not use USB driver yet, I have writed a driver
> > for a MPEGI coder chip (operate it via data and
> > address bus).I think my driver (just handle interrupts
> > from chip) is safe and will not affect kernel
>
>Well, I think the kernel version you are using  is  very  stable,  so
>maybe it _is_ a problem in your driver?
>
> > and i don't know how to decode backtrace?
>
>See  Documentation/oops-tracing.txt  in  youir  LInux  kernel  source
>directory; alternatively, look up the addresses / symbols manually in
>the Systems.map file in your kernel directory.
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>You got to learn three things. What's  real,  what's  not  real,  and
>what's the difference."           - Terry Pratchett, _Witches Abroad_
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
