Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7318606A331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LNlcXwfT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLJBg3jXdz2xH7;
	Fri, 06 Nov 2026 10:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1033" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793920683;
	cv=pass; b=ntksPKW00tGipyfS1m9Hws4GNPo+9d1sAKCJLh35URbVZ3GMQmQUlNS8xAMS7L8ns6VVDGKQUGvTC3Zxy63vDCh6DjDnENoU62zFfXgM+jYJpKORyzBiFErmBIUz2ihz45ab/Vl1cxWNEZihd5+g9JVxesiMyjmT2OoqN7MhnCnuSFQNvFhrCHHHmNwZZrMdi7Mqoc6IZDPicuyxM7Mx1uYI9pqTfUOKaRYjtNdck4QChRTfIF+DbOyBQZIiRfILNFz+flLodI5ahWtIri/M2eqreLLIgZe+pmR0atBRg9/2/IIt6iokf4d75aqbrIbn3c18cIirjpN0jYsajLkkcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793920683; c=relaxed/relaxed;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfJj23BpOynQcoj0//JMQ4w70f3aYmPongvq+efeo20kswyM04VK3BRhgDYlTVsoToLqhlKV6Re7K26OOTlGCnD12Ep3wE6HrL5BsG+TqJ6A9wjYZiVAdnQY0UtEPMIBpjgHG5BIPurAQ3mK6Uhheuxphg5pF65lllJIdKYGdT9F/rHRVQQgQtM4wC7xeyUJxKkWdoZemnCqAS9ekZqfO7cLFWL5KkYjgX2+JxCXyjjGxlZys70jB2RwkwJYpbvBguAxKXIRwHF+jv1Jf7Qrj4Qhjkeydstv0V/ShBfSkCqgYERk33lZeWWa8RPlmn1jGn5q0q3nExhTjEuXjcv/vg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LNlcXwfT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LNlcXwfT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLJBf2X6nz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 10:18:01 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so30043a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 15:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=oEhrICIRvHT8L91Wx6a2C9+dKWi6ER4V2PikMEahG3GHLyuz2B6ydm0q9JYB6OwWNu
         LCUG6z18hP1AHUPm9EfLkG82Fcdh1Wl44D3ZxG3Diadjiyc0qF0Mohcqbq/yhAjpvQLD
         AEkvPyfTS9aXNHihZnNd90fFiueGGD9FHDWWF13VvtUfMo4DWIX82GuG8B/GNfHMRzDw
         CbfRH8rO5BVjbgm42WDcy31j1IeN2pVLXarU9pdZ7MjOwRdalsdgb5bvIV7RjBVT301P
         +uvTQBkra/f2aA70XdICjQ4L3KLTK0ryu1tXsvOW750PXsmsioF1v8FC7M3tYFCJdtRv
         z82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=pWKSl1iyRnUdMl4a7QE0E0t7QvGSjvugwkv7GfF+9gc=;
        b=RrLgS+bWyzVPabX8/puj1mTgmOEnMn6drYYnlfEsMD8cNLsqENVpKQSE8HivzDjV+O
         CFOdwR/Jz/AC+Urcn7F5e35vv6XqwnP7ldbwtRdtklTwVxJ26q7pbijjBoGPi7yAmwqo
         Ow+lY8/wuHxxM4Bm9DxSLLMYF60Viit7/kSaxiA+4trwksuG1gdmiUx2yzytEZ5nAy+P
         pZcSMclbi04cpsXbusYLo+ynJSVB4TAkDZwkoTpOMokzCYzg83bybWWaHtLjpHziBlp7
         R1tb5iAjEmJCe+Vfd7VQ90ibmy+Z8fdUATJHXjD7DTluiVvCn6Gqc87DVRPB7c3hwuH3
         rSfw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=LNlcXwfTMDN6xQjqKAHpWc3Oftv8odz/qirMuyUUebxvLBypDUOqtq6HmsngGPSJe5
         CSZ9fQM/tIK4ZQroEGRXDsH8nfulN/2auP8WstJha6KEiTlagjPBX3HCu92b0AcAuZPQ
         eTsMlM8EfO1z1TfgTEYDaWv9TJgkSzCiM22gpy3upSfM9mOG5pL73wNZs2uJFVUOVxgl
         3XKZC9HQLV07wbaLBk6nKKI3s6h8p4gUUMkHWfaN04T0tIYPssBbMuG1nKZ4ODJU5/sg
         2TY/6thy5lNtVqk7R34UTfjeAjp0tYr/MEpNOZWLNpXDGQJ3fxWYLwozNtVi29qhF9Rd
         ReMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=VkQM5s52yYvQeWCdLt9IokivkYbi0ikITdV9QryEfr6FjrKPxgJlooQ9v61w9sq9AM
         UOVogZvRgxnx+o/CpmYshr70G2FnnrvgBCBh0pGEHtg4y9dhx74EoVNzCmPihEKqEBNl
         hc5EJVM/DsnE9wdoCn2P5PdK0YfUJr0oLofz27MSUly1wXf6qVm4NylWkBge4pL/vC+M
         VPqGGikQn/et9SYAkeM3Un0H9mDxp4XMI9cTHps1wI1ERm/ktum1WzQ5XcHsz5YWgv5h
         MetzEQGwBw+CV7IU2f+OytcLBgj/6b6DWJBzWX37w9n9iackrLTu1fWsTP5k8OJ13D2s
         8mBw==
X-Forwarded-Encrypted: i=1; AKwUvBxx7sFsQe5JNnyoqTOMxRkuPe781IT+I4Ue75CxgVP2TYqXY34vXKxfZp7T6XDDO3b3R6FWPMH674UUPR8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z98mSJsbSdb01GoucsWXyX5knP5JJImVQjnvAHrOK7bpZ/Fyiuk
	bb9U9RN9TytszMmmIgbt6mcFgO83myWdXb/D9jzNW0hVrgir6r77yAI4rZuoGqN4a13864mR3CG
	VuRiCRRfcLJWiZWmr57Nw1OxFp/VrJ2jeDTJ2esPO
X-Gm-Gg: AYBFou3RaAs47zObtmrrpR820NY2TDvrNb5rNGr3yf+JJlqSC6ZBrDRGSuRhUrOkLie
	csS1gnwxfIBT0nUNGMaD2X1Fs0CAFbwviicWeraLVFsG2aZIXBeH8kqqUXw5w9DjcgoNVSyO680
	7O2feB64jciCv7lbqwb+1AHfkoHePh+G8y8kaj/X7kSBCKTcIcm11bYY16h8uIKunceRBn0zQNB
	uB1AXVnsukLrHFCoOvEqSQDHoVCXomeMypxRRIKtSTMCgL/FvSt2IXPuwfAx/gI7f83LPPrjtRW
	mbAx1DlhZzifXzp+4ZJg3lO3L4VrIYp81ZGNyEtUPTZfl85o8s1SlbEq4FPDaUXgsm/BGkku0Od
	7QPxccMA0bT6k2H1eaMMRC5H0S3089RGjqB0MgLtZesAHkzkZ/YSi8uTcSKL1tL2O7TUF
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
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
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com

