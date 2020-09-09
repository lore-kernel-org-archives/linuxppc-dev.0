Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0AAC433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:30:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67AB2087C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67AB2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmjZL4v7lzDqWG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 23:30:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BmjVp2v0LzDqVm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BmjVp20b8z9sTv; Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjVp0c8Xz9sVM; Wed,  9 Sep 2020 23:27:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Scott Cheloha <cheloha@linux.ibm.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200811015115.63677-1-cheloha@linux.ibm.com>
References: <20200811015115.63677-1-cheloha@linux.ibm.com>
Subject: Re: [PATCH v3] pseries/drmem: don't cache node id in drmem_lmb struct
Message-Id: <159965716850.808686.9231965760373427817.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:27:29 +1000 (AEST)
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Rick Lindsley <ricklind@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 10 Aug 2020 20:51:15 -0500, Scott Cheloha wrote:
> At memory hot-remove time we can retrieve an LMB's nid from its
> corresponding memory_block.  There is no need to store the nid
> in multiple locations.
> 
> Note that lmb_to_memblock() uses find_memory_block() to get the
> corresponding memory_block.  As find_memory_block() runs in sub-linear
> time this approach is negligibly slower than what we do at present.
> 
> [...]

Applied to powerpc/next.

[1/1] pseries/drmem: don't cache node id in drmem_lmb struct
      https://git.kernel.org/powerpc/c/e5e179aa3a39c818db8fbc2dce8d2cd24adaf657

cheers
