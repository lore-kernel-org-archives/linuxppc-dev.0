Return-Path: <linuxppc-dev+bounces-27142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE27C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 15:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhHtb4r8Jz2yd7;
	Sat, 12 Sep 2026 01:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:31::f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789139175;
	cv=pass; b=ZZWlUN0cSvu1FcqxQ1guz0bZuLmSSh4oiT80Enk4oBWQ1CiunRBsyN9YmCskPcavSED8lR6nsdJiaoMMCOlx0DmcHmOlEYB5KWh+j0X69X7f+v3Q4N20TU/jxjex08pQdugzesyeVFaznjj/aLwntdDtxCnjeMF+SVDNMke7qnOlS9sHSpW39EDKHEJxQKs+tS6qp2eavn6mqDRx/RDMtFXTk8jWE2lp2IbKXojaqabVxylkCizIdSsfKA8HcithTM0v0Wt/Nzv4oWFVG+k7BGM6fFw5kHvlaTFeHfsgTsmLxgWfKjfMyvSaMTvqjWUvrKK8UZBMrQ1lfT/DYFpVjg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789139175; c=relaxed/relaxed;
	bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IT94K8yzzy4Yci/WGKnlpN23BfNgeL8fUtch+/Om1zm4OsX1WN9b3t/DciEENj4k1tA+EH2yIDtZ9QP/5SShiYQDuX/Ec9/0HZ7CbtuDldtZOm56xf9UK+Dyl4L+OdXEf/I/b9QzY2OPtIs0Vcol0XclxLtxT1fQKlGo72iZdko5K1/c98TilabVBK2DwaEZt3f3sGqz4LkeRfU+M0YbeuX9r+GD9O0Rbv7klbMI3ns8l9OJKnRrQNFS5vkn1ThXe7JRsXc5SlgXJfqkg5HZ3M+eCne7ZAa5EQMYRkA6ZCCmj7IR30QnjN7QEKoQ+x0r3Pg7trYdzQsxm+Z8vawVXg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pMgG0CMZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:31::f; helo=mail-oo2-x0f.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pMgG0CMZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:31::f; helo=mail-oo2-x0f.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com [IPv6:2607:f8b0:4864:31::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhHtY4CKsz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 01:06:12 +1000 (AEST)
Received: by mail-oo2-x0f.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so647611eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 08:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789139169; cv=none;
        d=google.com; s=arc-20260327;
        b=Z6rW89l3hYrdOC1INt6HeDCNzUKgtcMQ0jemm9Rr6BGGXgG41k2HEWxXNyGEt0aX9m
         2dvaS6rNW48MwL4iWD6BZpw+TEFPWPOiWVcWe6BJpZYOrwlzap25mG4wiV/DOu0vG3EY
         pMhzjVKptOxPCBrwwReaWlPidMigGdWZXyWOnjjVEnW0oc2ACAPEJzsp8Wic+fVnBmvg
         7B8W+u6RMTLmBYGwYYZvTzIZQOgWRM+1l72bs5Z4qh4fTEV2DlTTH3CSP/RX0OpZsUYQ
         KHwVWUriFgh7KGoKY6ZhjobEFxcExb+uF4ohg5SYTOSXRcLxCDwRAqI899rFoDpkgVTF
         jfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        fh=hk27kyvlbLFpUbqPwZP+Cl9H30Pk3DFsjQlJ5LArFh0=;
        b=j/piCePMrjdJ1FsX4qcUdM4qgmdOB/q1UZwx23OnJ1xvoBscVNA+gf5w0jm/Un278N
         OpOVPZ8bTqPvUZxNITCuCXsbD7/IezwaYv00D4Mf0QJpQFZFodc+BfIEfcgnAedCEn/t
         aMU4u25l/iswhyPgIIzIszaNk5S1kU2bQ1/dK5bEqPYGeVEafD6TBRmVkYd0kb2lOVgs
         ++Ipf/c4xybcAq65e3WP2EIuAsrq2JjyIAKpwcwi09AMR4O/Bk0xEgi6mPao7pjO3dWi
         ciy/oyN5RVSM1Wzh7i/LP89tBHjbP/5Chr8vCq0eAeziuJQk6SV3oC0tYoBgldw34P5K
         VWmw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789139169; x=1789743969; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        b=pMgG0CMZSCs/bVKOeg9oX/0iox/tzeWfcba/cNSAYzqVel8EzOh5626qmyiENZUymw
         UYg+3s4FE90jWTXrL/Hv8tc+ueyzpM6aZCnq5StyPGd3jtYy8fmhHzsOVbOP3Wbnws4y
         h0xzG/IR7+Y4Q+cgfLnbU91uMbAIpiD6/HUY5+W2OVujTgdtTeE3kezdXaTAXCrUkfa5
         7nPlM9OGMumbloXgAP3DYvVriZ5CeLLB5oQw2ypD74YPaUAUhi/0hcSZNr/oD4mI9Fmz
         +0lu1+IEoNGs0ixQWr6ZT3/O8EREx51YhYi+v9ECH2ebVnmTJ/351xacSHn3EclwwyWm
         zIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139169; x=1789743969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31WGPI9CsS8AEb1QmZigfY8oBbhGb6+EPuGPGJKusUg=;
        b=YEyNGfsE7ctvSZuD5NmdqXWOxb/QaVNC0AJdDVGRiMoay5/SaadOXKUygq3Z2/TKfW
         bwsxWcg2uKGIaViNZ18YzqqFWjnRiHZlCop75ILCwA5lSTbsd8Ee4OHkwBfB+46GlYI4
         imrihn1op92zlMtugx6BZRP9/0sV5s+p4WE/TR7AFtSOQYxOaKWanudxCXLCy4VUN3YH
         hRPexnrcDI1/OIPtPr3vpglsej/tuiO8Aj+onV6wg6vqN4VRDptdHNbRMr/CAa4C1prw
         q71Ax5gEFanWuXt45Q0WEmJo1OoyZaP71Il3rcH0s7gIcVfCAHLKv5OTjFzLz2xDMwVW
         CBKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNtTZQNrYOuirY4HCIIQZyk5p1Cq+s79ZsWcno5o9f4AtMTo6Fbe/M3ZzAOvIyObh5w+udpmxNWeiUTHQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lmDBLIJ9uuAIlYN1CTi6VfPe9VghJPj05foPjlXA9taMXk+vye
	8zRv52HdvGeb7Q8unFezhca4hBpkiFAhkRpGuKd0xnDQjrxONJV40hoiMtHVOFNQOSNAUk2U3W9
	ufmCWl4/n0SFQuVfJPS6RLd9MLL+TDc4=
X-Gm-Gg: AYBFou0WyJQ6W4zKAo6nnIR8E3VJj3z5B2djjdWqoDB0LUAk1YjE2O4US0nl8SRDLYU
	R/jAQPz9HEsp80WMVegkWppKfdiOpFvEY775hkP3kbsgA+5d9k5voaCFsFzIZahdzbhEKSo353P
	3z24uCZtsBiuIWR2LB/5tFYCc8MFwIASJGESxE/4jVUjjm5fj/HF8wtESx9+1luJTFACRps8x2V
	JB2EvwpajC9tfRkHslPd849FIZQ3Kf61QKHYyT2gRwZl20B2IlBXQNroWTTbtxe22p9A5hmuulq
	tIxKzhMCg+f9kVkbB065fvpWATgQoaC+/UNTcOGUamplWK08zQybue8=
X-Received: by 2002:a05:6820:8585:20b0:6b1:be9f:ce6c with SMTP id
 006d021491bc7-6c0b9d4e35dmr4967721eaf.4.1789139168581; Fri, 11 Sep 2026
 08:06:08 -0700 (PDT)
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
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
 <CAEjxPJ7hXSi=oLtQPV+7GEvN+txfYwZ-u-v_EysNHM0gSGNrCw@mail.gmail.com> <aqPUqU3eZeFrykj3@gremlin>
In-Reply-To: <aqPUqU3eZeFrykj3@gremlin>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Sep 2026 11:05:57 -0400
X-Gm-Features: AcwNN1UL9TCHStClpz4OqpdpVCOHFGRlTtL1ELl-GfcxGBMtPjfBSuHNlaSY27Y
Message-ID: <CAEjxPJ6P19eKF-c+mm2BSr5_WpmhMTZjjUfSamv3SfOPO4SGVw@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 6:16=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Thu, Sep 10, 2026 at 02:11:18PM -0400, Stephen Smalley wrote:
> > On Tue, Sep 8, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kerne=
l.org> wrote:
> > >
> > > The policy file has no write method and is exposed read-only (S_IRUGO=
 in
> > > selinux_files[]), yet sel_open_policy() performs no open mode check, =
so a
> > > CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at ope=
n, as
> > > kernfs does.
> > >
> > > The file can then never be mapped with FMODE_WRITE, so do_mmap() alwa=
ys
> > > clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_S=
HARED
> > > check in sel_mmap_policy() cannot be reached. Remove it.
> > >
> > > This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping t=
hat is
> > > neither a PFN map nor a mixed map, ahead of the core enforcing that o=
nly
> > > such mappings may do so.
> > >
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > We should likely do something similar for the other sel_open_*() and
> > sel_mmap_*() functions too.
> > In particular, truncation of the status file can bring down systemd
> > since it is mapped by libselinux.
>
> Yeah I think there's definitely more that can be done there.
>
> Though I think obviously that kind of stuff is better as a follow up as t=
his
> patch is focused on eliminating a case where VMA_MAYWRITE_BIT is cleared
> incorrectly.

Agreed, posted one for the status handlers at:
https://lore.kernel.org/selinux/20260911145840.19039-2-stephen.smalley.work=
@gmail.com/

