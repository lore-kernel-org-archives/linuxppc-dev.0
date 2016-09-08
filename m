Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVFrC4cN0zDsTX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 19:47:55 +1000 (AEST)
In-Reply-To: <1471993059-19239-1-git-send-email-bauerman@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: powerpc: Fix build of 64 bit little endian with CONFIG_KEXEC=n
Message-Id: <3sVFrC3mwzz9s9N@ozlabs.org>
Date: Thu,  8 Sep 2016 19:47:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-23-08 at 22:57:39 UTC, Thiago Jung Bauermann wrote:
> On ppc64le, builds with CONFIG_KEXEC=n fail with:
> 
> arch/powerpc/platforms/pseries/setup.c: In function ‘pseries_big_endian_exceptions’:
> arch/powerpc/platforms/pseries/setup.c:403:13: error: implicit
> declaration of function ‘kdump_in_progress’ [-Werror=implicit-function-declaration]
>   if (rc && !kdump_in_progress())
> 
> This is because pseries/setup.c includes <linux/kexec.h>, but
> kdump_in_progress is defined in <asm/kexec.h>. This is a problem because
> the former only includes the latter if CONFIG_KEXEC_CORE=y.
> 
> Fix by including <asm/kexec.h> directly, as is done in powernv/setup.c.
> 
> Fixes: d3cbff1b5a90 ("powerpc: Put exception configuration in a common place")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d81d8258218228d3137055afe8

cheers
