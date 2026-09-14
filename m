Return-Path: <linuxppc-dev+bounces-27266-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36909C88E7D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 19:57:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkGCd32nVz2y2K;
	Tue, 15 Sep 2026 05:57:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:3b::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789415869;
	cv=pass; b=M7KteO5Wn0TPACbiic8zdzI1xzRvMs64YVw7FuxOqwSBrcS3+kS47Dic/FF95MIJlsOe8E21MzuVqrqz4HCUke/7Kw2dIRK61rANHEJiOmsE8i6pMGAEAmDtP9iOtUqV3y/zDTmmULNnV7CgD6ZJhS02i9nTYOA3R66zO0llBmlRDYuu4KYu13RyVHCdnC6C5Ux8unMgReXfAcDsly/1Dfllyqz/VGQAxTlqVrZp59pbsBqFdXyEdahOIyKU5Vbp8OWGyuxNL5Bq9wyM+7nXHiWeM+pYJzO6nzWxGNmhpOBWJknJjT0c5AWj5KeCnboxyJcvR31bNX2Lil5AXdjetQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789415869; c=relaxed/relaxed;
	bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af1sPl3qGde2PCqwcDv3ByP35IyNsTM4IkwHD+VX3wavPcdckZ1tujy4qQJcJkdWpHj2nfSDUUSnsEFQwdSYzFznVaWkc9ZkIPVKU0uIjSO/GUSD2gPh4+0rKfLKsETaWJTNlEvwMSK/8J+c16ogWoAlhnPHvIF4GSB2ZhA6OHLzEuvR++XIipVzTQaGuSGsNyfAYzVzmnLQ//UNCI9JWW5o2EgZk1fR8x8g+5SZQLnPj2xXq4i5d124W0wCfFJceK8oOaiow0zVXx7y55F6YOrlmTRb/rUtmZRC5xfQtg4OlA2SYhhyZNZjND5I748KOVAMPSlBSjyD+6UVk5M4yw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=eKwmUJoE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=eKwmUJoE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkGCb0jfTz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 05:57:45 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-85469e25187so1854646b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 12:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415862; cv=none;
        d=google.com; s=arc-20260327;
        b=fZkX8WN1S9fJf+bSrxknXnxTtHux9tJJS9233HHe432MpQrNJhidnFjquEcWFrU37w
         7LoLn8VCmu7HuqVsm02WW2uEDsg/XtcutI8HfupeG1IbldEsGMECpe0wmoXAzzIoQU/7
         NLaMQBIvxUltj1+BFDRUOjFeTwOR2H2pu+X3FtDpREwI/6PprK/qSGVakfAKF3Ti4L4i
         0d9vq8WbmgZBgxHCw02v7yduuesZzq+EXfbyISCXdi+FF+Lg+9TV2V1tScuqno/J2uqX
         iBFkGR+1WerhhbC//qkQTYMVm7OgICTT20qtBUXzg5lgzksM8IxpsU65BHkbjaxwKms7
         aSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        fh=Le7lQR64UkC4ETJM45V+gevGa2HHIJXzFqD7/6P4mpw=;
        b=rmFoSo87DepJyFOf/khW+ADwzUfVxXpTS/JF57qNObTZywB/a329vseBJYTB07QdSg
         OtTXLusJaG0XK1jGMy0BSQi2/WZPHznmGaqy1qUX306G24YREPxnSrV5ZdSimXkIwRat
         xsbLafTGAmSc7QyeKT9R8DIqLA5gvn9rYKG+sRRpBZ56NtLkRF3zv0xG2Mvsom2fKoZK
         W1Zsyh2I5SpGx2IFE9od1ju2255KToMgBUs4xShNWegwR3rtjeb87jQD1EYl/YLeqsTO
         x95iaVXWBXxulQiQfqimCmUdeWnGTstoNQeyjq54BhyYQAgCGa9IvpNiDhkGu+Lpp8tp
         8wgQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789415862; x=1790020662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=eKwmUJoEmLi6VB+EguLCd71dPBfU55kO9Ddv3kvAef0z2cMvd7tCnZeSI/j+uWMq7+
         TnKvjfbM2s5BXLwApJo20IupgYzJtHh/L77KmytyGsc1CAMMP1UE44oyIz0IpF3/RWu6
         93dmRjSZZ/6k7BCCs4VxAoJx4nD/ga7Eurkrs1wgNCI9ZaGgBXNcBVXyoG5z2PDgeOxQ
         7akEa8E7IyXZbvu2bE6islZEu6mo+owVbb85oaUqy+xY+rbh6cSBAdzuWwljTu8Q7zI9
         PxuCBRxDLQdKSysS+PyW7lbgmQWuploGK7YNV6TNz13pCdQ2xbbSLAzsErESwuxOlXH3
         DAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415862; x=1790020662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=HsuMcaBjezlxhef1LA3Ct1FfRIeOp8BAYF8MFkjUg4a3XL3MO/F00Tno5yyTYMhXrg
         KYpfX2rt1h0WW2XCWfYOHwCnea/QSHoR3pg9TV7itXXXlgTKVhSN2S+wW29msHH2mmv+
         GN7gYgV8B8FyMF/VOQw47h48QKa4maP7JCRVzcDK59fnUn6Apd00gFhkBXdIrKCwaFlr
         4DWln/6jf640AsrjgsqMDTYQxCc06Nea69Fzs0TcJlmST35DtyQfdSIABMNVlctMl/Dd
         h+ao2rXg6x+qwZ5l4aY4NYHo2Ukel2HKwvzyo7rCN6jvMAI0bdqaucsTAzP+hwyijrpW
         UzwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzM4Zu1vGZCtSg3UoDXdTml2B9UgRb6yj0zTTa/+ATb5S29IwTIhKuWwOcy/U/if0+EKQyZgMNtzZQo0f4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nleWuW2n7dMHxQoj1rgHgQ9/peOokdGETJ9OrH4quG6P8VV4Be
	CC8L75s1/nJyQAzyqnR5HKpLlcHMZcc9ff+edmbEIL8zOvicIzDDpbzsnqvQrHJKDwTfwSKY5qZ
	YtMClsFWipssIkHhUbMhnwlWN49EgOFrC6yx8ng6H
X-Gm-Gg: AYBFou0//XJtsodfsIAzs1O8sFK/VUvmN9Zj5G7OC6hN9upmBWPIGBJgbi2FIzacloQ
	ZS3ej1Z4hE6JXMIfDC2KUp2fpJptASDmYfetF5dDFZb4weipA/tMj9kR8FVatemuEEsO+WWJLdo
	SLlhnr4tPExeLNtLYr9t+iOppoWigXRPS8FtHULEB+gAyJweCrZHdrijhDf1RKRSaqsdrFuZRVq
	Kgz+b353Lt96L/6r+L5KsCoQYENQtpxLWV1cDhnE9czeDQSpSCqTPPPP3ZBQP2HhkodGxDLLZcY
	JP6YRh6zQJbNZTpDgJmOULMkQGMgQSVAv35oMHSM33wlvS83YnHaupTAw5nF9PF4qkR3Lm1zoH2
	OX0rjlVHAzmA=
X-Received: by 2002:a05:6a00:18a9:b0:858:b809:6ec0 with SMTP id
 d2e1a72fcca58-86f869a920dmr8896742b3a.23.1789415862342; Mon, 14 Sep 2026
 12:57:42 -0700 (PDT)
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
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 15:57:29 -0400
X-Gm-Features: AcwNN1XaLRK0KaZAmfcRvdaBSkZOdh14LF1fb-xWULoFVhBfqyRklsdKoWBmLag
Message-ID: <CAHC9VhQ3TwdGGH6YtVyMqJX4avJwsadcRvRhAoUhCvJEHk=i=g@mail.gmail.com>
Subject: Re: [PATCH v2 12/40] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:05=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.
>
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

