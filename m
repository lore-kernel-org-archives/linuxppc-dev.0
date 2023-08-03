Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99FDC41513
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:31:48 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=PyYKaBLz;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGmry6B5cz3cJm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Aug 2023 21:31:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=PyYKaBLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2001:67c:2178:6::1c; helo=smtp-out1.suse.de; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGmr31Fnqz2yhL
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2023 21:30:58 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C279219AC;
	Thu,  3 Aug 2023 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1691062255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YTQRuqkv53Z8DJYB9c+3+vV74A3jJ25NIxoPGrGH1I=;
	b=PyYKaBLz1SEUTXpNmjBEtacozKZcMUFJawXf2mHZYHYa7ME722AbfYKNGKTqYzCoYAcB6w
	d8Xof9ygD0PzlGFppHEUvkhFRgj4arDISlGa9dsMScLMcFmisFt+seK5tAAo9ZN4XqdEOd
	3ezC2W3CtuYw3VPpuK4k5gULoOSSeqk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1D361333C;
	Thu,  3 Aug 2023 11:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id V9kENO6Py2QkNAAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 03 Aug 2023 11:30:54 +0000
Date: Thu, 3 Aug 2023 13:30:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 7/7] mm/memory_hotplug: Enable runtime update of
 memmap_on_memory parameter
Message-ID: <ZMuP7gsxQzAmRpNX@dhcp22.suse.cz>
References: <20230801044116.10674-8-aneesh.kumar@linux.ibm.com>
 <ZMjJPFcXlt+aeCUB@dhcp22.suse.cz>
 <a32fe748-fa18-bd92-3a10-5da8dbad96e6@linux.ibm.com>
 <ZMjjbKnxZXSNcJL5@dhcp22.suse.cz>
 <c1e6e3f6-2e3a-c098-ae78-0d86de8a3a95@linux.ibm.com>
 <ZMp7Vr8PbfoADQw0@dhcp22.suse.cz>
 <31305ab7-1e65-80aa-ee91-9190c8f67430@redhat.com>
 <ZMqLV2S6vY0cZxbp@dhcp22.suse.cz>
 <ZMtqu76Tgh9jj+AI@dhcp22.suse.cz>
 <1c6a74f0-85e9-5299-1520-9068e842b1a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6a74f0-85e9-5299-1520-9068e842b1a5@redhat.com>
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
Cc: Vishal Verma <vishal.l.verma@intel.com>, Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com, linux-mm@kvack.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Oscar Salvador <osalvador@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 03-08-23 11:24:08, David Hildenbrand wrote:
[...]
> > would be readable only when the block is offline and it would reallocate
> > vmemmap on the change. Makes sense? Are there any risks? Maybe pfn
> > walkers?
> 
> The question is: is it of any real value such that it would be worth the
> cost and risk?
> 
> 
> One of the primary reasons for memmap_on_memory is that *memory hotplug*
> succeeds even in low-memory situations (including, low on ZONE_NORMAL
> situations).

One usecase I would have in mind is a mix of smaller and larger memory
blocks. For larger ones you want to have memmap_on_memory in general
because they do not eat memory from outside but small(er) ones might be
more tricky because now you can add a lot of blocks that would be
internally fragmented to prevent larger allocations to form.

> So you want that behavior already when hotplugging such
> devices. While there might be value to relocate it later, I'm not sure if
> that is really worth it, and it does not solve the main use case.

Is it worth it? TBH I am not sure same as I am not sure the global
default should be writable after boot. If we want to make it more
dynamic we should however talk about the proper layer this is
implemented on.
-- 
Michal Hocko
SUSE Labs
