Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 0470BDDE45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 05:26:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Reading and writing from/to VME device
Date: Thu, 29 Mar 2007 12:27:07 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871089691C5@VCAEXCH01.hq.corp.viasat.com>
In-reply-to: <929bf310703290313o234a47f9gbf9c5083fc23e45e@mail.gmail.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Konstantin Boyanov" <kkboyanov@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>But when I try to configure it with outWinCfgADC.zlatedAddrL =3D =
0xA000,
>when I run the programm I get an errno 29 (Invalid argument) from
ioctl().
>In fact if I set the xlatedAddrL to some value smaller that 0x10000 I
get this
>error. Here's my most recent configuration:=20

The VME device driver has an (artificial, as far as I can tell) limit
that rejects window base addresses on an offset less than 0x10000.  You
could change the driver (in drivers/vme/vmedrv.c or vmelinux.c) to
accept a smaller base address offset.  I'm not sure of the reason for
the limit - I don't _think_ the TSI148 has such a limit, but I haven't
looked into it at all.

Tim
