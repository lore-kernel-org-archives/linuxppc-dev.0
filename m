Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP2YZ3bcCzDvyq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:02:26 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so698917pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:02:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Alan Modra <amodra@gmail.com>
Subject: [PATCH 0/3] minor build fixes
Date: Thu, 24 Nov 2016 00:02:06 +1100
Message-Id: <20161123130209.1667-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was building BookE and big endian with a little endian cross
compiler and it stopped working. My BookS BE tests must have been
building using the ELFv2 ABI. After this, the build sometimes still
strangely fails with dot symbols in syscall table unable to be found,
but that's looking like it may be a linker bug (Alan is going to take
a look).

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/64e: convert cmpi to cmpwi in head_64.S
  powerpc: allow compilation on cross-endian toolchain
  powerpc/64e: don't branch to dot symbols

 arch/powerpc/Makefile                | 6 ++++++
 arch/powerpc/boot/Makefile           | 1 +
 arch/powerpc/kernel/exceptions-64e.S | 6 +++---
 arch/powerpc/kernel/head_64.S        | 8 ++++----
 4 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.10.2
