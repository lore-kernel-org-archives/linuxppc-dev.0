Return-Path: <moisesdm82@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id CD1981007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 01:43:04 +1000 (EST)
Received: by ewy21 with SMTP id 21so141411ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 08:43:01 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 23 Jul 2010 17:43:01 +0200
Message-ID: <AANLkTi=nzrL8jori7ju67Pp9ehp6if=H76i0o0X9MNsw@mail.gmail.com>
Subject: problems flashing custom board
From: moises dominguez <moisesdm82@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174bde1ccecc4e048c0fe391
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174bde1ccecc4e048c0fe391
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am having problems programming u-boot(from ltib) in ads5121 based custom
board with CodeWarrior USB TAP(sector not erased). I hope you could help me.

Instead of 64 MB NOR flash(2xS29-GL256P) I am using a 16 MB (S29-GL128P) in
muxed-mode. I have choosen 5121ADS_init_sram_flash.cfg as base file, and
modified flash size and configuration on this way:
..
- writemem.l 0x80000020 0xfc00fcff     // CS0 from 0xfc00_0000 to
0xfcff_ffff, 16 MB flash
- writemem.l 0x80010000 0x05059110 //16 bit data, muxed mode
...

I have doubts about RST_CONF_LOC and RST_CONF_BMS; afaik, this two bits
select where u-boot should be programed, am I wrong? but, according
RST_CONF_BMS description there are only two boot start possible address for
CS0:
- 0x0000_0000 if BMS=0
- 0XFFF0_0000 if BMS=1 (as in eval. board).

But, if I map my flash to 0xfc00_0000.. it does not reach oxfff0_0000.. I
tried to map it to 0x0000_0000 (where SRAM is according cfg) and SRAM to
0xfc00_0000 but  I got : flash ID error (as if flash driver could not be
loaded?) Can u-boot be programed to any flash position? and .. can SRAM not
be mapped to any position different to cero?

I read too that we should change TEXT_BASE u-boot macro. I changed it to
0xFC00_0000 that is where I want to have u-boot.. but no success.

Regards,

Moises.

--0015174bde1ccecc4e048c0fe391
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am having problems programming u-boot(from ltib) in ads5121 ba=
sed custom board with CodeWarrior USB TAP(sector not erased). I hope you co=
uld help me.<br><br>Instead of 64 MB NOR flash(2xS29-GL256P) I am using a 1=
6 MB (S29-GL128P) in muxed-mode. I have choosen 5121ADS_init_sram_flash.cfg=
 as base file, and modified flash size and configuration on this way:<br>
..<br>
- writemem.l 0x80000020 0xfc00fcff=A0=A0=A0=A0 // CS0 from 0xfc00_0000 to 0=
xfcff_ffff, 16 MB flash<br>- writemem.l 0x80010000 0x05059110 //16 bit data=
, muxed mode<br>...<br><br>I have doubts about RST_CONF_LOC and RST_CONF_BM=
S; afaik, this two bits select where u-boot should be programed, am I wrong=
? but, according RST_CONF_BMS description there are only two boot start pos=
sible address for CS0:<br>
- 0x0000_0000 if BMS=3D0<br>- 0XFFF0_0000 if BMS=3D1 (as in eval. board).<b=
r><br>But, if I map my flash to 0xfc00_0000.. it does not reach oxfff0_0000=
.. I tried to map it to 0x0000_0000 (where SRAM is according cfg) and SRAM =
to 0xfc00_0000 but=A0 I got : flash ID error (as if flash driver could not =
be loaded?) Can u-boot be programed to any flash position? and .. can SRAM =
not be mapped to any position different to cero?<br>
<br>I read too that we should change TEXT_BASE u-boot macro. I changed it t=
o 0xFC00_0000 that is where I want to have u-boot.. but no success.<br><br>=
Regards,<br><br>Moises.<br><br><br>

--0015174bde1ccecc4e048c0fe391--
