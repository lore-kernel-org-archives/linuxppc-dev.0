Return-Path: <linuxppc-dev+bounces-25365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5B8C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:34:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtKN3Kkfz2yMl;
	Tue, 04 Aug 2026 22:34:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785846888;
	cv=none; b=c1y1pvimqJSwyeLa3Mkcin8bq/0zWVubC1hJJA1XRYfPWDWusep2HmJ6p0ZCswJlElxh8Twm+4fCXLKAASSIg0yenRCk7SrbiiNeOQUgdFbSnEkZiGOa8nnctPOjTmvQhZr55hgPzyPsjupvArUOAuuz9uVzyQVS1AfhMqUNCuKQXIf1fyfeLm+5GBULNGmvBDmgxai/LwOUN3a6Ha2GEuYe8W9EZOEfrxkAjzkZ8BAh4KWRlXmEFyXwuevh2Y9pJIM3GVwcWHiPMSjQZNpRl78WntFCTVuV57oW0+MigZzRgt4EYbqVgwtG9EZLdlIBN4nc8y5DHL96oZoa8H+P+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785846888; c=relaxed/relaxed;
	bh=1VZyWV/sBNXUleHaYHmmW4Y4u5KeXX8J+jfaO5wklAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKGa+v/S812Z51L/OZ08nkgNEwciTlNYvqbfEkI3u+baOp2yp533p1LDksRMhyuEovLMTq6p6IrtpcE0heU3Jr0rp0uVqeTiO5ikMpfd2dZXlVlPv7vlLraF8xrYWYYRVJ313DZu61+A1hoSFMyIW89Zk2afBhc65OqbcyNgaHVRYg/Nu6VyMhEno2ajjVjjIk4WwmqaDLlLKcw5K0Fn7xg723L9ZgN3p09Q2WHkNjJZkIlHf3W5L+Nu/xv0ABptG9c9Odqh+5Hy/r0I+vK0iKs4xMZkFZBZn+agfHVPA7GBXcIP1W55iqSmZIgq+GzBejmj484H0CITD1IDd3cKRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtKM5LWZz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:34:47 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7923FA1;
	Tue,  4 Aug 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB46A779C4;
	Tue,  4 Aug 2026 12:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tKeyJmLccWoTUgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 04 Aug 2026 12:34:42 +0000
Date: Tue, 4 Aug 2026 13:34:41 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHcJZYyz9Zrshdm@pedro-suse>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
 <anHHyiHqYf3yLf2K@lucifer>
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
In-Reply-To: <anHHyiHqYf3yLf2K@lucifer>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8E7923FA1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Tue, Aug 04, 2026 at 12:11:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> > From: Helge Deller <deller@gmx.de>
> >
> > Switch to the generic implementations, which are identical.
> 
> You sure do like succinct commit messages :)

I didn't even write this one! See the From: :))

> 
> Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
> ptep_get defines you get the generic versions from include/pgtable.h which are
> functionally identical.
> 

I can touch it up though, if you insist.

> (Being pedantic, they're not quite strictly identical as the
> ptep_test_and_clear_young() generic function does some weird unnecessary
> indirection with a local variable and the single {} is dropped etc.)
> 
> >
> > Suggested-by: Usama Arif <usama.arif@linux.dev>
> > Suggested-by: John David Anglin <dave.anglin@bell.net>
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> Nits above notwithstanding, LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

-- 
Pedro

