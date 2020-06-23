Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D31C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 10:02:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9626D20724
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 10:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9626D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rhfL3kHjzDqTx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=tianjia.zhang@linux.alibaba.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.alibaba.com
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rhbz1p2nzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 20:00:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0U0VEqxu_1592906410; 
Received: from 30.27.116.246(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0U0VEqxu_1592906410) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 23 Jun 2020 18:00:12 +0800
Subject: Re: [PATCH v4 0/7] clean up redundant 'kvm_run' parameters
To: Paolo Bonzini <pbonzini@redhat.com>, tsbogend@alpha.franken.de,
 paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
 sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
 jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
 chenhuacai@gmail.com
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <fe463233-d094-fca5-b4e9-c1d97124fd69@redhat.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <3a2bee8b-20b4-5d33-7d12-09c374a5afde@linux.alibaba.com>
Date: Tue, 23 Jun 2020 18:00:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fe463233-d094-fca5-b4e9-c1d97124fd69@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2020/6/23 17:42, Paolo Bonzini wrote:
> On 27/04/20 06:35, Tianjia Zhang wrote:
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
>> structure. For historical reasons, many kvm-related function parameters
>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>> patch does a unified cleanup of these remaining redundant parameters.
>>
>> This series of patches has completely cleaned the architecture of
>> arm64, mips, ppc, and s390 (no such redundant code on x86). Due to
>> the large number of modified codes, a separate patch is made for each
>> platform. On the ppc platform, there is also a redundant structure
>> pointer of 'kvm_run' in 'vcpu_arch', which has also been cleaned
>> separately.
> 
> Tianjia, can you please refresh the patches so that each architecture
> maintainer can pick them up?  Thanks very much for this work!
> 
> Paolo
> 

No problem, this is what I should do.
After I update, do I submit separately for each architecture or submit 
them together in a patchset?

Thanks,
Tianjia
