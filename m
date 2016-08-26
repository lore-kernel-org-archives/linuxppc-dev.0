Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL3PY4tmdzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 11:29:53 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7Q1TRJs117975
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:29:51 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251ff6aes4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:29:50 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 26 Aug 2016 06:59:46 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 65147125805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 07:03:03 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7Q1Tiex44499018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:59:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7Q1TgGQ014019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 06:59:43 +0530
Subject: Re: [RFC PATCH v3 11/12] powerpc: Support to replay PMIs
To: Nicholas Piggin <npiggin@gmail.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472106603-23336-12-git-send-email-maddy@linux.vnet.ibm.com>
 <20160825170829.7d91b115@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 26 Aug 2016 06:59:39 +0530
MIME-Version: 1.0
In-Reply-To: <20160825170829.7d91b115@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4282b277-8d99-a42f-45db-c15751dab36c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 25 August 2016 12:38 PM, Nicholas Piggin wrote:
> On Thu, 25 Aug 2016 12:00:02 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Code to replay the Performance Monitoring Interrupts(PMI).
>> In the masked_interrupt handler, for PMIs we reset the MSR[EE]
>> and return. In the __check_irq_replay(), replay the PMI interrupt
>> by calling performance_monitor_common handler.
>>
>> Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.
>> New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
>> to alert the usage of soft_irq_set_mask() for disabling lower
>> bitmask interrupts.
>>
>> Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
>> arch_local_irq_restore() to new Kconfig as suggested.
> Should you make a single patch out of this and patch 10?
> It doesn't make sense to mask perf interrupts if we can't
> replay them.
>
> Perhaps split the CONFIG_IRQ_DEBUG_SUPPORT change into its
> own patch first and have the PMU masking and replaying as
> a single patch?

Make senses. Will make the changes.

Maddy

>
> Just a suggestion.
>
