From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: NVRAM stuck in DST?
Date: Fri, 7 Dec 2001 22:38:04 +0100
Message-Id: <20011207213804.7802@smtp.wanadoo.fr>
In-Reply-To: <200112070759.IAA00984@piglet.grunz.lu>
References: <200112070759.IAA00984@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Hmmm... DST on? That's wrong; we're not in DST anymore! And the current
>offset to GMT is one hour, not two hours. I'm wondering whether
>something else besides MacOS sets those values.

AFAIK, MacOS is the only one to set it.

>If not, then I'll be stuck with whatever NVRAM values MacOS wrote there
>when it was last booted. Which means that unless at every DST time
>change, unless I bot MacOS once, I'll be stuck with the wrong time....

Yup, we need a proper tool for that. Actually, we need 2 things

 - a way for /dev/nvram to let userland know about the partitioning
of the nvram (expecially where the xpram is)
 - then a tool using that to write to the MachineLocation record
in nvram containing the tz offset and DST flag.

>Also, just for my understanding, doesn't MacOS save the system time in
>the RTC in localtime? In that case I don't see how time _advances_ on
>boot... unless the MacOS RTC is in DST-less localtime.

The kernel time is calculated from the RTC local time, offseted by
the pram gmt offset & dst to get a GMT time.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
