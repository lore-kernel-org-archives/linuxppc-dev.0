Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D5E0D679F4
	for <linuxppc-dev@ozlabs.org>; Sat, 13 May 2006 00:17:07 +1000 (EST)
Date: Fri, 12 May 2006 16:19:18 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
Message-ID: <20060512141918.GA3566@localhost>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<20060510213028.GG3878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060510213028.GG3878@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Matthias Grimm <matthiasgrimm@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

First a fat Thanks to Johannes, Benh and to all of those heroes making
it possible to run a relatively freh PPC (Apple) Powerbook model with Linux ... :)

I'm cross-posting. So a short note for those who can't know what all this is about:

I didn't have sound with a fresh git kernel, on the machine mentioned above:

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld

[Oops, something's messed up there: this actually is a 1.67 Ghz
processor. I'll have a look at this later .. :) ]

That's why I sent a message to linuxppc-dev@ozlabs.org. The thread is
starting here:

http://ozlabs.org/pipermail/linuxppc-dev/2006-May/022736.html

On Wed, May 10, 2006 at 11:30:28PM +0200, Wolfgang Pfeiffer wrote:
> On Wed, May 10, 2006 at 06:04:13PM +0200, Johannes Berg wrote:
> 
> > Also, try snd-aoa.
> 
> Impossible here, it does not compile here. Neither with gcc 4.0 or 4.1

Wrong. To put it mildly .. :) Result probably of me being too tired,
too fast, and too anal when reading instructions ...

# lsmod | grep -i aoa
snd_aoa_codec_onyx     12032  2 
snd_aoa_fabric_layout     7492  2 
snd_aoa                 8076  2 snd_aoa_codec_onyx,snd_aoa_fabric_layout
soundbus                6628  2 snd_aoa_fabric_layout,i2sbus
snd                    60148  12 snd_aoa_codec_onyx,snd_aoa_fabric_layout,
				 snd_aoa,snd_powermac,i2sbus,snd_pcm_oss,
				snd_mixer_oss,snd_pcm,snd_timer   

I successfully compiled the software now, and only with gcc-4.1. Example:

# modinfo snd_aoa 
filename:       /lib/modules/2.6.17-rc3-gf358166a-dirty/kernel/sound/aoa/snd-aoa.ko
description:    Apple Onboard Audio Sound Driver
author:         Johannes Berg <johannes@sipsolutions.net>
license:        GPL
vermagic:       2.6.17-rc3-gf358166a-dirty mod_unload gcc-4.1
depends:        snd
srcversion:     D0DFD2EF0CFEB8E7C08AAEB

The git kernel I compiled the snd-aoa modules for (must be from about
yesterday, IINM):

 cat /proc/version
Linux version 2.6.17-rc3-gf358166a-dirty (root@debby1-6) (gcc version
4.1.1 20060428 (prerelease) (Debian 4.1.0-2)) #1 Fri May 12 01:13:36
CEST 2006

config for this latest kernel (Please note the
"CONFIG_PREEMPT_VOLUNTARY=y" in there ... :) ... :

<http://wolfgangpfeiffer.com/config-2.6.17-rc3-gf358166a-dirty.txt>

I filled /etc/modules with snd_aoa modules and i have sound already
from boot time on ... with a minor glitch (i.e. not being able to
store a certain volume level via alsactrl to the next reboot, as it
seems), but sound ...

> 
> I took your instructions from
> http://lists.debian.org/debian-powerpc/2006/03/msg00470.html
> 

I'm listening to some Internet radio station via alsaplayer while
writing this mail ... :) ...

Results, as of now:

I can change the sound volume via the software. Tested in xine and
alsaplayer-gtk so far ...

I have problems doing the same with pbbuttonsd. That is I can start,
e.g., gtkppbuttons, but when pressing <FN>-<F5> or <FN>-<F4> it seems
being impossible to change the sound volume this way. But I can toggle
it completely ON/OFF with <FN>-<F3.> ... not being sure tho' whether
this is due to some of my braindead mistakes or really a pbbuttonsd
issue ...

Thanks again a lot to everyone for your work, your time, and the
resulting fine software ... :)

Nice weekend
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
