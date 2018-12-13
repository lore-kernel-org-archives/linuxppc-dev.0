Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6171AC67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:23:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E310D2075B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 09:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FpCH6Rn2zDqgb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 20:23:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fnvk6M5jzDqSR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 20:10:26 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id DCDFF68DEE; Thu, 13 Dec 2018 10:10:21 +0100 (CET)
Date: Thu, 13 Dec 2018 10:10:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181213091021.GA2106@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 13, 2018 at 09:41:50AM +0100, Christian Zigotzky wrote:
> Today I tried the first patch (0001-get_required_mask.patch) with the last 
> good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). Unfortunately this 
> patch is already included in the last good commit 
> (977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.

Hmm, I don't think this is the case.  This is my local git log output:

commit 83a4b87de6bc6a75b500c9959de88e2157fbcd7c
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Dec 12 15:07:49 2018 +0100

    get_required_mask

commit 977706f9755d2d697aa6f45b4f9f0e07516efeda
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Nov 10 22:34:27 2018 +0100

    powerpc/dma: remove dma_nommu_mmap_coherent

I've also pushed a git branch with these out to:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.5-debug
