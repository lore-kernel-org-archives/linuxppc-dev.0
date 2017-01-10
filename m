Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyLlj6VLYzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 16:52:49 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id y143so6078990pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 21:52:49 -0800 (PST)
Date: Tue, 10 Jan 2017 15:52:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 05/12] powerpc: reverse the soft_enable logic
Message-ID: <20170110155239.03f4c1cb@roar.ozlabs.ibm.com>
In-Reply-To: <1483968978-16035-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1483968978-16035-6-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon,  9 Jan 2017 19:06:11 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> "paca->soft_enabled" is used as a flag to mask some of interrupts.
> Currently supported flags values and their details:
> 
> soft_enabled    MSR[EE]
> 
> 0               0       Disabled (PMI and HMI not masked)
> 1               1       Enabled
> 
> "paca->soft_enabled" is initialized to 1 to make the interripts as
> enabled. arch_local_irq_disable() will toggle the value when interrupts
> needs to disbled. At this point, the interrupts are not actually disabled,
> instead, interrupt vector has code to check for the flag and mask it when it occurs.
> By "mask it", it update interrupt paca->irq_happened and return.
> arch_local_irq_restore() is called to re-enable interrupts, which checks and
> replays interrupts if any occured.
> 
> Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
> and PMIs are implemented as NMI. But this patchset depends on local_irq_*
> for a successful local_* update. Meaning, mask all possible interrupts during
> local_* update and replay them after the update.
> 
> So the idea here is to reserve the "paca->soft_enabled" logic. New values and
> details:
> 
> soft_enabled    MSR[EE]
> 
> 1               0       Disabled  (PMI and HMI not masked)
> 0               1       Enabled
> 
> Reason for the this change is to create foundation for a third mask value "0x2"
> for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
> set to a value "3", PMI interrupts are mask and when set to a value
> of "1", PMI are not mask. With this patch also extends soft_enabled
> interrupt disable mask.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
