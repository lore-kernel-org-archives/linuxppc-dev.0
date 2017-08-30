Return-Path: <seth.forshee@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj5Mx1F3czDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 23:05:33 +1000 (AEST)
Received: from mail-io0-f199.google.com ([209.85.223.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <seth.forshee@canonical.com>)
 id 1dn2gT-0000Ib-Cp
 for linuxppc-dev@lists.ozlabs.org; Wed, 30 Aug 2017 13:05:29 +0000
Received: by mail-io0-f199.google.com with SMTP id m40so5978186ioi.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:05:29 -0700 (PDT)
Date: Wed, 30 Aug 2017 08:05:25 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Build failures in powerpc ptrace selftests
Message-ID: <20170830130525.xwj3oy2cx2qdwvqc@ubuntu-xps13>
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

With gcc 7 from Ubuntu 17.10 I'm getting the follwing error building the
ptrace selftests for powerpc:

  ptrace-tm-vsx.c: In function ‘tm_vsx’:
  ptrace-tm-vsx.c:42:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~
  make[1]: *** [ptrace-tm-vsx] Error 1
  ptrace-tm-spd-vsx.c: In function ‘tm_spd_vsx’:
  ptrace-tm-spd-vsx.c:55:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~
  make[1]: *** [ptrace-tm-spd-vsx] Error 1
  ptrace-tm-spr.c: In function ‘tm_spr’:
  ptrace-tm-spr.c:46:2: error: PIC register clobbered by ‘r2’ in ‘asm’
    asm __volatile__(
    ^~~

Best I can tell gcc now considers any inline asm which clobbers r2 an
error, and I get it even with -fno-pic. I'm not familiar with powerpc
asm, but it's not obvious to me why r2 is in the clobber list for any of
these.

Thanks,
Seth
