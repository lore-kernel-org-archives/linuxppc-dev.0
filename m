Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF3C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:50:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FD820882
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ob7BXChx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FD820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FpnR67hpzDqdc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 20:50:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ob7BXChx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Ob7BXChx"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fpkg2T6DzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 20:47:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544694452;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=OgkIjYTVAghMHYNbTQQs7wlhsYtJAPI86xVTVQ+Yu8w=;
 b=Ob7BXChxflb3Mu6KLOOHRBB0fZLdvHQ0sOqEIbhK1Pv6EDz2/P/AZqjRWwZa5n6qzM
 JvBkvdfsmRNyRYr6ZoOnihgs9p6l8PPIgRFGQSmrVjLDNOc5/sMnj6aSCHnzW56Hp8Hi
 yirdkA/HmJNykZVNp1gtR7ySC0Hl0m74EO3R2/0xRz/Ao0CDHwpbB6b0o8JUp+X63vY1
 TtILvRautRBx1B6L+NZ0kJrBefrXb4DSHobQ631ys/mMHfF7selVb9BgpFLJZ/pbcoAF
 KaiDkUkfImO1VrkXdMAyXQef43cbqsIxGkTkg5atpRzpTU94VL+6ouJjWoHCJ6DwKOI/
 zVMw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkH2j1S+d7f+qCRMaRzyLzUgdHjSA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:8d43:e6ec:d963:b7de]
 by smtp.strato.de (RZmta 44.8 AUTH) with ESMTPSA id e03c1euBD9lJ0Qm
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 13 Dec 2018 10:47:19 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
Date: Thu, 13 Dec 2018 10:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213091021.GA2106@lst.de>
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 13 December 2018 at 10:10AM, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 09:41:50AM +0100, Christian Zigotzky wrote:
>> Today I tried the first patch (0001-get_required_mask.patch) with the last
>> good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). Unfortunately this
>> patch is already included in the last good commit
>> (977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.
> Hmm, I don't think this is the case.  This is my local git log output:
>
> commit 83a4b87de6bc6a75b500c9959de88e2157fbcd7c
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Dec 12 15:07:49 2018 +0100
>
>      get_required_mask
>
> commit 977706f9755d2d697aa6f45b4f9f0e07516efeda
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sat Nov 10 22:34:27 2018 +0100
>
>      powerpc/dma: remove dma_nommu_mmap_coherent
>
> I've also pushed a git branch with these out to:
>
>      git://git.infradead.org/users/hch/misc.git powerpc-dma.5-debug
>
Sorry Christioph. I was wrong. The first patch isn't included in the 
last good commit. I will try it again. I can only test beside my main 
work. That means it takes longer.

-- Christian

