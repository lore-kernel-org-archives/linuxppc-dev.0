Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BE3C4320E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 11:10:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9101F60F45
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 11:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9101F60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZWCh0q97z30Hp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 21:10:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 304 seconds by postgrey-1.36 at boromir;
 Wed, 28 Jul 2021 19:16:00 AEST
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZSh05CFjz306d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 19:15:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0UhEfyol_1627463435; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0UhEfyol_1627463435) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 28 Jul 2021 17:10:36 +0800
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To: Arnd Bergmann <arnd@arndb.de>
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
 <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
 <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
 <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <d3760b84-82b6-d8e1-0fed-dc494d226f3f@linux.alibaba.com>
Date: Wed, 28 Jul 2021 17:10:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Jul 2021 21:09:48 +1000
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
Cc: Amit Shah <amit@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Omar Sandoval <osandov@fb.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


在 2021/7/28 下午5:01, Arnd Bergmann 写道:
> On Wed, Jul 28, 2021 at 10:28 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> 在 2021/7/28 下午3:25, Arnd Bergmann 写道:
>>
>> I checked several hvc backends, like drivers/tty/hvc/hvc_riscv_sbi.c,
>> drivers/tty/hvc/hvc_iucv.c, drivers/tty/hvc/hvc_rtas.c, they don't use dma.
>>
>> I not finished all hvc backends check yet. But I think even if all hvc
>> backends don't use dma currently, it is still possible that the hvc
>> backend using dma will be added in the furture.
>>
>> So I agree with you it should better be fixed in the hvc framework,
>> solve the issue in the first place.
> Ok, sounds good to me, no need to check more backends then.
> I see the hvc-console driver is listed as 'Odd Fixes' in the maintainer
> list, with nobody assigned other than the ppc kernel list (added to Cc).
>
> Once you come up with a fix in hvc_console.c, please send that to the
> tty maintainers, the ppc list and me, and I'll review it.
OK, thanks, I will submit the patch ASAP :)
>
>          Arnd
