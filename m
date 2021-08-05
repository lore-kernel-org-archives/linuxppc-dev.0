Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918FCC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 08:20:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CAB6104F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 08:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06CAB6104F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgM3g5Pb2z3d85
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 18:19:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgLq42lTGz2xtj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 18:09:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R781e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0Ui1UakR_1628150926; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0Ui1UakR_1628150926) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 05 Aug 2021 16:08:47 +0800
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 amit@kernel.org, arnd@arndb.de, osandov@fb.com
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
Date: Thu, 5 Aug 2021 16:08:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------89017586A9F754D3FF14BE18"
X-Mailman-Approved-At: Thu, 05 Aug 2021 18:19:18 +1000
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

This is a multi-part message in MIME format.
--------------89017586A9F754D3FF14BE18
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2021/8/5 下午3:58, Jiri Slaby 写道:
> Hi,
>
> On 04. 08. 21, 4:54, Xianting Tian wrote:
>> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, 
>> int data,
>>       hp->outbuf_size = outbuf_size;
>>       hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
>>   +    /*
>> +     * hvc_con_outbuf is guaranteed to be aligned at least to the
>> +     * size(N_OUTBUF) by kmalloc().
>> +     */
>> +    hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
>> +    if (!hp->hvc_con_outbuf)
>> +        return ERR_PTR(-ENOMEM);
>
> This leaks hp, right?
>
> BTW your 2 patches are still not threaded, that is hard to follow.

yes, thanks, I found the bug, I am preparing to do this in v4.

It is the first time I send series patches(number >1), I checked the 
method for sending series patch on LKML.org, I should send '0/2' which 
is the history info for series patches.

I will add 0/2 in v4, sorry again for this:(

beside avove things, the solution in this patch is for you? thanks

>
>> +
>> +    spin_lock_init(&hp->hvc_con_lock);
>> +
>>       tty_port_init(&hp->port);
>>       hp->port.ops = &hvc_port_ops;
>
> thanks,

--------------89017586A9F754D3FF14BE18
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2021/8/5 下午3:58, Jiri Slaby 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org">Hi,
      <br>
      <br>
      On 04. 08. 21, 4:54, Xianting Tian wrote:
      <br>
      <blockquote type="cite">@@ -933,6 +949,16 @@ struct hvc_struct
        *hvc_alloc(uint32_t vtermno, int data,
        <br>
              hp-&gt;outbuf_size = outbuf_size;
        <br>
              hp-&gt;outbuf = &amp;((char *)hp)[ALIGN(sizeof(*hp),
        sizeof(long))];
        <br>
          +    /*
        <br>
        +     * hvc_con_outbuf is guaranteed to be aligned at least to
        the
        <br>
        +     * size(N_OUTBUF) by kmalloc().
        <br>
        +     */
        <br>
        +    hp-&gt;hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
        <br>
        +    if (!hp-&gt;hvc_con_outbuf)
        <br>
        +        return ERR_PTR(-ENOMEM);
        <br>
      </blockquote>
      <br>
      This leaks hp, right?
      <br>
      <br>
      BTW your 2 patches are still not threaded, that is hard to follow.
      <br>
    </blockquote>
    <p>yes, thanks, I found the bug, I am preparing to do this in v4.<span
        style="color: rgb(51, 51, 51); font-family: Arial, sans-serif;
        font-size: 13px; font-style: normal; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"><br>
      </span></p>
    <p>It is the first time I send series patches(number &gt;1), I
      checked the method for sending series patch on LKML.org, I should
      send '0/2' which is the history info for series patches. <br>
    </p>
    <p>I will add 0/2 in v4, sorry again for this:(</p>
    <p>beside avove things, the solution in this patch is for you?
      thanks <br>
      <span style="color: rgb(51, 51, 51); font-family: Arial,
        sans-serif; font-size: 13px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"></span></p>
    <blockquote type="cite"
      cite="mid:0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org">
      <br>
      <blockquote type="cite">+
        <br>
        +    spin_lock_init(&amp;hp-&gt;hvc_con_lock);
        <br>
        +
        <br>
              tty_port_init(&amp;hp-&gt;port);
        <br>
              hp-&gt;port.ops = &amp;hvc_port_ops;
        <br>
          </blockquote>
      <br>
      thanks,
      <br>
    </blockquote>
  </body>
</html>

--------------89017586A9F754D3FF14BE18--
