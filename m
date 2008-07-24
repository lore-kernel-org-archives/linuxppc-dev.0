Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-banded.atl.sa.earthlink.net
	(elasmtp-banded.atl.sa.earthlink.net [209.86.89.70])
	by ozlabs.org (Postfix) with ESMTP id 0301BDE1DB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:17:34 +1000 (EST)
Message-ID: <48890D8A.5040001@mindspring.com>
Date: Thu, 24 Jul 2008 19:17:30 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: kniht@linux.vnet.ibm.com
Subject: Re: link failure: file truncated
References: <48890B3B.8060806@us.ibm.com>
In-Reply-To: <48890B3B.8060806@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Tollefson wrote:
> Just tried to build the latest version from Linus' tree and I am getting
> a link error.
> 
> building with the pseries_defconfig
> 
> ...
>  LD      drivers/built-in.o
>  LD      vmlinux.o
>  MODPOST vmlinux.o
> WARNING: modpost: Found 6 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
> ld: final link failed: File truncated
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> ~/src/linus/linux-2.6>cat /etc/SuSE-release SUSE LINUX Enterprise Server
> 9 (ppc)
> VERSION = 9
> PATCHLEVEL = 3
> ~/src/linus/linux-2.6>ld --version
> GNU ld version 2.15.90.0.1.1 20040303 (SuSE Linux)
> Copyright 2002 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
> ~/src/linus/linux-2.6>gcc --version
> gcc (GCC) 3.3.3 (SuSE Linux)
> Copyright (C) 2003 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> ~/src/linus/linux-2.6>cat /etc/SuSE-release SUSE LINUX Enterprise Server
> 9 (ppc)
> VERSION = 9
> PATCHLEVEL = 3
> 
> 
> 
> Jon

As you may have seen from Segher's email from about 40 minutes ago, I can
confirm that I am getting the same error at the same point in the build.
I am going to reply to his message in a few minutes with more details he
requested.  Like you, I also have a 2.15-era ld version.

I can tell you that if you revert the patch that Segher sent on July 22
for file arch/powerpc/kernel/vmlinux.lds.S, the link should succeed (mine
does).

Regards,
Chuck
