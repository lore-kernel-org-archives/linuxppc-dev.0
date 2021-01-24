Return-Path: <SRS0=zfR2=G3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 18:09:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1242C2168B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 18:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1242C2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DP1GK5xB2zDr3R
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Jan 2021 05:08:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DP1DG1dHHzDqpd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2021 05:07:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=HhUOvfM5GjLoCSC9whTRSyY37b8Gp9Xbo3KKD5Qng4w=; b=Nwh9j/1vJ8QEsuvNwtNUS53AZP
 B38LmqvapqV8SptCubayYSP2OuIeQ6MxXiDON/5O+8kXCwiVcpe43dZc9MafsKTosxTt9DBbrnDSM
 k2oHopY0jVBsKwZQ3ueHF6jKmUEbIaZETsuminnNe59InN6H+eEiBI2auMvEIraO54KQTTWw5ILo0
 nhM/B0Bzp0377P4emjTM7b5LkEkIdxWQMVx8T65tE8ZkEe5k6f3aU1q89hxXo29vUTdj0S6/5GYgV
 GgG7i+3dL4Pz1ET9P5wB7pBkc/KF+QI2uf757Nh/mhsWiiyBgu/aAb9UipGTkbARES+uas+If+78v
 kxfsuXhA==;
Received: from [2601:1c0:6280:3f0::7650]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3jmD-0005We-6p; Sun, 24 Jan 2021 18:06:18 +0000
Subject: Re: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
To: Christoph Hellwig <hch@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-12-npiggin@gmail.com>
 <20210124150729.GC733865@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a420ccc5-91de-78e3-4276-7bca3e97b88b@infradead.org>
Date: Sun, 24 Jan 2021 10:06:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210124150729.GC733865@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, Ding Tianhong <dingtianhong@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Zefan Li <lizefan@huawei.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/24/21 7:07 AM, Christoph Hellwig wrote:
>> +config HAVE_ARCH_HUGE_VMALLOC
>> +	depends on HAVE_ARCH_HUGE_VMAP
>> +	bool
>> +	help
>> +	  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>> +	  arch_vmap_pmd_supported() returns true), and they must make no
>> +	  assumptions that vmalloc memory is mapped with PAGE_SIZE ptes. The
>> +	  VM_NOHUGE flag can be used to prohibit arch-specific allocations from
>> +	  using hugepages to help with this (e.g., modules may require it).
> help texts don't make sense for options that aren't user visible.

It's good that the Kconfig symbol is documented and it's better here
than having to dig thru git commit logs IMO.

It could be done as "# Arhcs that select" style comments instead
of Kconfig help text.


-- 
~Randy

