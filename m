Date: Fri, 3 Nov 2000 16:22:51 +0100
From: Claus <cl.en@gmx.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Message-ID: <20001103162250.A367@olis.north.de>
Reply-To: cl.en@gmx.net
References: <19340927090721.10201@192.168.1.2> <Pine.LNX.4.10.10011021740360.31372-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <Pine.LNX.4.10.10011021740360.31372-100000@opal.biophys.uni-duesseldorf.de>; from schmitz@opal.biophys.uni-duesseldorf.de on Thu, Nov 02, 2000 at 18:13:48 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 >:=20
 >: So what should have happened? Crash (panic message), or plain hang?

hi,
just for the record:

I've got the same crash as Albrecht in Sept. with 2.2.18pre4-ben1
and linuxppc2k on my PB3400 without the wakebay app.

Sep 18 00:35:03 apple kernel: Kernel panic: kernel access of bad area pc c0=
0cf34c lr c00cfa88 address 24 tsk
+pmud/297

System.map-2.2.18pre4-ben1:
c00cf218 t idepmac_sleep_device
c00cf334 t idepmac_wake_device
c00cf400 t idepmac_sleep_interface
c00cf4e4 t idepmac_wake_interface
c00cf728 t idepmac_notify_sleep
c00cfab0 T ide_dma_intr
c00cfb8c T ide_build_dmatable

My only solution was to snooze without the cd module.

In the meantime I switched to potato; with the current

15:28@pts/2 ~ > uname -a
Linux apple 2.2.18pre17-ben1 #38 Wed Oct 25 18:51:51 CEST 2000 ppc unknown

now it's something special, that I realized today. A snooze and prompt
wakeup with the cd module inserted seems to hang the entire machine,
but it waits for dma'ing /dev/hdc.
This can last up to _four_ minutes, and I have to wait 'cause nothing
can be written to hda.=20
The message 'system awake again' appears after hdc knows
and reports its dma status.=20

15:29@pts/2 ~ > cat /var/log/messages
<snip>
Nov  3 15:06:28 apple pppd[299]: Exit.
Nov  3 15:07:08 apple kernel: media bay 0 contains a CD-ROM drive
Nov  3 15:07:08 apple kernel: keybdev.c: Removing keyboard: input1
Nov  3 15:07:08 apple kernel: ADB keyboard at 2, handler 1
Nov  3 15:07:08 apple kernel: Detected ADB keyboard, type ISO, swapping key=
s.
Nov  3 15:07:08 apple kernel: keybdev.c: Adding keyboard: input1
Nov  3 15:07:08 apple kernel: event0: Event device for input1
Nov  3 15:07:08 apple kernel: input1: ADB HID on ID 2:2.14
Nov  3 15:07:08 apple kernel: ADB mouse at 3, handler set to 4 (trackpad)
Nov  3 15:07:08 apple kernel: mouse0: PS/2 mouse device for input2
Nov  3 15:07:08 apple kernel: event1: Event device for input2
Nov  3 15:07:08 apple kernel: input2: ADB HID on ID 3:3.01
Nov  3 15:07:08 apple kernel: hda: Enabling MultiWord DMA 2
Nov  3 15:10:48 apple kernel: hdc: Enabling MultiWord DMA 2


15:29@pts/2 ~ > cat /var/log/daemon.log
<snip>
Nov  3 15:07:07 apple pmud[130]: initiating user requested sleep
Nov  3 15:07:07 apple pmud[130]: running /etc/power/pwrctl sleep ac
Nov  3 15:07:07 apple pmud[130]: going to sleep
Nov  3 15:10:48 apple pmud[130]: system awake again
Nov  3 15:10:48 apple pmud[130]: running /etc/power/pwrctl wakeup ac



Regards



		Claus

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline


--d6Gm4EdcadzBjdND--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
