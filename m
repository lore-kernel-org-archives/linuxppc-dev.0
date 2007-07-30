Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F59BDDE06
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 17:33:55 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFPl9-0004X6-UF
	for linuxppc-embedded@ozlabs.org; Mon, 30 Jul 2007 09:33:44 +0200
Received: from p54a4d2c7.dip.t-dialin.net ([84.164.210.199])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 30 Jul 2007 09:33:43 +0200
Received: from mls.JOFT by p54a4d2c7.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 30 Jul 2007 09:33:43 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: ml403 ac97 driver
Date: Mon, 30 Jul 2007 09:33:35 +0200
Message-ID: <1185780815.5454.18.camel@localhost>
References: <1185698888.6397.37.camel@localhost>
	<11858308.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
In-Reply-To: <11858308.post@talk.nabble.com>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Qin Lin,

On Sun, 2007-07-29 at 22:40 -0700, Qin Lin wrote:
> # insmod ac97_bus.ko
> # insmod snd-ac97-codec.ko
> # insmod ml403_ac97cr.ko
> [   79.529114] ml403_ac97cr: remap controller memory region to 0xc500e000
> done
> [   79.611803] ml403_ac97cr: request (playback) irq 7 done
> [   79.674236] ml403_ac97cr: request (capture) irq 6 done
> [   79.784291] snd-ml403_ac97cr: write access to codec register 0x26 with
> bad value 0x800f / 32783!
> [   79.900247] snd-ml403_ac97cr: write access to codec register 0x26 with
> bad value 0xf / 15!
> [   80.004284] snd-ml403_ac97cr: write access to codec register 0x2a with
> bad value 0x2801 / 10241!
> [   80.116228] snd-ml403_ac97cr: write access to codec register 0x2a with
> bad value 0x3801 / 14337!

Completely fine.

> # ls -l /dev/snd
> crw-rw-rw-    1 root     root     116,   0 Jan  1 00:01 controlC0
> crw-rw-rw-    1 root     root     116,   4 Jan  1 00:01 hwC0D0
> crw-rw-rw-    1 root     root     116,   5 Jan  1 00:01 hwC0D1
> crw-rw-rw-    1 root     root     116,   6 Jan  1 00:01 hwC0D2
> crw-rw-rw-    1 root     root     116,   7 Jan  1 00:01 hwC0D3
> crw-rw-rw-    1 root     root     116,  24 Jan  1 00:01 pcmC0D0c
> crw-rw-rw-    1 root     root     116,  16 Jan  1 00:01 pcmC0D0p
> crw-rw-rw-    1 root     root     116,   1 Jan  1 00:01 seq
> crw-rw-rw-    1 root     root     116,  33 Jan  1 00:01 timer

Ok, should suffice. [In my case snddevices made many other device
files.]

> # aplay -D /dev/snd/pcmC0D0p
> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0p

Well, I think the way you specify the device is wrong. AFAIK the -D
option only accepts names which are defined in an ALSA configuration
file (.asoundrc & friends).
Furthermore: Did you try without any device (without -D option)? The
defaults should make ALSA pick the first available sound device. At
least, while I was testing, I didn't have to specify any device.

BTW: You need to specify the (.wav) file you want to play:
# aplay music.wav
Otherwise you won't here anything ;-). Read "man aplay" !

> # ./test_sound.out /dev/snd/pcmC0D0p 
> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0p
> cannot open audio device /dev/snd/pcmC0D0p (No such file or directory)

Ditto. But I haven't had a look into test_sound source yet, but it might
be the same issue.

 Joachim
