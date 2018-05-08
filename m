Return-Path: <clg@kaod.org>
Received: from 14.mo7.mail-out.ovh.net (14.mo7.mail-out.ovh.net
 [178.33.251.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g9Vr2gJrzF1dM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 17:05:39 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.105.118])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 71165A5E83
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 09:05:35 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/4] powerpc/xive: add support for H_INT_RESET
Date: Tue,  8 May 2018 09:05:13 +0200
Message-Id: <20180508070517.947-1-clg@kaod.org>
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

Hello,

H_INT_RESET performs a reset of the Hypervisor internal interrupt
structures, removing all settings done with H_INT_SET_SOURCE_CONFIG
and H_INT_SET_QUEUE_CONFIG. This is most important for kdump and kexec
to be able to restart in a clean state.

First patch closes a window in the kexec sequence in which the
H_INT_RESET hcall can be run concurrently with other hcalls when CPUs
are brought down. The other patches wire up the reset hcall making
sure it supports H_LONG_BUSY_* returned by the Hypervisor.

Thanks,

C.

 Changes since v2:

 - replaced msleep() by mdelay() as some calling path are under lock. 

Cédric Le Goater (4):
  powerpc/64/kexec: fix race in kexec when XIVE is shutdown
  powerpc/xive: fix hcall H_INT_RESET to support long busy delays
  powerpc/xive: shutdown XIVE when kexec or kdump is performed
  powerpc/xive: prepare all hcalls to support long busy delays

 arch/powerpc/kernel/machine_kexec_64.c |  8 ++--
 arch/powerpc/platforms/pseries/kexec.c |  7 ++-
 arch/powerpc/sysdev/xive/spapr.c       | 88 +++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 19 deletions(-)

-- 
2.13.6
