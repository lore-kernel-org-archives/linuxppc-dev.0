Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4CA52C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:14:07 +1000 (EST)
Received: from mail161-tx2 (localhost [127.0.0.1])	by
 mail161-tx2-R.bigfish.com (Postfix) with ESMTP id 520C2E012A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:14:03 +0000 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.235])	by
 mail161-tx2.bigfish.com (Postfix) with ESMTP id 7EF94180051	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:14:00 +0000 (UTC)
Date: Fri, 14 Jun 2013 17:13:54 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] powerpc/fsl_msi: add 'msiregs' kernel parameter
To: Minghuan Lian <Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-5-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-5-git-send-email-Minghuan.Lian@freescale.com>
 (from Minghuan.Lian@freescale.com on Fri Jun 14 02:15:59 2013)
Message-ID: <1371248034.2996.18@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 02:15:59 AM, Minghuan Lian wrote:
> 1. Only MSIIR1 can index 16 MSI registers, but when using MSIIR1
> the IRQs of a register are not continuous. for example, the first
> register irq values are 0x0, 0x10, 0x20, 0x30 ... 0x1f0. So it
> is hard to use 'msi-available-ranges' property to indicate the
> available ranges and 'msi-available-ranges' property has been
> removed from dts node, so this patch removes the related code.
>=20
> 2. Add 'msiregs' kernel parameter instead of 'msi-available-ranges'
> functionality.

The reason we used a device tree property was because this is for =20
virtualization and AMP scenarios where this instance of Linux does not =20
own all of the MSI registers.

I don't see any reasonable way to partition an MPIC v4.3 MSI group -- =20
but there are more groups, so it's not that bad.  What's the use case =20
for this patch?

-Scott=
