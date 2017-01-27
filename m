Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8frs1X5JzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:33:01 +1100 (AEDT)
In-Reply-To: <497a1d88a93.7082e0e9@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Pat Wall <pjwall@mac.com>, rtd@a-eon.com, aperez@alexperez.com,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: powerpc: Add missing error check to prom_find_boot_cpu()
Message-Id: <3v8frs0RLyz9t1B@ozlabs.org>
Date: Fri, 27 Jan 2017 11:33:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-23 at 19:42:54 UTC, Darren Stevens wrote:
> prom_init.c calls 'instance-to-package' twice, but the return
> is not checked during prom_find_boot_cpu(). The result is then
> passed to prom_getprop, which could be PROM_ERROR.
> Add a return check to prevent this.
> 
> This was found on a pasemi system, where CFE doesn't have a working
> 'instance-to package' prom call.
> Before Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') the
> area around addr 0 as mostly 0's and this doesn't cause a problem.
> Once the macro 'FIXUP_ENDIAN' has been added to head_64.S, the low
> memory area now has non-zero values, which cause the prom_getprop
> call to hang.
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/af2b7fa17eb92e52b65f96604448ff

cheers
