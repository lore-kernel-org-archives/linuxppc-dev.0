Return-Path: <linuxppc-dev+bounces-28883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39759CA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:18:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyTkc4X9sz30RN;
	Mon, 05 Oct 2026 04:18:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791134312;
	cv=pass; b=EQnzbUmmaHXuG9kzZewuWu5iAsPLjnfkN4y2PKKQHd2iuxrWsENXxyiblPvBX3aoFSyWiJII/5unlmSya5+MRRAM//K3i8gqQpGpyNVBsLXz98ZGclIa+Mt9vZBTxRL/KfcsLlUoJUC6uWmuzXQJlW+gyMqG7Z/gMPHgY+h3SNCvr9DY8avA3bUS1hpmcvrV8GTOSLjgf/SAsa6PWgJB/eigxneRTmF8Xr/OcQGCTr2MWbxt0ddgWLzA0lpgr1jjBqtsiPwRQ5jSqd1XCYpYNlz6zwGs3n3HfeXdD3HfJVQii1Bvol85M3cwgpMxzpTslM4u5qwBP5CEad1kiResQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791134312; c=relaxed/relaxed;
	bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4QYz3eWgJQhhcEd/9jvUAr56TUGxn9IKjiUYStugox313SBjqrqFtHybSPIL9YqJixRxCMs6BNG/kFYiyOx+iz0y72pMMPjEOfpQLm7S1bvgEzrxlBmCwLqsHX7Dos2k4uSuoXDunAMc20102H8c6+hWpu6j0D7wAoNL05jELwg6gmiZeN/i66Z5QLf1lLTFRohq5ciaRXRoOU7oawZTRF88ACKJSTPk4D6m8U71wW2wC1B9d8DYAwcwXhwoobx1NNBUFomh2WQd2nVvowra9IYuvtXBsJELRD8wd+BrSS1EQSSnVGIgqPvYoy8mrCZIzRSEsYDFKAN1gIl+MVBZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ucnh9VfA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ucnh9VfA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyTkb2lsbz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:18:30 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-5351f9dbfe0so93841cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134308; cv=none;
        d=google.com; s=arc-20260327;
        b=I5YQ9p3pMJEydYVrZ9+OXXlLBtA0Rt+V/PbHVy12xqjh422TDvCa0WCFecT9hQjRVJ
         2yPf6moe3zHAQ9CbD7PE2r2QQVe/XFeoiWYHAEOozfiqdR/lbWFXdgGotK+tQqnz2OdK
         tuSf3QpH93LMi9y7X0dmSyXAspvTdbUaxnAwu6I8pGLET2z/LWozXB+HWmXmq0dvKv76
         kuDu0ahKBpz8OcihP9ZFv83vQnQcj4HZHTKhZ6K59JEh9F22ey44w0we0tj1+9kZhSdS
         XZCsmgE7A8hHgFWblDFnWA5t7NYzaB6W/kZ+9tWN2my/Ccom83kiD/xWNwLAtKSKoOR3
         vvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        fh=ZDYu5g3gJLMD08w6t8+xhas1HKL4/mBTGJdW1iiP1Zg=;
        b=hjEqBWx6FwFJsXzfOXbgWMQJuw5t6/r4ui+eB1VGp7hKPYbcL1y+fuKtFuowP+/XWL
         aC03qgv97YidJvkFvfthmJ+xlzGZilBpMilASomfI8RHO5rGqW272bBzRiJ5c1SUwqNV
         64lFzqsaYjX1le5pgW2k9EDpm8Tjy3ikpKbNGqhPpA5D5v45KbsOcrUSMB9fnAevifSU
         H2jb2Cwf2vgV4YbWDuC736W5uobg6EcTMGK6H4H7IqEF6Z+PpqmGxPHFWtnLQfFsbCgy
         Th3U6k0PXrWgMmZ42ngSeDDn8wnKJZn3timKHtkGZ5S0CwlOA2V/TXq7p77cUGhSoY7o
         AKXg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134307; x=1791739107; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=ucnh9VfABcZnEgUQb8mb+L636WnQBFl1MbRncHlJxB5Ug4ChC/m/6Q7DHfM5F0dqc4
         usoHuL5xMnb+0zphw+fUgW257q4lur/FsDaz2Dd9oIw5mHFxvoxfR3kMw86zh/LBI9az
         HLEkrHUrS0l4G82s5PeUtUMj8lUnu886N3CJhMnza0BeUoS6y1iTpM3v8Z6TGyp8aE6J
         0/8hvWgHe3jHU+oxtyoVUFaOGI5FBMLUz1xbAPZTtQoz8kXOGrPWgRAKdDyHzlJ7fNDc
         RgySirFNwlmggvbXAokV5ePGi6zdM173BoymtUXJP9Ysjwz/00l7R6dI8Nd6spM7nsgq
         ylcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134307; x=1791739107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QinBTGgc4+2Xq3VgxIpbr+CWC5UMzdARKszuxAv87KA=;
        b=yWUVn9LIuiD2jAIAVUCiHrpf19a+wKoCbMYEXLCUEzpfxsX97Z20PLByDMU03A64vv
         OtsT4erqLyYIEReVsow16HI9Fc5j/XXrnyHyqPwSVTC62MIwtwsezz2hlkOv5/b68NcQ
         QHi2KVkxqC5F0qhRZ2ck+jgdHpASxJjLr+e1c84T2Y50D/F65ONZjuKVUkuOWDkq8Iah
         s/ZFiSPEUoZul4S/uLCVwum8KwFDgEMbnbiqhMjsS1lLvDlQnBTFnJhU0D3AE+TUDCQz
         3VznNSKwlB66u0OhQl+a9XOEdJagkdSabC+KEteHb6ljVmqerIr4G2NGZ+3+20HqT2YJ
         t/fg==
X-Forwarded-Encrypted: i=1; AKwUvBzArrOp2xx8uums5cXGKeLmhGrwxVTbWPv4BHzyxsaBeFQHnsNMAhbEl17V3D2OwvSt9MWaSavyObYsP2w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++liMfIcnHKWy0cHOM+iu8e/w8WyIf/V2MfUUT75CLbMQ4rey1z6
	TH5VAF2uKPnFAlsVVWV3R0+xd/v2SamZ11VTpIXga/KhEfztnuahWUqxTIqvbn3F+zzHk25OifO
	87YDPJNVli5qrFV/SOWGLIDjbV5eqOByOlVkODTT0
X-Gm-Gg: AYBFou2IoB7H+7Jy2bmkC62NvxsCzCGIQBMrWlFvgW6zbfh3h/+93R+hTskfr0KeauC
	p3GQ1oKe07vh0YiDiWpuDJayp+WTesasIMPWJqPTAIzLNTDNLdsTSzEzAXWvRgWoJgaMiNqyrcb
	bWC1MicpyDylIvfuVhfxaJgFDvJluWAY13Dl+WQKJLAPHFJRB0FKjdjgEL8nE0F98o5IUH/S8IH
	2wAgAKe1AL9n2o0el9JwhahDjl3vsMYlLZ4FHZq64HbrXr37rmT58Vi1cE7PwMFozoX51eWO5Vw
	X4E90W13tGXD3owOJzWu7JDyjWQdEmhTy9RZlccS83lHRalHzGGbq1E/
X-Received: by 2002:a05:622a:1b91:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-535146ce3e1mr16649101cf.4.1791134306600; Sun, 04 Oct 2026
 10:18:26 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-9-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:18:15 -0700
X-Gm-Features: AclHuK_AcqqolMBhSGAldWSHQHOOTkitmvHnvL2po1Vgiun02DenXRmiOZ3VQUs
Message-ID: <CAJuCfpFkfK4gvBPVoSiSdKs_3LR-0-dw_08BVxs-NqCvQK0-Mg@mail.gmail.com>
Subject: Re: [PATCH v4 09/38] drivers/usb/mon: update to use mmap_prepare +
 map kernel pages
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

On Sat, Oct 3, 2026 at 6:36=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace the deprecated .mmap hook with its replacement .mmap_prepare. As
> part of this change, additionally take the approach of mapping pages upon
> mmap rather than providing a fault handler.
>
> The page span cannot be mutated when an mmap mapping is in place, so this
> is safe to do in advance (the MON_IOCT_RING_SIZE ioctl operation exits
> -EBUSY if it's attempted, gated by the rp->mmap_active reference count).
>
> Utilise the newly introduced mmap_action_map_discontig_kernel_pages() to =
do
> this, which allows for iteration over pages in mon_bin_discontig_get().
>
> mon_bin_discontig_init() increments the rp->mmap_active reference count t=
o
> stabilise page spans. Should an error arise the core unmaps the VMA and
> mon_bin_vma_close() drops the reference again.
>
> The vm_ops->close hook implemented in mon_bin_vma_close() will ensure
> correct reference count arithmetic upon unmap (with mon_bin_vma_open()
> accounting for splitting).
>
> The existing semantics are all retained, including not mapping past the
> range of available pages, with a SIGBUS being raised in a userland proces=
s
> that attempts to access past this point.
>
> Ultimately insert_page() is invoked to insert each page, which increments
> the reference count on each mapped page. This mimics what was being done
> previously, only we pre-map the entire range rather than doing so on
> demand.
>
> The existing fault handler did nothing that required demand paging, and w=
as
> presumably implemented this way for historical reasons.
>
> One behavioural difference: pages are no longer faulted in on demand, so =
a
> page discarded with MADV_DONTNEED is not repopulated and a subsequent
> access raises SIGBUS, as with other pre-populated kernel mappings.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/usb/mon/mon_bin.c | 82 ++++++++++++++++++++++++++++++-----------=
------
>  1 file changed, 53 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index 687f6a8981f3..9d00b21a8153 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -1219,6 +1219,15 @@ mon_bin_poll(struct file *file, struct poll_table_=
struct *wait)
>         return mask;
>  }
>
> +static void __mon_bin_vma_open(struct mon_reader_bin *rp)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&rp->b_lock, flags);
> +       rp->mmap_active++;
> +       spin_unlock_irqrestore(&rp->b_lock, flags);
> +}
> +
>  /*
>   * open and close: just keep track of how many times the device is
>   * mapped, to use the proper memory allocation function.
> @@ -1226,64 +1235,79 @@ mon_bin_poll(struct file *file, struct poll_table=
_struct *wait)
>  static void mon_bin_vma_open(struct vm_area_struct *vma)
>  {
>         struct mon_reader_bin *rp =3D vma->vm_private_data;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&rp->b_lock, flags);
> -       rp->mmap_active++;
> -       spin_unlock_irqrestore(&rp->b_lock, flags);
> +       __mon_bin_vma_open(rp);
>  }
>
> -static void mon_bin_vma_close(struct vm_area_struct *vma)
> +static void __mon_bin_vma_close(struct mon_reader_bin *rp)
>  {
>         unsigned long flags;
>
> -       struct mon_reader_bin *rp =3D vma->vm_private_data;
>         spin_lock_irqsave(&rp->b_lock, flags);
>         rp->mmap_active--;
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>  }
>
> -/*
> - * Map ring pages to user space.
> - */
> -static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
> +static void mon_bin_vma_close(struct vm_area_struct *vma)
>  {
> -       struct mon_reader_bin *rp =3D vmf->vma->vm_private_data;
> +       struct mon_reader_bin *rp =3D vma->vm_private_data;
> +
> +       __mon_bin_vma_close(rp);
> +}
> +
> +static const struct vm_operations_struct mon_bin_vm_ops =3D {
> +       .open =3D     mon_bin_vma_open,
> +       .close =3D    mon_bin_vma_close,
> +};
> +
> +static int mon_bin_discontig_init(void *vm_private_data, void **private)
> +{
> +       struct mon_reader_bin *rp =3D vm_private_data;
> +
> +       /* Dropped by mon_bin_vma_close() on unmap, including on error. *=
/
> +       __mon_bin_vma_open(rp);
> +       return 0;
> +}
> +
> +static int mon_bin_discontig_get(struct discontig_kernel_page_state *sta=
te)
> +{
> +       struct mon_reader_bin *rp =3D state->vm_private_data;
>         unsigned long offset, chunk_idx;
> -       struct page *pageptr;
>         unsigned long flags;
>
>         spin_lock_irqsave(&rp->b_lock, flags);
> -       offset =3D vmf->pgoff << PAGE_SHIFT;
> +
> +       offset =3D state->pgoff << PAGE_SHIFT;
>         if (offset >=3D rp->b_size) {
>                 spin_unlock_irqrestore(&rp->b_lock, flags);
> -               return VM_FAULT_SIGBUS;
> +               discontig_kernel_map_abort(state);
> +               return 0;
>         }
>         chunk_idx =3D offset / CHUNK_SIZE;
> -       pageptr =3D rp->b_vec[chunk_idx].pg;
> -       get_page(pageptr);
> -       vmf->page =3D pageptr;
> +       discontig_kernel_map_page(state, rp->b_vec[chunk_idx].pg);
> +
>         spin_unlock_irqrestore(&rp->b_lock, flags);
>         return 0;
>  }
>
> -static const struct vm_operations_struct mon_bin_vm_ops =3D {
> -       .open =3D     mon_bin_vma_open,
> -       .close =3D    mon_bin_vma_close,
> -       .fault =3D    mon_bin_vma_fault,
> +static const struct discontig_kernel_page_ops mon_discontig_ops =3D {
> +       .init =3D mon_bin_discontig_init,
> +       .get =3D mon_bin_discontig_get,
>  };
>
> -static int mon_bin_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int mon_bin_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       /* don't do anything here: "fault" will set up page table entries=
 */
> -       vma->vm_ops =3D &mon_bin_vm_ops;
> +       const struct file *filp =3D desc->file;
>
> -       if (vma->vm_flags & VM_WRITE)
> +       if (vma_desc_test(desc, VMA_WRITE_BIT))
>                 return -EPERM;
>
> -       vm_flags_mod(vma, VM_DONTEXPAND | VM_DONTDUMP, VM_MAYWRITE);
> -       vma->vm_private_data =3D filp->private_data;
> -       mon_bin_vma_open(vma);
> +       desc->vm_ops =3D &mon_bin_vm_ops;
> +       vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
> +       vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
> +       desc->private_data =3D filp->private_data;
> +
> +       mmap_action_map_discontig_kernel_pages(desc, NULL, &mon_discontig=
_ops);
>         return 0;
>  }
>
> @@ -1298,7 +1322,7 @@ static const struct file_operations mon_fops_binary=
 =3D {
>         .compat_ioctl =3D mon_bin_compat_ioctl,
>  #endif
>         .release =3D      mon_bin_release,
> -       .mmap =3D         mon_bin_mmap,
> +       .mmap_prepare =3D mon_bin_mmap_prepare,
>  };
>
>  static int mon_bin_wait_event(struct file *file, struct mon_reader_bin *=
rp)
>
> --
> 2.55.0
>

