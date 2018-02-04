Return-Path: <srs0=tlxh=e6=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZ7yK3xS7zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zZ7yK1fYlz8t5N
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 22:38:17 +1100 (AEDT)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zZ7yJ0xsvz9t50
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2018 22:38:15 +1100 (AEDT)
Date: Sun, 4 Feb 2018 12:00:39 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4.4 backport 11/16] powerpc/64s: Add support for RFI
 flush of L1-D cache
Message-ID: <20180204110039.GH7519@kroah.com>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
 <20180204050010.13669-12-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180204050010.13669-12-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 04, 2018 at 04:00:05PM +1100, Michael Ellerman wrote:
> commit aa8a5e0062ac940f7659394f4817c948dc8c0667 upstream.
> 
> On some CPUs we can prevent the Meltdown vulnerability by flushing the
> L1-D cache on exit from kernel to user mode, and from hypervisor to
> guest.
> 
> This is known to be the case on at least Power7, Power8 and Power9. At
> this time we do not know the status of the vulnerability on other CPUs
> such as the 970 (Apple G5), pasemi CPUs (AmigaOne X1000) or Freescale
> CPUs. As more information comes to light we can enable this, or other
> mechanisms on those CPUs.
> 
> The vulnerability occurs when the load of an architecturally
> inaccessible memory region (eg. userspace load of kernel memory) is
> speculatively executed to the point where its result can influence the
> address of a subsequent speculatively executed load.
> 
> In order for that to happen, the first load must hit in the L1,
> because before the load is sent to the L2 the permission check is
> performed. Therefore if no kernel addresses hit in the L1 the
> vulnerability can not occur. We can ensure that is the case by
> flushing the L1 whenever we return to userspace. Similarly for
> hypervisor vs guest.
> 
> In order to flush the L1-D cache on exit, we add a section of nops at
> each (h)rfi location that returns to a lower privileged context, and
> patch that with some sequence. Newer firmwares are able to advertise
> to us that there is a special nop instruction that flushes the L1-D.
> If we do not see that advertised, we fall back to doing a displacement
> flush in software.
> 
> For guest kernels we support migration between some CPU versions, and
> different CPUs may use different flush instructions. So that we are
> prepared to migrate to a machine with a different flush instruction
> activated, we may have to patch more than one flush instruction at
> boot if the hypervisor tells us to.
> 
> In the end this patch is mostly the work of Nicholas Piggin and
> Michael Ellerman. However a cast of thousands contributed to analysis
> of the issue, earlier versions of the patch, back ports testing etc.
> Many thanks to all of them.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [Balbir - back ported to stable with changes]
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Also applied to 4.9.y
