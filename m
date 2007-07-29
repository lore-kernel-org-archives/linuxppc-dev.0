Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CFE8DDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Jul 2007 18:48:14 +1000 (EST)
Subject: Re: ml403 ac97 driver
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: qin lin <linkinge@gmail.com>
In-Reply-To: <2ec96d6e0707280204k50efb707q99a824c37f539309@mail.gmail.com>
References: <28652204.1477431184843737431.JavaMail.nabble@isper.nabble.com>
	<1184918815.5886.13.camel@localhost>
	<2ec96d6e0707280204k50efb707q99a824c37f539309@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 29 Jul 2007 10:48:08 +0200
Message-Id: <1185698888.6397.37.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi qin lin,

On Sat, 2007-07-28 at 17:04 +0800, qin lin wrote:
> I have add the driver to kernel as a module in ml403.When i insmod 
> the module ,there are warnings followed here:
> [  250.795594] snd-ml403_ac97cr: write access to codec register 0x26
> with bad value 0x800f / 32783! 
> [  250.911545] snd-ml403_ac97cr: write access to codec register 0x26
> with bad value 0xf / 15!
> [  251.015576] snd-ml403_ac97cr: write access to codec register 0x2a
> with bad value 0x2801 / 10241!
> [  251.127524] snd-ml403_ac97cr: write access to codec register 0x2a
> with bad value 0x3801 / 14337! 
> 
> And i check the warring find the warnings should be from function
> snd_ml403_ac97cr_codec_write() ，i have check the lm4550 codec
> datasheet to make sure the mask is what you have written.

These warnings are ok. Codec register 0x26 is the "PowerDown
Status/Control" register and the ALSA AC97 layer tries to write ones to
the lower 4 bits (which are AFAIK read only bits). LM4550 register 0x2a
has only one valid bit (lowest), but ALSA tries to write to a not
existing bit. So my driver masks out these bits.
The warnings show the invalid numbers ALSA wants to write to these
registers.

> What  confused  me is that where call the fuction
> snd_ml403_ac97cr_codec_write in the module_init program, would you
> mind if you point it for me? 

Well, the function alsa_card_ml403_ac97cr_init() is registered as the
module_init function. It registers the driver and the device to the
kernel via platform_driver/device_register(). As a consequence the
kernel will call the registered probe() function called
snd_ml403_ac97cr_probe(). Among other things, the function called
snd_ml403_ac97cr_mixer() is invoked. Finally this function registers a
mixer device and the codec_read() and codec_write() functions with the
ALSA AC97 layer. While registering the ALSA AC97 layer calls the read
and write functions several times - a kind of initialization sequence.
That's the usual structure of an ALSA driver - not that simple - I
know :-) .

> There is another problem trouble me .I find a simple test program to
> check  the codec playback work .But all it said that it cannot find
> the pcm file.Would you mind if you suggest something or paste what you
> have do to mknod the device? 

Oh, I forgot to mention that in the README file. I used the "snddevices"
script found in ALSA's alsa-driver package (form version 1.0.13, but
version shouldn't matter).

> # ./test_sound.out  /dev/snd/pcmC0D0
> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown
> PCM /dev/snd/pcmC0D0 
> cannot open audio device /dev/snd/pcmC0D0 (No such file or directory)

Hmmm, try to create the device files with the script from above and see
if that happens again ...
BTW: (After having created the device files) you can also use aplay
(alsa-utils package) for testing. Where did you find "test_sound"?

 Joachim
