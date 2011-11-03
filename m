Return-Path: <B11780@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A28E4B6F87
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 05:59:14 +1100 (EST)
Received: from mail12-am1 (localhost.localdomain [127.0.0.1])	by
 mail12-am1-R.bigfish.com (Postfix) with ESMTP id 9651D7F83A4	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 18:59:03 +0000 (UTC)
Received: from AM1EHSMHS018.bigfish.com (unknown [10.3.201.243])	by
 mail12-am1.bigfish.com (Postfix) with ESMTP id 18890A7804D	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 18:59:03 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on Freescale
 reference boards
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1320346215-21024-1-git-send-email-timur@freescale.com>
Date: Thu, 3 Nov 2011 13:58:57 -0500
Message-ID: <C957F668-1C3A-40CB-9505-27B4D6966751@freescale.com>
References: <1320346215-21024-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2011, at 1:50 PM, Timur Tabi wrote:

> Kconfig option PHYS_64BIT sets the size of phys_addr_t to 64 bits, =
which
> allows support for a 36-bit physical address space.  With this option, =
the
> kernel can support more than 2GB of RAM, but the larger address size
> impacts performance slightly.
>=20
> By including "select PHYS_64BIT" in the Kconfig for a particular =
board,
> that option is forced enabled, and it becomes impossible to create a =
32-bit
> kernel.  Instead, we should depend on the defconfig to enable this =
option.
> We still build a 36-bit kernel by default, and we also allow users to =
build
> 32-bit kernels if they really want.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/corenet32_smp_defconfig |    1 +
> arch/powerpc/platforms/85xx/Kconfig          |    5 -----
> 2 files changed, 1 insertions(+), 5 deletions(-)

Nak.  For certain boards like P204x-P50xx we only support a 36-bit =
address map.

- k=
