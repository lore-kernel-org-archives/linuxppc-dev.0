Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3460A67A64
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 04:15:29 +1000 (EST)
Date: Thu, 18 May 2006 20:17:48 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060518181748.GA2836@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost> <20060517221945.GA2902@localhost>
	<1147947192.15507.40.camel@johannes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147947192.15507.40.camel@johannes>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 18, 2006 at 12:13:12PM +0200, Johannes Berg wrote:
> On Thu, 2006-05-18 at 00:19 +0200, Wolfgang Pfeiffer wrote:
> 
> > changed /etc/modules to explicitly load only i2sbus:
> 
> Even that should not be necessary.

True. Just tested it (i.e. booted the machine) with this /etc/modules file:

----------------
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.

apm_emu
ide-cd
#ide-disk
#ide-generic
sbp2
i2c-powermac
#snd-powermac

#snd-aoa:
#soundbus
#i2sbus
#snd-aoa
#snd-aoa-fabric-layout
#snd-aoa-codec-onyx
# End snd-aoa

cpufreq_performance
cpufreq_powersave
sr_mod
therm_adt746x

-----------------

And this is lsmod, after booting with he file above (op. slightly
edited for better readability):

# lsmod | grep snd

snd_aoa_codec_onyx     12736  2 
snd_aoa_fabric_layout     7716  1 
snd_aoa                 8076  2 snd_aoa_codec_onyx,snd_aoa_fabric_layout
snd_pcm_oss            45824  0 
snd_mixer_oss          19392  1 snd_pcm_oss
snd_pcm                89060  2 i2sbus,snd_pcm_oss
snd_timer              22468  1 snd_pcm
snd_page_alloc          8744  1 snd_pcm
soundbus                6436  2 snd_aoa_fabric_layout,i2sbus
snd                    60148  10 snd_aoa_codec_onyx,
				 snd_aoa_fabric_layout,snd_aoa,i2sbus,
				 snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               8612  1 snd


BTW: Is there a way to let 'alsaconf' detect the soundcard on this
PB5,8 ?
So far that's impossible, as it seems. But this could also be
related to mistakes I made in my modules files, or wherever.

That's why I changed a few files today below /etc/modprobe.d/ and
/etc/modutils/ that still had a few instances calling snd-powermac:
I simply replaced 'snd-powermac' with i2sbus resp. (IIRC)
snd-aoa. To no avail so far: alsaconf still does not detect any
soundcard .. 

Status quo:

$ grep -irs i2sbus /etc/         
/etc/modprobe.d/alsa-base:install i2sbus /sbin/modprobe --ignore-install i2sbus $CMDLINE_OPTS && /lib/alsa/modprobe-post-install i2sbus
/etc/modprobe.d/sound:alias snd-card-0 i2sbus
/etc/modutils/alsa-base:post-install i2sbus /lib/alsa/modprobe-post-install i2sbus

Anything wrong up there?

Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
