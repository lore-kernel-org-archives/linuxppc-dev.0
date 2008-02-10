Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4C2A0DDEB7
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 13:46:08 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: of_iomap and request_mem_region
Date: Sun, 10 Feb 2008 03:45:54 +0100
References: <9e4733910802091838x3e596debj113089faef08c1c8@mail.gmail.com>
In-Reply-To: <9e4733910802091838x3e596debj113089faef08c1c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802100345.54580.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 10 February 2008, Jon Smirl wrote:
> of_iomap doesn't implicitly do a request_mem_region(). =A0How should
> request_mem_region() be handled? When using of_iomap you don't get the
> length of the region back so it isn't easy to call request_mem_region.
>=20
> What about adding a third param to of_iomap for the driver name? If it
> is non-null also do the request region. If it is null check to make
> sure the region has already be requested.

I'd prefer changing of_iomap so that it gets the of_device instead of
the device_node. That would help us do two changes at once:

1. call request_mem_region using dev->driver->name, as you mentioned.
2. use managed registrations, as lib/devres.c does e.g. in pcim_iomap,
so that we can kill all the calls to iounmap in the cleanup path
of OF drivers.

maybe we can do a new ofm_iomap interface first, and then move
drivers over to use that one.

	Arnd <><
