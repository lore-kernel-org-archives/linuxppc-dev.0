Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A40F1A075D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 00:18:51 +1100 (AEDT)
Date: Wed, 18 Nov 2015 13:18:43 +0000
From: Joseph Myers <joseph@codesourcery.com>
To: kbuild test robot <fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, <linux-sh@vger.kernel.org>
Subject: Re: [powerpc:test 6/9] arch/sh/math-emu/math.c:129:1: warning: ISO
 C90 forbids mixed declarations and code
In-Reply-To: <201511182009.NTi522dG%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.10.1511181306390.30047@digraph.polyomino.org.uk>
References: <201511182009.NTi522dG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Nov 2015, kbuild test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git test
> head:   ebb77ceeb18554a309846f9025a432fe848ddc8e
> commit: a4572d52d6d662db3956d1bc91a745e39a376979 [6/9] sh/math-emu: Move sh from math-emu-old to math-emu
> config: sh-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout a4572d52d6d662db3956d1bc91a745e39a376979
>         # save the attached .config to linux build tree
>         make.cross ARCH=sh 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/sh/math-emu/math.c:23:0:
>    include/math-emu/single.h:76:21: warning: "__BIG_ENDIAN" is not defined [-Wundef]
>    In file included from arch/sh/math-emu/math.c:24:0:
>    include/math-emu/double.h:81:22: warning: "__BIG_ENDIAN" is not defined [-Wundef]
>    arch/sh/math-emu/math.c:54:0: warning: "WRITE" redefined [enabled by default]
>    include/linux/fs.h:198:0: note: this is the location of the previous definition
>    arch/sh/math-emu/math.c:55:0: warning: "READ" redefined [enabled by default]
>    include/linux/fs.h:197:0: note: this is the location of the previous definition
>    arch/sh/math-emu/math.c: In function 'fadd':
> >> arch/sh/math-emu/math.c:129:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >> arch/sh/math-emu/math.c:129:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>    arch/sh/math-emu/math.c: In function 'fsub':
>    arch/sh/math-emu/math.c:136:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>    arch/sh/math-emu/math.c:136:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]

This looks rather like it could be some sort of false positive with the 
warning tracking / pre-existing condition given that only the warnings in 
one function are reported as new.  In any case, diagnostics with macro 
expansion tracking enabled would be more helpful.  But if genuine and not 
specific to the kernel code, I'd suggest using 
-Wno-declaration-after-statement here - as externally maintained code, it 
doesn't make sense to apply such kernel-specific coding-style rules to it.  
(It seems some other architectures disable all warnings when using this 
code.)

-- 
Joseph S. Myers
joseph@codesourcery.com
