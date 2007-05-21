Return-Path: <monodhs@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E2D5CDDE07
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 10:05:45 +1000 (EST)
Message-ID: <4650E27B.3020401@gmx.de>
Date: Mon, 21 May 2007 02:06:19 +0200
From: =?UTF-8?B?Q2hyaXN0aWFuIELDtmhtZQ==?= <monodhs@gmx.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Interrupt routing broken on TiBook IV with 2.6.21.x ?
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

With the availability of the stable 2.6.21.x kernels I recently started to
move over from OSS to ALSA for audio I/O.  Along with that move came the
surprise that not the simplest audio output works anymore (actually, this
was the case with the stable 2.6.20.x kernels and OSS already which I
therefore opted to avoid).

The problem I ran into is that no matter which application (speaker-test,
aplay, xmms, gxine) using either the native ALSA API or via the OSS
compatibility layer, none of these is able to sustain audio output for
more than 7 seconds.  In fact, most attempts max out at statistically one
second (with many even shorter than that).  After the signal at the output
jack died, the application appears to be blocking forever (it does not spin)
with no signs of ending its output.

I initially presented this problem on alsa-user@lists.sourceforge.net where
someone suggested that it might actually be caused by (broken) interrupt
routing for the built-in audio device.  This assumption may be supported
by the observation that once the sound previously produced by the application
(speaker-test in the simplest case) stopped being sent through the output
jack, no increase in the interrupt counter occurs.

An example output of /proc/interrupts on my machine looks like this (why
eth0 does not show up in this listing is beyond me):

            CPU0
  19:      39005   MPIC 1    Level     ide0
  20:         34   MPIC 1    Level     ide1
  25:     151785   MPIC 1    Level     VIA-PMU
  26:        131   MPIC 1    Level     keywest i2c
  27:          1   MPIC 1    Level     ohci_hcd:usb1
  28:          1   MPIC 1    Level     ohci_hcd:usb2
  30:        197   MPIC 1    Edge      PMac Output
  31:          1   MPIC 1    Edge      PMac Input
  40:          2   MPIC 1    Level     ohci1394
  42:          0   MPIC 1    Level     keywest i2c
  47:       7682   MPIC 1    Level     GPIO1 ADB
  48:      39571   MPIC 1    Level     radeon@pci:0000:00:10.0
  57:          0   MPIC 1    Level     eth1
  58:          1   MPIC 1    Level     yenta
  61:          1   MPIC 1    Edge      Sound Headphone Detection
BAD:          0


Has anyone any idea what causes the audio output to die prematurely ?


Cheers,
Christian
