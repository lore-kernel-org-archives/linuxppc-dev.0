Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B72CF2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 11:00:06 +1100 (EST)
Date: Wed, 8 Jan 2014 17:45:30 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <benh@kernel.crashing.org>
Subject: mpic build failure for 7447_hpc defconfig (bisected)
Message-ID: <20140108224529.GA4708@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 446f6d06fab0b49c61887ecbe8286d6aaa796637 ("powerpc/mpic: Properly
set default triggers") breaks the mpc7447_hpc_defconfig as follows:

  CC      arch/powerpc/sysdev/mpic.o
arch/powerpc/sysdev/mpic.c: In function 'mpic_set_irq_type':
arch/powerpc/sysdev/mpic.c:886:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:890:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:894:9: error: case label does not reduce to an integer constant
arch/powerpc/sysdev/mpic.c:898:9: error: case label does not reduce to an integer constant

Looking at the cpp output (gcc 4.7.3 from the kernel.org toolchains), I see:

   case mpic->hw_set[MPIC_IDX_VECPRI_SENSE_EDGE] |
        mpic->hw_set[MPIC_IDX_VECPRI_POLARITY_POSITIVE]:

The pointer into an array appears because CONFIG_MPIC_WEIRD=y is set for
this thing.

-------------------
  #ifdef CONFIG_MPIC_WEIRD
  static u32 mpic_infos[][MPIC_IDX_END] = {
        [0] = { /* Original OpenPIC compatible MPIC */

  [...]

  #define MPIC_INFO(name) mpic->hw_set[MPIC_IDX_##name]

  #else /* CONFIG_MPIC_WEIRD */

  #define MPIC_INFO(name) MPIC_##name

  #endif /* CONFIG_MPIC_WEIRD */
-------------------


Given it has been broken since 3.4-rc5, is it safe to say MPIC_WEIRD is dead
and unused?  Or should the case be converted to if/else or similar?  Or were
other versions of gcc actually able to "see" constant numbers?

Paul.
--
