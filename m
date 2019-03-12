Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FEC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E9E2075C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E9E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jcjz1HWBzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 01:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.210.194; helo=mail-pf1-f194.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jcgj1qYJzDq75
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 01:25:03 +1100 (AEDT)
Received: by mail-pf1-f194.google.com with SMTP id s23so1926212pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 07:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JVtjTgwXpS+F36W6pTKl2sgAGbR0g7swMsIvnMxPdXI=;
 b=M+UCdVXkXaSPTtvxJDWBDXPmO0L9WK5sYA/wnK5PENLOF3I9VqMgblaES/WDy+DcOs
 kETtApoL2G652PygbWWNuqJlgIeozdHuldOrfsGj6WZwXHAYFizkPMcjbWXZbfk3VsqJ
 YBOkHV2fqpc5+KcPJv3QDIMiPELj5sAfb44bMC9WEo253hQZbzuRtFG225kw83J2oQlI
 Her6F+ZPYOVxN/H/PVlYyp3YueIwAvyhs+AC4kpURAIjl0FDdKBBBbf/b1Wa5moxQcGz
 eVF2cBo4G9am/UIH9o1Xr7z3v9uJGuSDGa4NhDeSwMlWx0jcOuxY4Q1N5E6NJ1lLRG6q
 sMHQ==
X-Gm-Message-State: APjAAAVwxRItji3GhkmFDyXHtsu9XBZmaBK/+Yu7WQTFAu6YU6doUBIh
 DDypkQstUZX3aA7HNaYKazefXA==
X-Google-Smtp-Source: APXvYqy/lZGxY05IxZmj/bjio5X3k/2VTVwc6tTbffOlATD8kE0l5KCBmKSisZ7AgbuRRARTZhJkfA==
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr39726199pfd.229.1552400699994; 
 Tue, 12 Mar 2019 07:24:59 -0700 (PDT)
Received: from localhost.localdomain ([106.215.118.61])
 by smtp.gmail.com with ESMTPSA id z15sm16451189pgc.25.2019.03.12.07.24.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Mar 2019 07:24:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To: Dave Young <dyoung@redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <409a4754-0d01-6eab-2524-94d88bbc609b@redhat.com>
Date: Tue, 12 Mar 2019 19:54:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Paul Mackerras <paulus@samba.org>, James Morse <james.morse@arm.com>,
 Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Dave Anderson <anderson@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dave,

On 03/11/2019 02:35 PM, Dave Young wrote:
> Hi Bhupesh,
> On 03/10/19 at 03:34pm, Bhupesh Sharma wrote:
>> Changes since v1:
>> ----------------
>> - v1 was sent out as a single patch which can be seen here:
>>    http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>
>> - v2 breaks the single patch into two independent patches:
>>    [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>>    [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
>>
>> This patchset primarily fixes the regression reported in user-space
>> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
>> with the availability of 52-bit address space feature in underlying
>> kernel. These regressions have been reported both on CPUs which don't
>> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
>> and also on prototype platforms (like ARMv8 FVP simulator model) which
>> support ARMv8.2 extensions and are running newer kernels.
>>
>> The reason for these regressions is that right now user-space tools
>> have no direct access to these values (since these are not exported
>> from the kernel) and hence need to rely on a best-guess method of
>> determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
>> by underlying kernel.
>>
>> Exporting these values via vmcoreinfo will help user-land in such cases.
>> In addition, as per suggestion from makedumpfile maintainer (Kazu)
>> during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
>> vmcoreinfo in the core code itself rather than in arm64 arch-specific
>> code, so that the user-space code for other archs can also benefit from
>> this addition to the vmcoreinfo and use it as a standard way of
>> determining 'SECTIONS_SHIFT' value in user-land.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>>
>> Bhupesh Sharma (2):
>>    arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
>>    crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>>
>>   arch/arm64/kernel/crash_core.c | 1 +
>>   kernel/crash_core.c            | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> Lianbo's document patch has been merged, would you mind to add vmcoreinfo doc
> patch as well in your series?

Thanks for the inputs. Will add it to the v3.
Let's wait for other comments/reviews, before I spin a version 3.

Regards,
Bhupesh

