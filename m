Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CBDFDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jul 2007 18:28:38 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IFQcE-0007Jx-VH
	for linuxppc-embedded@ozlabs.org; Mon, 30 Jul 2007 01:28:34 -0700
Message-ID: <11859770.post@talk.nabble.com>
Date: Mon, 30 Jul 2007 01:28:34 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ml403 ac97 driver
In-Reply-To: <1185780815.5454.18.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1185698888.6397.37.camel@localhost>
	<11858308.post@talk.nabble.com>
	<1185780815.5454.18.camel@localhost>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi Joachim

i have hearing the music . Thanks.   just use=20
#aplay music.wav=20

Before that i recompile the alsa-lib again. change configure options
later i will paste the whole  commands so as anybody can reference it .




Joachim F=C3=B6rster wrote:
>=20
> Hi Qin Lin,
>=20
> On Sun, 2007-07-29 at 22:40 -0700, Qin Lin wrote:
>> # insmod ac97_bus.ko
>> # insmod snd-ac97-codec.ko
>> # insmod ml403_ac97cr.ko
>> [   79.529114] ml403_ac97cr: remap controller memory region to 0xc500e00=
0
>> done
>> [   79.611803] ml403_ac97cr: request (playback) irq 7 done
>> [   79.674236] ml403_ac97cr: request (capture) irq 6 done
>> [   79.784291] snd-ml403_ac97cr: write access to codec register 0x26 wit=
h
>> bad value 0x800f / 32783!
>> [   79.900247] snd-ml403_ac97cr: write access to codec register 0x26 wit=
h
>> bad value 0xf / 15!
>> [   80.004284] snd-ml403_ac97cr: write access to codec register 0x2a wit=
h
>> bad value 0x2801 / 10241!
>> [   80.116228] snd-ml403_ac97cr: write access to codec register 0x2a wit=
h
>> bad value 0x3801 / 14337!
>=20
> Completely fine.
>=20
>> # ls -l /dev/snd
>> crw-rw-rw-    1 root     root     116,   0 Jan  1 00:01 controlC0
>> crw-rw-rw-    1 root     root     116,   4 Jan  1 00:01 hwC0D0
>> crw-rw-rw-    1 root     root     116,   5 Jan  1 00:01 hwC0D1
>> crw-rw-rw-    1 root     root     116,   6 Jan  1 00:01 hwC0D2
>> crw-rw-rw-    1 root     root     116,   7 Jan  1 00:01 hwC0D3
>> crw-rw-rw-    1 root     root     116,  24 Jan  1 00:01 pcmC0D0c
>> crw-rw-rw-    1 root     root     116,  16 Jan  1 00:01 pcmC0D0p
>> crw-rw-rw-    1 root     root     116,   1 Jan  1 00:01 seq
>> crw-rw-rw-    1 root     root     116,  33 Jan  1 00:01 timer
>=20
> Ok, should suffice. [In my case snddevices made many other device
> files.]
>=20
>> # aplay -D /dev/snd/pcmC0D0p
>> ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0=
p
>=20
> Well, I think the way you specify the device is wrong. AFAIK the -D
> option only accepts names which are defined in an ALSA configuration
> file (.asoundrc & friends).
> Furthermore: Did you try without any device (without -D option)? The
> defaults should make ALSA pick the first available sound device. At
> least, while I was testing, I didn't have to specify any device.
>=20
> BTW: You need to specify the (.wav) file you want to play:
> # aplay music.wav
> Otherwise you won't here anything ;-). Read "man aplay" !
>=20
>> # ./test_sound.out /dev/snd/pcmC0D0p=20
>> ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM /dev/snd/pcmC0D0=
p
>> cannot open audio device /dev/snd/pcmC0D0p (No such file or directory)
>=20
> Ditto. But I haven't had a look into test_sound source yet, but it might
> be the same issue.
>=20
>  Joachim
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/Re%3A-ml403-ac97-driver=
-tf4164866.html#a11859770
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
