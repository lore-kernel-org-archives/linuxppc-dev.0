Return-Path: <linuxppc-dev+bounces-28890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69C6CA5FF1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 18:02:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyVj725Xqz30RN;
	Mon, 05 Oct 2026 05:02:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::831" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791136939;
	cv=pass; b=ErBFA4+tcXWYDnKBNA8vDbMh8G0zzJSpTsvvU8NM2ksfZx+7hLBnTVM2W4lJZDiXH+9+yO88FZY7ET3uuONMUBKsbwl+mCQpPqCQpk+Fgdqj/AwzB5EFFQrACY9odqCR4vn2KUSnA6KcIMa+PPEiF4QvZlHpejHHs/6uZOGaHxJbgmrvBmhAEvNwgNlGs2teqamDWCUlZip7oJxZPsdtrldu4gvu0WF6bRDwPh4KER5c24Na+RFT5aE6/XS5Mk4u/QslDdDs8XV7eGr++NoO3ZpytNjSjpyNpci92c71eDJUeoLG34UmzQP/m1xLq26BJOwKsjiQ66z19HzuUNBJpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791136939; c=relaxed/relaxed;
	bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSfLxEIgFojh+IWhLwGGzLDlt2dQojTNO82pL6/qUI9cd6DEm/rCVSywzu3ulP6TBJQAL75+jLbOYbNr737YROCIhk2fgy5REdtOZjLdq9RYGCxO2ovB3XexweSIEdCGAPoZI0Xo9YzMe8550n5VXi7pnJw8Jh46QqdEOmHPjKdN80cIwugtEEGK5yRTIhFbb0dvR2f6zjntIndbwagAAsFJ5tJyqjlY069AKiMIYFO8qfq5lpM46uQMnSmmEvs1XxcjmaF+WeHVluyBZqiE8l3H47FDShIeoLWRSbQQscvoX9LgU60PoXX+Ea336JIrKMnGMzEw0TXDRscHaP1v0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fUghnaaG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fUghnaaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyVj56x30z2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 05:02:17 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-5337c7b9937so262871cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 11:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136935; cv=none;
        d=google.com; s=arc-20260327;
        b=Zi2GAfLiciMf18zVYNXWchKi4eXAAoH+yIH3+SAJs8/CjN57KhKNWb1tkny89ed7+s
         xBplyWFlqVpyg+uqFHDb00DmIfQmjwFiHWdIFuLh42b0zNL2KatyThGAyQnbm9+uFT2r
         FefBDHf/Xu3fcqfeLZK2n+QwRxQ04yIX7ZPVdIIV3GAK1EV9PuLY/r9whchDDiwa/TER
         y6P9OjwYSi+ERfTExh7t5D2AMFBj4sCDDuISLIv0hhaxVVKYKG+5ukgU0OyIg11PuGrj
         vbZ5/px9hT1HCoNY9iiDiCC3zgWgJ8uUurRCl5hQhvaxnMrZCDCswdYvG7aiqVIkEv9g
         wmhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        fh=oaBj/mv/DFql4k+20I4KJQJokXt7pkqFdCtAr/J0Nt8=;
        b=G2ktDkmgpjgoAmsCTf8WZVBfVaEvJwe23ThTWXpLGYUXo4XvDfMA+eDQPQ5jrHddNj
         Ki81WUzJ2szgpzE5tjHMowZCQVHtQsyZwEkM/YjQxvSEq9UaB4C0rMb4rVzmZDh5nlZ5
         JZoQTB9YdAodOWcqwtlC7crR+UtXmSxiMH2mbxaIP7WIZymiI0QGCTlOZFmBnI9mO1ik
         ZlrMDW2mkC/JwZ7KgeV8N6q/HeHvrvTgGQTZCZrPYGVs3Su0MQiyvgUimIMb/XfWgafD
         jmJVe3GZ6YqG0JHdOyYhq3Arr8daI87pIYJpOmG8k9ddmclDkxQTkR0ELHbFYrK+FXO3
         vk2w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136935; x=1791741735; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=fUghnaaGmMBBI4ey3gheIVhzBs+6Lb0RfwIUl1ffl3Xvq4ze2eN3gFN0rmNrDWdJl4
         SdlsrduPY6qRDZWQIgxp1XSIIEVxg3eyZCUXTMzNsZMhuuD23wKjyU81zC2l+0VZEReR
         RBocVh7mpLaYfTQ7cZuVodxCv13bnTglqqTgCi75vaMkwQa1nWX8Ah+zOOEzUhi0nn/b
         LTIykJRJLcIdAI0xWyVYM+kQyxEBKDAPYJcAa5RtKIjKWj5jBZUWLr7NMNEAv6mEZPHr
         313Xxb8WyfSEtb+rSJYpXgY3rp2/MHm0ei90i9rldJ/OcmJkPEvGO3miztgAdqUzggIv
         yC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136935; x=1791741735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=a4VK0dyG/VCEuS46+PSaXSgPSQyJlXJreoHytIk4lpwMu5/FyG6gpWZvmjAwpFPvK3
         pF4iMXXZH9Qc66pcwXKx/yhN6ZvMjfUKioI/5j+pSi2X4Tok6QbdM++VE/zNYCn5C3qy
         YyG6mUlFyAUXMMtc2sITrdE3HSQQsxzk1+wwmhpIBtjza+F5HI+LylgXseJgd4rAC+5p
         SewpwFpnl8QbLlbzOp+BRCZvtdkIO8lXFfrc4VJe4//o2f6SCvKGGaRmOTY5d7eru8oF
         rOAUyIV/f2BsFIPLU9jsMyOuIkqF6eRlVMcVCG1eCbcee+LunWqi7CNm6eC/+zwjpk7G
         RD9w==
X-Forwarded-Encrypted: i=1; AKwUvBx4lrDxDJmhSn09r7bhetblkgx6/3zWXPtfdF47ugAVaBpILRkfWdatRmwPxowRAQnOOUTSbiP36izBVCI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lU6IqT/DRNIYNUJmQLcEqrPNSx01GX87HljBFzXyZx3SFZtU5A
	AiQUsE299VCVPyJdrbg875UUx+1DLpAYfbZiql42PUPAJsQcKNNK4dtqTFbC63XbK92A37y9vOe
	G+0Pg3ke//wDB4N4r94TGwD14XqvrpqjBWix/D1Iy
X-Gm-Gg: AYBFou2ntOw9fTLExmLbGp+xN9IYSmzdBO0267hQZgk5yZ961VPdh3Er6Cwd4iOQcqe
	UoEwpKNUSyYRvl/x//24i4swsSsfAwnQ0s9n2iPORITyY+UuekBUeMitXU7jCQ2eKqwjb2Jwob2
	W1yWa8iGiEiWKPexQZNN2SfP8GMG3iYifUgBIMPOfqtIolaU0ns7FPTi2QJu5hDj3FEjlVOVW52
	g6lwrMHzY6N7HMzRbG78c0eqoCS4OZl1Tr0Clql0CdqVV8nq38eclnVuN50eLsV3lROBtYgpoId
	u3PBwt59hCqnXPcWB+6kg/YuPWXvsZUlJ1eY3KnDlmJ4+pf2GinHBGYz
X-Received: by 2002:a05:622a:1b20:b0:530:e335:4ef with SMTP id
 d75a77b69052e-535113c3cb6mr18023261cf.2.1791136934142; Sun, 04 Oct 2026
 11:02:14 -0700 (PDT)
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
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:02:02 -0700
X-Gm-Features: AclHuK_nOqMX3djeZOdNLjNPymjaWdesvnL51eoG4SJjNhtYox1cB5x1yziRAMs
Message-ID: <CAJuCfpHiaV6uDCfOMmHJ4tPosUBPRMUF9zjrB0fkCWZG1umG5w@mail.gmail.com>
Subject: Re: [PATCH v4 18/38] fbdev: defio: assert FBINFO_VIRTFB, drop VM_IO,
 add VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Sat, Oct 3, 2026 at 6:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Currently all drivers which use defio allocate system memory. All of them
> also set FBINFO_VIRTFB, other than ssd1307fb, however this driver allocat=
es
> system RAM, so simply failed to set this flag when it ought to.
>
> This patch sets FBINFO_VIRTFB on ssd1307fb probe, then drops setting VM_I=
O
> in fb_deferred_io_mmap() and instead requires FBINFO_VIRTFB to be set,
> erroring out with a kernel warning if not.
>
> The logic requires a page from the driver and since commit 1ecbc7dd2902
> ("fbdev/deferred-io: Always call get_page() for framebuffer pages") has
> always required it to be refcounted, so this was implicitly already the
> case.
>
> Finally this patch sets VM_MIXEDMAP, as the logic is mapping
> kernel-allocated memory so this is appropriate.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

With the same disclaimer as in previous patch,

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/video/fbdev/core/fb_defio.c | 6 +++---
>  drivers/video/fbdev/ssd1307fb.c     | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index fd00b86e1ae6..fb359ecc3966 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -366,13 +366,13 @@ int fb_deferred_io_mmap(struct fb_info *info, struc=
t vm_area_struct *vma)
>  {
>         vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
>
> +       if (WARN_ON_ONCE(!(info->flags & FBINFO_VIRTFB)))
> +               return -EINVAL;
>         if (!try_module_get(THIS_MODULE))
>                 return -EINVAL;
>
>         vma->vm_ops =3D &fb_deferred_io_vm_ops;
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> -       if (!(info->flags & FBINFO_VIRTFB))
> -               vm_flags_set(vma, VM_IO);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP);
>         vma->vm_private_data =3D info->fbdefio_state;
>
>         fb_deferred_io_state_get(info->fbdefio_state); /* released in vma=
->vm_ops->close() */
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index c4fdecafd856..958514a35433 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -763,6 +763,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         info->fix.smem_start =3D __pa(vmem);
>         info->fix.smem_len =3D vmem_size;
>
> +       info->flags =3D FBINFO_VIRTFB;
> +
>         fb_deferred_io_init(info);
>
>         i2c_set_clientdata(client, info);
>
> --
> 2.55.0
>

