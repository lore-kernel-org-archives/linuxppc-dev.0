Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 10B3C679EF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 08:17:27 +1000 (EST)
Date: Thu, 18 May 2006 00:19:46 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: snd-aoa status update / automatic driver loading
Message-ID: <20060517221945.GA2902@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060517215412.GA4504@localhost>
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

On Wed, May 17, 2006 at 11:54:12PM +0200, Wolfgang Pfeiffer wrote:
> 
> 
> # lsmod | grep -i snd   [again slightly edited]
> snd_aoa_codec_onyx     12736  2 
> snd_aoa_fabric_layout     7716  2 
> snd_aoa                 8076  2 snd_aoa_codec_onyx,snd_aoa_fabric_layout
> snd_pcm_oss            45824  0 
> snd_mixer_oss          19392  1 snd_pcm_oss
> snd_pcm                89060  2 i2sbus,snd_pcm_oss
> snd_timer              22468  1 snd_pcm
> snd_page_alloc          8744  1 snd_pcm
> soundbus                6436  2 snd_aoa_fabric_layout,i2sbus
> snd                    60148  12 snd_aoa_codec_onyx,
> 				 snd_aoa_fabric_layout,snd_aoa,i2sbus,
> 				 snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
> soundcore               8612  1 snd
> 
> 
> [do you see modules that are not needed anymore with the new snd-aoa,
> with the hardware I have?]

Update:

changed /etc/modules to explicitly load only i2sbus:

--------------------
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
i2sbus
#snd-aoa
#snd-aoa-fabric-layout
#snd-aoa-codec-onyx
# End snd-aoa

cpufreq_performance
cpufreq_powersave
sr_mod
therm_adt746x
-------------------

.. which seems enough to load the rest of the needed snd modules:
After the change above [following op. slightly edited]:

---------------------
# lsmod | grep -i snd
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

---------------------


> 
> 
> /etc/modules:
> -------------------------
> # /etc/modules: kernel modules to load at boot time.
> #
> # This file contains the names of kernel modules that should be loaded
> # at boot time, one per line. Lines beginning with "#" are ignored.
> 
> apm_emu
> ide-cd
> #ide-disk
> #ide-generic
> sbp2
> i2c-powermac
> #snd-powermac
> 
> #snd-aoa:
> soundbus
> i2sbus
> snd-aoa
> snd-aoa-fabric-layout
> snd-aoa-codec-onyx
> # End snd-aoa
> 
> cpufreq_performance
> cpufreq_powersave
> sr_mod
> therm_adt746x
> 
> ------------------------

HTH

Regards
Wolfgang
-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
