Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE35C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:59:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FFD61959
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FFD61959
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9RGN2Cmgz3c90
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 23:59:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com;
 envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN>)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9RG138mXz2yy7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 23:58:49 +1100 (AEDT)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9RCX0nqrz9tR4;
 Wed, 31 Mar 2021 20:56:40 +0800 (CST)
Received: from [10.174.179.96] (10.174.179.96) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 20:58:43 +0800
Subject: Re: [PATCH -next] powerpc/eeh: Remove unused inline function
 eeh_dev_phb_init_dynamic()
To: Daniel Axtens <dja@axtens.net>, <ruscur@russell.cc>, <oohall@gmail.com>,
 <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>
References: <20210324140714.19612-1-yuehaibing@huawei.com>
 <874kgy8ptt.fsf@linkitivity.dja.id.au>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <238925b8-c2be-8282-1ce6-e1d92b7b527e@huawei.com>
Date: Wed, 31 Mar 2021 20:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <874kgy8ptt.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.96]
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2021/3/26 13:08, Daniel Axtens wrote:
> Hi,
> 
>> commit 475028efc708 ("powerpc/eeh: Remove eeh_dev_phb_init_dynamic()")
>> left behind this, so can remove it.
> 
> I had a look: the inline that you are removing here is for the
> !CONFIG_EEH case, which explains why it was missed the first time.
> 
> This looks like a good change. Out of interest, what tool are you using
> to find these unused inlines? If there are many more, it might make
> sense to combine future patches removing them into a single patch, but
> I'm not sure.

Just use some grep skill, will do that if any.

> 
> checkpatch likes this patch, so that's also good :)
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Kind regards,
> Daniel
> .
> 
