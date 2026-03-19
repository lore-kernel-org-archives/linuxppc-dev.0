Return-Path: <linuxppc-dev+bounces-18454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67FB109024E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:34:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcB9V02pfz2ynn;
	Fri, 20 Mar 2026 03:34:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773938061;
	cv=none; b=dfy5Xxn2AFbbHSs5Uu+RGiGyER/Lgd7hU448xhl496IUW3AbO0bKGGlCLc3hVUzh13yLYDHjDktodbeRED33+8z9mptiW+QnLKiKBLHyt5LqBhoPM0fC/9aTKo3valm6SwyF0kDH071G5BeDIVitXAj25hbx4xs++ACDjgijAv+3AJEvvZ9UkrsbvdhIKsFHE22X/MhHDpozmRV7sWD5kA0qvyNyBbs2GRbgULy8J0MN0BXLQRxhyWI8PkOEhgYdcURVtOPMwZEv4Gly4pJE8SnQHie1+ElTUIgcKprfWuumHRVk4NLcRdIfSAPXiJkpIm371qKqT3SN8iZdEqBqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773938061; c=relaxed/relaxed;
	bh=We2az9rV2uZhEm2AbxZxzNYfpPMKfj/UCTlthMox8c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNeOR0VaQ2J3PzIXo0dGQ8gjXiaDfoVeyRiDs34yDNSaBGW0Dd3U/nErKVSdvQ+LsmLDfJzuxuuu04OOOkG5Tf0qpz0fnqyMiHwoDR3P2+L8aFtn0froN9MOas7rCFb5PW08eUd5Ba5NC65woFHN4C1h+OZiBbmE1hnWM2Iv4/RtqmAE9WnVTbmsFSY8qIMa+wXM1k9Nraf7VaiGIisOSERIKx8yecFceIXom++H2xkQBbiIzxAfqTcQTiPpcgNhYG3kULhzEFOb8+CvfbG1SDYZjNXbR9/6ANT91PwWo8w5XqaaXkhJ6nEf+sQpnXKLd+KSAPF4FEzUBQgRzIR+rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AL2p7D4n; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AL2p7D4n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcB9S53g1z2yng
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 03:34:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5783360133;
	Thu, 19 Mar 2026 16:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6525C19424;
	Thu, 19 Mar 2026 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938057;
	bh=We2az9rV2uZhEm2AbxZxzNYfpPMKfj/UCTlthMox8c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AL2p7D4nNNuwVwc7Lph39O0JFakdkYyaKrzGaPHTF2GlW3nDaBEjsMovt8IMS1cvj
	 nF/Y3zcnq4HLceLlcb6ZNa8uwOSPS9SWkhVjLMbig3i7KtVn/sUAbfmVPQesBc+smm
	 1em/bPnI5cwFnbtL9+1T0wOIIFyaOYswLb8TV3Jrtgd9OpVCyzRy0/2cXUKGL7tmOg
	 p/vGe+nw48VyFu5vUn7QxEbTeLZzSpoqZVdkf5aZk90hZ1WePMNrOHlWOcl6wQkke1
	 ZJTW5adr2V3cuwzpxHwFD5YXGP9Xk9BnMlUdpEnaAU+qap2KVjtghs04ibjGQEjgmW
	 /TmfbXYeRDlPg==
Date: Thu, 19 Mar 2026 16:34:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
 <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
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
In-Reply-To: <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>

On Thu, Mar 19, 2026 at 11:24:27AM -0400, Gregory Price wrote:
> On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> > All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> > select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> >
> > For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> > and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> > CONFIG_CMA and CONFIG_COMPACTION already do).
> >
> > We'll clean up CONFIG_MIGRATION next.
> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
> this up.

That is quite the HOTTAKE young Gregory!

(It seems my pun crimes are continuing)

>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
> ~Gregory

Cheers, Lorenzo

