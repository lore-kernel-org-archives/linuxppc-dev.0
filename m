Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZyv2SMszDrdC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 17:08:39 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so2695214pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 00:08:39 -0700 (PDT)
Date: Thu, 25 Aug 2016 17:08:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 11/12] powerpc: Support to replay PMIs
Message-ID: <20160825170829.7d91b115@roar.ozlabs.ibm.com>
In-Reply-To: <1472106603-23336-12-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472106603-23336-12-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 25 Aug 2016 12:00:02 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Code to replay the Performance Monitoring Interrupts(PMI).
> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
> and return. In the __check_irq_replay(), replay the PMI interrupt
> by calling performance_monitor_common handler.
> 
> Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.
> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
> to alert the usage of soft_irq_set_mask() for disabling lower
> bitmask interrupts.
> 
> Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
> arch_local_irq_restore() to new Kconfig as suggested.

Should you make a single patch out of this and patch 10?
It doesn't make sense to mask perf interrupts if we can't
replay them.

Perhaps split the CONFIG_IRQ_DEBUG_SUPPORT change into its
own patch first and have the PMU masking and replaying as
a single patch?

Just a suggestion.
