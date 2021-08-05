Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDBFC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 11:14:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CE0610FF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 11:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83CE0610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgQxS46wJz3cM0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 21:14:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgQx60F1gz3cKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 21:14:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0Ui1z.hC_1628162053; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0Ui1z.hC_1628162053) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 05 Aug 2021 19:14:13 +0800
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 amit@kernel.org, arnd@arndb.de, osandov@fb.com
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
 <f1b92c7d-0eaf-4eac-ecd2-fbb74fb63b52@kernel.org>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <202cf491-5cdd-999f-d556-a5ebd2b4e266@linux.alibaba.com>
Date: Thu, 5 Aug 2021 19:14:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f1b92c7d-0eaf-4eac-ecd2-fbb74fb63b52@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


在 2021/8/5 下午4:09, Jiri Slaby 写道:
> On 05. 08. 21, 9:58, Jiri Slaby wrote:
>> Hi,
>>
>> On 04. 08. 21, 4:54, Xianting Tian wrote:
>>> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, 
>>> int data,
>>>       hp->outbuf_size = outbuf_size;
>>>       hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
>
> This deserves cleanup too. Why is "outbuf" not "char outbuf[0] 
> __ALIGNED__" at the end of the structure? The allocation would be 
> easier (using struct_size()) and this line would be gone completely.
I will make the cleanup in v4.
>
>>> +    /*
>>> +     * hvc_con_outbuf is guaranteed to be aligned at least to the
>>> +     * size(N_OUTBUF) by kmalloc().
>>> +     */
>>> +    hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
>>> +    if (!hp->hvc_con_outbuf)
>>> +        return ERR_PTR(-ENOMEM);
>>
>> This leaks hp, right?
>
> Actually, why don't you make
> char c[N_OUTBUF] __ALIGNED__;
>
> part of struct hvc_struct directly?
thanks, it a good idea, I will change it in v4.
>
>> BTW your 2 patches are still not threaded, that is hard to follow.
>>
>>> +
>>> +    spin_lock_init(&hp->hvc_con_lock);
>>> +
>>>       tty_port_init(&hp->port);
>>>       hp->port.ops = &hvc_port_ops;
>>
>> thanks,
