Message-ID: <3E47F4D4.5070202@embeddededge.com>
Date: Mon, 10 Feb 2003 13:52:04 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c
References: <18854.1044839284@ull>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> It is quite clearly broken - ....


Pay attention....:-)

You can also read this over and over again in the archives........

First, these functions are used by more than kernel printk.  They
are shared with xmon and kgdb debugger functions.

Second, the kernel printk doesn't call this driver until the driver
has been initialized, which means it has allocated all of the "normal"
memory buffers for fifo and the CPM BD's.

The ONLY time these functions will find a buffer in DPRAM is when xmon
or kgdb is used.  If you are using kgdb or xmon, and find something wrong
with the buffer management, then there is a bug.......xmon and kgdb don't
generate buffer contents that necessitates this test.  If you add this
code it will never get executed.

 > ...a quick perusal of the code will convince you
> of this.

No it won't.  Find the case where this happens and then I'll be convinced :-)


> It appears that the code originally didn't take into account buffer addresses
> that may be in DPRAM, and when it was updated to do so, whoever did it, updated
> the first instance of the code,

I did it.  It was updated to support xmon and kgdb.  Only the modifications
necessary to support these functions were added. In addition to these driver
changes, there are assumptions and interactions with boot roms/loaders so
we could start kgdb very early in the debugging phase, long before the driver
was formally initialized.

> ... I for one would like to see this bug fixed.

Prove it's a bug, it will get fixed.

I will mildly apoligize, but you have to understand I get lots of patches
from people claiming "bugs", when it isn't one and they don't take the time
to understand why something was done or even how it works.  I'll add the
code, it won't have any effect, it that makes you happy.

> ..... In
> fact, I have a vague recollection that the same bug also existed in the 8260
> version of this code, and that I submitted a fix for it among the 8260 uart
> patches I posted some time ago.

I took the time to look for something from you in the past and didn't find
anything.  If it showed up, you would have received the same discussion.
The 8260 driver was just a copy of this one with only the necessary changes
to make it work on that processor.

> This serves to highlight the difficulty of getting stuff into the "official"
> linuxppc kernel sources,

The real difficulty arises from the time many of us have to spend proving
patches work correctly or that a real bug exists.  In this case, no one took
the time to prove it was a bug, which it isn't, or that it was even fixed.
The reason we have only a few people with the ability to actually update
the trees is we take the time to understand how all of this stuff works
and do our best to ensure we aren't creating more problems than we are solving.


For example, was someone supposed to blindly accept Jocke's patch to make
the serial port fifos so much larger?  I had to take the time (over and over) :-)
to explain why this wasn't a bug.  It would be nice if some of you went through
the learning curve to understand how things are supposed to work before you
just declare bugs and submit patches.

 > ...I don't know what to do about this, ...

The thing to do about it is for _you_ to invest the time in some engineering
practices and show that you really found a bug, you can reproduce the bug,
you implemented some feature enhancement, your modifications didn't introduce
other problems, the code considers effects on other platforms, and that
your update does what it claims.  When I have to do this, the priority of
these updates falls well below my own work.

As a final example, Jocke keeps bugging me about his ethernet updates.  I
explained (yet again, it was in the archives) that this had been attempted
in the past, and it caused problems with packet routing/forwarding.  Why
do I have to take the time to set up the testing environment and once again
prove this is still a problem?  I hoped to find someone with a test
environment to prove this (as they mentioned the bug in the first place),
but they are also busy with their own projects.  Someday I may have time
to set this up, make some changes to the patch so it works better, and
do some testing to ensure the upstream alignment changes are done properly.
If someone else can take the time to ensure it works (or make it work)
in this condition where it was known to fail in the past, I would be more
likely to check it in without taking the time to do the testing myself.

It's easy to hack up code, throw it over the fence, and complain when
someone else won't take care of it.  Make that job easier for those of
us trying to maintain the source trees, it would be appreciated.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
