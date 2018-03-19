Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404qQ522JvzF0wF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 08:46:21 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 404qQ44DMLz9sVM
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2018 08:46:20 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] powerpc: Free up CPU feature bits
Date: Tue, 20 Mar 2018 08:46:10 +1100
Message-Id: <1521495973-3237-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is against the powerpc next branch.  It takes
advantage of the fact that there are only a few CPU feature bits that
are meaningful on both 32-bit and 64-bit platforms.  At the moment,
many of the 64 bits of the CPU feature mask on 64-bit platforms are
taken up with bits which are only relevant to 32-bit platforms.  This
series rearranges things so that we can use those bits for new
features that are relevant only to 64-bit platforms.  With this, there
are now 20 bits available for new 64-bit features.

To make things simpler, we use the bottom 12 bits of the CPU feature
word for features that are relevant to both 32-bit and 64-bit
platforms.  The remaining 20 or 52 bits are then available for
features specific to 32-bit or 64-bit platforms.

Paul.

 arch/powerpc/include/asm/cputable.h       | 223 +++++++++++++++---------------
 arch/powerpc/include/asm/time.h           |   2 +-
 arch/powerpc/kernel/cpu_setup_6xx.S       |   2 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c         |   3 +-
 arch/powerpc/kernel/vdso.c                |  12 +-
 6 files changed, 122 insertions(+), 122 deletions(-)
