Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id 0ED8868A0F
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 03:09:32 +1100 (EST)
Subject: Re: [PATCH] sound/ppc/pmac.c typo.
From: Stelian Pop <stelian@popies.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hek3251ez.wl%tiwai@suse.de>
References: <1137753338.5050.8.camel@localhost.localdomain>
	<s5hpsmn7y0l.wl%tiwai@suse.de>
	<1137772472.14920.9.camel@localhost.localdomain>
	<s5hek3251ez.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 Jan 2006 17:09:26 +0100
Message-Id: <1137773366.14920.16.camel@localhost.localdomain>
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

Le vendredi 20 janvier 2006 à 17:06 +0100, Takashi Iwai a écrit :
> At Fri, 20 Jan 2006 16:54:31 +0100,
> Stelian Pop wrote:
> > 
> > Le vendredi 20 janvier 2006 à 15:51 +0100, Takashi Iwai a écrit :
> > > At Fri, 20 Jan 2006 11:35:38 +0100,
> > > Stelian Pop wrote:
> > > > 
> > > > In 2.6.16-rc1 there is a small typo introduced by the 'Remove device_node addrs/n_addr' changes
> > > > which prevents my Powerbook G4 sound from working:
> > > > 
> > > > 	Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
> > > > 	snd: can't request rsrc  0 (Sound Control: 0x80000000:80004fff)
> > > > 	ALSA device list:
> > > > 	   No soundcards found.
> > > > 
> > > > The patch below fixes it. Of course, the patch fixing the i2c issues 
> > > > ('i2c_smbus_write_i2c_block_data' patch) needs to be applied to in order for
> > > > the sound to completly work.
> > > >  
> > > > Signed-off-by: Stelian Pop <stelian@popies.net>
> > > 
> > > Thanks, I applied it to ALSA tree now.
> > 
> > Thanks.
> > 
> > BTW, is it a hardware or a configuration issue the fact that I'm unable
> > to mix several alsa streams ?
> 
> Did you install alsa-lib 1.0.11rc2, too?  It should work with dmix as
> default.

This is an ubuntu breezy ppc distribution, and it seems that the package
is called libasound2, and it is based on alsa-lib 1.0.9-2.

Stracing the aplay process shows that dmix.conf is being read:

	defiant:~ 20 > strace -eopen aplay wav/slow_20spindle_20motor.wav
	open("/etc/ld.so.cache", O_RDONLY)      = 3
	open("/usr/lib/libasound.so.2", O_RDONLY) = 3
	open("/lib/libm.so.6", O_RDONLY)        = 3
	open("/lib/libdl.so.2", O_RDONLY)       = 3
	open("/lib/libpthread.so.0", O_RDONLY)  = 3
	open("/lib/libc.so.6", O_RDONLY)        = 3
	open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
	open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
	open("/usr/share/alsa/pcm/default.conf", O_RDONLY) = 4
	open("/usr/share/alsa/pcm/dmix.conf", O_RDONLY) = 4
	open("/usr/share/alsa/pcm/dsnoop.conf", O_RDONLY) = 4
	open("/dev/snd/controlC0", O_RDONLY)    = 3
	open("/dev/snd/controlC0", O_RDONLY)    = 3
	open("/dev/snd/controlC0", O_RDWR)      = 3
	open("/dev/snd/controlC1", O_RDONLY)    = -1 ENOENT (No such file or directory)
	open("/dev/aloadC1", O_RDONLY)          = -1 ENOENT (No such file or directory)
	[...]

I suppose I could test with 1.0.11rc2 if it does make sense to.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
