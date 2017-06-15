Return-Path: <srs0=2tch=5u=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpL1X4rZQzDqLf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 20:52:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wpL1X3j0Fz8sv5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 20:52:32 +1000 (AEST)
Message-ID: <1497523944.2897.71.camel@kernel.crashing.org>
Subject: Re: [PATCH] Revert "powerpc: Handle simultaneous interrupts at once"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Thu, 15 Jun 2017 20:52:24 +1000
In-Reply-To: <1497508135-7016-1-git-send-email-mpe@ellerman.id.au>
References: <1497508135-7016-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 16:28 +1000, Michael Ellerman wrote:
> This reverts commit 45cb08f4791ce6a15c54598b4cb73db4b4b8294f.
> 
> For some reason this is causing IRQ problems on Freescale Book3E
> machines, eg on my p5020ds:

This looks like a driver bug.... it could be that you get hammered by
an interrupt, and get away with it because by chance the CPU lets you
go through one or two instructions before firing again, while here we
just take them in a loop.

I suspect a bug in that fsl_ebc driver.

Cheers,
Ben.
