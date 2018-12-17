Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3716C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637C620672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JCdb2GjCzDqZp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 18:36:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JCbK211JzDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:34:37 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 1FA7768DD3; Mon, 17 Dec 2018 08:34:34 +0100 (CET)
Date: Mon, 17 Dec 2018 08:34:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/8] powerpc/dma: properly wire up the unmap_page and
 unmap_sg methods
Message-ID: <20181217073434.GC1933@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-3-hch@lst.de>
 <ea83ba21-feee-9776-ab0a-5bc78b237e4c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea83ba21-feee-9776-ab0a-5bc78b237e4c@c-s.fr>
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

On Mon, Dec 17, 2018 at 07:41:54AM +0100, Christophe Leroy wrote:
>
>
> Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
>> The unmap methods need to transfer memory ownership back from the device
>> to the cpu by identical means as dma_sync_*_to_cpu.  I'm not sure powerpc
>> needs to do any work in this transfer direction, but given that it does
>> invalidate the caches in dma_sync_*_to_cpu already we should make sure
>> we also do so on unmapping.
>
> Why do we have to do that on unmapping ? If we are unmapping it means we 
> are retiring the area, so why would we need to use CPU for syncing an area 
> than won't be used anymore ?

So in general we need the cache maintaince only at map time if the CPUs
gurantee to never ѕpeculate into memory that might be under DMA, which
for modern CPUs is increasingly rate.  If the CPUs could speculate into
the area that was DMA mapped we need to do another round of cache
maintainance on unmap to make sure we really do not have any data
in the cache.  powerpc currently does that for dma_sync_*_to_cpu, but
not for the unmap case, which not only looks odd but also seems to be
worked around in drivers (see the ppc44x crypto patch).

Note that there are some way to optimize the amount of cache flushing
done even when the cpu speculates, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/mm/dma.c#n93

But for that I need help with people that actually understand the
non-coherent powerpc SOCs and who can test it.  For now this patch
is conservative.
