Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7BDC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFB220672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFB220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JCgw4yk3zDqB9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 18:38:36 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JCcg4wvNzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:35:46 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D30D168DD6; Mon, 17 Dec 2018 08:35:43 +0100 (CET)
Date: Mon, 17 Dec 2018 08:35:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 7/8] powerpc/dma: split the two __dma_alloc_coherent
 implementations
Message-ID: <20181217073543.GD1933@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-8-hch@lst.de>
 <de3d6e75-70d6-e1af-f733-b1aeed99d6c5@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de3d6e75-70d6-e1af-f733-b1aeed99d6c5@c-s.fr>
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
Cc: Christian Lamparter <chunkeey@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 17, 2018 at 07:51:05AM +0100, Christophe Leroy wrote:
>
>
> Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
>> The implemementation for the CONFIG_NOT_COHERENT_CACHE case doesn't share
>> any code with the one for systems with coherent caches.  Split it off
>> and merge it with the helpers in dma-noncoherent.c that have no other
>> callers.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>   arch/powerpc/include/asm/dma-mapping.h |  5 -----
>>   arch/powerpc/kernel/dma.c              | 14 ++------------
>
> Instead of all the ifdefs in dma.c, couldn't we split it
> in two files, ie dma.c for common parts and dma-coherence.c for specific 
> stuff ?

The end goal is to kill dma.c and keep dma-noncoherent.c only with most
of the code moving to common code.  Here is the current state of that:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.5

But it still has issues on two tested platforms and isn't ready yet.
