Return-Path: <linuxppc-dev+bounces-19870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A06F327B5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 07:29:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0DX64140z2ySW;
	Tue, 21 Apr 2026 17:29:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776756598;
	cv=none; b=Z1rD3VaXToKcQulogDCkjxtZN/KKc3aKRkTdkOLHyYKWRJWFAfA7WABMrLkSh1WBi1MF5HFBg2dNbIRhuVCa/NYRFUzQXpV2wYKd2KvPQSJBo5OUUdpIMikBSAxT/RIAdDtUvZ9GMpBMAQAe46xwjLzfGtx7yBebiqUv1djPC6IeVHihdT047dpjreo2DUJo3bXk9WIQVicBQFQL7wo8DX7DS4s60f0ZVqa7vsenabZ7vlv8JpA90myY7MAZF3sAdm6y6/DobGAlx968mYucjjFXsxcS8p70fVUHaBoX4zaDn8+NIgbFnTUQZxz7mxXltVcVchax/V03cXhiKgJpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776756598; c=relaxed/relaxed;
	bh=VmpWofTIlMRvaJ2R/6EdvLQ0b7yTNFErU+2L4jvVqZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuVS2ktzRVycg4B1LpvpK0K7IaewoBpc9FDUZwkLfgayFKD5LzqqULQEzcJg2FHFN9SWaXY3GZVOzdKU6SEmcFW6P/llEmSaZvKSxDp+BBop6R/ne5mI0MTeaKI6n+MfwVTZK3Mj9Xsw0u9lXg3nQTIiMG1R9bf/2k4NLTkIDjiIcYMxXHsv24cC+eaCVDv6rpxV+hzQEweFEf9ib/HG8UCaDTDhNX7lxmXWc6M+K6ujaNOgsmlpLwS6ew+tS4M0aMBrVAM5Hypk2fTegJ3TLKGUv/Gjn+gYVMrSLbuLBbhSUsVsocJ0P3w9PG3GGQHYnHaxfaBNTkOxlDfw16ihZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xEksfWTK; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qUQJoihJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xEksfWTK; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qUQJoihJ; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xEksfWTK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qUQJoihJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xEksfWTK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qUQJoihJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0DX55tx4z2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 17:29:57 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D01F5BCDE;
	Tue, 21 Apr 2026 07:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776756594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmpWofTIlMRvaJ2R/6EdvLQ0b7yTNFErU+2L4jvVqZ0=;
	b=xEksfWTK1V92y20VMkyzbGQOjYDBcGO/gWhbuEyYcKEa+ycQJF5wp6W1MB99niJpWx84bk
	W102vN7KyOIr6MqHMYJybMDcZq3J2H9McFMkisag+oyd1sTqcBj297x6+VRYxdvpWNxDqR
	KE+NO28lRXCJDE79c/TuvwYc7Xv70SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776756594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmpWofTIlMRvaJ2R/6EdvLQ0b7yTNFErU+2L4jvVqZ0=;
	b=qUQJoihJzeuHaNAO0HLLA7EYBdbRP/1+UK8T4zmec7ce/r6WXBask/Hk9tiJ3dN4AMFxNZ
	FodFjuFZWHSg7QAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xEksfWTK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qUQJoihJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776756594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmpWofTIlMRvaJ2R/6EdvLQ0b7yTNFErU+2L4jvVqZ0=;
	b=xEksfWTK1V92y20VMkyzbGQOjYDBcGO/gWhbuEyYcKEa+ycQJF5wp6W1MB99niJpWx84bk
	W102vN7KyOIr6MqHMYJybMDcZq3J2H9McFMkisag+oyd1sTqcBj297x6+VRYxdvpWNxDqR
	KE+NO28lRXCJDE79c/TuvwYc7Xv70SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776756594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VmpWofTIlMRvaJ2R/6EdvLQ0b7yTNFErU+2L4jvVqZ0=;
	b=qUQJoihJzeuHaNAO0HLLA7EYBdbRP/1+UK8T4zmec7ce/r6WXBask/Hk9tiJ3dN4AMFxNZ
	FodFjuFZWHSg7QAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29EF1593AF;
	Tue, 21 Apr 2026 07:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h3awB3En52n4KQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 Apr 2026 07:29:53 +0000
Date: Tue, 21 Apr 2026 09:29:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm/mm_init: Fix pageblock migratetype for
 ZONE_DEVICE compound pages
Message-ID: <aecnZzXiFf2n70K6@localhost.localdomain>
References: <20260421022044.1217503-1-songmuchun@bytedance.com>
 <20260421022044.1217503-5-songmuchun@bytedance.com>
 <aeb50jwoCBvgEnec@localhost.localdomain>
 <9343F329-BCD4-4D64-94CB-A94F0E9E4400@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9343F329-BCD4-4D64-94CB-A94F0E9E4400@linux.dev>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,linux-foundation.org,kernel.org,ellerman.id.au,linux.ibm.com,oracle.com,google.com,suse.com,gmail.com,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D01F5BCDE

On Tue, Apr 21, 2026 at 02:54:35PM +0800, Muchun Song wrote:
> 
> 
> > On Apr 21, 2026, at 12:15, Oscar Salvador <osalvador@suse.de> wrote:
> > 
> > On Tue, Apr 21, 2026 at 10:20:44AM +0800, Muchun Song wrote:
> >> The memmap_init_zone_device() function only initializes the migratetype
> >> of the first pageblock of a compound page. If the compound page size
> >> exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
> >> subsequent pageblocks in the compound page remain uninitialized.
> >> 
> >> Move the migratetype initialization out of __init_zone_device_page()
> >> and into a separate pageblock_migratetype_init_range() function. This
> >> iterates over the entire PFN range of the memory, ensuring that all
> >> pageblocks are correctly initialized.
> >> 
> >> Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> > Would not the call to __init_zone_device_page() from
> > memmap_init_compound() take care of the subsequent pageblocks?
> > 
> 
> No, it won't handle them automatically, as the page count from
> compound_nr_pages doesn't cover the following pageblocks.

Ok, I see.

 

-- 
Oscar Salvador
SUSE Labs

