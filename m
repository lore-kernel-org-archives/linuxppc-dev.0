Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4FF82C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:25:40 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>, <James.Yang@freescale.com>
Subject: [PATCH] powerpc: Make ptrace work reliably
Date: Thu, 16 May 2013 10:59:49 +0530
Message-ID: <1368682191-4225-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bharat Bhushan <bharat.bhushan@freescale.com>

Bharat Bhushan (2):
  powerpc: debug control and status registers are 32bit
=> This patch makes debug control and status registers as 32bit as they are.
   This does not fix anything

  powerpc: restore dbcr0 on user space exit
=> This patch fixes the ptrace reliability issue. The description is the patch
   describes one of the case where it does not work reliably

 arch/powerpc/include/asm/processor.h |    8 ++++----
 arch/powerpc/kernel/asm-offsets.c    |    1 +
 arch/powerpc/kernel/entry_64.S       |   24 ++++++++++++++++++++----
 3 files changed, 25 insertions(+), 8 deletions(-)
