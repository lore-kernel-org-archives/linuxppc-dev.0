Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 1AAAB67A44
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 01:19:48 +1000 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
	<1148046418.3864.14.camel@johannes.berg>
	<87zmhef57o.fsf@briny.internal.ondioline.org>
	<1148050189.6228.13.camel@johannes.berg>
Date: Sat, 20 May 2006 01:13:38 +1000
Message-ID: <87bqtum4il.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?utf-8?Q?Petri=C5=9For?= <eddy.petrisor@gmail.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Sat, 2006-05-20 at 00:40 +1000, Paul Collins wrote:
>
>> Here's the dmesg after "modprobe i2sbus":
>> 
>> May 20 00:35:51 briny kernel: i2sbus: mapped i2s control registers
>> May 20 00:35:51 briny kernel: i2sbus: control register contents:
>> May 20 00:35:51 briny kernel: i2sbus:    fcr0 = 0x0
>> May 20 00:35:51 briny kernel: i2sbus:    cell_control = 0x0
>> May 20 00:35:51 briny kernel: i2sbus:    fcr2 = 0x4ef1c25
>> May 20 00:35:51 briny kernel: i2sbus:    fcr3 = 0x0
>> May 20 00:35:51 briny kernel: i2sbus:    clock_control = 0x0
>> May 20 00:35:51 briny kernel: layout id is 51
>
> Did you have the changed modules installed? Otherwise you'd also have to
> manually load snd_aoa_fabric_layout and possibly snd_aoa_codec_tas or
> so. If you had them installed the MODULE_ALIAS("sound-layout-51");
> should have made it load automatically.

Yep, I did make install after the build.  And modinfo
/lib/modules/`uname -r`/kernel/sound/aoa/snd-aoa-fabric-layout.ko
shows ones of the aliases as "sound-layout-51".

I did a fresh boot with snd-powermac renamed out of the way, and now I
get even less action: nothing logged in dmesg, and when I unload all
five modules and probe snd-powermac (having renamed it back) I get

May 20 01:08:29 briny kernel: snd: can't request rsrc  0 (Sound Control: 0x80010000:80010fff)

Then when I removed snd-powermac and probed i2sbus I got the same

May 20 01:10:00 briny kernel: i2sbus: mapped i2s control registers
May 20 01:10:00 briny kernel: i2sbus: control register contents:
May 20 01:10:00 briny kernel: i2sbus:    fcr0 = 0x0
May 20 01:10:00 briny kernel: i2sbus:    cell_control = 0x0
May 20 01:10:00 briny kernel: i2sbus:    fcr2 = 0xb7f53c
May 20 01:10:00 briny kernel: i2sbus:    fcr3 = 0x0
May 20 01:10:00 briny kernel: i2sbus:    clock_control = 0x0
May 20 01:10:00 briny kernel: layout id is 51
May 20 01:10:00 briny kernel: i2sbus control destroyed

Probing snd_aoa_fabric_layout and snd_aoa_codec_tas yielded no further
dmesg output and /proc/asounds/cards remains "no soundcards".

-- 
Dag vijandelijk luchtschip de huismeester is dood
