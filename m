Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id C7B6367BAB
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 22:44:41 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Sat, 9 Dec 2006 12:44:05 +0100
References: <20061207172259.64168f8c@localhost>
	<200612090100.09380.arnd@arndb.de> <4579FE4F.8000206@acm.org>
In-Reply-To: <4579FE4F.8000206@acm.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612091244.05862.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 December 2006 01:07, Corey Minyard wrote:
> > I think the current representation is perfect. AFAICS, there are always
> > two registers, but depending on the HW implementation, they may be
> > between 1 and 4 bytes wide, and can have a different spacing.
> > =A0=20
> The BT and SMIC interfaces have three registers. =A0Does that break thing=
s?
>=20
It should still work, but I have to admit that at this point it gets ugly.

How about defining the properties just like the driver expects them:

reg <size> <len>:	the area spanning all registers (2 or three)
reg-spacing <number>:	offset of the start of each register (default 1)
reg-size <number>:	length of each register (1, 2, or 4, default 1)
reg-shift <number>:	bit-position of the data inside the register
			(default 0).

	Arnd <><
