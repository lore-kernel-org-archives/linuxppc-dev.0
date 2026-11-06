Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F5606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ENJhv1m3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLLyf6q4dz2xGg;
	Fri, 06 Nov 2026 12:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::432" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793928170;
	cv=pass; b=Ib35sL5jAnsNoOnBtC3JDq2eu/UOmqgx2s/1vm9iO4CvYMDNCt/rnkKXpVO/UMqfCC2NZXiTE6zG6ZV5c4OYCKu7oN4yr0tubXIM5VrxagqXw4G03VkE0oMERYIstOxyvKhJ6PMJ85AoYc24LQgrSH/tP05uqYEvZSaIEQVY66MOWdIUXYwBX/4C/zIUt7LisdthfZqkxqrP3VSSdyVF3MQBmW9hy3TlY7eahWQKB+LV7hnScgkos42muwdGxGclSMkNS+rzP24MwCiO4dA4pYHqb50nFXpEWY6/xlX0x9jlgvEihXjquyq+u7nuAhPoGFN1h/BJdLCiL+A4u4KxHw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793928170; c=relaxed/relaxed;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6DVM+kOY7yRMZrDGQJO5kWMgNcV68O1oL2KBKh1gNJ/Z8Mxg689B2uGVWl+EiDI1jRaeIeZ1NJZn82uPVXrRqNiQyLPWfEkvnw0JZ0OXzO0MA0lVg1ubLiVQH6m/btLBPgWJVW856OwY391z7V2JqJZQfd9l8ufiTChKt9Isso+Fi1MuLLUC9QkxNR5XNbkY0FofCYK9ZU9otWdCV5YnfsyicNUuURxFUhcLIJxLks3m0U8/p5PpdKHXIoxgcx3zrrec1QbEhBoYAxZ1NPSLlRu2oljS7X+Cb81z0PNYzvtp7Fsoup3UswyueIgs/W8q44/9WcKEeTDSHsOnSVEdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ENJhv1m3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ENJhv1m3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLLyd4qxBz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 12:22:48 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8b2382bf051so33733b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 17:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=brMR3BmpSuwGThXgWB4j7cDoV88EFoAacr2u4oeqpQCsx53mrxHm4SPtTeYYAK88db
         W7kS6ssTdctoK0UphZDz0Yc6eHCyIg3Klb6lPR2B4bCV0qAzXGlfM7oyp6xAGQQs88ht
         z4rXni5JRIyPgYM5Utts3Kv6g9YvxkrTOMXG4tCrOzrc4dZ0jDTXSTv7t9oGV539hXh9
         EqxOk8VkHaCHPmrkDXBxKhVycSjt+4BAPb0ODjBPl60Egfup/1QR4LLDTf8Q3yAfdBtM
         5LXxuZupNSXlWafAxu4bxKpFwFAq2Lmrqx0s80FVr1VP06b3WzFEGWuZPSBod50t8quc
         ju7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=ZgCDfzpCi+WHkiFOces6Ti/QnfDYtpamC/6Qqkg2d1M=;
        b=rdxkZWmrfuK0O6e9CyOaUmbuvyPrBH7gJE1U6OkUbtuNWuX4zgN3sR9CkENwLdR+Uf
         Ae4d9czRM337V6C8R/aHsT35kFk1Wc56xwRo2BCw2UYh4+apmSBnKidlHaPq8Plg6NH9
         gM1cddBryxIafAhWmi3s5hBeQoh7jj6Sb5CjOKaSRdflZZN3b2LFTHSoDEuqjCiEtrfJ
         qMscFXkxmM++zr2oWPqTfGuMCcopkz0eps/VewhDv7pnFjWc1pj65pNphITyBccWubdR
         7Qy59YmJ7gufZ5WjS2lvEUsyLXSE6M82ILgFRn10Ru8hwhemSRM/nO4vrEKKtBHhiUHO
         0sdg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=ENJhv1m38x+bMZK8RHR+LMGSw90kycgaKGSyyljnmwI7xlQvRnhnFXOzNDycjTh9XD
         G70cnL7uVvcQuHj9XUA8KI9oiYBOWYtezJAmlyFbeTnofXjbMkWGbD9zInpfxNElA7V9
         VIplXkUQvf0AvRfWweu7uuNDZ+AbBusG+7jTE6w3R/0pkAeUz8rczrfF2hwxNIPnMQUd
         cbWSMWNTwEPHKWrYa7kmuEyPM2n1QGZu1HaE8PEr94TSTgDES/beNpf9MCZczrdM7NXa
         IAFi+yyI9w0tvH359NhhvhKcYjwxtV1exi50t6M9XTEpmLIl4eAaol9RGSNHuZ51Qmmz
         vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BNTcp6mjzvc1M+3U0frqODZfWkRJFSVXMAU5bT6mtSrgu7v19FsBUdW1Fn31i0wzH5
         u0Rf6P7XpzqS7IwDlf0of8RGlGWcj7wRNA1wucoe28FYHm4mKAqN2x6Pbh4qfWdx6+BH
         NdaVF/u+s4vNCr3TuAe4PInVyzovXHcqV8AWgTt2uuu8dLSl4nImVnuCzJ8M9zhcWAC/
         6NRllXjT3WMcM8XoYLIuJ7EOMNCjJAHUcH/Wfb53FmQwQVFpCi3MD/yANzdtF7lWQwXW
         Aj+daWHRFc1fmChGuo4OdbeQOsbZPrL0XPf258FD1DIO0qT92yjombuRXvOwipP3fOjD
         PpQg==
X-Forwarded-Encrypted: i=1; AKwUvBzr/mwefogSgyMHrbA8DCUxYaymlavKpx5q/Pv4YLCdzDQNlv9eJ9j3iMMexoBmJtnVFzJxqf9q863IZuM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ixVFyFAsLXhpJZTe8uhpwmcI1e1S2bGufoC2D2TIr4HV8PJrf
	L6hwj+BsoHqPZae5ZM55jzRIsiIka+Pg8H/TimdlbGgwkTWX2zPVcaTAANIkTI8O3JfnY54n3Qo
	Y1fBjaFtLrlpcFf5m28GZYWNCUKf8QxmnslJfGMXd
X-Gm-Gg: AYBFou31dkOKXiVGUrBkIG2PP4EjgFi7WglE40HZHC+DDoI0fSnWGzoxybOjnkB6bpY
	NzjT/ymLHbJ8kiZ1132qGsWXX7jSfjwUJd1KTotWF+GMpC1sn8QuJs+kFqgJnDO7eNKsx8E+8DL
	1JbaFOO/AuM88avF6z7voZG6F3Xk9i3FYiLhUsycohFWppX9Sx6z2XQUvhzIKrm4nRHyL57RvRr
	oOkVXs+4ypmSDUGFZZwa9Kt4zOLdWkcpQDKWPHZ9fYGggUt39Brupf3dcvP+nuzILZIVOHbhtuZ
	sbUqBCKIPXXn3AjVCkCCSAyIuM/98v7ZBTYmaDexUQjKJk7UjlACfkkNGa36asq0J3LCXqD1jpF
	ClMjDMx48qPeFIsBADfIs70G4ECEYv+cnsgamCcG6JfS1jAAigho+cE7U0t2jJ1Lkm9++
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
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
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
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
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
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
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

