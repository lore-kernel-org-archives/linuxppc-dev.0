Return-Path: <linuxppc-dev+bounces-23998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E22C44501
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 09:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxR292y7nz2yS4;
	Fri, 10 Jul 2026 19:13:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783674785;
	cv=none; b=PtVqjuJGFn6D6EWJfCsQfHqgu9mirXXvYRSdyMfb2mhsPogz8taCCONAH/JzPJFqk14ZLUuJzJ5oB5/GMwq0krB66/CNl8zKohQjyKNqGl1shV5umFSjYSnnPW7omiy1lS3yRsoE1JfBFoz8IWrRean9a2j8+1o4bniAl1vp64ipMvf5o+RhR+ZrdfhvgFfE1iHI8zFZnc+m8I3XnCjOt219W5mCy7RBAMSCEPXDowuwx/Hg5nCRr3862qCEEE7mw+ZSqCV7m7jqkd8kTYfAyK0FlK/N/l4/211bLkCmHqxG2qRsdbSfoPs+vtHPExwIc/51yR+YepoHlkana2JSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783674785; c=relaxed/relaxed;
	bh=u4DsWnWasA8h85Gsu5f/xy2b9ecOlCuQy+slRnVs+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boVbVOU96O1NBQoSnZt21Jf/I5qaPlJ6eNn4gFCJtYs+QbV/TXeTQ0zU8Fiop9HA1t3/hoo4DfmMQeDABpOMgC0IDme+wCIn5BKFwc2wp899zrP9iSleRiusNLPUZVHXL4m27C7xCknQVTKZrn4RpY7sbDwlIOC95H/w3lfOFPv4fZYgau7oTljQIX67pA7qkyGOxzKoxCRqbDA0H99eO1NwJHIugCR8QqsZoh9cN2MChdhMlcyQK3oRLO7wdlIUiCZOq4M0edCQi/y7lnG7SFvzRdBLwhoxsDWT8fYuA/lXxurqB408np8wahUy82ExqbEVOSTPpV3lme0kduMibQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zapqd/L+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zapqd/L+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxR285993z2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 19:13:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8883C403F7;
	Fri, 10 Jul 2026 09:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BF1F000E9;
	Fri, 10 Jul 2026 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783674782;
	bh=u4DsWnWasA8h85Gsu5f/xy2b9ecOlCuQy+slRnVs+gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zapqd/L+c4EJRqbtdJXls25prmMPM69KR+behI08XwP7Zvf6QZAqU7MiOzZtFHRF/
	 wD4iJaGNt8Adqf0+BR3WQ4gGuuKCKQPbob13gw2XF+IwWUuAJC53l5NtARu5EgnrqO
	 2s+OVM2YpE6+2ky0X8MAtBRzo0TLixGd+xwQf2zQCIqpcqzKd7rH17c8Hq//DpGAjK
	 VX1oMzXzF9r/Ezcb6NoQiu5uEZXcE0v7sYESgSiNwMvQEQUnX9X/cbJYV2J6UjOOxU
	 eKf5qxR79Cu00qV8/YxzDNqW3yviZQ4UK9uTlc9c8F0hRNVzdmRfLpn3XDSxvfvSx2
	 0r8QevW6jbmAA==
Date: Fri, 10 Jul 2026 10:12:47 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: David CARLIER <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dev Jain <dev.jain@arm.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8] mm: pgtable: free kernel page tables via RCU to fix
 ptdump UAF
Message-ID: <alC3HqLVTBA92Prx@lucifer>
References: <20260706203128.162335-1-devnexen@gmail.com>
 <ak0YI9KjSstnj9rJ@lucifer>
 <CA+XhMqzvFtLq1OT-qh207aJhSf+okdE8o8Joe8e_KBvdCjcQfQ@mail.gmail.com>
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
In-Reply-To: <CA+XhMqzvFtLq1OT-qh207aJhSf+okdE8o8Joe8e_KBvdCjcQfQ@mail.gmail.com>

On Tue, Jul 07, 2026 at 06:08:49PM +0100, David CARLIER wrote:
> Sure thing :)
>
> On Tue, 7 Jul 2026 at 16:19, Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > Hi David C,
> >
> > This has been through a lot of revisions so I think for the sake of expediency
> > the best solution here is for me to grab this and fiddle with it a bit then post
> > it out myself.
> >
> > TO BE VERY CLEAR - I will keep your authorship and attribution :), and simply
> > stick my name on a Co-developed-by tag.
> >
> > So this will remain your patch.

Apologies, but the approach I'm taking is very significantly different so it
would be problematic in terms of patch provenance to do this :(

I will make sure to credit you directly in the commit message so there is proper
attribution, this patch and follow up stuff has grown a lot (been working on it
all of yesterday afternoon/evening + this morning) and need to ensure the stable
stuff is backported etc.

Thanks for your contributions here, very much appreciated, and sorry to have
messed you about on this!

Cheers, Lorenzo

