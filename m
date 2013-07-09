Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83A3A2C0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 09:48:47 +1000 (EST)
Received: from mail79-co1 (localhost [127.0.0.1])	by mail79-co1-R.bigfish.com
 (Postfix) with ESMTP id 53E99B403C0	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Jul 2013 23:48:42 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.230])	by
 mail79-co1.bigfish.com (Postfix) with ESMTP id CBD5138004D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 23:48:41 +0000 (UTC)
Date: Tue, 9 Jul 2013 18:48:35 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Update compilation flags with core specific options
To: Catalin Udma <catalin.udma@freescale.com>
References: <1372764004-18896-1-git-send-email-catalin.udma@freescale.com>
In-Reply-To: <1372764004-18896-1-git-send-email-catalin.udma@freescale.com>
 (from catalin.udma@freescale.com on Tue Jul  2 06:20:04 2013)
Message-ID: <1373413715.8183.210@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 06:20:04 AM, Catalin Udma wrote:
> If CONFIG_E500 is enabled, the compilation flags are updated
> specifying the target core -mcpu=3De5500/e500mc/8540
> Also remove -Wa,-me500, being incompatible with -mcpu=3De5500/e6500
> The assembler option is redundant if the -mcpu=3D flag is set.
> The patch fixes the kernel compilation problem for e5500/e6500
> when using gcc option -mcpu=3De5500/e6500.

Another reason to do this is that currently, the assembler is replacing =20
lwsync with sync on 64-bit kernels (it doesn't happen on 32-bit because =20
we generate the lwsync at runtime) due to the -Wa,-me500.

-Scott=
