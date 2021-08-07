Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Aug 2021 15:01:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E552560249
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Aug 2021 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E552560249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ghlsm2BQpz30C9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Aug 2021 01:01:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GhlsL1r7sz303D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Aug 2021 01:00:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0UiE-spl_1628348428; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0UiE-spl_1628348428) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 07 Aug 2021 23:00:32 +0800
Subject: Re: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Arnd Bergmann <arnd@arndb.de>
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
 <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
 <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <0b689760-6da4-f796-633a-059fa758bbf3@linux.alibaba.com>
Date: Sat, 7 Aug 2021 23:00:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Jiri Slaby <jirislaby@kernel.org>, Amit Shah <amit@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Guo Ren <guoren@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Omar Sandoval <osandov@fb.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


在 2021/8/6 下午10:51, Arnd Bergmann 写道:
> On Fri, Aug 6, 2021 at 5:01 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> @@ -163,6 +155,13 @@ static void hvc_console_print(struct console *co, const char *b,
>>          if (vtermnos[index] == -1)
>>                  return;
>>
>> +       list_for_each_entry(hp, &hvc_structs, next)
>> +               if (hp->vtermno == vtermnos[index])
>> +                       break;
>> +
>> +       c = hp->c;
>> +
>> +       spin_lock_irqsave(&hp->c_lock, flags);
> The loop looks like it might race against changes to the list. It seems strange
> that the print function has to actually search for the structure here.
>
> It may be better to have yet another array for the buffer pointers next to
> the cons_ops[] and vtermnos[] arrays.
I will make the change in v5, thanks.
>
>> +/*
>> + * These sizes are most efficient for vio, because they are the
>> + * native transfer size. We could make them selectable in the
>> + * future to better deal with backends that want other buffer sizes.
>> + */
>> +#define N_OUTBUF       16
>> +#define N_INBUF                16
>> +
>> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
> I think you need a higher alignment for DMA buffers, instead of sizeof(long),
> I would suggest ARCH_DMA_MINALIGN.

thanks, I will fix it in v5:

#define __ALIGNED__ __attribute__((__aligned__(ARCH_DMA_MINALIGN)))

>
>         Arnd
