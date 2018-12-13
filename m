Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A448C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:44:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C092075B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 08:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="tIdjypSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C092075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FnLG6pHvzDqrT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 19:44:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="tIdjypSt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::12; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="tIdjypSt"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43FnH670LnzDqnB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 19:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544690523;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Bfvpromnms5UokDyRtp7mH4KUnO6cTFACJPyYkrfIZw=;
 b=tIdjypSts0G9v3lFT9xSznIoav5ac2d3cXtoD9rhjwhDGqaIImhDlb/XZnZNd220+R
 Sqax3oAfJHl7tICMKlh+NsvCmTqA11TG97texcz/6630vS1a+34FxFXEF4NZYvY8RBS3
 HWVcesknIex5Wx8NvtQfn1NFYG++12KgQJRVkWyfnE0+FBnk4elwJakXi0AtDuSnrQ2L
 k+39qn44ftQAuP78VRl4L7xXdVyzej5cS6YPTXyJHgA/rw6KXFn6iRk8c61n1aKHwjMS
 SyytAfTZWQgcGTUg2QNCdH6XDs9PwzWfY+5l3tpXTJv/UgizgQvJ8qtQXdxSNGi7hBc2
 GTZg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CldjnHGzWIOkKp9XQtfSmiGNPVi3g=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:b0df:52d4:ca12:299b]
 by smtp.strato.de (RZmta 44.7 AUTH) with ESMTPSA id j074b8uBD8foG3D
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 13 Dec 2018 09:41:50 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
Message-ID: <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
Date: Thu, 13 Dec 2018 09:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
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

On 12 December 2018 at 3:39PM, Christian Zigotzky wrote:
> Hi Christoph,
>
> Thanks a lot for your reply. I will test your patches tomorrow.
>
> Cheers,
> Christian
>
> Sent from my iPhone
>
>> On 12. Dec 2018, at 15:15, Christoph Hellwig <hch@lst.de> wrote:
>>
>> Thanks for bisecting.  I've spent some time going over the conversion
>> but can't really pinpoint it.  I have three little patches that switch
>> parts of the code to the generic version.  This is on top of the
>> last good commmit (977706f9755d2d697aa6f45b4f9f0e07516efeda).
>>
>> Can you check with whіch one things stop working?
>>
>>
>> <0001-get_required_mask.patch>
>> <0002-swiotlb-dma_supported.patch>
>> <0003-nommu-dma_supported.patch>
>> <0004-alloc-free.patch>

Today I tried the first patch (0001-get_required_mask.patch) with the 
last good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). 
Unfortunately this patch is already included in the last good commit 
(977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.

-- Christian


