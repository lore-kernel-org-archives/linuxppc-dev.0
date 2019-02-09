Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDAC282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 21:27:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDA621929
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDA621929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xlWW1DgJzDqVJ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 08:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xlTV1lpGzDqSc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 08:25:49 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.237]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPA (Nemesis) id
 1N2BQM-1hFF1e2EFa-013ciY; Sat, 09 Feb 2019 22:12:52 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: Christoph Hellwig <hch@lst.de>
Date: Sat, 09 Feb 2019 21:10:58 +0000 (GMT)
Message-ID: <4d5302a8b75.61849dba@auth.smtp.1and1.co.uk>
In-Reply-To: <20190208091818.GA23491@lst.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: Re: use generic DMA mapping code in powerpc V4
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:SWtdbAmuF5oWHVG0iVqb+VmTq5SfUqG+M3Vz+yEx3ywU4kmnJgz
 i+WU8+tBHdXB+9w3T6CTYQ7rL/+S+pogfcb9xwIxrlaNxOejc+tmS2Tk3ZsJvG6hwzNLEYg
 D+6BMEKDBWCrxkgCzr7L5KP2WMTEQLFxvdnosJldyhHooAMPNoBE/rM4g0w+k2fmuEP3FNZ
 fZMVW1oPc6URjPxRUvS8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDKyDsX5uBg=:WXeW71GYK4R8KGd43F1vuR
 8+/droYaxxFRZN1QB1SlFh/kwIoZAGXNt9QaJNVftN96GIwJXrBYPlsfgjc0jDjx4y1orUSS+
 FWwKLX4ralDl04uV6NMXd1ClMOO9+MX+ouwTtXu4YWDPvcHaxqSJmDfLZE/7UIUoUNPkFrKJN
 6Mbe0zVWvR+XC02HNEg3uJtGPOCROGZZyvZLfTAslOK1f+ZCucVBRBsWz1FZMcwJjKL/W9HtC
 ayjPhLCbQRnqbRhd4inoQlFnS4yj2viwP97P0Dj5gjmE7HBTneYj2Az9kohUBAUGukAMGBYpX
 oA7R7yESjbqVViqovEdz+8C50gY6ySkA019IwmR9QnZk3xxEQhHWSU6LO6jYgi25yO7o0Q7+7
 bWQOA8geAAJGuf+/KOvjAkUkqn9axUpNCz18H9etYGXIWUbXKBW4rQomXNDvHB68MqtnDVagn
 /O4KZPcf71G/sZvqWVsXnYTkyvZS1p1IPHJHe3Z/sxNaYUdV0j31T5ZIuzZze0qcnXe0IYEp/
 QbkTH9bcqkq0fNxt4BnPpZIyouEmYsOlKdQIOeVjtQ62dyZWI+9eCBFASGFU1Kk5fhT8kxtqO
 53RHkJUbv3fRJLDV4DcLZK9P20sst/b8Jaei3Yw+RnyqOM3xDBYsyDZcdaA523dcArUXRRdnc
 Ou+9VeNO3jvglAxgbabgzUCXNLJKirDZc3fkw+LokyLOW7y2f3JsE97TLqLRIh2nr/McgUhu+
 nbmkJGQO9LcoauwzeJluAaFLPCsPKxW4cP/xYECo63GmwiqodHWv3kIXaEc=
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
Cc: linuxppc-dev@lists.ozlabs.org, Julian Margetson <runaway@candw.ms>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Christoph

On 08/02/2019, Christoph Hellwig wrote:
> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
>
> Thanks a lot once again for testing!
>
> Now can you test with this patch and the whole series?
>
> I've updated the powerpc-dma.6 branch to include this fix.

Update: I found the following in my dmesg, think it points to an of-by-one error in the pfn selection:

Feb  9 19:47:00 Cyrus kernel: [    0.000000] Top of RAM: 0x200000000, Total RAM: 0x200000000
Feb  9 19:47:00 Cyrus kernel: [    0.000000] Memory hole size: 0MB
Feb  9 19:47:00 Cyrus kernel: [    0.000000] Zone ranges:
Feb  9 19:47:00 Cyrus kernel: [    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffefff]
Feb  9 19:47:00 Cyrus kernel: [    0.000000]   Normal   [mem 0x000000007ffff000-0x00000001ffffffff]

I had a quick look but couldn't see where though.

Regards
Darren

