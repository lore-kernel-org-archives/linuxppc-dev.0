Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D2411A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:57:02 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 0/4] powerpc: trivial unused functions cleanup
Date: Fri, 20 Mar 2015 10:56:25 +0700
Message-Id: <1426823789-949-1-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
References: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series removes unused functions from powerpc tree that I've been able
to discover.

Two machines at hands, e300 and e500 based, boot and run without regressions
on my workload with this series applied. The removed code seems also been
rarely touched, so it seems the series is safe at least in general. But I
can't obviously express any strong point in support of the series, so it's
completely OK to leave things as is.

v3: In patch 4/4, do not remove fsl_mpic_primary_get_version() from
    arch/powerpc/sysdev/mpic.c because the patch by Jia Hongtao
    ("powerpc/85xx: workaround for chips with MSI hardware errata") makes
    use of it.

v2: Added a brief explanation to each patch description of why removed
    functions are unused, as suggested by Michael Ellerman.

Arseny Solokha (4):
  powerpc/boot: drop planetcore_set_serial_speed
  kvm/ppc/mpic: drop unused IRQ_testbit
  powrepc/qe: drop unused ucc_slow_poll_transmitter_now
  powerpc/mpic: remove unused functions

 arch/powerpc/boot/planetcore.c        | 33 ---------------------------------
 arch/powerpc/boot/planetcore.h        |  3 ---
 arch/powerpc/include/asm/mpic.h       | 11 -----------
 arch/powerpc/include/asm/ucc_slow.h   | 13 -------------
 arch/powerpc/kvm/mpic.c               |  5 -----
 arch/powerpc/sysdev/mpic.c            | 25 -------------------------
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  5 -----
 7 files changed, 95 deletions(-)

-- 
2.3.3
