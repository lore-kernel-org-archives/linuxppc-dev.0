Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2185C1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 05:12:17 +1100 (AEDT)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 15:12:12 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 1D8BF352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 13:11:59 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2AH9olR4923602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 14:09:51 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AIC72n021083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 15:12:08 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, imunsie@au1.ibm.com, mikey@neuling.org,
 andrew.donnellan@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, gpiccoli@linux.vnet.ibm.com
Subject: [PATCH] Reuse PHB/domain number on PCI adresses when available
Date: Thu, 10 Mar 2016 15:11:44 -0300
Message-Id: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch changes the way PCI domain numbers are generated on powerpc.
No functional changes were introduced. The reason for this modification
is better explained on patch's commit message, but in short we currently
increment a global variable at each new PHB discovered, and use this
value as domain number. The problem is that in some cases, like PCI
device hotplug remove and re-add, the address is changed - as modern
kernels are using predictable network naming for example, we can end up
having some issues tracking network interfaces after hotplug operations.

I CC'ed both cxl folks, Bjorn and PCI list, so we can be sure this
modification, if accepted, won't impact any other related area.

Thanks in advance,


Guilherme

Guilherme G. Piccoli (1):
  powerpc/pci: Reuse PHB number on pci_controller add if available

 arch/powerpc/kernel/pci-common.c | 47 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

-- 
2.1.0
