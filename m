Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL6tz6Fb0zDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 18:08:26 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 17so16426819pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 00:08:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] improve recoverability of OPAL calls
Date: Mon, 23 Oct 2017 17:08:12 +1000
Message-Id: <20171023070815.19803-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a few patches to improve recoverability for FIXUP_ENDIAN
on powernv. We should try to minimise SRR[01] (and MSR[RI]=0) usage
as much as possible. Whether that's by using HSRR or mtmsrd, it
usually results in faster and smaller code too.

There's a few other places we can improve, but I've had these
patches around for a while.

Thanks,
Nick


Nicholas Piggin (3):
  powerpc/book3s: use label for FIXUP_ENDIAN macro branch
  powerpc/book3s: Add an HV variant of FIXUP_ENDIAN that is recoverable
  powerpc/powernv: Use FIXUP_ENDIAN_HV in OPAL return

 arch/powerpc/include/asm/ppc_asm.h             | 27 ++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |  4 ++--
 2 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.13.3
