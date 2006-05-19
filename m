Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47C3E679F5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 22:46:44 +1000 (EST)
Received: from [84.135.205.239] (helo=johannes.berg)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.61) (envelope-from <johannes@sipsolutions.net>)
	id 1Fh4NL-0003hV-Of
	for linuxppc-dev@ozlabs.org; Fri, 19 May 2006 13:46:40 +0100
Subject: i2sbus transfer foo
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9BFMAD0Rho3c3KeDPcml"
Date: Fri, 19 May 2006 13:36:52 +0200
Message-Id: <1148038613.15507.193.camel@johannes>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9BFMAD0Rho3c3KeDPcml
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry for the vague subject :) I don't really know what to say...

Let me introduce some things first. First of all, the i2sbus controllers
Apple has in their mac-io chip are capable of doing (among others we
don't care about) 16-bit transfers in 32x and 64x i2s modes, and 24-bit
transfers in 64x i2s mode. For the latter, the chip requires that the
inputs are actually 32-bit aligned, which means that it's a bit weird
that it doesn't actually transfer all the 32 bits. But that's another
issue, maybe there's a way to make it transfer 32 bits that I don't
know. Or maybe it even does and we just don't have a codec capable of
using or creating data in those remaining 8 bits.

Anyway, let's dive right in, here's a sample capture where I was
capturing an 880Hz sine wave generated with gstreamer on another machine
via a direct cable:

00007910  f8 36 48 00 f7 a1 cc 00  f7 a1 cc 00 f7 2e ea 00  |.6H...........=
..|
00007920  f7 2e ea 00 f6 df 58 00  f6 df 58 00 f6 b4 ee 00  |......X...X...=
..|
00007930  f6 b4 ee 00 f6 af 78 00  f6 af 78 00 f6 cf 59 00  |......x...x...=
Y.|

The hexdump above is directly from the DMA memory area, not gone through
alsa, I made a debugfs file that gives me access to the buffer area
straight away.

Let me start arecord again:
$ arecord -r 44100 -f S32_LE -c2 > /tmp/test.wav

Dumping the dma area again yields:
00008680  e4 00 ff bd e4 00 fe 93  22 00 fe 93 22 00 fd 6f  |........"...".=
.o|
00008690  2b 00 fd 6f 2b 00 fc 55  62 00 fc 55 62 00 fb 49  |+..o+..Ub..Ub.=
.I|
000086a0  76 00 fb 49 76 00 fa 52  49 00 fa 52 49 00 f9 71  |v..Iv..RI..RI.=
.q|
000086b0  1f 00 f9 71 1f 00 f8 aa  2c 00 f8 aa 2c 00 f7 ff  |...q....,...,.=
..|
and a 3rd time:
0000ff60  00 07 3a 12 00 06 6f 77  00 06 6f 77 00 05 89 d9  |..:...ow..ow..=
..|
0000ff70  00 05 89 d9 00 04 8e 73  00 04 8e 73 00 03 80 4a  |.......s...s..=
.J|
0000ff80  00 03 80 4a 00 02 64 b0  00 02 64 b0 00 01 3e c0  |...J..d...d...=
>.|
0000ff90  00 01 3e c0 00 00 16 65  00 00 16 65 00 fe ea b6  |..>....e...e..=
..|
4th time it's like 3rd, 5th like first, but 6th time:
0000bc60  e8 39 00 00 13 60 00 00  13 60 00 01 3d 96 00 01  |.9...`...`..=
=3D...|
0000bc70  3d 96 00 02 63 55 00 02  63 55 00 03 7f f5 00 03  |=3D...cU..cU..=
....|
0000bc80  7f f5 00 04 8b 73 00 04  8b 73 00 05 87 84 00 05  |.....s...s....=
..|
0000bc90  87 84 00 06 6d cc 00 06  6d cc 00 07 37 ae 00 07  |....m...m...7.=
..|

See the problem?

When I actually manage to have it aligned like in #3 above,
SNDRV_PCM_FORMAT_S24_BE would be correct. And in that case, I once even
got a nice wav file that audacity can downsample to 16 bit and play
properly. But in all other cases I get mangled sound for obvious
reasons.

The correct data layout seems to be the first though, because when I
transfer that *to* the chip for playback (by making i2sbus announce
32bit big-endian format to alsa) I get proper sound with the correct
volume, hence I just changed i2sbus to always announce 16 and 32-bit BE
formats which also no longer mangles sound with gstreamer (except for
clicking every once a while on some streams[1]).

Oh, and note that those 4 cases aren't all possible cases. If you think
about it you'll notice that there are 8 cases because we have two
channels. I think I even mixed them in the dumps above, not sure.

Some looking at snd-powermac code later I now changed the i2sbus code to
do a dbdma-programmed engine stop in hope that would synchronize (as a
comment in snd-powermac implies) but that doesn't seem to be correct
either. I now more often get the first case though not all the time.

I'm out of ideas. I don't have a clue how to get this thing synchronized
properly. If anyone has a solution let me know, otherwise I'll probably
just disable 24-bit recording for good, then at least the chances of
getting sound that makes sense (even if left and right might be
switched) are 1/2 as opposed to 1/4 assuming even distribution... Also,
the question is why this does not happen on playback, or at least so
much less frequently that I haven't seen it yet...

johannes

[1] only happens with gstreamer on some streams, and then only if I use
alsasink without giving it the latency-time option, even if I give it
the default it doesn't click. very strange.

--=-9BFMAD0Rho3c3KeDPcml
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG2t06Vg1VMiehFYAQK/PBAAnj/EcTctP9Wp5GbRxGHLnMvpd6QOls40
dLOlPlxnjqFkXKaV12TRyb72s7moFiRAAmQjo9rGTj6ifJJhibroVZVRmtf7nay1
gZuf1uHfZEQ1iIMaBsmDr+jtkHYq41zdmVhQEemChmKTQungxj2l+rsqUaPNoQmS
f6DWc7JHKeHdLXn7TTeQ2AzNGTR5l2w9gFejsIWbr+7g2hsSrFb5MwIOJe/Jywe2
ET0TugVRf0pyhdyw2BPlgthxLEMXs0lzXBkhEz8vB24JLjbLq/1KYkGzIfZJC/jE
SOQY0dLmebgl0Nc1zKrUmhVdb7Um8tQabuTG198vkoO5HEIX5ksEZkn4cHwFTEYP
JiG9AFsZVXSAAm4PXMTN9lUYrTcczahjwva+DPdE54LVVLhU2TUJRJT3RUTWvuqo
wUb/Om7IO0IcmFdigx4zvuGyqzD4s+7cXUcxvrq3BYPy51bYN8AB9z39Xl9S40mB
DKHp/Z1LeDrXBrCE+3TJmMT46kaTY56bvsmGQEL/Y45UUYYHwNUwZmnlhyYWAGoh
wd0I2oBWgxU2M+JLccomS/zYz/th2HikM13v0vTO3L/VMs73B0/I2/bCQABu01vt
Pcj96vGnDVRNFxKeJpjLviHnN6sZQelDK2GBE0P+VaFfsqzb4NTq2ByLyPGqpPf3
NL0ep6ZIvvg=
=o86k
-----END PGP SIGNATURE-----

--=-9BFMAD0Rho3c3KeDPcml--
