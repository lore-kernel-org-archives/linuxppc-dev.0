Return-Path: <SRS0=QJlM=AF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C7AC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A99E2076E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2020 23:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="N3n8DDOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A99E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49sdxL56c8zDqq7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2020 09:03:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.25;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=N3n8DDOJ; 
 dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49sdvK695KzDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2020 09:02:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1593039717;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=jNwJPgbXWSY5k3ONcpmWSpzVAtyG7kyzLOQfdxBIq78=;
 b=N3n8DDOJUmenEyBJtv9r756W7RX0vT/Xi5Rdd+1Eg7ZR+gFW5HVOQJPcn2mKF47xE9
 ++9v40/jRxIP/ih28DAfRWaXIVRlEZkvJ7JAuYAby8ZXnC13zzIwdjFqS140L+bFL3Xj
 XyynnQ6J3msOYU0BS/0BRVcYBLqEV/E6jKGT6j1fejlhXz1owKToeaYkfRlkGR+9POXQ
 FonlGgjdzrsuWHM6JMDIWbEQPOi3yVJhC3tpemd21vXJ900Sfe2Oy9ZSSX2z0oySDF3s
 gR+CDTfjv66oMlkA7/GpcvEWJhyxBvHajBGJj44qR+tP+qNfO1J874WUu+NDmx+b61Rq
 BNBA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgGJ0QV6eoJYgVI5+ZHl6Cxch0QSA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:e17f:c1c2:dced:2bd3]
 by smtp.strato.de (RZmta 46.10.5 AUTH)
 with ESMTPSA id 60686ew5ON1q442
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 25 Jun 2020 01:01:52 +0200 (CEST)
Subject: Re: FSL P5020/P5040: DPAA Ethernet issue with the latest Git kernel
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <56DB95B8-5F42-4837-ABA0-7E580FE04B73@xenosoft.de>
 <20200624082352.GA24934@oc3871087118.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <004794fb-370c-c165-38e6-a451dc50c294@xenosoft.de>
Date: Thu, 25 Jun 2020 01:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624082352.GA24934@oc3871087118.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 24 June 2020, at 10:23 am, Alexander Gordeev wrote:
> On Sun, Jun 21, 2020 at 08:40:14AM +0200, Christian Zigotzky wrote:
>> Hello Alexander,
>>
>> The DPAA Ethernet doesn’t work anymore on our FSL P5020/P5040 boards [1] since the RC1 of kernel 5.8 [2].
>> We bisected last days [3] and found the problematic commit [4]. I was able to revert it [5]. After that the DPAA Ethernet works again. I created a patch for reverting the commit [5]. This patch works and I will use it for the RC2.
>> Could you please check your commit? [4]
> Hi Christian,
>
> Could you please check if the kernel passes CONFIG_TEST_BITMAP self-test?
>
> Thanks!
>
>> Thanks,
>> Christian
>>
>> [1] http://wiki.amiga.org/index.php?title=X5000
>> [2] https://forum.hyperion-entertainment.com/viewtopic.php?p=50885#p50885
>> [3] https://forum.hyperion-entertainment.com/viewtopic.php?p=50892#p50892
>> [4] lib: fix bitmap_parse() on 64-bit big endian archs: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=81c4f4d924d5d009b5ed785a3e22b18d0f7b831f
>> [5] https://forum.hyperion-entertainment.com/viewtopic.php?p=50982#p50982
>>
>>
Hi Alexander,

Thanks for your reply!

I compiled a test kernel with the option "CONFIG_TEST_BITMAP=y" 
yesterday. After that Skateman and I booted it and looked for the bitmap 
tests with "dmesg | grep -i bitmap".

Results:

FSL P5020:

[    0.297756] test_bitmap: loaded.
[    0.298113] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, 
Time: 562
[    0.298142] test_bitmap: parselist_user: 14: input is 
'0-2047:128/256' OK, Time: 761
[    0.301553] test_bitmap: all 1663 tests passed

FSL P5040:

[    0.296563] test_bitmap: loaded.
[    0.296894] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, 
Time: 540
[    0.296920] test_bitmap: parselist_user: 14: input is 
'0-2047:128/256' OK, Time: 680
[    0.299994] test_bitmap: all 1663 tests passed

Thanks,
Christian
