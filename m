Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKvFd1TRfzF0Y2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 00:24:04 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 66so3729714plc.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 05:24:04 -0800 (PST)
Date: Mon, 15 Jan 2018 23:23:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 13/17] powerpc/64s: Add support to mask perf
 interrupts and replay them
Message-ID: <20180115232341.02e862e4@roar.ozlabs.ibm.com>
In-Reply-To: <1513742157-28768-14-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1513742157-28768-14-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Dec 2017 09:25:53 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Two new bit mask field "IRQ_DISABLE_MASK_PMU" is introduced to support
> the masking of PMI and "IRQ_DISABLE_MASK_ALL" to aid interrupt masking
> checking.
> 
> Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added
> to use in the exception code to check for PMI interrupts.
> 
> In the masked_interrupt handler, for PMIs we reset the MSR[EE] and
> return. In the __check_irq_replay(), replay the PMI interrupt by
> calling performance_monitor_common handler.

I think we need to add all interrupt types which clear MSR[EE] in their
masked handler to the test in may_hard_irq_disable(), otherwise EE can
be enabled before all such pending interrupts are replayed.

We should define all such interrupts in a mask and use that in
may_hard_irq_disable() and corresponding place in masked_##_H##interrupt:

Thanks,
Nick
