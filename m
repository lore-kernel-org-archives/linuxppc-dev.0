Date: Mon, 28 Jun 2004 06:19:36 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
In-Reply-To: <1088415754.6992.1.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.60.0406280615400.3259@localhost.localdomain>
References: <20040628070916.706A6C109F@atlas.denx.de>
 <1088415754.6992.1.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, David Woodhouse wrote:

> On Mon, 2004-06-28 at 09:09 +0200, Wolfgang Denk wrote:
>>>    is this possible?  anyone done it this way, and can tell me what
>>> pitfalls i have to watch for?  thanks.
>>
>> This is a pretty standard setup. Although I don't really recommend to
>> use JFFS2 for root filesystem (for example, because with a  big  root
>> filesystem  the boot time may deteriorate). Instead, we usually split
>> the stuff in a read-only partition (for example cramfs),  a  volatile
>> part (tmpfs), and a persistent storage partition (JFFS2).
>
> I think it should be OK when it's 4MiB in size. Mount time was far more
> of a problem in JFFS2 many years ago when people were using the 2.4
> kernel. It's a lot faster in 2.6.
>
> There's people looking at making it even faster now, too.

we're still using the 2.4 kernel here, but i don't think boot/mount
time is an issue.  i mean, someone's just going to turn the unit on,
wait to get a "READY" prompt, and go to work.  if it takes a bit
longer, tough. :-)

it was more the response time from flash as opposed to RAM that was an
issue for me.  that's why i was asking about having the root FS loaded
from flash into RAM at boot time.  we'd probably be happy about
sacrificing boot time response (copying all of the root FS into RAM)
for better run time performance, although i don't know the differences
in performance at the moment.

but i like the fact that it's snappier under 2.6.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
