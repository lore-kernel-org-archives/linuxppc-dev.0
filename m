Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE5BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:19:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8776E2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 21:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776E2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jnsg2gzTzDqJC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:19:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Jjsh4VdLzDqDF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 05:19:03 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 189C8A78;
 Tue, 12 Mar 2019 11:19:00 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F195A3F59C;
 Tue, 12 Mar 2019 11:18:56 -0700 (PDT)
Subject: Re: [PATCH 00/14] entry: preempt_schedule_irq() callers scrub
To: Vineet Gupta <vineet.gupta1@synopsys.com>, linux-kernel@vger.kernel.org
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <e604601e-f8e1-a8b5-d364-69ca967996ce@synopsys.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a5b1605b-b3b3-7898-30ae-d993050e8c7a@arm.com>
Date: Tue, 12 Mar 2019 18:18:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e604601e-f8e1-a8b5-d364-69ca967996ce@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Mar 2019 08:12:35 +1100
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
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@redhat.com>,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/03/2019 18:03, Vineet Gupta wrote:
[...]
>> Regarding that loop, archs seem to fall in 3 categories:
>> A) Those that don't have the loop
> 
> Please clarify that this is the right thing to do (since core code already has the
> loop) hence no fixing is required for this "category"
> 

Right, those don't need any change. I had a brief look at them to double
check they had the proper need_resched() gate before calling
preempt_schedule_irq() (with no loop) and they all seem fine. Also...

>> B) Those that have a small need_resched() loop around the
>>    preempt_schedule_irq() callsite
>> C) Those that branch to some more generic code further up the entry code
>>    and eventually branch back to preempt_schedule_irq()
>>
>> arc, m68k, nios2 fall in A)
> 

I forgot to include parisc in here.

[...]
