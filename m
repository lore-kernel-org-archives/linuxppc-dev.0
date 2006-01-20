Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id E10E5689DD
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 02:54:37 +1100 (EST)
Subject: Re: [PATCH] sound/ppc/pmac.c typo.
From: Stelian Pop <stelian@popies.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hpsmn7y0l.wl%tiwai@suse.de>
References: <1137753338.5050.8.camel@localhost.localdomain>
	<s5hpsmn7y0l.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 Jan 2006 16:54:31 +0100
Message-Id: <1137772472.14920.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le vendredi 20 janvier 2006 à 15:51 +0100, Takashi Iwai a écrit :
> At Fri, 20 Jan 2006 11:35:38 +0100,
> Stelian Pop wrote:
> > 
> > In 2.6.16-rc1 there is a small typo introduced by the 'Remove device_node addrs/n_addr' changes
> > which prevents my Powerbook G4 sound from working:
> > 
> > 	Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
> > 	snd: can't request rsrc  0 (Sound Control: 0x80000000:80004fff)
> > 	ALSA device list:
> > 	   No soundcards found.
> > 
> > The patch below fixes it. Of course, the patch fixing the i2c issues 
> > ('i2c_smbus_write_i2c_block_data' patch) needs to be applied to in order for
> > the sound to completly work.
> >  
> > Signed-off-by: Stelian Pop <stelian@popies.net>
> 
> Thanks, I applied it to ALSA tree now.

Thanks.

BTW, is it a hardware or a configuration issue the fact that I'm unable
to mix several alsa streams ?

For example, if I issue two instances of 'aplay foo.wav', the first one
plays the sound while the second one remains stuck in:
	stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7467, ...}) = 0
	open("/dev/snd/controlC0", O_RDONLY)    = 3
	close(3)                                = 0
	open("/dev/snd/controlC0", O_RDWR)      = 3
	ioctl(3, USBDEVFS_CONTROL, 0x7fee2bf8)  = 0
	ioctl(3, UI_DEV_CREATE, 0x7fee2ca0)     = 0
	close(3)                                = 0
	open("/dev/snd/controlC0", O_RDONLY)    = 3
	close(3)                                = 0
	open("/dev/snd/controlC0", O_RDWR)      = 3
	ioctl(3, USBDEVFS_CONTROL, 0x7fee2fa8)  = 0
	ioctl(3, 0x80045532, 0x7fee2fd8)        = 0
	open("/dev/snd/pcmC0D0p", O_RDWR
until the first one ends playing. Only then the second one continues the
execution.

Just in case this is useful:
	# cat /proc/asound/version
	Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
	# cat /proc/asound/cards
	 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
	                      PowerMac Snapper (Dev 0) Sub-frame 0
	# cat /proc/asound/devices
	  0: [ 0]   : control
	  1:        : sequencer
	 16: [ 0- 0]: digital audio playback
	 24: [ 0- 0]: digital audio capture
	 33:        : timer
	# cat /proc/asound/pcm
	00-00: PMac Snapper : PowerMac Snapper : playback 1 : capture 1

Stelian.
-- 
Stelian Pop <stelian@popies.net>
