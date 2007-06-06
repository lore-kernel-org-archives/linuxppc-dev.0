Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 193FBDDF0F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:39:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 00:39:51 +0200
References: <1181147415.5674.108.camel@rhino>
In-Reply-To: <1181147415.5674.108.camel@rhino>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706070039.51541.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 June 2007, Wade Farnsworth wrote:
> +=A0=A0=A0=A0=A0=A0=A0/* LPC47M192 Super I/O configuration */
> +=A0=A0=A0=A0=A0=A0=A0outb(0x55, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* enter supe=
rio config mode */
> +
> +=A0=A0=A0=A0=A0=A0=A0/* Enable keyboard and mouse */
> +=A0=A0=A0=A0=A0=A0=A0outb(0x07, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* device sel=
ector register */
> +=A0=A0=A0=A0=A0=A0=A0outb(0x07, 0x4f);=A0=A0=A0=A0=A0=A0=A0/* select key=
board registers (device 7) */
> +=A0=A0=A0=A0=A0=A0=A0outb(0x30, 0x4e);=A0=A0=A0=A0=A0=A0=A0/* keyboard a=
ctivation register */
> +=A0=A0=A0=A0=A0=A0=A0outb(0x01, 0x4f);=A0=A0=A0=A0=A0=A0=A0/* activate k=
eyboard */

Hardcoded I/O port numbers always worry me a little. I know that this is
supposed to work in general, but can't you read the I/O port range from
a device tree property?

	Arnd <><
