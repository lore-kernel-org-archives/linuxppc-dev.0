Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E25EB64DD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Aug 2023 09:05:07 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=OgOx5qtL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RFThd6N8Tz3bmH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Aug 2023 19:05:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=OgOx5qtL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2001:67c:2178:6::1d; helo=smtp-out2.suse.de; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RFTgj1pFzz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2023 19:04:16 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 719F91F897;
	Tue,  1 Aug 2023 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1690880652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I6/n4Ux6YWy9GCwXQYfypkxLzivnlsuKwD27zLIsxlE=;
	b=OgOx5qtL4A20RxLma0h5n5Q+aOu1i4ebHW/c1Zbo9aqcMuDuJXF0DkHZweOF31RbfkAYNp
	w+1V4LyDAi32lYkNi1XJcGzt/Vye/kyKrd2YpSoxR59ExAYUqrQrM5VM0fyNADdhMTkaQB
	UZeas5snoQ3dBKPSYoKXd8JdIJg4m3o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62D9113919;
	Tue,  1 Aug 2023 09:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Kf2yF4zKyGQ0NwAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 01 Aug 2023 09:04:12 +0000
Date: Tue, 1 Aug 2023 11:04:11 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v7 4/7] mm/memory_hotplug: Support memmap_on_memory when
 memmap is not aligned to pageblocks
Message-ID: <ZMjKiwC5G0mu/UjW@dhcp22.suse.cz>
References: <20230801044116.10674-1-aneesh.kumar@linux.ibm.com>
 <20230801044116.10674-5-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801044116.10674-5-aneesh.kumar@linux.ibm.com>
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
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, npiggin@gmail.com, Vishal Verma <vishal.l.verma@intel.com>, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue 01-08-23 10:11:13, Aneesh Kumar K.V wrote:
[...]
> +	if (mode == MEMMAP_ON_MEMORY_FORCE) {
> +		unsigned long memmap_pages = memory_block_memmap_on_memory_pages();
		unsigned long wastage = memmap_pages - PFN_UP(memory_block_memmap_size());

		if (wastage)
			pr_info_once("memmap_on_memory=force will waste %ld pages in each memory block %ld\n",
				wastage, memory_block_size_bytes() >> PAGE_SHIFT);

would be more useful IMHO.

> +
> +		pr_info_once("Memory hotplug will waste %ld pages in each memory block\n",
> +			     memmap_pages - PFN_UP(memory_block_memmap_size()));
-- 
Michal Hocko
SUSE Labs
