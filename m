From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Wed, 9 Aug 2000 19:04:35 +0200
Message-Id: <20000809170435.11366@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000809115042.866F-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000809115042.866F-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Ok. Then for this to work, we need to slightly change the boot code not
>> to call simply ppc_md.get_rtc_time(), but to also adjust it on pmac using
>> the pram timezone. That means adding a new ppc_md.fixup_time() used only
>> at boot, or adding a "fixup" parameter to ppc_mc.get_rtc_time() set to 0
>> in normal cases and to 1 on first call during boot.
>
>Or let ppc_md.time_init() return offset between ppc_md.get_rtc_time()
>value and UTC and use the offset in time_init() as I proposed
>previously...

Yes, that would work. But when the offset is non-NULL we must also make
sure we call do_settimeofday() to disable the warp hack in kernel/time.c

Saving the timezone value to xpram is another issue. It could be done
from userland but we currently don't have userland tool that properly
access the xpram portion of the nvram. I did plan to add some ioctls to /
dev/nvram for it to return the location of the various nvram partitions,
looks like it will be time to actually implement them... Also, the
userland tool will have to be written...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
