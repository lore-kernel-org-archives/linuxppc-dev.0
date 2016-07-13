Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq18q4MSCzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 11:15:07 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id l125so2151813ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 18:15:07 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 0/3] powerpc: tweak the kernel options for CRASH_DUMP and
 RELOCATABLE
Date: Wed, 13 Jul 2016 09:14:37 +0800
Message-Id: <1468372480-6453-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
Compare to v1 [1], the main differences are:
 - Still automatically select RELOCATABLE when CRASH_DUMP is enabled.
 - Add a new patch to kill RELOCATABLE_PPC32.

v1:
The first patch fixes a build error when CRASH_DUMP=y && ADVANCED_OPTIONS=n
for ppc32. The second does some cleanup for RELOCATABLE option.

Kevin Hao (3):
  powerpc32: booke: fix the build error when CRASH_DUMP is enabled
  powerpc: merge the RELOCATABLE config entries for ppc32 and ppc64
  powerpc32: kill RELOCATABLE_PPC32

 arch/powerpc/Kconfig              | 61 +++++++++++++++------------------------
 arch/powerpc/include/asm/page.h   |  6 ++--
 arch/powerpc/kernel/Makefile      |  3 +-
 arch/powerpc/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/mm/init_32.c         |  2 +-
 5 files changed, 29 insertions(+), 45 deletions(-)

[1] http://linuxppc-dev.ozlabs.narkive.com/fKHcSZbu/patch-0-2-powerpc-tweak-the-kernel-options-for-crash-dump-and-relocatable
-- 
2.8.1
