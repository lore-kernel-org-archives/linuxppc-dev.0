Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F2AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 23:38:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93C860EE3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Aug 2021 23:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C93C860EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GdvbD3Jltz3d7y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GdWTs1Rb8z2yL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Aug 2021 18:32:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UhkYpQP_1627893150; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0UhkYpQP_1627893150) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 02 Aug 2021 16:32:31 +0800
Subject: Re: [PATCH 2/2] virtio-console: remove unnecessary kmemdup()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 amit@kernel.org, arnd@arndb.de
References: <20210801051655.79048-1-xianting.tian@linux.alibaba.com>
 <b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <5ad81a0e-fbb2-a849-6db7-f5718633d282@linux.alibaba.com>
Date: Mon, 2 Aug 2021 16:32:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------5546104638CD853A0222348F"
X-Mailman-Approved-At: Tue, 03 Aug 2021 09:38:00 +1000
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
Cc: osandov@fb.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------5546104638CD853A0222348F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2021/8/2 下午3:25, Jiri Slaby 写道:
> Hi,
>
> why is this 2/2? I seem (Lore neither) to find 1/2.
You didn't receive 1/2?
[PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/1/8 <https://lkml.org/lkml/2021/8/1/8>
>
> On 01. 08. 21, 7:16, Xianting Tian wrote:
>> hvc framework will never pass stack memory to the put_chars() function,
>
> Am I blind or missing something?
>
> hvc_console_print(...)
> {
>   char c[N_OUTBUF]
> ...
>   cons_ops[index]->put_chars(vtermnos[index], c, i);
>
> The same here:
>
> hvc_poll_put_char(..., char ch)
> {
> ...
>    n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>
> AFAICS both of them *pass* a pointer to stack variable.

yes, I discussed the issue with Arnd before in below thread,  you can 
get the history, thanks

https://lkml.org/lkml/2021/7/27/494 <https://lkml.org/lkml/2021/7/27/494>

>
>> So the calling of kmemdup() is unnecessary, remove it.
>>
>> Fixes: c4baad5029 ("virtio-console: avoid DMA from stack")
>
> This patch doesn't "Fix" -- it reverts the commit. You should've CCed 
> the author too.

yes, we discussed ther issue in above thread, which we CCed the author.

>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   drivers/char/virtio_console.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/char/virtio_console.c 
>> b/drivers/char/virtio_console.c
>> index 7eaf303a7..4ed3ffb1d 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -1117,8 +1117,6 @@ static int put_chars(u32 vtermno, const char 
>> *buf, int count)
>>   {
>>       struct port *port;
>>       struct scatterlist sg[1];
>> -    void *data;
>> -    int ret;
>>         if (unlikely(early_put_chars))
>>           return early_put_chars(vtermno, buf, count);
>> @@ -1127,14 +1125,8 @@ static int put_chars(u32 vtermno, const char 
>> *buf, int count)
>>       if (!port)
>>           return -EPIPE;
>>   -    data = kmemdup(buf, count, GFP_ATOMIC);
>> -    if (!data)
>> -        return -ENOMEM;
>> -
>> -    sg_init_one(sg, data, count);
>> -    ret = __send_to_port(port, sg, 1, count, data, false);
>> -    kfree(data);
>> -    return ret;
>> +    sg_init_one(sg, buf, count);
>> +    return __send_to_port(port, sg, 1, count, (void *)buf, false);
>>   }
>>     /*
>>
>
>

--------------5546104638CD853A0222348F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2021/8/2 下午3:25, Jiri Slaby 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org">Hi,
      <br>
      <br>
      why is this 2/2? I seem (Lore neither) to find 1/2.
      <br>
    </blockquote>
    You didn't receive 1/2?<br>
    <span style="color: rgb(0, 0, 0); font-family: courier, monospace;
      font-size: medium; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      text-decoration-style: initial; text-decoration-color: initial;
      display: inline !important; float: none;">[PATCH 1/2] tty: hvc:
      pass DMA capable memory to put_chars()</span><br>
    <a href="https://lkml.org/lkml/2021/8/1/8">https://lkml.org/lkml/2021/8/1/8</a>
    <blockquote type="cite"
      cite="mid:b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org">
      <br>
      On 01. 08. 21, 7:16, Xianting Tian wrote:
      <br>
      <blockquote type="cite">hvc framework will never pass stack memory
        to the put_chars() function,
        <br>
      </blockquote>
      <br>
      Am I blind or missing something?
      <br>
      <br>
      hvc_console_print(...)
      <br>
      {
      <br>
        char c[N_OUTBUF]
      <br>
      ...
      <br>
        cons_ops[index]-&gt;put_chars(vtermnos[index], c, i);
      <br>
      <br>
      The same here:
      <br>
      <br>
      hvc_poll_put_char(..., char ch)
      <br>
      {
      <br>
      ...
      <br>
         n = hp-&gt;ops-&gt;put_chars(hp-&gt;vtermno, &amp;ch, 1);
      <br>
      <br>
      AFAICS both of them *pass* a pointer to stack variable.
      <br>
    </blockquote>
    <p>yes, I discussed the issue with Arnd before in below thread,  you
      can get the history, thanks<br>
    </p>
    <p><a href="https://lkml.org/lkml/2021/7/27/494">https://lkml.org/lkml/2021/7/27/494</a>
    </p>
    <blockquote type="cite"
      cite="mid:b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org">
      <br>
      <blockquote type="cite">So the calling of kmemdup() is
        unnecessary, remove it.
        <br>
        <br>
        Fixes: c4baad5029 ("virtio-console: avoid DMA from stack")
        <br>
      </blockquote>
      <br>
      This patch doesn't "Fix" -- it reverts the commit. You should've
      CCed the author too.
      <br>
    </blockquote>
    <p>yes, we discussed ther issue in above thread, which we CCed the
      author.</p>
    <blockquote type="cite"
      cite="mid:b5554967-a683-96ae-deb9-2d4980d33b41@kernel.org">
      <br>
      <blockquote type="cite">Signed-off-by: Xianting Tian
        <a class="moz-txt-link-rfc2396E" href="mailto:xianting.tian@linux.alibaba.com">&lt;xianting.tian@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
          drivers/char/virtio_console.c | 12 ++----------
        <br>
          1 file changed, 2 insertions(+), 10 deletions(-)
        <br>
        <br>
        diff --git a/drivers/char/virtio_console.c
        b/drivers/char/virtio_console.c
        <br>
        index 7eaf303a7..4ed3ffb1d 100644
        <br>
        --- a/drivers/char/virtio_console.c
        <br>
        +++ b/drivers/char/virtio_console.c
        <br>
        @@ -1117,8 +1117,6 @@ static int put_chars(u32 vtermno, const
        char *buf, int count)
        <br>
          {
        <br>
              struct port *port;
        <br>
              struct scatterlist sg[1];
        <br>
        -    void *data;
        <br>
        -    int ret;
        <br>
                if (unlikely(early_put_chars))
        <br>
                  return early_put_chars(vtermno, buf, count);
        <br>
        @@ -1127,14 +1125,8 @@ static int put_chars(u32 vtermno, const
        char *buf, int count)
        <br>
              if (!port)
        <br>
                  return -EPIPE;
        <br>
          -    data = kmemdup(buf, count, GFP_ATOMIC);
        <br>
        -    if (!data)
        <br>
        -        return -ENOMEM;
        <br>
        -
        <br>
        -    sg_init_one(sg, data, count);
        <br>
        -    ret = __send_to_port(port, sg, 1, count, data, false);
        <br>
        -    kfree(data);
        <br>
        -    return ret;
        <br>
        +    sg_init_one(sg, buf, count);
        <br>
        +    return __send_to_port(port, sg, 1, count, (void *)buf,
        false);
        <br>
          }
        <br>
            /*
        <br>
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------5546104638CD853A0222348F--
