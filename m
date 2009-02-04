Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id DD83CDDEFF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 01:04:44 +1100 (EST)
Message-ID: <4989A075.9090906@gersys.de>
Date: Wed, 04 Feb 2009 15:04:37 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: ADS5121 problem using audio interface
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I'm trying to get the audio interface working on my ADS5121 Rev4.0 and
have some questions.

I did manage to record and play audio files of type raw and format
S32_BE like this:

$ arecord -traw -c2 -fS32_BE -Dhw:0,0 testfile
$ aplay -traw -c2 -fS32_BE -Dhw:0,0 testfile

I am not able to get the auto conversion work, so that I could play a
wav file of any format. I'm getting this error:

$ aplay -Dplughw:0,0 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find
an usable access for 'plughw:0,0'
aplay: set_params:901: Sample format non available

I'm not sure, but I expect this to be a problem of my ALSA configuration
and this is where I'm stuck.
Does anyone have a working ALSA configuration file for the ads5121?
Or any other hints on how to overcome this problem?
Does anyone know how to convert wav files so that they can be played in
raw mode?

Many thanks
Stefan.

-----
These are the steps I performed to get audio work:

I'm using kernel 2.6.24.6 (linux-2.6-denx.git/ads5121) with ALSA-1.0.15
built into the kernel and ELDK-4.2.

1. Build and install alsa-lib-1.0.15 and alsa-utils-1.0.15 natively on
the target.

$ wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.15.tar.bz2
$ tar xf alsa-lib-1.0.15.tar.bz2
$ cd alsa-lib-1.0.15
$ ./configure
$ make
$ make install

$ wget ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.0.15.tar.bz2
$ tar xf alsa-utils-1.0.15.tar.bz2
$ cd alsa-utils-1.0.15
$ ./configure --disable-nls
$ make
$ make install

2. Manually create the device nodes, with Minor numbers according to
output from /proc/asound/devices

$ cat /proc/asound/devices
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

$ mkdir /dev/snd
$ mknod /dev/snd/pcmC0D0p c 116 16
$ mknod /dev/snd/pcmC0D0c c 116 24
$ mknod /dev/snd/controlC0 c 116 0
$ mknod /dev/snd/timer c 116 33
$ mknod /dev/snd/seq c 116 1

3. Run aplay...

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ADS [MPC5121 ADS], device 0: AC97 AC97 HiFi-<NULL>-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ aplay -L
default:CARD=ADS
    MPC5121 ADS,
    Default Audio Device
null
    Discard all samples (playback) or generate zero samples (capture)

$ aplay -traw -c2 -fS32_BE -Dhw:0,0 /dev/urandom
$ arecord -traw -c2 -fS32_BE -Dhw:0,0 testfile
$ aplay -traw -c2 -fS32_BE -Dhw:0,0 testfile
