Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C8B2DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 15:40:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IFNzI-0003V2-CD
	for linuxppc-embedded@ozlabs.org; Sun, 29 Jul 2007 22:40:12 -0700
Message-ID: <11858308.post@talk.nabble.com>
Date: Sun, 29 Jul 2007 22:40:12 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ml403 ac97 driver
In-Reply-To: <1185698888.6397.37.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1185698888.6397.37.camel@localhost>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Joachim
I re-coross-compile alsa-lib and alsa-utils and install them in /usr on
board ,but the result is really no different .Would you mind if you point
out what i forget to do ?=20



# insmod ac97_bus.ko
# insmod snd-ac97-codec.ko
# insmod ml403_ac97cr.ko
[   79.529114] ml403_ac97cr: remap controller memory region to 0xc500e000
done
[   79.611803] ml403_ac97cr: request (playback) irq 7 done
[   79.674236] ml403_ac97cr: request (capture) irq 6 done
[   79.784291] snd-ml403_ac97cr: write access to codec register 0x26 with
bad value 0x800f / 32783!
[   79.900247] snd-ml403_ac97cr: write access to codec register 0x26 with
bad value 0xf / 15!
[   80.004284] snd-ml403_ac97cr: write access to codec register 0x2a with
bad value 0x2801 / 10241!
[   80.116228] snd-ml403_ac97cr: write access to codec register 0x2a with
bad value 0x3801 / 14337!
# ./snddevices                      .........//use alsa-driver-1.0.14=20
creating device nod script
Creating mixer?...done.
Creating sequencer...done.
Creating midi0?...done.
Creating dsp?...done.
Creating audio?...done.
Creating sndstat...done.
Creating music...done.
Creating dmmidi?...done.
Creating dmfm?...done.
Creating amixer?...done.
Creating adsp?...done.
Creating amidi?...done.
Creating admmidi?...done.
rm: /dev/snd: is a directory
Creating snd/control?...done.
Creating snd/seq...done.
Creating snd/timer...done.
Creating snd/hw??...done.
Creating snd/midi??...done.
Creating snd/pcm??p...done.
Creating snd/pcm??c...done.
Creating aload?...done.
Creating aloadSEQ...done.

# ls -l /dev/snd
crw-rw-rw-    1 root     root     116,   0 Jan  1 00:01 controlC0
crw-rw-rw-    1 root     root     116,   4 Jan  1 00:01 hwC0D0
crw-rw-rw-    1 root     root     116,   5 Jan  1 00:01 hwC0D1
crw-rw-rw-    1 root     root     116,   6 Jan  1 00:01 hwC0D2
crw-rw-rw-    1 root     root     116,   7 Jan  1 00:01 hwC0D3
crw-rw-rw-    1 root     root     116,  24 Jan  1 00:01 pcmC0D0c
crw-rw-rw-    1 root     root     116,  16 Jan  1 00:01 pcmC0D0p
crw-rw-rw-    1 root     root     116,   1 Jan  1 00:01 seq
crw-rw-rw-    1 root     root     116,  33 Jan  1 00:01 timer

# cat /proc/devices
Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
116 alsa
128 ptm
136 pts
254 keyboard
# cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

# aplay -D /dev/snd/pcmC0D0p
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0p

# ./test_sound.out /dev/snd/pcmC0D0p=20
ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0p
cannot open audio device /dev/snd/pcmC0D0p (No such file or directory)

.............test_sound.out   is   A Minimal Playback Program  from =20
http://equalarea.com/paul/alsa-audio.html


thanks for your help!

Qin Lin














Joachim F=C3=B6rster wrote:
>=20
> Hi qin lin,
>=20
> On Sat, 2007-07-28 at 17:04 +0800, qin lin wrote:
>> I have add the driver to kernel as a module in ml403.When i insmod=20
>> the module ,there are warnings followed here:
>> [  250.795594] snd-ml403_ac97cr: write access to codec register 0x26
>> with bad value 0x800f / 32783!=20
>> [  250.911545] snd-ml403_ac97cr: write access to codec register 0x26
>> with bad value 0xf / 15!
>> [  251.015576] snd-ml403_ac97cr: write access to codec register 0x2a
>> with bad value 0x2801 / 10241!
>> [  251.127524] snd-ml403_ac97cr: write access to codec register 0x2a
>> with bad value 0x3801 / 14337!=20
>>=20
>> And i check the warring find the warnings should be from function
>> snd_ml403_ac97cr_codec_write() =EF=BC=8Ci have check the lm4550 codec
>> datasheet to make sure the mask is what you have written.
>=20
> These warnings are ok. Codec register 0x26 is the "PowerDown
> Status/Control" register and the ALSA AC97 layer tries to write ones to
> the lower 4 bits (which are AFAIK read only bits). LM4550 register 0x2a
> has only one valid bit (lowest), but ALSA tries to write to a not
> existing bit. So my driver masks out these bits.
> The warnings show the invalid numbers ALSA wants to write to these
> registers.
>=20
>> What  confused  me is that where call the fuction
>> snd_ml403_ac97cr_codec_write in the module_init program, would you
>> mind if you point it for me?=20
>=20
> Well, the function alsa_card_ml403_ac97cr_init() is registered as the
> module_init function. It registers the driver and the device to the
> kernel via platform_driver/device_register(). As a consequence the
> kernel will call the registered probe() function called
> snd_ml403_ac97cr_probe(). Among other things, the function called
> snd_ml403_ac97cr_mixer() is invoked. Finally this function registers a
> mixer device and the codec_read() and codec_write() functions with the
> ALSA AC97 layer. While registering the ALSA AC97 layer calls the read
> and write functions several times - a kind of initialization sequence.
> That's the usual structure of an ALSA driver - not that simple - I
> know :-) .
>=20
>> There is another problem trouble me .I find a simple test program to
>> check  the codec playback work .But all it said that it cannot find
>> the pcm file.Would you mind if you suggest something or paste what you
>> have do to mknod the device?=20
>=20
> Oh, I forgot to mention that in the README file. I used the "snddevices"
> script found in ALSA's alsa-driver package (form version 1.0.13, but
> version shouldn't matter).
>=20
>> # ./test_sound.out  /dev/snd/pcmC0D0
>> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown
>> PCM /dev/snd/pcmC0D0=20
>> cannot open audio device /dev/snd/pcmC0D0 (No such file or directory)
>=20
> Hmmm, try to create the device files with the script from above and see
> if that happens again ...
> BTW: (After having created the device files) you can also use aplay
> (alsa-utils package) for testing. Where did you find "test_sound"?
>=20
>  Joachim
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=20
View this message in context: http://www.nabble.com/Re%3A-ml403-ac97-driver=
-tf4164866.html#a11858308
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
