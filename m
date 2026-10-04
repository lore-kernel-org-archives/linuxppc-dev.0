Return-Path: <linuxppc-dev+bounces-28889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE2FCA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:54:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyVXL5Zmlz30RN;
	Mon, 05 Oct 2026 04:54:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791136482;
	cv=pass; b=Tn3isYjfUP0uhB75UyGC63OXZmfIFwIYDSdVQZg9KEz+iXgq+fZPGo3W7MZ+ljx+WzwlRaHaogHnFcRm9RhKqDJjQFYSuFzoNfgGcdnzeVuasvD24A1enAV/9StG7sVlj/FmDqlkYCVPekzf1zn77xiK3Z7UkJpxYBcjtazH2J7vnj64lo7kfruBleGKGB3e2tEoulKFOCbDE8FhswtRWhbc6+I2Yr1kQVdy39B3EnfkBbjKDCK4CMbp/g11+8xz3deyRUEckYhqWOa0dno2/H+wVL63jQsFSCFG2dm2cp2EzXVXcV+JuYH0AL1GBdT8Z2MoZTcCBtSCBzIghDK0Eg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791136482; c=relaxed/relaxed;
	bh=Fdcss6XzKw26cI5TyCzpDNu6o5ifWClMegsH9OJNnig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrPGGXxYUUxhj/1QiXmrYFhO6cuOpAgc7RmhmOTv8uj3oaznfRtpPWMN7qshIN72/JzWiBND6o3Y2uAu67boPGXCTHQ/+7Kynbbq03s44FUjxYp5g9KvbvXLDBGUkbSGNfWT8UEOFnfEPPVDA/TwVyDTHLv+gisF6w4h8NuVw4ST3rjdqdow81RJVIWNujZbQ88tvBBDdBI2P589te4KJJ6hyxAlV1oFhit5oye4QeeuByLyW2pZ3dPAKk7/G0DImp0tYobV930M6cDvzj5w5zKp+HOAZ+prjgNOSTAdJ6F/jW0N3rzIjPdpNVYbMnlwtQE1Jmc+d+foRjeqr8rn1A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z9XWBp42; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Z9XWBp42;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyVXK5w8Zz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:54:41 +1100 (AEDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-5351f9dbfe0so97671cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136479; cv=none;
        d=google.com; s=arc-20260327;
        b=UZ81GIbhmFulNnaCqZ4KkLiO5x18029ZDS/QYP5SSz+Xi9KDA2xiTa2YCMV+tNIzxC
         CiAXjTVT+sra3vjttzsgDwZGxmiMzT5JSky3VpqeppoCNVj6I/AaZsshDOXquveOY04e
         KBZ3QnAcssLhV4D71Ia79gbdWMPVu/ZPRiM4dWGQKkpEKc0RTC6kJSW5q59mm++bBU9d
         TNKQfeX0yaVDM4oZHO1oO7Q2lY0ZAYErhnYlaZJNavcVACN1hhKy5jIKKPfXUmON1n6u
         uS0bRmpHfPzWoZ+X2V6KO2dANDcU3tic5EGI/NdwaNjlzJ7ctRAgWqQLbvBwVx9OPXap
         fTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fdcss6XzKw26cI5TyCzpDNu6o5ifWClMegsH9OJNnig=;
        fh=kp8KaaNJSiDxvLtTOK15Pg12WYn6sw3j+JU07Qkv+CI=;
        b=oId9mrbusmo+XuV+ezHAs2jjoACpLBRS3j4KoYvIwlCSQuzxc8fibOiV4lc/V/looc
         fLClAxrb+E/aw6xxbRJZLUDr6fVm7MyrtBaA4Ro2clP7Fg0jErHE1DrfiJTeunhlrQWD
         KYXWmMrDmnxc/l6VbAG8WeggDgf+11qtDrbcCub0vlbhYaEAR5oxr5hPdRBR50VOSvgo
         4pBp7XpVPiJfswsAl+taFGN1AGVw2+Pzww8TF18AQR+zJpL/e8ag9aXvIrLN3UCm9XTa
         P6TYWxGv+S4+S0+7OvDunGZlowyx3ybKrZbK7RXW2uvFvd0b4mGzI0XLdZtWQIm+lD7O
         MUEQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136479; x=1791741279; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fdcss6XzKw26cI5TyCzpDNu6o5ifWClMegsH9OJNnig=;
        b=Z9XWBp42dx1H1Q23O8O/XQHxmfI+n9T1CBHLETaDKcR3VfAEGBHcJ6IEhbRIc4LNfj
         0JwpqMlWJSqO0MyMDTebDhVgB/Vt722+xOB9F0qdR6o3DOfTsirwo+BTAt07mve4ocxp
         yxRwa991byWxMRkKx6J2h5g5PKIufL+sTgtIWArT3HCLZ0/5ugfO3knqVG5UX6mts4XJ
         L3n/t6mLRF2THIt9WTvKcNrclZgHnYoOowjk2cqkodOTocWwzOjEX16nlLoyGUDKSv8o
         wEoxQO2OK4gMKGkHH7lB/LsFY4H4o1GDjfh2h5lt5E2Ui/VKINzalY9FZdEHzcLftMts
         U3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136479; x=1791741279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fdcss6XzKw26cI5TyCzpDNu6o5ifWClMegsH9OJNnig=;
        b=qz0ReGrq7PPP+pifa7uHfnSWZnHbPXgZK+GE3jj7ETvl33cevq6/tAdUBGpLUHYp8V
         RDnvsamBsCxaI1LphR8cXA1Vd14VYj+IVcnnPs7xhZXrz0L2fMNha/k55XjQxvb7oMmS
         7FGMwRFAV1FwfqwkUh4M0iNhb9409M173a1j7gSSGsW4oUsbLgV0+1krQ07vuQYZtpy5
         SKANeAZyuOd9bJE6WFLnG8reR3BQU97SIgAiyVTtg+rnliLJ5GWRjOT+0dghBiSBBPGv
         U4OxD+jQc3gEcrAxr61tMK6m3cLcUn/ScZBV3zC8R2opIPiUTxdZGJ1fpnV+hMPqjrEr
         ZMuQ==
X-Forwarded-Encrypted: i=1; AKwUvBx54V0R7yUpnuw1GLam1AfFAnmO7xsIZAww5cW5ag90vNFpQIaOIV67eQKXw2D8ECwyeAqKbmEQyJmztwI=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lY97rhxS1PdU9teyy/qWh4nmKFaawbcL/+1WsadvF0C1tP2a7O
	qrIeyG7smQDhUIhxr8PKsNYUtGXmGcCwPnZ5lN9scAxNz18Q+jCMEJzoJEUv92HvjIef6v2MQP9
	9rj0l7Dwupa3X2QXDOrrcUsI6XCu+VCQK1nUwHL3L
X-Gm-Gg: AYBFou1BCa7GailxcKZayVRrVc3AFQfZwXwksQntJlhG4AD/8BKpu2oYz9n8P7URM5N
	DCc+K7gI2J4aNzdUxwQ9KE8e+LKa37DipIsko/Lte0GoxdMKM1hymvLRI/AAF12h5D9vX+2Hoi8
	C7pYlAxcu0XymoBEt2ZIT++/ytzbndrQGrPTgb10oZHuqZEF+k2GahtJkZ/efVqjp65C5zjiJNW
	UGoS6/iUJooWgQxxLINwgw8/aSFR5Pg1JoYbchrTCRYF7UBQJcQB08a03dcxsXg6DZsfmZUL6sS
	LAfNwbtEFAHDkL3KNmAWf/SrcmIFfFj/2+jpvlDVY/om/9oAsMVDXQpl
X-Received: by 2002:ac8:7e89:0:b0:534:b7b2:634f with SMTP id
 d75a77b69052e-53514799503mr16690141cf.8.1791136478525; Sun, 04 Oct 2026
 10:54:38 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-17-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-17-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:54:27 -0700
X-Gm-Features: AclHuK-Rg0T0ymL6HRAgNQPZX5D4YqOng-e9RJRoGVP6zixq0eakV-RXfXJpvBY
Message-ID: <CAJuCfpHM9-VY97TD8yXCEcWirLHik7UPf2_gv5CzqEexD2hbHg@mail.gmail.com>
Subject: Re: [PATCH v4 17/38] scsi: sg: convert mmap hook to mmap_prepare and rework
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
> Move from the deprecated mmap hook to the new mmap_prepare hook.
>
> We are mapping kernel pages here, so use the discontiguous kernel mapping
> mmap action to do so.
>
> Unwind the rather confusing loop and instead map as many pages as we can =
at
> one time.
>
> Note that we do not need to pay attention to rsv_schp->k_use_sg here, as
> the pages are populated for the length of the buffer at
> rsv_schp->page_order granularity as compound pages.
>
> The discontiguous kernel page mapping logic handles the compound pages fo=
r
> us.
>
> sfp->mmap_called keeps the buffer stable for us. As before it is never
> cleared, so a failed mmap also leaves it set.
>
> We also remove some useless vma, vma->vm_file NULL checks - these will
> always be non-NULL if you reached the mmap hook logic.
>
> We retain log output for consistency, but change what's output on page
> mapping to indicate that sg_discontig_get() does the work now.
>
> Note that we drop the VMA_IO_BIT flag for the VMA here. It was never
> necessary as we invoke alloc_pages() which gives us refcounted folios tha=
t
> are fine for GUP to access (VMA_IO_BIT would prevent that).
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

The code looks correct but I must disclaim that I have no experience
with this driver.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/scsi/sg.c | 115 ++++++++++++++++++++++++------------------------=
------
>  1 file changed, 51 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 5408f002e6c0..3f9e08725602 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1212,85 +1212,72 @@ sg_fasync(int fd, struct file *filp, int mode)
>         return fasync_helper(fd, filp, mode, &sfp->async_qp);
>  }
>
> -static vm_fault_t
> -sg_vma_fault(struct vm_fault *vmf)
> +static int sg_discontig_init(void *vm_private_data, void **private)
>  {
> -       struct vm_area_struct *vma =3D vmf->vma;
> -       Sg_fd *sfp;
> -       unsigned long offset, len, sa;
> -       Sg_scatter_hold *rsv_schp;
> -       int k, length;
> -
> -       if ((NULL =3D=3D vma) || (!(sfp =3D (Sg_fd *) vma->vm_private_dat=
a)))
> -               return VM_FAULT_SIGBUS;
> -       rsv_schp =3D &sfp->reserve;
> -       offset =3D vmf->pgoff << PAGE_SHIFT;
> -       if (offset >=3D rsv_schp->bufflen)
> -               return VM_FAULT_SIGBUS;
> -       SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
> -                                     "sg_vma_fault: offset=3D%lu, scatg=
=3D%d\n",
> -                                     offset, rsv_schp->k_use_sg));
> -       sa =3D vma->vm_start;
> -       length =3D 1 << (PAGE_SHIFT + rsv_schp->page_order);
> -       for (k =3D 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
> -               len =3D vma->vm_end - sa;
> -               len =3D (len < length) ? len : length;
> -               if (offset < len) {
> -                       struct page *page =3D rsv_schp->pages[k] + (offse=
t >> PAGE_SHIFT);
> -                       get_page(page); /* increment page count */
> -                       vmf->page =3D page;
> -                       return 0; /* success */
> -               }
> -               sa +=3D len;
> -               offset -=3D len;
> +       const unsigned long req_sz =3D (unsigned long)*private;
> +       Sg_fd *sfp =3D vm_private_data;
> +       Sg_scatter_hold *rsv_schp =3D &sfp->reserve;
> +       int err =3D 0;
> +
> +       mutex_lock(&sfp->f_mutex);
> +       if (req_sz > rsv_schp->bufflen) {
> +               err =3D -ENOMEM;  /* cannot map more than reserved buffer=
 */
> +               goto out;
> +       }
> +       sfp->mmap_called =3D 1; /* Prevents changes to buffer size. */
> +out:
> +       mutex_unlock(&sfp->f_mutex);
> +       return err;
> +}
> +
> +static int
> +sg_discontig_get(struct discontig_kernel_page_state *state)
> +{
> +       Sg_fd *sfp =3D state->vm_private_data;
> +       Sg_scatter_hold *rsv_schp =3D &sfp->reserve;
> +       const unsigned int order =3D rsv_schp->page_order;
> +       const pgoff_t nr_pages =3D state->nr_pages_mapped;
> +
> +       if (nr_pages >=3D (rsv_schp->bufflen >> PAGE_SHIFT)) {
> +               discontig_kernel_map_abort(state);
> +               return 0;
>         }
>
> -       return VM_FAULT_SIGBUS;
> +       SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
> +                                     "%s: offset=3D%lu, scatg=3D%d\n", _=
_func__,
> +                                     nr_pages << PAGE_SHIFT, rsv_schp->k=
_use_sg));
> +
> +       discontig_kernel_map_page(state, rsv_schp->pages[nr_pages >> orde=
r]);
> +       return 0;
>  }
>
> -static const struct vm_operations_struct sg_mmap_vm_ops =3D {
> -       .fault =3D sg_vma_fault,
> +static const struct discontig_kernel_page_ops sg_discontig_ops =3D {
> +       .init =3D sg_discontig_init,
> +       .get =3D sg_discontig_get,
>  };
>
>  static int
> -sg_mmap(struct file *filp, struct vm_area_struct *vma)
> +sg_mmap_prepare(struct vm_area_desc *desc)
>  {
> -       Sg_fd *sfp;
> -       unsigned long req_sz, len, sa;
> -       Sg_scatter_hold *rsv_schp;
> -       int k, length;
> -       int ret =3D 0;
> +       Sg_fd *sfp =3D desc->file->private_data;
> +       const unsigned long req_sz =3D vma_desc_size(desc);
>
> -       if ((!filp) || (!vma) || (!(sfp =3D (Sg_fd *) filp->private_data)=
))
> +       if (!sfp)
>                 return -ENXIO;
> -       req_sz =3D vma->vm_end - vma->vm_start;
> +
>         SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
>                                       "sg_mmap starting, vm_start=3D%p, l=
en=3D%d\n",
> -                                     (void *) vma->vm_start, (int) req_s=
z));
> -       if (vma->vm_pgoff)
> +                                     (void *) desc->start, (int) req_sz)=
);
> +
> +       if (desc->pgoff)
>                 return -EINVAL; /* want no offset */
> -       rsv_schp =3D &sfp->reserve;
> -       mutex_lock(&sfp->f_mutex);
> -       if (req_sz > rsv_schp->bufflen) {
> -               ret =3D -ENOMEM;  /* cannot map more than reserved buffer=
 */
> -               goto out;
> -       }
>
> -       sa =3D vma->vm_start;
> -       length =3D 1 << (PAGE_SHIFT + rsv_schp->page_order);
> -       for (k =3D 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
> -               len =3D vma->vm_end - sa;
> -               len =3D (len < length) ? len : length;
> -               sa +=3D len;
> -       }
> +       vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
> +       desc->private_data =3D sfp;
>
> -       sfp->mmap_called =3D 1;
> -       vm_flags_set(vma, VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
> -       vma->vm_private_data =3D sfp;
> -       vma->vm_ops =3D &sg_mmap_vm_ops;
> -out:
> -       mutex_unlock(&sfp->f_mutex);
> -       return ret;
> +       mmap_action_map_discontig_kernel_pages(desc, (void *)req_sz,
> +                                              &sg_discontig_ops);
> +       return 0;
>  }
>
>  static void
> @@ -1415,7 +1402,7 @@ static const struct file_operations sg_fops =3D {
>         .unlocked_ioctl =3D sg_ioctl,
>         .compat_ioctl =3D compat_ptr_ioctl,
>         .open =3D sg_open,
> -       .mmap =3D sg_mmap,
> +       .mmap_prepare =3D sg_mmap_prepare,
>         .release =3D sg_release,
>         .fasync =3D sg_fasync,
>  };
>
> --
> 2.55.0
>

