Message-ID: <3F004440.6000301@peak.uklinux.net>
Date: Mon, 30 Jun 2003 15:08:00 +0100
From: Seb James <seb@peak.uklinux.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: u-boot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [U-Boot-Users] soft_i2c and ds1307 with tqm823l
References: <20030630133530.CC405C592A@atlas.denx.de>
In-Reply-To: <20030630133530.CC405C592A@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
[ snip ]

>>Ok, well I've successfully compiled with CONFIG_HARD_I2C and have
>>communicated with my clock, so that is good. Next up is transferring the
>>date in u-boot to linux, but I'm sure that will be documented somewhere.
>>
>>
>
>You don't "transfer" the daye. Linux will pick it  up  itself  (which
>requires an RTC driver and eventually some modifications).
>

Let me check that I understand: As far as I can see the u-boot realtime
clock drivers just allow you to set and read the time from the u-boot
command line; a useful utility. If linux is to read the time from the
realtime clock it must have a realtime clock driver of its own; there's
no way that u-boot can pass the time to linux at boot time? (Of course,
this would be fraught with difficulties, because depending on how fast
your cpu boots linux, a different amount of time would elapse before
linux could actually do something with the passed date stamp).

So, next up for me is to write a linux driver for the ds1307. I was
actually in the middle of that before getting sidetracked by the u-boot
rtc code. However, the u-boot code has enabled me to hardware debug my
realtime clock circuit, so that was very useful.  Has anyone written a
linux driver for the ds1307 or similar? (I'm cross posting to the
linuxppc-embedded list to ask this question).

>>As for CONFIG_SOFT_I2C; Attached (really this time) is a diff between
>>the original u-boot-0.4.0/include/configs/TQM823L.h and the one that I
>>have altered. The compile of soft_i2c.c fails with the following error
>>messages:
>>
>>
>
>That's because you did  not  define  the  required  macros  (see  for
>example the configuration in lwmon.h).
>
>
Right, so it's not the case that you just #define CONFIG_SOFT_I2C; you
have to correctly define the macros. I shall do some work on the readme
and post a diff later on. Thanks for the pointers.

best,

Seb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
