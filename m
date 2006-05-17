Return-Path: <dean@bong.com.au>
Received: from aramaki.bong.com.au (aramaki.bong.com.au [203.91.232.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFAD6679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 08:48:29 +1000 (EST)
Message-ID: <446BA3FF.5050308@bong.com.au>
Date: Thu, 18 May 2006 08:30:23 +1000
From: Dean Hamstead <dean@bong.com.au>
MIME-Version: 1.0
To: debian-powerpc <debian-powerpc@lists.debian.org>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost>
In-Reply-To: <20060517215412.GA4504@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

perhaps a comprehensive sound test would be in order, akin perhaps to 
the one the winehq chaps are doing right now

Dean

Wolfgang Pfeiffer wrote:
> Hi Johannes
> 
> Thanks for the update .. :)
> 
> I loaded the new drivers, and they work, as it seems. In the end it
> will probably need a bit more use of this driver before i can give a
> reliable test report ... :)
> 
> Below a few first notes ..
> 
> On Wed, May 17, 2006 at 12:09:24PM +0200, Johannes Berg wrote:
>> Hey,
>>
>> Currently snd-aoa is known to work on the following machines:
>> * PowerBook5,8
> 
> I use snd-aoa on the latter
> 
>> People with those machines are encouraged to use and stress-test it,
> 
> 
> I compiled/installed your (old) snd-aoa files at about last (Tuesday)
> night , and got these errors when re-booting the machine today:
> 
> -------------------------
> # zgrep mismatch /var/log/boot.*gz [following op slightly edited for readability]
> 
> /var/log/boot.2.gz:Wed May 17 16:14:04 2006: ^[[9;0]^[[14;0]Setting up
> ALSA...warning: 'alsactl restore' failed with error message 'alsactl:
> set_control:894: warning: name mismatch (Line-out Switch/Headphone
> Switch) for control #2
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:896:
> warning: index mismatch (0/0) for control #2
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:894:
> warning: name mismatch (Master Playback Volume/Capture Source) for
> control #3
> 
> /var/log/boot.2.gz:Wed May 17 16:14:05 2006: alsactl: set_control:896:
> warning: index mismatch (0/0) for control #3
> --------------------------
> 
> This error seems to be *gone* after updating ('git pull') snd-aoa,
> compiling and installing it at about 16:00 UTC today (Wednesday)...
> 
> # modinfo snd-aoa
> filename:       /lib/modules/2.6.17-rc3-gf358166a-dirty/kernel/sound/aoa/snd-aoa.ko
> description:    Apple Onboard Audio Sound Driver
> author:         Johannes Berg <johannes@sipsolutions.net>
> license:        GPL
> vermagic:       2.6.17-rc3-gf358166a-dirty mod_unload gcc-4.1
> depends:        snd
> srcversion:     C4332AD34674ECE97C7BF91
> 
> Notes:
> 
> 1:
> 
> I removed snd-powermac from /etc/modules to prevent the module from
> being loaded when booting ... only today .. Sound still works ... :)
> 
> 2:
> 
> Took me some reboots/'alsactl store' to have sound switched on
> automatically after logging in to KDE ... not being sure what was
> going on .. 
> 
> 
> 3:
> 
> I have a kmix Volume slider now ... this is new on *this* kmix applet
> (i.e. the one I have to load via Multimedia --> KMix from the KDE
> kicker)
> 
> So: Nice ... is this the solution you like, too ? ... ;) .. 
> 
> 4:
> 
> I can hear two sound files at the same time: Didn't work at the first
> try. I then installed again /etc/asound.conf, that I copied from my
> old ti-IV-Book (Not being sure tho' whether this really is such a good
> idea .... : 
> 
> -------------------------------
> pcm.!default {
> 	type plug
> 	slave.pcm asymer
> }
> 
> pcm.dmixer {
> 	type dmix
> 	ipc_key 1977
> 	ipc_perm 666
> #	ipc_key_add_uid true
> 	slowptr true
> 	slave {
> 		pcm "hw:0"
> 		period_time 0
> 		period_size 1024
> 		buffer_size 8192
> 		rate 44100
> 	}
> }
> 
> pcm.dsnooper {
> 	type dsnoop
> 	ipc_key 1978
> 	ipc_perm 666
> #	ipc_key_add_uid true
> 	slave.pcm "hw:0"
> }
> 
> pcm.asymer {
> 	type asym
> 	playback.pcm "dmixer"
> 	capture.pcm "dsnooper"
> }
> 
> pcm.jack {
> 	type jack
> 	playback_ports {
> 		0 alsa_pcm:playback_1
> 		1 alsa_pcm:playback_2
> 	}
> 	capture_ports {
> 		0 alsa_pcm:capture_1
> 		1 alsa_pcm:capture_2
> 	}
> }
> 
> # These are for alsa-oss
> pcm.dsp0 pcm.default
> ctl.mixer0 "hw:0"
> ------------------------------
> 
> 5:
> 
> Ooops: Alsaplayer just disappeared while playing somem Internet radio
> station:
> 
> /var/log/kern.log from about the time of the crash:
> 
> May 17 23:34:11 debby1-6 kernel: [15962.091766] i2sbus: stop/suspend
> 
> [nothing more, as it seems .. Sorry]
> 
> No problem restarting alsa-player after this little crash .. :) 
> 
> 
> 
>> Now, when you boot, mac-io is already built-in so provides the i2s
>> device, which my i2sbus module binds to. Since udev synthesizes events,
>> i2sbus gets loaded automatically. Now, i2sbus creates uevents on its
>> own, with the layout number given as the MODALIAS. Hence, the layout
>> fabric module is loaded because it has an alias for all the layouts it
>> handles, and it in turn requests all the codec modules that it requires.
>> Also, this means that 'modprobe i2sbus' will suffice to get the driver
>> up and running without a reboot, 
> 
> ... didn't try this so far, but I'll keep that in mind for
> /etc/modules ... :)
> 
> The problem I had so far after installing the new snd-aoa drivers was
> to first unload them (before reloading) without the need to reboot
> ... it seems the KDE panel (kicker) is using the drivers, thus
> preventing them from being unloadable ... I'll see into that later on
> ... 
> 
> Just in case it helps:
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
> 
> Thanks for your work .. :)
> 
> And please let me know if you need to know more ..
> 
> Best Regards
> Wolfgang
> 
