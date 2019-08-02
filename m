Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F288C433FF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 00:51:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8B02083B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 00:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8B02083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4607rK62hmzDqvy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 10:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yanaijie@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4607p66tlyzDqk5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 10:48:59 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 380B879A79CC01A16C7;
 Fri,  2 Aug 2019 08:48:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 08:48:46 +0800
Subject: Re: [PATCH v3 00/10] implement KASLR for powerpc/fsl_booke/32
To: Diana Madalina Craciun <diana.craciun@nxp.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "christophe.leroy@c-s.fr"
 <christophe.leroy@c-s.fr>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "keescook@chromium.org"
 <keescook@chromium.org>, "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>
References: <20190731094318.26538-1-yanaijie@huawei.com>
 <VI1PR0401MB2463844DD4A35EB3F0959C22FFDE0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <bc30b426-d7c6-c839-ebd2-a404465079a3@huawei.com>
Date: Fri, 2 Aug 2019 08:48:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2463844DD4A35EB3F0959C22FFDE0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
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
Cc: "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jingxiangfeng@huawei.com" <jingxiangfeng@huawei.com>,
 "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "fanchengyang@huawei.com" <fanchengyang@huawei.com>,
 "yebin10@huawei.com" <yebin10@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/8/1 22:36, Diana Madalina Craciun wrote:
> Hi Jason,
> 
> I have tested these series on a P4080 platform.
> 
> Regards,
> Diana

Diana, thank you so much.

So can you take a look at the code of this version and give a 
Reviewed-by or Tested-by?

Thanks,
Jason

