Return-Path: <ken@kenmoffat.uklinux.net>
Received: from ppgpenguin.kenmoffat.uklinux.net
	(spc2-brig1-3-0-cust232.asfd.broadband.ntl.com [82.1.142.232])
	by ozlabs.org (Postfix) with ESMTP id D2B2A67A46
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 12:23:04 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by ppgpenguin.kenmoffat.uklinux.net (Postfix) with ESMTP id F008D146DF
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 01:01:40 +0000 (GMT)
Date: Fri, 4 Mar 2005 01:01:40 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.58.0503040042380.20574@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Subject: Is emu10k1 broken in ppc ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 First noticed this earlier this week, trying to upgrade my iBook from
2.6.8 to 2.6.11-rc5, using a debian config.  At that point, it didn't
seem important to me.  Bit me again tonight when I tried to get my
AmigaOne up to 2.6.10 from 2.6.9 using my existing config.  The case
labels are SNDRV_EMU10K1_CODE_POKE and SNDRV_EMU10K1_CODE_PEEK, neither
the header nor the code changed between 2.6.9 and 2.6.10.

sound/pci/emu10k1/emufx.c: In function `snd_emu10k1_fx8010_ioctl':
sound/pci/emu10k1/emufx.c:2055: error: case label does not reduce to an int=
eger constant
sound/pci/emu10k1/emufx.c:2068: error: case label does not reduce to an int=
eger constant
make[3]: *** [sound/pci/emu10k1/emufx.o] Error 1
make[2]: *** [sound/pci/emu10k1] Error 2
make[1]: *** [sound/pci] Error 2
make: *** [sound] Error 2

Any clues, please ?  Definitions from emu10k1.h are

#define SNDRV_EMU10K1_IOCTL_CODE_POKE=09_IOW ('H', 0x11, emu10k1_fx8010_cod=
e_t)
#define SNDRV_EMU10K1_IOCTL_CODE_PEEK=09_IOWR('H', 0x12, emu10k1_fx8010_cod=
e_t)

Ken
--=20
 das eine Mal als Trag=F6die, das andere Mal als Farce
