Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8749C606CF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 21:03:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FECB2173C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 21:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ogfiwj3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FECB2173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45jHx301FQzDqRS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jul 2019 07:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p00-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5300::11; helo=mo6-p00-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ogfiwj3j"; 
 dkim-atps=neutral
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45jHv111hYzDqCB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2019 07:01:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562619697;
 s=strato-dkim-0002; d=xenosoft.de;
 h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=F62XObaQbKX5UzgMX5MV9Y4b3bmEnsz1M6HJYtnDS9s=;
 b=Ogfiwj3jfmrqYfNRG2OsuIfACty56G4RX3F18AaCGXyTgyS8jVl79iR/cg3344oW9J
 Db2pqXJsfbxqVliniZZvPuRJF/g4GtUcaKSdgtGlav9g7Q9PdzuBIBxwNskZkqLxZCJu
 Ax5cgB0gULyqfthWNh5FpsxFeXzdDybZSfFf3yTtnE7K859mYUIK4hKy2OBBZsqGAE2o
 kee9KnAX1bszvGtOKTbduoK9twLnQd1MUmsiEfRqYlmTR10TAE6ZYFD5wG5AFJrl0/ZG
 bEZoMNzc4XLX61XToe784UbB8qcpxtLjmiofF8K+exPsx734yXGJxq0zNkAU+CZWlLQT
 6+3Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgGI+pr5th5jHa812ZIRY+g7442fQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:e50f:93c9:7e15:41d8]
 by smtp.strato.de (RZmta 44.24 AUTH) with ESMTPSA id U0b154v68L1X5Zu
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 8 Jul 2019 23:01:33 +0200 (CEST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, wen.yang99@zte.com.cn
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH v3] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <3c1d01ef-5d2a-2ec6-aeeb-b7936515a119@xenosoft.de>
Date: Mon, 8 Jul 2019 23:01:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Wen,

Thanks for your patch!

Did you test your patch with a P.A. Semi board?

Cheers,
Christian
