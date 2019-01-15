Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09CDC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBA520657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 13:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="RrLLUPfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBA520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fBlL1l0HzDqDV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 00:58:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::7; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="RrLLUPfX"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fBj13HQHzDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 00:56:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547560608;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=qjQYj2poIqFNPGRwB16+nYsywTx1PQvvhTI5rvcaBgI=;
 b=RrLLUPfXurj0+YXCgH50VklEz+dEeI8cf8rkCHM3Xm6pQtWP1e9yR6TyHQxU1kQB0d
 p6riTy+KGFyJcbcqySmKH8tgMKtWXYyqfyyMVCBle227nXoISTsNt4HJ2U82XF0GPJw4
 3xZ9NgQBlgCfLL1/lKJNRP7L2vQX03eF3W4ZWF5WcBD5/2vo2Ygz32tcDt3tQ6lKkKvJ
 DzEgfUgS6YdzsBEbVNttGrlDPoKSumSg9mne2pM/a+kdGGH986t+9e0mP8qhK7iIMVaC
 PG2WbYDlgHgfdvNwc4aPvqcnCxyVw3pexFXwbp/iLEts1r5wuO+AAuHmoV2dPlYaKl2Z
 jC3Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkNi0C2kzEbDQg0vrQvOCYvo/qC"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:25bb:7249:5b2a:1f0]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0FDuYsN4
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 15 Jan 2019 14:56:34 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
 <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
Date: Tue, 15 Jan 2019 14:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115133558.GA29225@lst.de>
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

On 15 January 2019 at 2:35PM, Christoph Hellwig wrote:
> On Tue, Jan 15, 2019 at 11:55:25AM +0100, Christian Zigotzky wrote:
>> Next step: 21074ef03c0816ae158721a78cabe9035938dddd (powerpc/dma: use the
>> generic direct mapping bypass)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout 21074ef03c0816ae158721a78cabe9035938dddd
>>
>> I was able to compile the kernel for the AmigaOne X1000 (Nemo board with PA
>> Semi PA6T-1682M SoC). It boots but the PA Semi onboard ethernet doesn't
>> work.
> Thanks.  But we are exactly missing the steps that are relevant.  I've
> pushed a fixed up powerpc-dma.6 tree, which will only change starting from
> the first commit that didn't link.
>
> The first commit that changed from the old one is this one:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/257002094bc5935dd63207a380d9698ab81f0775
>
> which was that one that your compile failed on first.
>
> Thanks again for all your work!
>
Thank you! I tried the commit 240d7ecd7f6fa62e074e8a835e620047954f0b28 
(powerpc/dma: use the dma-direct allocator for coherent platforms) again.

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 240d7ecd7f6fa62e074e8a835e620047954f0b28

I modified the 'dma.c' patch because of the undefined references to 
'__dma_nommu_free_coherent' and '__dma_nommu_alloc_coherent':

---

@@ -163,8 +99,13 @@ static inline void dma_nommu_sync_single(struct 
device *dev,
  #endif

  const struct dma_map_ops dma_nommu_ops = {
+       .alloc                          = dma_direct_alloc,
+       .free                           = dma_direct_free,
         .map_sg                         = dma_nommu_map_sg,
         .unmap_sg                       = dma_nommu_unmap_sg,
         .dma_supported                  = dma_direct_supported,

---

The X1000 boots and the PASEMI onboard ethernet works! X5000 (P5020 
board): U-Boot loads the kernel and the dtb file. Then the kernel starts 
but it doesn't find any hard disks (partitions).

-- Christian

