Return-Path: <linuxppc-dev+bounces-20762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC42CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF99P3GL1z2xHF;
	Tue, 12 May 2026 18:43:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575417;
	cv=none; b=Ma3cQnJxtp3mAy9oEqzrxVhPlFt9nCsX78rws2qszL+/htWZhzC4Zi/xAizUKqbQXmbUGgOSvL//1EnCQtvQiTE6bQnH915EyKfaZ9sz+E2mF/ZA0dxFCJ7xzJ/qocWoMJ0faHEvgYM2vzMye5IXqLhu9rUm0ecD0nf/GgA9Hvy98D28jtQr8WdWg/Gen1sGRLlC1+FXqPOyGHdIyQWuGZbpUj9ICAQQunIYKZgnUGve41APoyW3p0xCDMQanEODagig4fWr8pqmHuAqraowkwVnZWcEQpm42Oe6Ztf3Y92rSGgmKFvmjmOQFLglj+miyzIvOsaGzQn54qGxdMw3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575417; c=relaxed/relaxed;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em4xL8dcl3U5VGWBhVAbTHyWQkJSevKrz0DkB40Z5SnfO5Z1mqyNytJIIIwAbh16NB9ugEFkP4bFYUA3zoQkkH3ZJzBLbLRe2ZGoPvh3QGwDRfxlhMB0MtHW0s5ip/qQmXQE3ffPn+llj29uoS2Sva4jpcNh2NxdTqxnHW8ZNYG14l0zZY56/AQEuHvxSmGfrmP9glQW3fB9P5TSaRJVi7RGlFBajjWVvD5mf6CzII6pyD+mN1jFj0/UFWno6WSpfDFpJMYNEXbMO3jlMS03+eoewmbh1uo9Qu6nPvJKE5VTgoytegT5i30xoP3u7EplvFFKdzHqKjaJnSBMj6PdhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Jyj/SB+C; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHPvgflS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0T9CA8lU; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A3zfqhPU; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Jyj/SB+C;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uHPvgflS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0T9CA8lU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A3zfqhPU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=osalvador@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF99N4n8bz2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:43:36 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12BA46C03E;
	Tue, 12 May 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=Jyj/SB+Cj0ycIn6iy8AirBgulA6woT7s7jmXHjjxlRIXRCVzsL6L8KCyFx0VmNqINjW+Bd
	fhe2neyAlpOi8KZqoA127vAVVcGFSUGufO3DYQu9FCiXiSgA0rWidbHoptSnYRs4onmu6C
	PN421IzXHTv3Mt9DUQwcjpW2lPi8GJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=uHPvgflSxr1f21qR9SmbrNgQVen1f+3vhIPieRLWMld01iYwwQiqW1lWb5qjTqEV++QpjZ
	P9ahR7tCkwfmtKCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=0T9CA8lUeaTSCvXnCWFLGeD+LEPDue/aNB43knGlbA4F86IRy7dtWguts2d6AfqI2klKZS
	WYm3JaJXzqdRIpHnu38kmGpnJK9452IJ65qb+UasIJRLB1ZPVD33kAJowFuAKhI9cH9tBW
	ufEMI5OiM1Uh6TdRERinXKYvWpRKahk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=A3zfqhPU29cjLTrw7wX35axoGznxQqTbC6ajU+CyBOykK0HUW7zpfn7gd/5crHxz+VlE+f
	//4KXicVjO4LUJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BC8593A9;
	Tue, 12 May 2026 08:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOwfMi3oAmqfCgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:43:25 +0000
Date: Tue, 12 May 2026 10:43:20 +0200
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
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Message-ID: <agLoKNAFMGPXFSqC@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo]

On Mon, May 11, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
> 
> We can stop including bootmem_info.h.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/powerpc/mm/init_64.c | 8 --------
>  mm/Kconfig                | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index b6f3ae03ca9e..64f0df5bb5cd 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -41,7 +41,6 @@
>  #include <linux/libfdt.h>
>  #include <linux/memremap.h>
>  #include <linux/memory.h>
> -#include <linux/bootmem_info.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -388,13 +387,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
>  
>  #endif
>  
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -void register_page_bootmem_memmap(unsigned long section_nr,
> -				  struct page *start_page, unsigned long size)
> -{
> -}
> -#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> -
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e221fa1dc54d..97b079372325 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -537,7 +537,7 @@ endchoice
>  
>  config MEMORY_HOTREMOVE
>  	bool "Allow for memory hot remove"
> -	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
> +	select HAVE_BOOTMEM_INFO_NODE if X86_64
>  	depends on MEMORY_HOTPLUG
>  	select MIGRATION
>  
> 
> -- 
> 2.43.0
> 
> 

-- 
Oscar Salvador
SUSE Labs

