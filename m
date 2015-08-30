Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D11651A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:40 +1000 (AEST)
In-Reply-To: <1440727035-4314-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: powerpc/eeh: Fix fenced PHB caused by eeh_slot_error_detail()
Message-Id: <20150830212040.BC2E01401AF@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-28-08 at 01:57:00 UTC, Gavin Shan wrote:
> The config space of some PCI devices can't be accessed when their
> PEs are in frozen state. Otherwise, fenced PHB might be seen.
> Those PEs are identified with flag EEH_PE_CFG_RESTRICTED, meaing
> EEH_PE_CFG_BLOCKED is set automatically when the PE is put to
> frozen state (EEH_PE_ISOLATED). eeh_slot_error_detail() restores
> PCI device BARs with eeh_pe_restore_bars(), which then calls
> eeh_ops->restore_config() to reinitialize the PCI device in
> (OPAL) firmware. eeh_ops->restore_config() produces PCI config
> access that causes fenced PHB. The problem was reported on below
> adapter:
> 
>    0001:01:00.0 0200: 14e4:168e (rev 10)
>    0001:01:00.0 Ethernet controller: Broadcom Corporation \
>                 NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)
> 
> This fixes the issue by skipping eeh_pe_restore_bars() in
> eeh_slot_error_detail() when EEH_PE_CFG_BLOCKED is set for the PE.
> 
> Fixes: b6541db1 ("powerpc/eeh: Block PCI config access upon frozen PE")
> Cc: stable@vger.kernel.org # v4.0+
> Reported-by: Manvanthara B. Puttashankar <mputtash@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/259800135c654a098d9f0adf

cheers
