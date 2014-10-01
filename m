Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65F9D1A1833
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:12:31 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:12:06 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6BFEC2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:12:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s916lmC154657168
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 16:47:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s917C43m003870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:12:04 +1000
Date: Wed, 1 Oct 2014 17:12:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] powerpc/eeh: Refactor config accessors
Message-ID: <20141001071204.GA28956@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 01, 2014 at 05:07:48PM +1000, Gavin Shan wrote:
>When EEH errors are detected on some particular PCI adapters, one of
>which is shown as follows, the PCI config space of thoese PCI adapters
>(PE) should be blocked. Otherwise, we will run into fenced PHB when
>collecting EEH logs (part of recovery). The patchset fixes this issue.
>Also, EEH_PE_RESET is replaced with EEH_PE_CFG_BLOCKED to indicate its
>usage. It's bad idea to allow PCI config access even EEH_PE_CFG_BLOCKED
>flag is set for the corresponding PE because it potentially triggers
>recursive EEH error. The patchset also blocks config request from EEH
>backend if necessary.
>

Missed to attach the logs from "lspci" to point the adapters we have
problems with:

# lspci -s 0003:09:00.0
0003:09:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 \
	     Gigabit Ethernet PCIe (rev 01)
# lspci -n -s 0003:09:00.0
0003:09:00.0 0200: 14e4:1657 (rev 01)

Thanks,
Gavin

>Gavin Shan (6):
>  powerpc/eeh: Fix condition for isolated state
>  powerpc/eeh: Rename flag EEH_PE_RESET to EEH_PE_CFG_BLOCKED
>  powerpc/powernv: Drop config requests in EEH accessors
>  powerpc/pseries: Drop config requests in EEH accessors
>  powerpc/eeh: Block PCI config access upon frozen PE
>  powerpc/eeh: Don't collect logs on PE with blocked config space
>
> arch/powerpc/include/asm/eeh.h               |  3 +-
> arch/powerpc/kernel/eeh.c                    | 19 +++++++---
> arch/powerpc/kernel/eeh_driver.c             | 12 +++---
> arch/powerpc/kernel/eeh_pe.c                 | 10 ++++-
> arch/powerpc/kernel/rtas_pci.c               | 30 ++++++---------
> arch/powerpc/platforms/powernv/eeh-ioda.c    |  2 +-
> arch/powerpc/platforms/powernv/eeh-powernv.c | 56 +++++++++++++++++++++++++++-
> arch/powerpc/platforms/powernv/pci.c         |  2 +-
> 8 files changed, 97 insertions(+), 37 deletions(-)
>
>-- 
>1.8.3.2
>
