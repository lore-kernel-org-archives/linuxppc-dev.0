Return-Path: <linuxppc-dev+bounces-20754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9318CD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:28:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF8qc1xlfz2yYs;
	Tue, 12 May 2026 18:28:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778574492;
	cv=none; b=hNyWD0NJqKjZ25rIH8PjAwGmOHHy726P5gobcySX7PoKoselxJ2CHBHHlz15jEjzd3tEuh9mQexwwFfEL0EZHnLLqIyQiQqTCpmEx1ZaIH7CiXZDxyoGWqa+d410z/NcAEFUzUSTuJsfR6vVZNjgqU4hIswFArn6BTATjODBEL1+rGqOWLe8OZaevizdsKXuP9PdQSW02ns1GBw0UazIOWcuZllDLIDATM1uLs9nIXHKCHyt2+ct2WyUPi1+5ciZlRkbIkT1j4rKe/u1seTpz5Cz8/g+kIVxHg3UrYF6FXozrFzGPpLFRS2Z8sdhYOeeKnUvsowidHsHZ1zwOMH8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778574492; c=relaxed/relaxed;
	bh=4xGGRlnxg7aexlglixAi3kMj3axlw5heWUP27yTL0LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk77/KAFMBMLjQHWkgG3UIWw+TtthdWOiGGCEkdwUuLM6j/tb3lReQfZrJvCZX6zqPduFDeOMB8UsnQVbI3GmHzoxyWIBa29nEAYTiyS2VgBmH2f4/Y1OEeO40TE0x8VVm9egL2cejIT4li44CH3e5xlXPDUXCwovM88+tDRUDI9cuCaAWSlymIGKdlp7d9VVL5uUWhcvbrYC0VdBvi/zGPFEZ9LVAMeYEJkuD9+UV/7t64HVgW1TA7J4qltt9ss+kBdd3I8+Pfz5fwAI0PQNjU9upNP9+maeiKH4deCEl58j189Ug9i/FqQ4drrHsV7oBv6LOLbKfXHtClgArM8XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF8qb2g1qz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:28:10 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9F1567AD1;
	Tue, 12 May 2026 08:28:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75CE8593A9;
	Tue, 12 May 2026 08:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uc6mGZbkAmqOegAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:28:06 +0000
Date: Tue, 12 May 2026 10:28:04 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Message-ID: <agLklK9iCcV6lsSn@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A9F1567AD1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:05:29PM +0200, David Hildenbrand (Arm) wrote:
> sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
> register_page_bootmem_info_node() is a nop.
> 
> Let's just get rid of register_page_bootmem_info().
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

