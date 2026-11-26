Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D362E606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fWFSX2K3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb0sR17vlz2y2h;
	Fri, 27 Nov 2026 02:32:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::17"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795707131;
	cv=none; b=a+UURV2ekM9LDzUYOyTl7cqWuAKcmmWgW5d2CglXqrWo4ZWmFW9a/arfSHdT3egXIcjGmAzh3NWxoldHDdbixiQAPZ0TReC4Ce0+lcpoZ+Q/3NcsJGzgbTe196Mo9AOVBnTtr5IQdxxBTm608tSA6B6a2dqawy/DTaNeN7whMLJG8fDw23VyZy6vIik5BLXRrSzvKfivl8CE8oM+0AOi57BSGofXtth+M/J5yNpg4zZPRLNdjMjZ91r6rKSGEUCCBllEW/Sk+ZHTkqTwgVFGvhaxSBrAZIgMVr7Cdp3q2uLRG7PVbcYAOYQe0hSq/z31CT/vdMkIKDrVhxdyFZjudg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795707131; c=relaxed/relaxed;
	bh=WaGhGP18N1e5WQjSL7Kf13XBuOe/Lyl+VKElqyiI+RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYt7Fl+BBZkrLqjeErcn0viyajxWcOieWQdOWkeBgfbHBmV+ZMy9rJvGRJXMHNq/NrhJtK0r4ISmBfleNhXGFBzRZHOLJblv8xVW3WNeYDfB+/98vdokxbmXkZsA1Jb2W+yovaS4wJp5InqsRJ4pnR1vR+1MlPgSeygU6VwaceqT+7wx0NlAQ9crnxqzHou4J91+9Hb51N+gCXHgQhjN3nS/rppcHTIrYNyrJ3/bOTOMMmxRTDdl1UPpXtvNxVvi1K15LfVOxRFQ/W3BaaayrymzJStpsPFhF+fBhtRP5OlJKzjA0+MA/5BhxJcXwB86iqvB08MH5xORPJZ1c6jeOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fWFSX2K3; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::17; helo=mta0.migadu.com; envelope-from=shakeel.butt@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fWFSX2K3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::17; helo=mta0.migadu.com; envelope-from=shakeel.butt@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 399 seconds by postgrey-1.37 at boromir; Fri, 27 Nov 2026 02:32:06 AEDT
Received: from mta0.migadu.com (out-23.mta0.migadu.com [IPv6:2001:41d0:1004:224b::17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb0sL2jJxz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 02:32:05 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=e8n4p5I4AJEqksbOANyj0Uvx8iI2baqGaT4jyvFlF3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707107; v=1; x=1796311907;
 b=fWFSX2K3FsYFD86Ulj/nMBMNSs1CZYTk2i7KQNjc/VHxkWS+Cf1DN6SuzRKbndje9RtxTql8
 8ne94XIv341Q7dpQGl/ILzyJEIBtZupXFwCZibtM8bgfjp60gxtYJrU1OW2KdbxNxHctHsXHiha
 HGHIHf2gDVWlXTg6qKl5APdE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id e28c61dcd929e842;
	Thu, 26 Nov 2026 15:24:58 +0000
X-Mizu-Trace-ID: e28c61dcd929e842
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 07:24:42 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Dumazet <edumazet@kernel.org>, maple-tree@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, iommu@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-um@lists.infradead.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH slab/for-next v2 00/14] mm/slab: mandate SLAB_MAY_ACCOUNT
 for __GFP_ACCOUNT allocations to avoid wasting memory for slab metadata
Message-ID: <20261126152250.GB738059@shakeel.butt@linux.dev>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 09:37:01PM +0000, Harry Yoo (Meta) wrote:
> TL;DR
> -----
> 
> The purpose of this series is to convert existing slab users that
> specify __GFP_ACCOUNT on allocations to specify SLAB_MAY_ACCOUNT on
> cache creation, to reduce memory waste for slab metadata with
> CONFIG_MEMCG=y && CONFIG_MEM_ALLOC_PROFILING=y.
> 
[...]
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


