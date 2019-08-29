Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F37C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 01:59:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AD42077B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 01:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AD42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Jm595M5KzDrNH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 11:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com; envelope-from=yanaijie@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jm2n5LH7zDrHt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 11:57:36 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4F550E427B9ACF4E9F9F;
 Thu, 29 Aug 2019 09:57:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 09:57:22 +0800
Subject: Re: [PATCH v6 00/12] implement KASLR for powerpc/fsl_booke/32
To: Scott Wood <oss@buserror.net>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
 <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <npiggin@gmail.com>, <keescook@chromium.org>,
 <kernel-hardening@lists.openwall.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
 <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <923983fc-364d-440d-5c3a-3d3d6de60d14@huawei.com>
Date: Thu, 29 Aug 2019 09:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a39b81562bcdeda7ffe0c2c29a60ff08c77047a6.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
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
Cc: wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
 jingxiangfeng@huawei.com, zhaohongjiang@huawei.com, thunder.leizhen@huawei.com,
 fanchengyang@huawei.com, yebin10@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/8/28 12:05, Scott Wood wrote:
> On Fri, 2019-08-09 at 18:07 +0800, Jason Yan wrote:
>> This series implements KASLR for powerpc/fsl_booke/32, as a security
>> feature that deters exploit attempts relying on knowledge of the location
>> of kernel internals.
>>
>> Since CONFIG_RELOCATABLE has already supported, what we need to do is
>> map or copy kernel to a proper place and relocate.
> 
> Have you tested this with a kernel that was loaded at a non-zero address?  I
> tried loading a kernel at 0x04000000 (by changing the address in the uImage,
> and setting bootm_low to 04000000 in U-Boot), and it works without
> CONFIG_RANDOMIZE and fails with.
> 

Not yet. I will test this kind of cases in the next days. Thank you so
much. If there are any other corner cases that have to be tested, please
let me know.

>>   Freescale Book-E
>> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
>> entries are not suitable to map the kernel directly in a randomized
>> region, so we chose to copy the kernel to a proper place and restart to
>> relocate.
>>
>> Entropy is derived from the banner and timer base, which will change every
>> build and boot. This not so much safe so additionally the bootloader may
>> pass entropy via the /chosen/kaslr-seed node in device tree.
> 
> How complicated would it be to directly access the HW RNG (if present) that
> early in the boot?  It'd be nice if a U-Boot update weren't required (and
> particularly concerning that KASLR would appear to work without a U-Boot
> update, but without decent entropy).
> 
> -Scott
> 
> 
> 
> .
> 

