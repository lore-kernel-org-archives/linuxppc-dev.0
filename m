Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BB606A33C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Xpelanak
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ8Jd3L3Cz2yKn;
	Thu, 12 Nov 2026 16:36:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794461793;
	cv=none; b=CeDSwgUI/wSB/myKyHQYfTlv0uK9AA92ZWyUvb5PHLwuSvqEO9HHO1i5lXWoYNKSaDs5oI8P3z41Im7BPD5L4nMTRGnW+mQWF39BjKkHW9VfC+tl062Fr6duCn4I3t7qmcfs8VOzpSp+gtjZluCKGKhF2PS3fHp4u8facYdbOzkj36ZRWKjIBiKO6iMpEQ9nWO0y/rYD8tszBoRi35skfaO9riOarlw232+a2J/ZhdrNWJYJ5s6jrFadF2k2EbU0/9yfk/KMFE6F1bZgkMwQ2Ifprs3hPHtTWPPUmrpOGrAXo1Rcfkr6g9xqy1nfFRD+9FOAdgJcJyDBXX7WFnWevA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794461793; c=relaxed/relaxed;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RFZ1ndLx91tWo3adTo8jXgWYyPRWZFk2+aj82dXVzPB0m2Z2sR1qGHIkNhD7Vih7oOEZWuvBEyiiTxxVDIn88RyMFyU0TIHCe811f/BP8d+03lN5qfOjfzPQyDLS0giYlnDvakYAXYcQBUuRlZ+WQ9w+lcFzjIJKLpAbxXDovNzm2o80MnUjWrHozmcB66zBe61hm/y7EB0qSekZeBEFF+gXB3CvmeOHmiHO2yG1u0+F1POmfilO2lLw7K4bQJEte0BE4HOZX3CAjwWw205Jbu7Qny261gyhcuHxkGXY3L6HNfFGg49kKCdKXduUDhDcM+i17kHHkpL7CnSaZD1vNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Xpelanak; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Xpelanak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ8Jb36GHz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 16:36:30 +1100 (AEDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-93e55db58cfso352340785a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 21:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=XpelanakZx0gbJd9VFmfiVKxSVSQoZDHAZtpLerBZScOP7CmyQKAFyz4T4B8Z/v1Vv
         gQvWU/fTIYY1kQDxM1G+I8kNxLPzEhKFlXQtkAqsd9L+OWCtb3aFuPxAVxfg0fbVo/HF
         GOdetdTvQrvEVO/PSO31xUZBYolwUhnH3zcKsysT71zIZ8eN4HtGJWM1a5xt4oZcgc8D
         qE1Cv8rkyHB7ie1SNAIfdfFttr3t+Bb8/Z7c5NyQcXzqIr9xlI24RvloXfXUcbgcNEIy
         ShuGqJdaVInPaWpFiyRhHC0wOhLUpnMe10ssAbn3UQ9OsGN36QNpfSa0VOcYUTi8g43v
         f8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=sNmTdlaDgIG496KZvpbws0edUNoWiUXo2/5hyWoPiOkUKa4FB3V1Ck2f1AfY0m1XlT
         yBXADeUxCJ+ChTCr4cm+ei3yuT00PKLI2gS8meqa1W16Cnwnbf7VZmU7vcmyDxfMcd6u
         tHsCnWEF7d7nZqXYSPz+YKbeIe+t74Bvj3PyLNWemqz6wNGk7PF4S+9P7zHY/VuN39kl
         zy+X1VQVxieo8JWlYb1+wbXj72GQzAWEaR45dNVXuIa/BgutXI7CJH2uVdqn/VsLqBtH
         uke9xOMNF2YV3TPub5oMQEnpEtVRwUmrBQ9iIseojpYwHXjXtuKer3Ye244fUPt/7c8T
         sGmA==
X-Forwarded-Encrypted: i=1; AL+hErHCAUoVyacnLNBGWVdF5Ews8HvBnYH2LIlCuuNbjwmq3Py6ly8bRtB7gjRpbJ2jVBy7i6R4y8eEgzUNtUA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9/2OrEYcapyLuJqtKEasifvwk13RxKuLMA/ngpkOXajjySFhtM
	GYP3/mG4c+sWxre/QZL0pzq17jr2YpJ6mzzCmjS6eshUgwCEuFac6nQYrE28aYYm3fI=
X-Gm-Gg: AYBFou2hJDuekMVS5aju5o5YpZh3+qJwpaQOeP5xZIys/ya23aURUSPq3xXwyezjGMv
	yqpEer0B9FtPZDJJgtb69ZR9EWPGnHKOvDOT9hjQ8X3bwcJyQJLlBlw5QmIuzsX81waUYYNvl9+
	v1GI72C87hOLwH41ASX9VuukeOKE+SaYyqQH62TJlyDgumPRN1mZy7l7CygdKRGsPJMohz6sadN
	fgjhztiiY9kZEwIoSNDeZJ0wNQY733ZyYaFsVNOTmMOB5r3Wv28LU6j6iUSuGKuO/Lvhjv+nD79
	vKvKP4xxzomPgbiv8Md/RHKVNJEwMQED2iieix+bJMcgyMwK4LFLYdIMxWhzkAuXtmS+s3TfHyQ
	GwO3INqaxm5XK9SMcGdr73HlgqCZOvs7+x9AT3zs5vj/Lg0ef/QfR9eJII3JPnhaomNkM7fHFmJ
	VIwRtOOEbjl3bpDnqzX7r9NRJKgmV+CaNp51UifcrJ3eH4ib9yHfHfDka7W+T3s9/Uo/OcE8bcM
	gDdtM6gDupUxREFGD4wxtm843GZHnVSsCRKN4TPHmcayEm7QTguY8TZfwxh1OL879s6Fp1Q9/lr
	C1yPUUonqD7tU5CVeeYLoFyGEsrc/SSC6ryjrM/vqKNZGU7YfYeiiAoWBkLj42gKCWkNEZKHmT9
	H07opUjY=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
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
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


