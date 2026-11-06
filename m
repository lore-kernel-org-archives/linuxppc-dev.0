Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF5606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4g7meN9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLQgs3s5bz2xH7;
	Fri, 06 Nov 2026 15:10:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793938217;
	cv=none; b=hwQAE5HkUUfGastBoBstsRT+MoYX56IRsQ7wgJ0TeZPtE7pBwqNzN7g2FUeeULtggM+2MEfZ9PAx/cJtGk8ENtqzunL4W5EMMNRjxyhbtlq4ol4/zJAuzLAR9kyCzXoUFdLbzBUFVoYpzpUNb22dft9+wVyJyRMdE4da/ESyyN/XbgZ6sqCXt4JQ5pVrQc74rAE90vTktN0Hj/nJ7OfN72v56kvWk6jBwXQc5uudJnHoa6bsJTHHeLB4nUwRxN54Xq0FfT+X+A/L9gWMf2yHED0RX70qXydgdJ0ApUIRy61DZQ1HVMC9echyhwZSkjwDxlX00F0Mnuy/tW0+XKVafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793938217; c=relaxed/relaxed;
	bh=bpOrsKv6qGnA9uW832gOGeZZa5N6TFONX1C9LOr1sUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiupJXGmZBbbWEfzprV3QgeepktjFrWRs9LLGaKkftgC0ql4CUt1FQA1gZbXCBPMCaxc2tBMHCGCR3P+AMhcnjfKIgDwO7U+3eiDzzAI1f2hNTdKptpK5ICLHZ6CyjO5JODSoV7OqC/YgUpqizGAJ5TdjSzCj9k7VAPtttcxFLbDdLdwpDsqpG746K3DFkt2aLyiHbJ59TXMkhRa/IdIrZuz4bSo5iMrAlU0uOeLkBx3MKxYRKDREvGfa8+E6eivbRfnBcW1spGPrHh8i9Fqto8Y+UWeu97GqXHZrB1KErSCEfrKblFIsdcAZ1DHtKP2P92zNAkwM2OeJY9YnpkC+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4g7meN9; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4g7meN9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLQgr1Pczz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 15:10:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B7ACC4429B
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 04:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4411F00923
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938213;
	bh=bpOrsKv6qGnA9uW832gOGeZZa5N6TFONX1C9LOr1sUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M4g7meN9L4jcufSegpXXlWaGlXSAiSHsKt/N0gqp+weN1qe6aJeULVDkyojAgWtGd
	 gPzkuMhS3VJVvD2iSMsunZRORx5vJwxaWTAQVgFcpLq14jjWIAD7Nw2dIR1i7/2Hzk
	 /O5QenXf94M6jdl7yxnrnrLBTyfQ+VOsC+G1To0qVtvIPWpP8LkN4Fxrkoshn5Eodv
	 iI2U+VQDFU28zucCyh62Ju3w7+sSJBZjMtmNRYMl89xvA9b06kdZffirB4Mo5dQJxN
	 lfwJBW8CcnqbWHB2+bVzFKHN9Grs/TML+8Rs5t7LhzX+R2+u3PZkzW2XpkS0NsohGE
	 EFmyKRadV+PGA==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e4c00d71aso17159685a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxAcbyBy7UBsqCSUL2TrlVsLb5N+FP2EajdYQKRFZcdp93ap2+EU6P3qQhMcl4pCx3mkBF1fjLglzdqy0I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/L/VMz54ze3LK3eF+MjbOa7g05+YtlxYUupgxqP6A/O22/EHpu
	hKNJtwuHUrciAEQcn4wHDEJ8PRSXJS8NgymT2vRL5pu32+d8F9cUHLl3zArdNiMG7zAKdgBHJkd
	igjQvd+oFiPuTRATlsCB+KOapgojleBc=
X-Received: by 2002:a05:620a:1b86:b0:93e:c12c:f134 with SMTP id
 af79cd13be357-945f364d640mr184996685a.79.1793938212273; Thu, 05 Nov 2026
 20:10:12 -0800 (PST)
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
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 12:10:01 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zfovh2t9zNeo2D6+TqPbKeEeoFniTyE6DQT8w8stXNhw@mail.gmail.com>
X-Gm-Features: AclHuK-3k2KPmLqEqbOgFVFtxh57Y4Ge5X7nQzdyUQMEUj3H7k7EkhGovaoUjnE
Message-ID: <CAGsJ_4zfovh2t9zNeo2D6+TqPbKeEeoFniTyE6DQT8w8stXNhw@mail.gmail.com>
Subject: Re: [PATCH 04/13] mm/migrate: convert VMA flag tests to use vma_flags_t
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 5:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> migration logic.
>
> We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
> there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
> take legacy flags for the time being.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>

