Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95C606A33C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moJaaXVs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNVzm6CjLz2y7r;
	Tue, 10 Nov 2026 00:31:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794231076;
	cv=none; b=A2xEGT0d5QrwZRPdFZkylXofprJgodX5yPsqT1z7sV7Wdhb/aLBwHXeCONqfHGUJKphz7weD4lYdoDstGxVjQ0CQdkdB/AFB0Z+b1NkH7oKSwYaq/o2G+/Pyrj2k+ZIGvP4OghJ3E7SkBZ6dh9buKC1MbUk3EG140mE3Aq/1zqA35Fe/G/umk2ySZKel9GNWtXYO/dSZ1qCgc4UMH2A8DuzsvCSRerDj5RLPU6HN2Vo+rgbiNLYazAWTfHg1hKhT8PQL9cxlYIaL/FO33Gw5lkMJ2ShI6/6LZMlRW0oGq79CTfm5Ra314oxIqtA6Mk6Zg9mnyuumZkrNSIJd8E/0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794231076; c=relaxed/relaxed;
	bh=HZb1ecY9gAspjaczVb/ho/JkduHza/gfWZak6QZzsog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=br+op+DHl76wE7o/sGSPGlvumzpe0zD3OgHcqZEMiNdoy9Jn+aZ7urjDvIVGkx5VsIp6DBB9JJjptZbKMubx/ale9aUP/jh9Sgv9Ww5puj1y5HcagzNy5JWpIQMSKCzkD+4KAepklJLlFzN58VgCSh02Zg8gJ77MPyICMBWq+NHK3RVbUJY5RHCbUXKNShCsxY/63YYsg1P/nNhYnz6idtaHGB1jYbna8GfMr0jcRQ6uRB/elw3P905Ezp+5K3SdWBuwuRoKGvTfIO+Rn0CrMjXtHcvXp8fo/SIgddSARRHVtevEmFGo90xVtocae8drN/eUeVPadEkw0wks4bZI7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moJaaXVs; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moJaaXVs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNVzk4Y2Nz2xwL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 00:31:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E5C5F40244;
	Mon,  9 Nov 2026 13:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A331F0089F;
	Mon,  9 Nov 2026 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231071;
	bh=HZb1ecY9gAspjaczVb/ho/JkduHza/gfWZak6QZzsog=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=moJaaXVsjzU7SL4CI8JBlVbPKjmyaTD3NHAgdTnwk/M1L60N+Lk5weuwkobiTd93C
	 8s5kF6qwjOZc6FI/CH+6n9ves3n9Dt3ncPHme7MMz8CrOWrXu7GVA3alW12QVQxfFC
	 dYdxN3at+z/1sifp3qbo3ReksK4F/0ytjastLvz2FzQpT5Hf4HIrH6DUDcYCRbwUm+
	 dEj416YDQH6bI4b6I/NGuMzR1qG7vWeEqkoYkCakzFXeyTPSKb1bte6mOADwhhJ34m
	 oj57425c6Psc1SXo2+31xoM4HAfQoI0isPU+xPj1eF0X/18EEWq+95be4Si8H/sog8
	 62xe9bzzf6Bpg==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use
 vma_flags_t
Message-Id: <179423105176.12172.13163434370832642610.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:30:51 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 21:30:57 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> KSM tests VMA flags directly.
> 
> The ksm_madvise() interface continues to take legacy flags for the time
> being.
> 
> No functional change intended.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: ksm-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
        https://git.kernel.org/mm/core/c/4ec4530e

-- 
Cheers,

David


