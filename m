Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6DK4KbCzDrPC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:31:13 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id q2so12648468pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:31:13 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:31:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 5/9] powerpc: reverse the soft_enable logic
Message-ID: <20160726153103.26dda0ce@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-6-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 25 Jul 2016 20:22:18 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> "paca->soft_enabled" is used as a flag to mask some of interrupts.
> Currently supported flags values and their details:
> 
> soft_enabled		MSR[EE]
> 
> 0			0	Disabled (PMI and HMI not masked)
> 1			1	Enabled
> 
> "paca->soft_enabled" is initialed to 1 to make the interripts as
> enabled. arch_local_irq_disable() will toggle the value when
> interrupts needs to disbled. At this point, the interrupts are not
> actually disabled, instead, interrupt vector has code to check for
> the flag and mask it when it occurs. By "mask it", it updated
> interrupt paca->irq_happened and return. arch_local_irq_restore() is
> called to re-enable interrupts, which checks and replays interrupts
> if any occured.
> 
> Now, as mentioned, current logic doesnot mask "performance monitoring
> interrupts" and PMIs are implemented as NMI. But this patchset
> depends on local_irq_* for a successful local_* update. Meaning, mask
> all possible interrupts during local_* update and replay them after
> the update.
> 
> So the idea here is to reserve the "paca->soft_enabled" logic. New
> values and details:
> 
> soft_enabled		MSR[EE]
> 
> 1			0	Disabled  (PMI and HMI not masked)
> 0			1	Enabled
> 
> Reason for the this change is to create foundation for a third flag
> value "2" for "soft_enabled" to add support to mask PMIs. When
> arch_irq_disable_* is called with a value "2", PMI interrupts are
> mask. But when called with a value of "1", PMI are not mask.
> 
> With new flag value for "soft_enabled", states looks like:
> 
> soft_enabled		MSR[EE]
> 
> 2			0	Disbaled PMIs also
> 1			0	Disabled  (PMI and HMI not masked)
> 0			1	Enabled
> 
> And interrupt handler code for checking has been modified to check for
> for "greater than or equal" to 1 condition instead.

This bit of the patch seems to have been moved into other part
of the series. Ideally (unless there is a good reason), it is nice
to have each individual patch result in a working kernel before
and after.

Nice way to avoid adding more branches though.

Thanks,
Nick
