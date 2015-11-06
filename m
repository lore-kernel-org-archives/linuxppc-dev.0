Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E1841A0D6A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 08:10:07 +1100 (AEDT)
Message-ID: <1446844180.11597.13.camel@freescale.com>
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
From: Scott Wood <scottwood@freescale.com>
To: Laurent Vivier <laurent@vivier.eu>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Date: Fri, 6 Nov 2015 15:09:40 -0600
In-Reply-To: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-05 at 12:47 +0100, Laurent Vivier wrote:
> When I try to cross compile a ppc64 kernel, it generally
> fails on the VDSO stage. This is true for powerpc64 cross-
> compiler, but also when I try to build a ppc64le kernel
> on a ppc64 host.
> 
> VDSO64L fails:
> 
>   VDSO64L arch/powerpc/kernel/vdso64/vdso64.so.dbg
> /usr/bin/powerpc64-linux-gnu-ld: arch/powerpc/kernel/vdso64/sigtramp.o:
> file class ELFCLASS64 incompatible with ELFCLASS32
> /usr/bin/powerpc64-linux-gnu-ld: final link failed: File in wrong format
> 
> This fails because gcc calls "collect2" with
> "--oformat elf32-powerpcle" with ppc64 objects, without the
> "--oformat" ld works well because it use the format of the
> first object as output format.
> 
> As this case is correctly managed to build the other kernel
> objects, this patch replaces $(GCC) by $(LD) to generate the
> VDSO objects.

I cross-compile ppc64 kernels and have not seen this problem.  I do need to 
pass in -m64 as part of $(CC) if it's not the toolchain default, which is not 
nice, but the proper fix for that is to add -m64 in the makefiles -- and if I 
don't it fails way before VDSO.

Why is GCC building ppc64 object files but telling the linker --oformat elf32-
powerpcle?  Are different options somehow being passed to GCC in one case 
versus the other?

-Scott
