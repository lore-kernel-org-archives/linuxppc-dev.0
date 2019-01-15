Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C42C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252A420656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 13:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252A420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fBGs5YP7zDqfd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 00:37:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fBDz3vbrzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 00:36:02 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 3856667358; Tue, 15 Jan 2019 14:35:58 +0100 (CET)
Date: Tue, 15 Jan 2019 14:35:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190115133558.GA29225@lst.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
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

On Tue, Jan 15, 2019 at 11:55:25AM +0100, Christian Zigotzky wrote:
> Next step: 21074ef03c0816ae158721a78cabe9035938dddd (powerpc/dma: use the 
> generic direct mapping bypass)
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> git checkout 21074ef03c0816ae158721a78cabe9035938dddd
>
> I was able to compile the kernel for the AmigaOne X1000 (Nemo board with PA 
> Semi PA6T-1682M SoC). It boots but the PA Semi onboard ethernet doesn't 
> work.

Thanks.  But we are exactly missing the steps that are relevant.  I've
pushed a fixed up powerpc-dma.6 tree, which will only change starting from
the first commit that didn't link.

The first commit that changed from the old one is this one:

http://git.infradead.org/users/hch/misc.git/commitdiff/257002094bc5935dd63207a380d9698ab81f0775

which was that one that your compile failed on first.

Thanks again for all your work!
