Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D51562C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:16:17 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <stuart.yoder@freescale.com>, <james.yang@freescale.com>
Subject: [PATCH 0/2 v3] powerpc: Make ptrace work reliably
Date: Wed, 22 May 2013 09:50:57 +0530
Message-ID: <1369196459-17275-1-git-send-email-Bharat.Bhushan@freescale.com>
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

v2->v3
 - Load PACACURRENT immediately after _MSR(r1), and load DBCR0
   just after "beq resume_kernel 
 - Added lat_sysycal results before and after the patch

v1->v2
 - Subject line was missing 0/2, 1/2, 2/2

Bharat Bhushan (2):
  powerpc: debug control and status registers are 32bit
=> This patch makes debug control and status registers as 32bit as they are.
   This does not fix anything

  powerpc: restore dbcr0 on user space exit
=> This patch fixes the ptrace reliability issue. The description is the patch
   describes one of the case where it does not work reliably

 arch/powerpc/include/asm/processor.h |    8 ++++----
 arch/powerpc/kernel/asm-offsets.c    |    1 +
 arch/powerpc/kernel/entry_64.S       |   28 ++++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)
