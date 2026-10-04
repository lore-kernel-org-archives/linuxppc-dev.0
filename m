Return-Path: <linuxppc-dev+bounces-28884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B212CA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyTld4ZYRz30RN;
	Mon, 05 Oct 2026 04:19:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::830" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791134365;
	cv=pass; b=Zyzdn+0k3PVEQQDEYba0wVqgIXgTRbTkDbuvBrC/1JIKD51CoJZAYLjnsZq+eeTlYoCayHry5J5KO7cmGq75mQf1tH3gSCFQ5miZqJnjElvjMRpLa8YznfJCW2D0zYyPC0PqZ2/vkzIky3SKnIlNgORmOzc8S0UMuiW6DCppnMYMOxXCo97K8P9z0hhTr38IA6ai+S73papJSwU0RGWhZHJbYwA+BotzTMCkkGN+HPW71eWBDrbZqnw/aaf8vkbJqM/9dE87W9w5wPGu2ww7dZ8CmJVZdnbPENPtq0g5cu/OnyF3sx1GbGwhXnBn9dEWszCwq0TWpDlOWxffde1yKw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791134365; c=relaxed/relaxed;
	bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyMM6WJO3KcTcMexCwz+Wt/hKJ9Nf6rcfn5LvxX1Bs5P8E+oZLFagJpyLJdYtlMu2bc8jZZzzsofNckuCy+Y2qTemP73HINrZvLtD8kAy6GcX1gdQBaYM7ppHi+SqDmHJiv8FOljO7k2Ekm2+yVgtQrzLtkl0bI7X7+2bZQ/K2d/Dcx/yAxsKamAvNpkj1MSvnv6f047v6BCjPAGjBcpeVEFvsoGPej/NVZZjFBJYuiCLz1PGyjlls04qZvG/MtqNkvy3bCSzL46ogUZiftLA0cuh6BIGPYIthCe1MUyNcVaKhFw0PCoO2HBbnTBma+vuNCb/7BIqZ0CUhUJONR4ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N3Mr7AfH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N3Mr7AfH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyTlc5flxz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:19:24 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-5337c7b9937so259271cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134362; cv=none;
        d=google.com; s=arc-20260327;
        b=J2GKjx29p48yk1CSnpHvwuxHVwilAcbJgEjazbpZLnL/hFhP2MxQHi4pCxjtcYA5Ur
         2SMRyjY2g2a7wve3ePiXkxsrDgEm8qCLeF8k0gLuF4x9cC4/VvmiOLlQn92lgepstj53
         AMABty5IwNpiEP4sBiPSz7u80xgt9eKt0KOWbhmgpHwZVy09AIs/jIa3O0yga1KvObYi
         73747x3CDu4isIny6uVR8tV9y2Pk3lUxwkGZjFRin79gi7LOR/bHTHtLXGcMICNHRn5p
         BOp+MsDtJgadMtFhfOWyc+PbMCCwB4ySnOts1kIEOufaE+CTbqyehdIZMIvyocdjVF0z
         r+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        fh=Nx8E7/lICRxN5D9A1NhSKMybZZl+xRw+C4QXT30Y6K8=;
        b=pO8WI+lAeRurESrOsyXceBwK7oB7TlfcUIeS3t6odHTkpbSzoU2zsrcYPYFxWnEkFW
         1BGpiYSIZJjYs/M/gE5qhoUWVLrvi2euKVg8Tw+2cOa0IIbJND1usl4+qEvVMoUp/RPi
         x0ZbsV+YPDhuFujPmqq0YqTDFNiQIdwaOKYZMxCVxFE+PuAYVk9ECt5vxAGvwk756W89
         JLoDy11xjzZfLKbfHKG1H6SbtlnRqd9mYqe1rMSuz/N/RAolCUIPINbpSODZu7X8vUrb
         Rt/d6zHkOSWoUdnJx9ZV4LSmJIb8w0ZYzScLSIUDfwp+GJOn+rzPnLLEd6+dMyhdVIzT
         v2Yw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134362; x=1791739162; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        b=N3Mr7AfHm+KKXahoVhbsUA0XhpP7EXz83DzTmEwTkgSCOJS44TEaHUWOi6RsgRQiTp
         SdUZVmaRPggE49Jt7ZKHXn9h3BMi1ncxkQ1d1dVDvefNfSOLR2ci2vR2SR/8BIrq5wp3
         FXPIBmggkfj4n3LhGPAWL54+WRKD6qUWNEYk4ZY/DjMceyB82v1vYKMUnEUQEeO2Vt1o
         TBX0AVwFwOpirODczZfzRATKvrHftsH5XJrGBDea9px0f8fd722y0+V9bu5VSBsgXisd
         eQprE90ErkDhjU0iSTRQodo5q222ZSs6Di6MBZdefv5ptb/hD0zYQe80ho79qbneTnuH
         YTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134362; x=1791739162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        b=dNolPBGct/Qhd/jmVTBPH5VQXYKwLPmpe56I5LkIFhQZ5poI4XFPfNMFUMoHQsx64+
         xguTomw3n2/xNVXdPm8K/8jNbDvPlF2Z3nwWeUpFrfXIKFSFuKBcPxpMCPvungvfmc9c
         GnYbK2Cl6XNJJLm2X6xwovcW8b7zrsXLnZesEaia+KuyP/0nwXxmdov/zd2rLjTsPuW9
         GPNTdmdTCX2RhD6SP27kARR8GkWhBvrxuFAVJEUPlcuiB1I6r61pdLaGrLmkfoNazbFv
         yZhVeuufezqXRyhh6BR/4hxIukIrOI818dzrs4p/NoQrdduOiPbTUGofeLem5ZIEdOjZ
         aK5Q==
X-Forwarded-Encrypted: i=1; AKwUvBySCarQT8YA3dmKjOFf3al/mPxrNF10H0PePcSIKQvT2tkkvW9sLhY8xFleEfVFvJm5zAqwJErTqUdhW+A=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lWnctDegJJnc0s/dR/+WpeKV3+5HTp2brdLbGEmnvxI0SsL7oH
	u3pcbFaBhTYzNZOXaxgxwPcgn0yQANqDDyJ8gD4CtL5u7A5YXS9aVLzEFUbsD+XvxZrPd6R+1Ht
	GezSrBfa8lRPCn1lkrbt4NaeZY8TI9wMFAZftk5Iv
X-Gm-Gg: AYBFou30Ag0gj91UCLjf5ICP8TMDpBwn0Xu9en0KycxV8tTQEWYEw5KesAFw4mWUhSb
	hcj79zFfxPrP/XX7N9dQZ879rBpXtCDay57J4UP69CjbxzJjV1GfJa++xMKhUCrs2inv59AHFKu
	9NH7F403Gtl+gWACFrYq1C0JlulJFEmPscf+4dqf//Q5lxQDN6pQNijSrzqjhtVQ24BG+nPdhYX
	eFRQ4RjZxN8iifLKMCtMtwjD/r9iB5sqdG0g2HKq76JSbax8QjAFXuYB9D35xjom0p16PjdHEpF
	WQ1hEGY8QDt1zVAS3V49jPbOmgNktaNPSvwc2XeHzeR94rByrODRheWCMQ==
X-Received: by 2002:ac8:5e4d:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-535131e75aemr16242571cf.10.1791134361196; Sun, 04 Oct 2026
 10:19:21 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-11-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-11-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:19:09 -0700
X-Gm-Features: AclHuK8q5domRMZg3DAHzMyB2slG297Lp1_L7hWmlqEUWco5tu_MI_s_DzFbhWI
Message-ID: <CAJuCfpGdJM=J+6tkzid_Mu+7nevdhFaTW0E9tbKXoLmzC951Fw@mail.gmail.com>
Subject: Re: [PATCH v4 11/38] selinux: reject writable opens of policy file,
 drop mmap shared/write check
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

On Sat, Oct 3, 2026 at 6:37=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
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
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c7d91476971c..545a6f89f9e7 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -340,6 +340,9 @@ static int sel_open_policy(struct inode *inode, struc=
t file *filp)
>         struct policy_load_memory *plm =3D NULL;
>         int rc;
>
> +       if (filp->f_mode & FMODE_WRITE)
> +               return -EACCES;
> +
>         rc =3D avc_has_perm(current_sid(), SECINITSID_SECURITY,
>                           SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL)=
;
>         if (rc)
> @@ -424,14 +427,6 @@ static const struct vm_operations_struct sel_mmap_po=
licy_ops =3D {
>
>  static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma=
)
>  {
> -       if (vma->vm_flags & VM_SHARED) {
> -               /* do not allow mprotect to make mapping writable */
> -               vm_flags_clear(vma, VM_MAYWRITE);
> -
> -               if (vma->vm_flags & VM_WRITE)
> -                       return -EACCES;
> -       }
> -
>         vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
>         vma->vm_ops =3D &sel_mmap_policy_ops;
>
>
> --
> 2.55.0
>

