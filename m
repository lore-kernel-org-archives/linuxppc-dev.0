Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C4606A32F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgFmAbUp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLQP068ktz2xH7;
	Fri, 06 Nov 2026 14:57:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793937444;
	cv=none; b=g+LiNNqDvXozV4SdzfvKXSUL7go9Xg5hA9o1rgAEGXn8nC7zY/9ixzm6QnoN2FWq5t5frn92IwezLckYnNgJJ8hRGATWLw7HY3bWLKeGp2Tk7P9s4Fhi6jDzNx4MfU5avUNUYLjhifOSh4eZbvANa70XTIaBe7Qy183JJyuT21a8z1n3eHYgQQTtA2BB+lVA+MhC1NKu8IHhYwGthBZBOdp1eGcLYlwNoc6hDd0HAosY7CHP3/RxHHHb7HgRGx00XyusrQcBb9m9vgSwVhlcVlRUXoeDMQYgIky10xeZmIvUSmRE66Q2o2Budl3jD+3owXGZ242YIs/I3exVeJWiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793937444; c=relaxed/relaxed;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfOnRBVEzLu2ECfNs+ZNkS41BS/3tTgegIfmJsagn6yZSpXXgWYX7LlcEZn6VPVMUA5wbL4+oWhfI8n/yEtAfab3q0T1fLNAFQGRHH2QmdtWkfKOzsL+pCOEUZsrBKVRmOpEyiLW4rE2FOl9meR3IjKprHhlAi77IyO/cD/vT4Z9I6PZNWOOoYvwSPWR4n84WI5moFKoR8JCpXoMtmRCj4UHBA0pkn3LEXR+Xgobkakrno83eO29lkqfZkzeJPEGxcD0WZGPwnD2vmOEyO8ORG95xTjRz/ZiTS1Nhkz34i/ovZ2s3Zt8TJFRH776VF79jjUGn8BuRfMAXOQ0fh4JbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgFmAbUp; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgFmAbUp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLQNz63Vyz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 14:57:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09C8A43FFE
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 03:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF0E1F0092F
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 03:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937440;
	bh=lHXR2FH3bh5spT35/G4nG+cv25q2yTDGLvo0NNx3ZVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EgFmAbUpAM2cjwI+PAsaOIcEAvxopqxzrr5ETtb9YJduifyoKzN8YwdyePG7jZcgl
	 MAF1R31GIZ0XeuUOJ5ajpkRLAI0gc7RjT1TWr25oDrdTv5MC3GjICuS4R/pPi0d0Y+
	 pCObQVcMyzbJ8upJobLZEEgDDMPAax+RNdKemLW9HXK51pfSHhspbfEziQxNccns9m
	 V6Ao+kTwjY7l3VQQwr9rOMONlSWWfRMpgLakbtQVmIq6dK6cSWWL0ZgDvyUd9/JdBX
	 zzAa59f4NI2tvQUjbttnwVD7TfUy2F0n9FlrD/xYew+h3qG/zcNr0KCdZAsNc+VsTK
	 tfw0hgrFmLfHA==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cbc3ab2fdso9234185a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 19:57:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzznJw2wRKbw9YaIApLMsHluNOdVEJSnofaFa/MFXrt+rTiJ8Up0DG8pgJAn0xZj7Q1AFCEU23egBrDhvw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/Aj3T+o4MMIz8DCljZ9wJc9Q0SlKasZh1tSOZtIi2L0sodoxNP
	0vpamakV0PjAzLoYR2qtXhvPW5k0GMLfi2jmrUGu25JTspwr/bqaVSzex4jRYDU421GoYtyTEGN
	3o65PMLbJ9qVWlKtJGUIgQ5ZSytlVGGE=
X-Received: by 2002:a05:620a:6c88:b0:939:b8d6:9b1c with SMTP id
 af79cd13be357-945f34af2acmr198595685a.19.1793937440071; Thu, 05 Nov 2026
 19:57:20 -0800 (PST)
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
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:57:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
X-Gm-Features: AclHuK8deEInzaZZJ26UPrq6mS-8I8VnGN9Ocbio_nvLAi7VvywQ3Ss3UdDHcfM
Message-ID: <CAGsJ_4wCd_j5or0uHwPLq0PUixcXgiFim=_d7uUhUhAuQf0nTQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 5:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the remaining uses of the legacy vm_flags_t flags in the rmap log=
ic
> with vma_flags_t values.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

>  mm/rmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1131b76bbbc2..cdc97fec8586 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1196,7 +1196,7 @@ static bool page_mkclean_one(struct folio *folio, s=
truct vm_area_struct *vma,
>
>  static bool invalid_mkclean_vma(struct vm_area_struct *vma, void *arg)
>  {
> -       if (vma->vm_flags & VM_SHARED)
> +       if (vma_test(vma, VMA_SHARED_BIT))
>                 return false;
>
>         return true;
> @@ -1660,7 +1660,8 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>          * VM_DROPPABLE mappings don't swap; instead they're just dropped=
 when
>          * under memory pressure.
>          */
> -       if (!folio_test_swapbacked(folio) && !(vma->vm_flags & VM_DROPPAB=
LE))
> +       if (!folio_test_swapbacked(folio) &&
> +           !vma_test_single_mask(vma, VMA_DROPPABLE))

Right, VMA_DROPPABLE_BIT is not available on
32-bit architectures, so vma_test() cannot be
used here.

