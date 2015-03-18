Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CA751A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 16:19:40 +1100 (AEDT)
In-Reply-To: <20150315220847.1ecfe174@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv3] powerpc: convert relocs_check to a shell script using
 grep
Message-Id: <20150318051940.238AC14011D@ozlabs.org>
Date: Wed, 18 Mar 2015 16:19:40 +1100 (AEDT)
Cc: Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@ACULAB.COM>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-15-03 at 11:08:47 UTC, Stephen Rothwell wrote:
> This runs a bit faster and removes another use of perl from
> the kernel build.

It tells me:

$ make ARCH=powerpc CROSS_COMPILE= -s ppc64_defconfig
#
# configuration written to .config
#
$ make ARCH=powerpc CROSS_COMPILE= -s -j240 
...
arch/powerpc/relocs_check.sh: objdump (objdump) is not executable
make: *** [relocs_check] Error 1

I suspect because:

+if [ ! -x "$objdump" ]; then

Doesn't search the PATH.

cheers
