Return-Path: <linuxppc-dev+bounces-26863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD09C79FAE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 20:23:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfb3W56yfz2ytV;
	Wed, 09 Sep 2026 06:23:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788898983;
	cv=pass; b=QC3wJNzEuItOtmeWV67hw35BTdEEDNHs34zsNmMOhp/0UNtDBCN6Z8lXSybQX0c1KBCFI3g7xxehjkS0/KALBQHAJSyZKJmsvwlwY9YuGixcFqOC2vtJaMPk5VZsXOlWcnTVFZNLaV7Dx9Kil9HFh/CRnfYJGxpOVKESO0Q6l+1KDdWodbc8cXyKwJ1UUd5g69FEJlF7D7qKKG/xl5bq/mxOeXK7Nf4sivQzbJJpTiWQ0jjIforB1RazJGTiQnst42imlHsJ5nvU69JAtF0J+4RaC9J1c3Z6q/758LVs4+96gDuOtsKDYM/Vm97IbcwbJXpFiMYH+P8H6jhZyGJVMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788898983; c=relaxed/relaxed;
	bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOvLIESOZpyLTcbzo1aazOtOXgST/KbPCDG7Hz+LkiYMsrJQ79O+e1yUqN2hM930Iz/dVvB3FyPYPLE887w1cvotIsKERIXbimOjwpocm/lNP2JJzdDP+wOgWlv7ZkVt90pQ3H7ExgdiGzgtFc34HeXE/T1PrUpTH1w0FLpbGkdAGmVsj/V5HnxWLblNdZ6DchjJtlODHoBOPPXd8KoN6P1fLMsPU6+9+bFazxRBl31dqQ/g8mZlqNYcc4myRc7fAt/DuowoxwATaWpF6FU7vYr+m3y78ziFRepLIfW/btX/cThSFcemConrPKxvSWBoyr+7KoJDrd6RtCYC8h7yfw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OmsXVaV0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jannh@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OmsXVaV0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jannh@google.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfb3V0hNdz2yrg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 06:23:01 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d6ff3aca07so1705ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 13:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898979; cv=none;
        d=google.com; s=arc-20260327;
        b=DIlKxG/VI1Tae3rq7KKHZ8xuHH8VVVxT8md/JOZY0vAoDDmGKS+MioGYSFbNPTrFx7
         v70NmMI3vZmDvCtcAKlJwwg0UXiSBr0lOihCLlrNaCD+1Wxlql/9JRu1G16pf/IVeUy3
         8MnqHVuTKTfTE3nveYew6Krf2G+XrMq+i4dMVQGnDrP6NinycXYTAMAI/Yr3UsGpmFhF
         LC1eLwBkZG7EQopzo99EeO8JEZVGEJddyRw6tQWZWiOT3jso3skR+FOez1Mp0daBo/Wl
         h+FlPvXDQiZVZZ99rV3THLpihO+0GOKNYgsMwaZFws2m9HRikQF+6x5OBrcFrlyGAgXC
         anIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        fh=22hEHjp5ryzWJyvvUvbZ3fa5NsOGvY7ys2qK62oIZzo=;
        b=BJeasQJ5+ks7yhuaLyJkeuL3ySxoVgJgr5z8bz7UTT3SZ53hqjisc/53xWlYx9uo8t
         htEGX47ZhzX+MLg0yLoRxT1DAf+H0LgEsZbpnZlnG6bY3HTZrTO49Ey8IYURu/wtAR/r
         DXeFonLpXPW5CaCJyU7DelvBcvWyksaiyO3l5PH1meoGwpuyZ6fQPrW2l985Qffu8NVt
         af3GKKH0hnAl/lWxCWS+O2cZaE/sYa137unS4oz3CbIo9l8sJFhnInnbU4rNbnVFprSy
         U0WtyYNYJRMRywjamnxVZc7XQkBd3ud1+7/u2Ztvei2bOTkdU9XZeNdVZt1+1HJKkg6f
         DjOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898979; x=1789503779; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=OmsXVaV06qLIRUWhYfw9hfB7UZHxxLSkU0WgwH8nT3QFk+rSL0Fxmq9qPMatTH7TsU
         wamP2vClGdcJhI/o5wWNqi/kg+OWaGtJgH0zREP5SvOYBZRm2hBFr/tRwozZS4YsuDp0
         1ipej/BmN0GxCnzh25Hdt6nEqiaxaMh+Bk20patv6vAlnDJmckTF41qjZlGHoY3APR9N
         jGRAvmyv1ZXEIU2Arbds+h7YOO7FTQJ9A6wfC56j64oeOQipbcMOGZPk6eI4UvMj8rtG
         R/thXIgPqhqKl4FyYC9dpvo2u8zlAolcR4bENbxgcTUG+1nBZ3qukmI68E+bDr7Gxqum
         Y6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898979; x=1789503779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=Fitp0Oa6DEJEjkRLfM0UAv2iYfvxm8H+KahOtgR2mHFquNCfzY3TktGitu2ztaYohx
         ucpQSsvIq17dzhQugEpD8E5iJnSA1Kx3P2bqDPbNjJSEcqRjDHrACLBRvMFh1CrUFdbi
         coX6krjItwvZTOW3numQ32abihxHj6qKJJIBGFRan+gHGFFxe0meeKbVyF7/UYvUW1bp
         DtaOm3jICsiQSSSzSANowA2oEwtps7QKvZLuif29meJuRdjOoDQYKowwVIXXaRghaAF0
         eQK2Z2IL263NEo///C5RDPAh65cTtPnTK2d980lkdCNetLXYwWkZDBSodYPlKuMuyeth
         baOg==
X-Forwarded-Encrypted: i=1; AKwUvBy6VrDQXY0yyJMPD69OoG+LlbmY/Y/IGQ6ShELsCp2W9sTGn0FEezyD7xeRt+fvylBotqhC3Gq/COo4Pgc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lMKYxIkfRV2WY7PlCdUl8X00c/iBKfHbicwKWLzPCvy7tGWol2
	TkpXwzx85VHPvqh0/azCzEWrg3iwvFLXORySHRGzPWbl8AODTh4LdaFmbZglPCIlLHBL17evrpG
	OyIv6eDq33Buwqp/EK1m53HZmSBXghYt8wozUvXDc
X-Gm-Gg: AYBFou1Mz25qUxigkazIGB+mRLMMKoeelpiUhmHPZyn7BRdUL6S8jj+FdXlG4Zr5DgY
	rSwU89/cPiKxvjEBy9e5zm/JJGQhLLI5QzGNtmBM/++MWhN7ssk5V/GRxPlOerUSAfiij8pt7dV
	v7cJoZ5TEcvd1LH5Gt2I3tleiAFIXu69HtndIuoexVEQUwJgxNG7Dz8GwnkXRa/+UMilYIVAifm
	nUZsQPkA2Nj4Thvmku/6BAkSM889j+0p6z8mAEqei/rDJBFP+bhnJO/cjVuohWWF8/kgWfc/pjl
	qF4gk8cqzUsQOa6GWMrQyL1P1JPJRxcNFQKt97orF/Osu2yiyAQw+Br7FpcX9jbpRr7oydffo00
	pt968g1PC+vQtd+33eCwWw+dzm9Kbmd3s
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
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
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
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

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
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

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

