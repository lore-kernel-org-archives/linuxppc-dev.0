Return-Path: <linuxppc-dev+bounces-25442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E44C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 12:40:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFVP53QYBz2y1Y;
	Wed, 05 Aug 2026 22:40:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785933609;
	cv=none; b=Pckv/mM2QjlpytSpIGQa7eVkYYZW1QnkBWGI1JcDbiMQWDpuwMFNRPs4kyY/k/cxOI+A196MLZJ1nBy7IJtKpQB2bE991g3R4b1F30xBt02U/SXZbU67pcsDd5fqm9FJrLkcZxpMAzHeBLti9Cx7ILMI9OB5R74LHVh9XDAUoafNMUvnR+7NBbxpZEEvIFRcR41zMnEnXOap0PVrA/IGeisyDMHVQKWX2MsWadCy30aLt0KgDsB4Lbrd7R2tPumtBts2nWWZORD5vOate1ONp24BduZrpLFfpBnAGmyH8LWt8+AnYCPg8enuslJDq7RPmKq2g4IcGm2Nc3OKuOKvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785933609; c=relaxed/relaxed;
	bh=BFHIi52G0DLGh2jlHFvMQOsriC8Uz3afVC7wSChQQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFqEVhINo6wePMqoQOg+05lcP9TD7xjw7p6J0m0YEEwezhq3jFfHhSvirl7g1b3BlNfw9JB2cG1HSXnZaGztbfFG67mPwYQrwmCk9aD6VYhkpOkGvSPJ5Ceo0W8iSxSFlEe4SzhePl0KzIBga4GjXeXkujs4FSfN+3c982WYwvDCjs0O9DDK4OXbNU7rXMbvGCeZVJvCuFiWDJs54Jf5q8nLZ9/AgrNXn4ddcQc/izkYYOJpKfMjtkyqCWlrd0Hf3kHjxBKqJFRaTQBjfZ3auLsFDTuHx8a0xi2SVFym1PCk9OPf8wMVmMxHfjdUFQZS2v5Uzfx4ICpyr3Fgdb2OXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVP45KyQz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:40:08 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7D8F3E26;
	Wed,  5 Aug 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBBE8779C3;
	Wed,  5 Aug 2026 12:40:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5Z90LiMvc2owfAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 05 Aug 2026 12:40:03 +0000
Date: Wed, 5 Aug 2026 13:40:02 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mm: add basic PTE const type-safety
Message-ID: <anMrnsN1xf_Psn3w@pedro-suse.lan>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <a5afofuxhzwkeb76jdheottyxt4mms3arg2iucunztczbmd3lf@wiqp7yccjzlt>
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
In-Reply-To: <a5afofuxhzwkeb76jdheottyxt4mms3arg2iucunztczbmd3lf@wiqp7yccjzlt>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C7D8F3E26
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed, Aug 05, 2026 at 04:12:21PM +0530, Anshuman Khandual wrote:
> On Mon, Aug 03, 2026 at 05:43:54PM +0100, Pedro Falcato wrote:
> > Since forever, MM code has thrown pte_t * around with no concern for const
> > safety, or typesafety of any kind. This is confusing. Attempt to address it
> > by:
> > 1) Making sure pte_get*() helpers can cope with const pte_t * arguments
> > 2) Constifying the pte_offset_map_ro_nolock() return type, which by definition
> > already pledges that users will not write to it.
> > 
> > These two simple steps were already able to uncover code smell from
> > khugepaged + do_swap_page().
> > 
> > Separate steps could include introducing pte_offset_map_ro_lock() for more
> > widespread usage of this.
> > 
> > Benefits of this include less confusion and better type-safety. It could also
> > futurely aid in efforts such as [0] which may want semantic annotation of these
> > accesses.
> > 
> > Based on mm-unstable and compile-tested on a handful of architectures.
> > 
> > No functional changes intended.
> 
> Even though the pte accesses should always be type-safe, this series does
> not really address the problem completely and instead changes things only
> for a small set of pte access sites. So just wondering how much beneficial
> this series really is ?

This series is meant to be a small step in the right direction (while
feeling out what the community thinks, which seems to be receptive). The
obvious next steps would be to introduce some sort of

const pte_t *pte_offset_map_ro_lock(struct mm_struct *mm, pmd_t *pmd,
			   unsigned long addr, spinlock_t **ptlp);

and use it in more places. That will obviously involve a bit of churn.


-- 
Pedro

