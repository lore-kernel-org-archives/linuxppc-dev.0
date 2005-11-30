Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id C9BDC6884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 20:34:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 30 Nov 2005 10:33:25 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2EFC@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <zengshuai@sogou.com>, "ppc" <linuxppc-embedded@ozlabs.org>
Subject: RE: linuxppc-embedded help needed:kernel access of bad area
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear zengshuai,

zengshuai@sogou.com wrote:
> i writed a led driver for PQ2FADS(a ppc board).
> but i can't read/write 0x04500000 where led register addr locate in.
> i tested two ways to do that.
> first,
> p=3D0x04500000;
> *p=3D0x12;
> ....
> second,
> outb(0x12,0x04500000);
> ...
> two ways both didn't work.they had a some wrong:kernel access of bad
area.
> how can i know which area is bad area or good area?
> and what can i do next? thanks.

Do yourself a favor, read a book about Linux device driver development,
for example one listed[1] in the excellent Denx's DLUG FAQ[2].
Getting some training on PowerPC development is a good idea too.
[1] http://www.denx.de/wiki/view/DULG/MoreInformationBooks
[2] http://www.denx.de/wiki/DULG/Manual

Peruse also your chip data-sheet, and you will see that outb() is
non-sense.

If you are accessing the led register from kernel space, you'll find
a solution using ioremap(). Otherwise, if you are accessing the led
register
from user space, this link[3] will help you, or this shorter one[4].
You can follow this thread[5] for more information.

[3]
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
[4] http://tinyurl.com/6c7th
[5] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html

Please next time, do ourselves a favor, try some searching first
(google,=20
whatever). Your question is a FAQ.

Regards,
--=20
Stephane
