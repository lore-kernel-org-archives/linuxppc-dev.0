From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmu_suspend/resume
Date: Sun, 12 Aug 2001 19:36:56 +0200
Message-Id: <20010812173656.31987@smtp.wanadoo.fr>
In-Reply-To: <3B75FE93.DC81EBFE@acm.org>
References: <3B75FE93.DC81EBFE@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I have been using pmu_suspend and pmu_resume to keep my TiBook from
>turning off when debugging some kernel stuff.  Is this ok?
>
>The reason I ask is that pmu_suspend seems to have the desired effect,
>temporarily turning off the PMU.  But pmu_resume does not seem to leave
>the PMU in a stable state.  Now I realize that I am debuging a kernel
>and that it could/probably is other factors which are causing these
>problems but I just wanted to make sure that there is not some better
>way of disabiling the PMU or that I might be using these functions
>incorrectly.

pmu_suspend waits for the PMU to be idle, then disable the PMU
"request" interrupt. The goal here is to make sure there's no
asynchronous PMU activity going on at a point where we might
switch interrupts off for a long time.
If we are in the middle of a PMU request and interrupts are
switched off long enough, it will timeout and shut down the
machine.

You should not need to use them unless you expect to disable
interrupts for a long time, which is usually a bad thing to do.

If you are tracking a problem where the PMU is shutting you
off while running a piece of code, then it may be useful.

Note that if you enter xmon, then xmon will regulary call
pmu_poll to keep it happy, despite having interrupts disabled.

Ben.

BTW. Obviously, pmu_resume puts things back to normal.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
