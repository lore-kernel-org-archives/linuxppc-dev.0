Return-Path: <clg@kaod.org>
Received: from 8.mo178.mail-out.ovh.net (8.mo178.mail-out.ovh.net
 [46.105.74.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fgkl0jtHzF266
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 17:31:26 +1000 (AEST)
Received: from player716.ha.ovh.net (unknown [10.109.105.75])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8C443105F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2018 09:15:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/4] powerpc/xive: add support for H_INT_RESET
Date: Tue,  3 Apr 2018 09:15:44 +0200
Message-Id: <20180403071548.19829-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

H_INT_RESET performs a reset of the Hypervisor internal interrupt
structures, removing all settings done with H_INT_SET_SOURCE_CONFIG
and H_INT_SET_QUEUE_CONFIG. This is most important for kdump and kexec
to be able to restart in a clean state.

First patch closes a window in the kexec sequence in which the
H_INT_RESET hcall can be run concurrently with other hcalls when CPUs
are brought down. The other patches wire up the reset hcall making
sure it supports H_LONG_BUSY_* returned by the Hypervisor.

Cédric Le Goater (4):
  powerpc/64/kexec: fix race in kexec when XIVE is shutdowned
  powerpc/xive: fix hcall H_INT_RESET to support long busy delays
  powerpc/xive: shutdown XIVE when kexec or kdump is performed
  powerpc/xive: prepare all hcalls to support long busy delays

 arch/powerpc/kernel/machine_kexec_64.c |  8 +--
 arch/powerpc/platforms/pseries/kexec.c |  7 ++-
 arch/powerpc/sysdev/xive/spapr.c       | 89 +++++++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 19 deletions(-)

-- 
2.13.6
