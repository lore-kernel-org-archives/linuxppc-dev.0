Return-Path: <jhuwig@intec-isdn.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 665C92BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Dec 2004 19:41:38 +1100 (EST)
Received: from [212.227.126.160] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CZQ3M-0006CL-00
	for linuxppc-embedded@ozlabs.org; Wed, 01 Dec 2004 09:41:36 +0100
Received: from [80.135.68.198] (helo=intec-isdn.de)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CZQ3L-0006O0-00
	for linuxppc-embedded@ozlabs.org; Wed, 01 Dec 2004 09:41:35 +0100
Received: from joerg (192.168.4.32)
	by intec-isdn.de with MERCUR Mailserver (v4.02.30 ODAtMjMwNS00MzY0)
	for <linuxppc-embedded@ozlabs.org>; Wed, 1 Dec 2004 09:39:58 +0100
From: =?iso-8859-1?Q?J=F6rg_Huwig?= <jhuwig@intec-isdn.de>
To: <wd@denx.de>
Date: Wed, 1 Dec 2004 09:44:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20041130162456.5D24AC1430@atlas.denx.de>
Message-Id: <0412010939587000@intec-isdn.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB driver for ISP1362 very slow 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

I tried different USB memory sticks but the result was always the same.
Also there were no error messages in the log file.=20

After trying to understand the driver, I found two defines which seem to =
be
responsible for the slow transmission.

In     hcd-1161.c: #define ATL_DONE_DELAY   10
and in hcd-1161.h: #define ATL_BLOCK_SZ     64

with this defines the host controller handles every 11 ms one 64Byte ATL
block, which of cause is very slow.=20

I have changed the ALT_BLOCK_SZ from 64 to 512 and reduced the=20
ATL_DONE_DELAY from 10 to 2. With this changes the driver works much =
faster.

Is it OK to change these constants in that way or could this cause =
trouble?


Best regards,

Joerg Huwig






-----Urspr=FCngliche Nachricht-----
Von: wd@denx.de [mailto:wd@denx.de]=20
Gesendet: Dienstag, 30. November 2004 17:25
An: J=F6rg Huwig
Cc: Linuxppc-embedded@ozlabs.org
Betreff: Re: USB driver for ISP1362 very slow=20

Hello,

in message <04113016200014900@intec-isdn.de> you wrote:
>=20
> I'm using an ISP1362 as an USB host controller connected to a MPC880=20
> running under Linux 2.4.25.
> The Driver seems to work fine as I can mount an USB memory stick.=20
> But the performance is very bad. To copy a 1MByte big file from the=20
> USB memory stick to the RAM disk takes about 3 minutes.

Are there any error messages in the log files? Did  you  try  another =
USB
memory stick, especially any USB 2.0 stick?

> Does anyone has experience with the ISP1362 driver in Kernel 2.4.25??

Sure. We implemented it and tested it with mass storage devices,  USB
modems, network adapters and in combination with RNDIS on Windoze.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de "I
find this a nice feature but it is not according to  the  documen-
tation. Or is it a BUG?"   "Let's call it an accidental feature. :-)"
                       - Larry Wall in <6909@jpl-devvax.JPL.NASA.GOV>
