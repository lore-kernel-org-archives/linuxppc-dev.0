Date: Tue, 14 Aug 2001 10:45:49 +0100
Subject: Re: Occasional crash reports
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010814094529.3E40EDBA11@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 14, 2001, Takashi Oe wrote:
> On Mon, 13 Aug 2001, Benjamin Herrenschmidt wrote:
>
>> I'm getting regular crash reports for which I'm having trouble figuring
>> out what's going on exactly. Those are with my tree or bk 2_4_devel, but
>> the problem may be present elsewhere.
>>
>> So basically, the kernel tends to die in various locations where things
>> should be just fine, but I did notice one thing: In most of these cases,
>> I had softirq around in the backtrace (either running in softirqs, or
>> having do_softirq() in the backtrace). There is one case where I didn't
>> have it: it dies inside power_save(), so probably because an interrupt
>> that happened just before messed things up.
>>
>> I'm wondering if we might be running into some stack overflow...
>
> I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
> are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
> rather easily with regular programs, given a day or two.

Can you point at which program reliably crashes beige/G3?
that's what I use as my dev/build machine and it seems to be stable (2.4.x)
except under the following circumstance:

If I boot using the BootX application - at which point something drops a
bomb which almost always ends up in the network stack and shows up as an
illegal instruction (usually an FP one).

If I hard-reboot this doesn't seem to happen.

I haven't had time to fiddle with making the kernel write-only or whatever
to find out who drops the bomb (although is may well be something that is
left over from MacOS that BootX application hasn't managed to stop).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
