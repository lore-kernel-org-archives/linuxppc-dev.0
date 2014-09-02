Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 500EA1A0037
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 14:35:20 +1000 (EST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 0F91A1400DE
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2014 14:35:20 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/3] powerpc: Make sstep.c more generally useful
Date: Tue,  2 Sep 2014 14:35:06 +1000
Message-Id: <1409632509-32510-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series modifies the code in arch/powerpc/lib/sstep.c so
that it can be used by KVM in its instruction emulation, thereby
reducing the number of different PowerPC instruction emulators that we
have in the kernel.  It does this by splitting the existing
emulate_step() function into two: an analyse_instr() function that
decodes an instruction and executes the easy ones, and an
emulate_step() function that uses analyse_instr() and then executes
the loads and stores.  The subsequent two patches add emulation of
some extra instructions.

v2: add #ifdef CONFIG_ALTIVEC around do_vec_{load,store} calls.

The patch series is against v3.17-rc1.

 arch/powerpc/include/asm/sstep.h |  62 +++
 arch/powerpc/lib/sstep.c         | 996 +++++++++++++++++++++++++--------------
 2 files changed, 698 insertions(+), 360 deletions(-)
