Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4927F67C0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 04:09:09 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: data transfer limit using ioctl()?
Date: Wed, 13 Dec 2006 18:09:02 +0100
References: <297583.85646.qm@web36607.mail.mud.yahoo.com>
In-Reply-To: <297583.85646.qm@web36607.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612131809.03365.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 13 December 2006 10:24, Parav Pandit wrote:
> =A0 How much maximum data transfer should be done using ioctl() to driver?

No, there is no technical limit. Usually, it's considered good style
to transfer only a basic data type with fixed length though, like uint32_t
or loff_t, not a long buffer. You should also make sure you have a fixed
length buffer, and that it's the same size on 32 and 64 bit kernels.

=46or long non-structured transfers, use read/write operations if possible.

> =A0 I can also use the Netlink sockets to transfer data from user to kern=
el.
> =A0 Is there any limit that we should consider for choosing ioctl() to dr=
iver or using netlink sockets?
> =A0 =A0
No, that decision does not depend on the data size mostly, but more on
what you want to do.

	Arnd <><
