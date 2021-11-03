Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF63C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 21:40:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CA2610A8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Nov 2021 21:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45CA2610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hl0ZH6R5kz2ywn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Nov 2021 08:40:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=cuibixuan@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hkdhy22dWz2xrl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Nov 2021 18:30:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R521e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=cuibixuan@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UusDGT3_1635924614; 
Received: from 30.225.28.86(mailfrom:cuibixuan@linux.alibaba.com
 fp:SMTPD_---0UusDGT3_1635924614) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 03 Nov 2021 15:30:14 +0800
Content-Type: multipart/alternative;
 boundary="------------BYtl3zSEZc0QXGmzUwOcjkhn"
Message-ID: <e1f3c2bb-d4e2-e3d8-9057-688382a70059@linux.alibaba.com>
Date: Wed, 3 Nov 2021 15:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH -next] powerpc/44x/fsp2: add missing of_node_put
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1635406102-88719-1-git-send-email-cuibixuan@linux.alibaba.com>
 <163584792552.1845480.16701207323198181302.b4-ty@ellerman.id.au>
From: Bixuan Cui <cuibixuan@linux.alibaba.com>
In-Reply-To: <163584792552.1845480.16701207323198181302.b4-ty@ellerman.id.au>
X-Mailman-Approved-At: Thu, 04 Nov 2021 08:40:32 +1100
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
Cc: ivan@de.ibm.com, paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a multi-part message in MIME format.
--------------BYtl3zSEZc0QXGmzUwOcjkhn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2021/11/2 下午6:12, Michael Ellerman 写道:
>> Early exits from for_each_compatible_node() should decrement the
>> node reference counter.  Reported by Coccinelle:
>>
>> ./arch/powerpc/platforms/44x/fsp2.c:206:1-25: WARNING: Function
>> "for_each_compatible_node" should have of_node_put() before return
>> around line 218.
>>
>> [...]
> Applied to powerpc/next.
>
> [1/1] powerpc/44x/fsp2: add missing of_node_put
>        https://git.kernel.org/powerpc/c/290fe8aa69ef5c51c778c0bb33f8ef0181c769f5

Thanks. :-)


Bixuan Cui

--------------BYtl3zSEZc0QXGmzUwOcjkhn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2021/11/2 下午6:12, Michael Ellerman
      写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:163584792552.1845480.16701207323198181302.b4-ty@ellerman.id.au">
      <blockquote type="cite" style="color: #007cff;">
        <pre class="moz-quote-pre" wrap="">Early exits from for_each_compatible_node() should decrement the
node reference counter.  Reported by Coccinelle:

./arch/powerpc/platforms/44x/fsp2.c:206:1-25: WARNING: Function
"for_each_compatible_node" should have of_node_put() before return
around line 218.

[...]
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Applied to powerpc/next.

[1/1] powerpc/44x/fsp2: add missing of_node_put
      <a class="moz-txt-link-freetext" href="https://git.kernel.org/powerpc/c/290fe8aa69ef5c51c778c0bb33f8ef0181c769f5" moz-do-not-send="true">https://git.kernel.org/powerpc/c/290fe8aa69ef5c51c778c0bb33f8ef0181c769f5</a></pre>
    </blockquote>
    <p>Thanks. :-)<br>
    </p>
    <p><br>
    </p>
    <p>Bixuan Cui<br>
    </p>
  </body>
</html>
--------------BYtl3zSEZc0QXGmzUwOcjkhn--

