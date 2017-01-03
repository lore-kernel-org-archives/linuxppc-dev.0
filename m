Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tt5GT73ydzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 18:31:13 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id n5so32726642pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 23:31:13 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC v2 0/3] Support Soft NMI
Date: Tue,  3 Jan 2017 18:30:55 +1100
Message-Id: <20170103073058.30066-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is based on suggestions from paulus and benh.
The bugs are all mine. The idea was to implement soft
NMI(s) by keeping interrupts enabled in the soft-disabled
state, but to use the interrupt controller to gate posting
of new interrupts to the processor. This is still work in
progress and a preliminary RFC that needs testing.

Nick posted a more comprehensive version for soft NMI at
https://patchwork.ozlabs.org/patch/704605/, but it does
not work when interrupts are disabled

TODOs:
	1. Integrate on top of
		https://patchwork.ozlabs.org/patch/706983/


Changelog v2:
 - Rename functions as suggested by Nick
 - Move irq in paca down for better alignment
 - Break the patches up further into interrupt disabling
   and soft nmi patches
 - Support only PPC_XICS for now

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

Balbir Singh (3):
  Merge IPI and DEFAULT priorities
  Keep interrupts enabled even on soft disable
  Enable soft nmi handler

 arch/powerpc/include/asm/paca.h      |  1 +
 arch/powerpc/include/asm/xics.h      |  8 ++----
 arch/powerpc/kernel/exceptions-64s.S | 33 +++++++++++++++++------
 arch/powerpc/kernel/irq.c            | 52 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/time.c           | 27 ++++++++++++++++++-
 5 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.9.3
