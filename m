Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBE606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLQTc0Rzwz2xHG;
	Fri, 06 Nov 2026 15:01:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793937683;
	cv=none; b=OrZhC7HPCB2kGVj6WHZA63Y3PqsTmNKUPVfYa3JajFgVl1G0RjA9kRpnpkpjSBUrYf7qqSNysh/m5fQFtgnG6kel2b2JsddAtOvlytRSUr0WrBkW+Fxi9ea/Zt2YwAE9lDSdl1KUcTiRCiU8pGWClBCf8Xl5EfHzLHUplWqT41V5LrUBIKCpO306AuWVcXvhn6HGGTm3bBWzqEuvhSt/oWwdqKwv/PyPA0/lKfizsmSAS1eIQi4rECH53gkE++k0s1HuGL2N8AC2XEk5zzcx0/2J9JD19DEsTjpUq4z4q2t7J+hDZDPUObw3UYlXQR2HXHIHTH78bUvVjdheivtHew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793937683; c=relaxed/relaxed;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu8Wf2BoGXpu+okRL46rI0rO89iiukZaR9mkFlNTvuBPnsVmqKt6LypuilvUtKqoRcT1auS0YLB8Od5dDnzwAbcZD0hFMvK7OnEthO5B/pj9/d+fcYu/XVMgtt/rHwFUfNJIFJi52TLv9NCbTiQkIvcWqmk6CyuuHBdoe0iakv9JsfDiJwtKdS6QA/KZTvpbtabtIFMJUtOJKNvZIivOMMScPK2j2+kGBFRUO/iploG1Odmk6oDG49Y4YWCKLbbCCFODbGsIuKM9OLOW91xmy58eJOenKkM63LGzTnOx5bPmrZaWZ/6TDSEDN3kGpKXX2X4V2IFCFLn1t/4p7IKQSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLQTZ6YLHz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 15:01:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D5F043FD7
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 04:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225611F00926
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2026 04:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937679;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LNdgrU5zM2nugBvZVCR02iYgDIFmlQHM3kqBcyp/SVdk7mtCDyZg91KEZW9QGqiq4
	 pTrdL/v5+Sridp9dwQOz13aeDVsJ3H2YdUTQ2WgTqzAN3jOXnwlTOnh17e7nKmSJJS
	 cBGQ2Hysr/0o2u+C0HNxL4jSArWNZCkAWoE4VqHwdeCR6AmOWsinVXhs4XeD3AnnYL
	 NyyqQbfWqKaONffmcdGvCd7zgPIyaaZdh/1bZChmRJVWt9bEoba8Mj9VPdtvLQJHSL
	 LtcLpkBtQervU2s3YqAwlJwk+9qPdvnWWnyivKaN8yf3MXd/mXhVPuD1TG2CyQRZXk
	 koUxpIOcYqO3g==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f259cdc86so15092685a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz5RApWirpJl5zzjeWR2Dp7MxMR/hMhifWZSXfEMpPkkHl/FwHurbUzeWaRKByR6w2yuWb+M6rAgmnolBE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8b4A3Qot8vct0HLpDzFy+J8ei0jKzmaoVJx8IQUBk2UmIPXfr+
	9RKz8PLjpDV1JGNpf0aPU3mJ323292t+6zDBFHs9Td4R1skxlc7iifuOqyEKULNqg2OeO+tG9yr
	JN2c7RtKI8OtxviqNtXusw/WLi0QDEAA=
X-Received: by 2002:a05:620a:688f:b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-945f33a9aa3mr181925685a.7.1793937678322; Thu, 05 Nov 2026
 20:01:18 -0800 (PST)
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
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 12:01:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
X-Gm-Features: AclHuK-043SJnHCawrQog3yw2g1v7cvWQi1ZSPtdBLorMSdL4MZoNdMju91VkJk
Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
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

On Fri, Nov 6, 2026 at 5:33=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
>
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() an=
d
> khugepaged_enter_vma() continue to take legacy flags for the time being.
>
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>

