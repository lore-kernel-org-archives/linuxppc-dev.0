Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7BE1B71D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 06:36:02 +1100 (EST)
Received: from mail141-va3 (localhost.localdomain [127.0.0.1])	by
	mail141-va3-R.bigfish.com (Postfix) with ESMTP id 7DB9ABB81C8	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 19:35:56 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.236])	by
	mail141-va3.bigfish.com (Postfix) with ESMTP id 3A82568004D	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 19:35:56 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id oAIJZpff016958	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 12:35:51 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAIJZobn006889	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 13:35:50 -0600 (CST)
Date: Thu, 18 Nov 2010 13:35:49 -0600
From: Scott Wood <scottwood@freescale.com>
To: <steven.lin@teradyne.com>
Subject: Re: application needs fast access to physical memory
Message-ID: <20101118133549.1c6d2cc3@udp111988uds.am.freescale.net>
In-Reply-To: <OF313AFE4A.0F7F91F0-ON882577DF.0057B647-862577DF.005CF920@notes.teradyne.com>
References: <20101118125425.GE7256@yookeroo>
	<OF313AFE4A.0F7F91F0-ON882577DF.0057B647-862577DF.005CF920@notes.teradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Nov 2010 10:55:21 -0600
<steven.lin@teradyne.com> wrote:

> Thanks for the replies.
>=20
> In the Linux Device Drivers book regarding mmap(), it states:
>=20
>    Mapping a device means associating a range of user-space addresses to
>    device memory.
>    Whenever the program reads or writes in the assigned address range, it
>    is actually
>    accessing the device. In the X server example, using mmap allows quick
>    and easy
>    access to the video card=E2=80=99s memory. For a performance-critical
>    application like this,
>    direct access makes a large difference.
>=20
> For whatever reason, mmap() is definitely not quick and does not appear to
> be a direct access to device memory. After the application completes a
> large write into physical memory (via the pointer returned from mmap()),
> the application performs an ioctl() to query whether the data actually
> arrived into the memory region. It seems to take some time before the
> associated kernel module actually "sees" the data in the physical memory
> region.
>=20
> There's a few things I should say about this memory region. There's a tot=
al
> of 512 MB of physical memory. U-Boot passes "mem=3D256M" as a kernel
> parameter to tell Linux to only directly manage the lower 256 MB. The
> special region of physical memory that the application is trying to access
> is the upper 256 MB of memory not directly managed by Linux. The mmap()
> call from the application is:
>    *memptr =3D (void *) mmap( NULL, size, PROT_READ | PROT_WRITE, MAP_SHA=
RED,
>    _fdTerAlloc, (off_t) 0x10000000);

Try this patch:
http://patchwork.ozlabs.org/patch/68246/

-Scott
