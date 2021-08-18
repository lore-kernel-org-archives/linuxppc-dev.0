Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:35:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17E660041
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E17E660041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqD7t15M3z3cWV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:35:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqD7M1xkVz303t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 13:35:22 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R221e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0Ujd4SCS_1629257711; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0Ujd4SCS_1629257711) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 11:35:11 +0800
Subject: Re: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 amit@kernel.org, arnd@arndb.de, osandov@fb.com
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
 <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
 <5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org>
From: Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <a0e671da-e2e9-3696-950d-16b931e1fe9a@linux.alibaba.com>
Date: Wed, 18 Aug 2021 11:35:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org>
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


在 2021/8/18 上午11:17, Jiri Slaby 写道:
> Hi,
>
> On 17. 08. 21, 15:22, Xianting Tian wrote:
>> As well known, hvc backend can register its opertions to hvc backend.
>> the opertions contain put_chars(), get_chars() and so on.
>
> "operations". And there too:
>
>> Some hvc backend may do dma in its opertions. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>> 1, c[] is on stack,
>>     hvc_console_print():
>>     char c[N_OUTBUF] __ALIGNED__;
>>     cons_ops[index]->put_chars(vtermnos[index], c, i);
>> 2, ch is on stack,
>>     static void hvc_poll_put_char(,,char ch)
>>     {
>>     struct tty_struct *tty = driver->ttys[0];
>>     struct hvc_struct *hp = tty->driver_data;
>>     int n;
>>
>>     do {
>>         n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>>     } while (n <= 0);
>>     }
>>
>> Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
>> is passed to virtio-console by hvc framework in above code. But I think
>> the fix is aggressive, it directly uses kmemdup() to alloc new buffer
>> from kmalloc area and do memcpy no matter the memory is in kmalloc area
>> or not. But most importantly, it should better be fixed in the hvc
>> framework, by changing it to never pass stack memory to the put_chars()
>> function in the first place. Otherwise, we still face the same issue if
>> a new hvc backend using dma added in the furture.
>>
>> We make 'char c[N_OUTBUF]' part of 'struct hvc_struct', so hp->c is no
>> longer the stack memory. we can use it in above two cases.
>
> In fact, you need only a single char for the poll case 
> (hvc_poll_put_char), so hvc_struct needs to contain only c, not an array.
>
> OTOH, you need c[N_OUTBUF] in the console case (hvc_console_print), 
> but not whole hvc_struct. So cons_hvcs should be an array of structs 
> composed of only the lock and the buffer.
>
> Hum.
>
> Or maybe rethink and take care of the console case by kmemdup and be 
> done with that case? What problem do you have with allocating 16 
> bytes? It should be quite easy and really fast (lockless) in most 
> cases. On the contrary, your solution has to take a spinlock to access 
> the global buffer.

May be we can change hvc_struct as below,

struct hvc_struct {

         ...
         char out_ch;
         char c[N_OUTBUF] __ALIGNED__;
         int outbuf_size;
         char outbuf[0] __ALIGNED__;
};

c[N_OUTBUF]  is only used for hvc_console_print(); out_ch is only used 
for hvc_poll_put_char(). Thus no competition exits, the spinlock can be 
removed.

Then cons_hvcs array can only contains the buffer.

Is it OK for you?  thanks
>
>> Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
>> dma alignment is wrong. And use struct_size() to calculate size of
>> hvc_struct.
>
> This ought to be in separate patches.
OK, thanks
>
> thanks,
