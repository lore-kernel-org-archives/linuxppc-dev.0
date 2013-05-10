Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 948282C0188
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 13:10:01 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH v2 0/4] kvm/ppc: interrupt disabling fixes
Date: Thu, 9 May 2013 22:09:40 -0500
Message-ID: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
 - Split into separate changes
 - Rebase on top of (and fix a bug in) powerpc: Make hard_irq_disable()
   do the right thing vs. irq tracing
 - Move interrupt diasbling/enabling into kvmppc_handle_exit

Based on Ben's next branch.

Scott Wood (4):
  powerpc: hard_irq_disable(): Call trace_hardirqs_off after disabling
  kvm/ppc/booke64: Fix lazy ee handling in kvmppc_handle_exit()
  kvm/ppc: Call trace_hardirqs_on before entry
  kvm/ppc: IRQ disabling cleanup

 arch/powerpc/include/asm/hw_irq.h  |    5 +++--
 arch/powerpc/include/asm/kvm_ppc.h |   17 ++++++++++++++---
 arch/powerpc/kvm/book3s_pr.c       |   16 +++++-----------
 arch/powerpc/kvm/booke.c           |   18 +++++++++---------
 arch/powerpc/kvm/powerpc.c         |   23 ++++++++---------------
 5 files changed, 39 insertions(+), 40 deletions(-)

-- 
1.7.10.4
