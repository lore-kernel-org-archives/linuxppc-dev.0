Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91192C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 09:23:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88E820657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="apYhu8Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88E820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gJX86DYnzDqmT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 20:23:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::1; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="apYhu8Ru"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gJVL0mmszDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 20:21:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547716885;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=IYaHkj5lFuCS1o0NpM2A895kbFVDdTVOQs5mRSCoyk0=;
 b=apYhu8RuaVGgmdn47ruf9floxchyLFsjJVUewJxWK7aOkA5SoIjO6GgwRQt0/+osp8
 CMZseh2uWncxAhHkWNi3LKJMevYmylumEO56PqCuSidA9kk3itOGqm6NX9+s7O0V66HU
 hYk0SQ0eo+Tst7R7DYpB/ztB+fM23zvOXKuMnAteLMb6YyoiGlTj2eVhA9qYD/WQjkM8
 b4KF7mwq9hSVJUy4iVdAOW3I9YcurUoNAxaewOiVJutACrCgzfs/Dg0Yx3FEhpzDbJW7
 oesx0DvyxzjmwKaBfaZTHHHWdf35tcAisQinKBx7naEazJlVR3PPVEno+SlVi/YcdQLW
 o7yQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkN2lRWMpIV4miMvSq1nazBhLEi"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:2d08:5cb1:24de:823]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0H9LC2Db
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 17 Jan 2019 10:21:12 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
 <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
Date: Thu, 17 Jan 2019 10:21:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115151732.GA2325@lst.de>
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

I compiled the fixed '257002094bc5935dd63207a380d9698ab81f0775' 
(powerpc/dma: use the dma-direct allocator for coherent platforms) today.

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 257002094bc5935dd63207a380d9698ab81f0775

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6 


env LANG=C make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc zImage

env LANG=C make CROSS_COMPILE=powerpc-linux-gnu- ARCH=powerpc uImage

The X1000 boots and the PASEMI onboard ethernet works!

Bad news for the X5000 (P5020 board). U-Boot loads the kernel and the 
dtb file. Then the kernel starts but it doesn't find any hard disks 
(partitions).

Cheers,
Christian


On 15 January 2019 at 4:17PM, Christoph Hellwig wrote:

So 257002094bc5935dd63207a380d9698ab81f0775 above is the fixed version
for the commit - this switched the ifdef in dma.c around that I had
inverted.  Can you try that one instead?  And then move on with the
commits after it in the updated powerpc-dma.6 branch - they are
identical to the original branch except for carrying this fix forward.
