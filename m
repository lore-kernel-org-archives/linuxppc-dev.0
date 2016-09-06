Return-Path: <glaubitz@physik.fu-berlin.de>
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTK2J0K5lzDrpM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 07:08:23 +1000 (AEST)
To: Paul Mackerras <paulus@samba.org>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
Date: Tue, 6 Sep 2016 23:01:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul!

I'm referring to your change [1]:

"powerpc/xmon: Fix SPR read/write commands and add command to dump SPRs"

which introduced assembly code in the new file arch/powerpc/xmon/spr_access.S.

Unfortunately, this code contains assembly instructions which are not available on
all ppc targets. In particular, this change breaks the build on PPC e500v2 targets,
see the corresponding Debian bug report [2].

Could you have a look and possibly add some guarding #ifdefs for the ppc targets
where "ld" is not a supported instruction?

Thanks,
Adrian

> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=31cdd0c39c7544ced79da53aa0b7e989f3a39582
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=836741

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
