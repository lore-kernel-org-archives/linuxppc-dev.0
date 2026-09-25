Return-Path: <linuxppc-dev+bounces-28184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D6C98328
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:35:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjDT0vKjz2yd7;
	Fri, 25 Sep 2026 17:35:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790321753;
	cv=pass; b=cyD/fyMpN3wN8hMqGXOjj47l4T+azcXbXqzT47pMGUY85vzRqhPHATVAPDQfdj1FQNvhH7v0SKg/2g7Z5TldLjECaG+epQl4cj2LqtM7zmKmuQgcO2lCQrisVkPGhSd67p6rK3ZQQRbAa7yh2ApEzUIqlkPo4JHSZ7V7uETwpquHbNgonzCtoLGtMn5QuwE8K+inOsUTKje5TKEkBKv5p14mPMxRjUP0SFE/D7d7i3Jh+3LHG4N9Bzv2stmOdfWuxVT9M+OPnctViNmDAXodUCVX/PNCcKdzTLnkXCtDkEDsQMk7wiblYkAYKhgBR4RB5Ya1zj2MPPJ+Ufh2W9hxJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790321753; c=relaxed/relaxed;
	bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llKdiNOJmRruuG2PrI5J5Fnf2xBZrKYdjUx7R4Pzq8EcxqCCdmhF0G75vQB9s76cCoBoH8kg882v12R3s1tP499NyOZCgnDfSln1Wd2kPf2+RqVaMCq9FzAtWZjMX1XNt8R4Cj9Tf5djghef5wZpZ5n+WAY1xVmewFhHyQa5En4ThDWT2GHxpnWCPCVQNQxFU0+tYBZ+IiFMCu9AFh+22jB94QKmCoatS/qsNXovUpoZSCAS3b3eUTJcGD5W02Z1RPHdg2jHgggUy83wzFlEBmHBW2qC62MeYFvO4V3A1okGYY4D5hOP/sS7ciJlOLFsx+7ub7TphdX2nALCXozaLg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gH0zcf6C; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=gH0zcf6C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrjDS0Ctsz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:35:51 +1000 (AEST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so7242a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 00:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321747; cv=none;
        d=google.com; s=arc-20260327;
        b=N01kpgw8zk8+DuOFcf8oGqADM3o3JJNpVzu19RQP5725N+6N7x2vAlo8i6HBWHBp8G
         mw4KI2hVP+uZoiwb7mmFhF6TKlIUzJ53p46wi9XAkYQAQ8hXxIsVpDvuD44Gg37mK4SS
         sExGEE02q9UoHc+1YbhdTMOo+RMQCxQBMy6RoGtrjRpI4dQzGrOcsuyAJ7cFObTkLzBW
         NRftG0sJueJ5UmCAvCt2nAFGbqeZx6ar90YcyM2W2opzSsjYAxYW6zQg2Z0ZIFvAgTW8
         BjT+UB3OeJUyjTfSaTzO/GxnavVhEZwKb+gkm84eiNgahoTNgHdXyAmWJ6/XLyuoByf/
         yjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        fh=jshRhl8wvyvnHUge965xsnQVZOWnEt9O/a7C1zTOq6E=;
        b=FdHJ9MpKzKdysTyARNK8uZCwGGv40MPwzGcOlUNyymX4388iyG57PVgiuiel1MfPHW
         0GOGUXWo/t5Q8giS/TTNI8Xx0wLZGC2vlDZroefhPFO1G8EPvIVC5VrLVafIvcECAArb
         5n+MMewa+BPuCXp6gD2O66tV07qCXWFp2HJThQZu3SqGQQHLH2xaligj9bD2hnM/lx1u
         YqMeHtPrzvoM5yMXar+G2R5rMOt7gdl0AoXB49RV6+aflVpT6AGYeHh68r5pCzqot9Hv
         2mOOTNoaek+8n3TBEyiuiEBlyXj6+Pt+cY3gNrHtIc150uS1R1lI12YLa/KtCcb0UyvV
         rcjQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321747; x=1790926547; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=gH0zcf6CNKehVczoykb0HkSu2dn+3qOCHIWmEF3lq8VRsV9nPU0kW8KbLwnCiKh2Ei
         Kxh8SGohfy+xbMTUpVkJbaARN5ILhOeVQsBA1wyX9FIECMb+93YHbJ45ppnA3PyttvxB
         dRt1OnGN6/V8d54rKAoMx2ueiCecDF7KpgGBIbtkbcrU9aIpQi7UYVPIHNU2i0AUgDt/
         P1EVZThEocByZXohMtf0U1WwxZzhK8x0gY0fnGca3m3bU+QZkGQfTQdY+Uwyw7EW8l/o
         Zk2twDgACtuSiOeW+nVtI8Xg8UbSuMWvTwUZNA8K0dGM153sohecaWsIoTDPyl/7dMwj
         1nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321747; x=1790926547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
        b=VfqWRB7pSG1nUEqPx4JG//NvP1w7KkgmWiPChf24VU5zVzKAMlZcVq3Nrnf8kO/ulU
         R7IyFQCEnBkF2cxm2qESCfyIzeCON6V+a4AHymmqy02dkYW2dEqT7Y+86tMuo71K/rz+
         BDwYc+8fFdp64L/PZMr2DPomqRQpc3+Edjl1v+SufJtgkfnaIedKD0UTlP3/seB2JwWZ
         wE2MuqdBoIylj2OA/0toPCAU84Z5xjpBGJkL0zMsrzB1JNq3gsc8BM7mNmigKYpeBTT3
         ecVMPDlH67KnqM3gAPkxfS3WxFDgqw574e6WjWKPJ6HLDVTRi5W4pyly/xlP9CamydR5
         a/mQ==
X-Forwarded-Encrypted: i=1; AKwUvBwk7eHOl5D9KuHlXR98k7WfdM5HwEQfjNVirr8/nsNaUPflyMkV1xPSRMWYubk7QiOH7cWyAU9gZFN3DrU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n3KKFUeiL7lnIW6OsiiqcEzNiJFjyh29SLiG6F+rvHi8oPb45B
	YalkPaL3l7i7X31pswztrALWUmBTsyWkSatHqDcY7DJuA8cnLEaLiqGC5BG9+nfJS+sP8VyaOaW
	aWNgrQgfVYNs+P/Zy8cxr0RhY8Vo3u1XCuBOKk+0O
X-Gm-Gg: AYBFou3a1wIqvms9A2vawk2pDD2E+3tUl9OIpbqKP62iqPPLY6EnLm88jjdt0+aSs5m
	GWl5BBo78HRKPbvbB9pQ6RJwmvqQ7XFiBRf1apQrNE0/R3mYfetgenY/xrM1sgRRexJNAjmpfy+
	jQERf86EdP6OHMbDUj5gM2aBs9FUNwCRc8nwW4iPHlxNRctNadMNNuQRQkm0/kd1g8ms5OdlfIz
	X/qZQLsoDMt7H+REqJHl/DJr208FJ91zXD/HopnnjLTtodQ3yeC7V/5aPeFUrNnA1K/wFqfWPVz
	6w/RBMkykwmdERfYBF+2mtBZkqZip0pqD/OyvhLs8RX+TzQdjcKMcKNoUCbwAl3J
X-Received: by 2002:aa7:c64c:0:b0:6aa:e332:b762 with SMTP id
 4fb4d7f45d1cf-6aae49c58f0mr23500a12.8.1790321746110; Fri, 25 Sep 2026
 00:35:46 -0700 (PDT)
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
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org> <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
In-Reply-To: <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:35:33 -0700
X-Gm-Features: AclHuK_NuiQlFRW78Nf23QbG4E3oej6nx-ZjiAb0IRRSHloLT2xGmv-6NXWsN8E
Message-ID: <CAJuCfpHpo58c6eOPY_CvP+ts2zwXQEDNX2bohXd0CBANYWrBWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, 
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

On Thu, Sep 24, 2026 at 12:30=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > There's no reason to export the symbols for these functions which are o=
nly
> > called from internal mm logic, additionally there's no reason for them =
to
> > be declared in mm.h.
> >
> > This patch therefore removes the exports and moves the declarations to
> > mm/internal.h.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h | 3 ---
> >  mm/internal.h      | 3 +++
> >  mm/memory.c        | 2 --
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >
>
> Makse sense.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>

