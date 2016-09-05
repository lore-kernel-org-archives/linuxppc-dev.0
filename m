Return-Path: <debbugs@buxtehude.debian.org>
Received: from buxtehude.debian.org (buxtehude.debian.org
 [IPv6:2607:f8f0:610:4000:2015:12:0:147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSSS03B68zDrns
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 21:39:12 +1000 (AEST)
Subject: Bug#836741: linux: FTBFS on powerpcspe due to the use of unsupported
 instructions
Reply-To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 836741@bugs.debian.org
Resent-Message-ID: <handler.836741.B.14730753048480@bugs.debian.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <147307529891.26744.6537243126225612598.reportbug@ikarus>
Date: Mon, 05 Sep 2016 13:34:58 +0200
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Source: linux
Version: 4.7.2-1
Severity: normal
User: debian-powerpc@lists.debian.org
Usertags: powerpcspe

Hi!

Linux 4.7.x introduced another regression on powerpcspe due to the use of
unsupported assembly instructions [1]:

/<<PKGBUILDDIR>>/arch/powerpc/xmon/spr_access.S: Assembler messages:
/<<PKGBUILDDIR>>/arch/powerpc/xmon/spr_access.S:5: Error: unrecognized opcode: `ld'
/<<PKGBUILDDIR>>/arch/powerpc/xmon/spr_access.S:10: Error: unrecognized opcode: `ld'
/<<PKGBUILDDIR>>/scripts/Makefile.build:331: recipe for target 'arch/powerpc/xmon/spr_access.o' failed
make[6]: *** [arch/powerpc/xmon/spr_access.o] Error 1

This is very reminiscent of #823526 [2] which also used some FPU instructions
not available on powerpcspe/e500. And, indeed, like "ldarx" and "stdcx", "ld"
is not available on e500 either [3] (see p. 3-68).

I haven't looked at the code yet, but I assume guarding the code with some
additional #ifdef's should fix the issue the same way as in #823526.

Thanks,
Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=linux&arch=powerpcspe&ver=4.7.2-1&stamp=1472977882
> [2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=823526
> [3] http://www.nxp.com/files/32bit/doc/ref_manual/E500CORERM.pdf

--
 .''`.  John Paul Adrian Glaubitz
 : :' :  Debian Developer - glaubitz@debian.org
 `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
