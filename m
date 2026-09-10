Return-Path: <linuxppc-dev+bounces-27035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E5AC88E40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 18:11:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgm2v48gyz2xqM;
	Fri, 11 Sep 2026 04:11:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:31::f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789063895;
	cv=pass; b=PVz6mxe+2BlyjhKE4i5e7eb3oVPDrVr9E5+MHDiz6sQQGKl1UuDiOSWfSyt8BE/0AOkOAeVs9xatSbZ5apADZDuoiJTz3fh20y2nE5d+YV0Yz55BFPpAPhnJSYcpc8w4mGtCJCmpi2472MyeCKib0CK70yWxXbwUIn0FlDVD1tUSh6bsc46KzAm69X6qdzthI6NcyTlPpbZzmn+0f8gMmwU351lN/KzB161LkzwBJSPNDj5oKCytDwCQdfvrS/Vm6auY9Ph+f0Kxn+Tn+OwvWVqDOtypp6jX8HlezytMsKI7hDXGNJR/oQne8+UFB7wi951XYcxgCtzPTOdrCptK8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789063895; c=relaxed/relaxed;
	bh=gxuS67QpsgmiVo7SJODgVn7jNGL8PaTVeXELBYXj9Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey8A1a5G+sRYO7pUvbcC3sp76m3B2asQpTlJX1qwkW/FAWqSvZuZ6jLzqFD8LtNShO21q3/KAVuK60iBFtTzpzdaUd0XpawtwbxJDyVAu7xV+PObeBZ3g5s4jZC6hU3554GiG75K9Clz3SWUC3CGMLoVp6LLg85eQmaEEqC99Fl5Sip54U2dohOWDb8XXjSdUQbND29JDOqFQP9h8I4XMTUDjbNMiBN+0zuNgE/nkJNDHxX9s6Jfu7WD0EqB3KPF69lGp/NZuRM4OSH6A400wh70aiSAsmzxNnvYdJoMQkyFjV8/Z9wPse7Kl2Jgt+lnSJTBoi1A2H8hGFaDEZlLjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fbk+q9D9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:31::f; helo=mail-oo2-x0f.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fbk+q9D9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:31::f; helo=mail-oo2-x0f.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com [IPv6:2607:f8b0:4864:31::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgm2t1G1Vz2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 04:11:32 +1000 (AEST)
Received: by mail-oo2-x0f.google.com with SMTP id 006d021491bc7-6b1ae716890so82911eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 11:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789063890; cv=none;
        d=google.com; s=arc-20260327;
        b=bkzizkr3TtOpiS2s0vV1VvZiv/keimnHR984e7Tfs/FoCOrDJIRXZ+OD/rtgBQc8MG
         y0UR0WU0+f2iW8+Kcl1LVgmbirSIZRElaapbBjQ6tBw4yEAPfgQW+0M1aHyCF04snPwM
         8XYwT0c2dcagbZu/B/rRjBK1k+/z0iALWrZ1pD353w7L3xqmTUATwiObdS8ycuuVrEkN
         xQW4OlsZDrjiyOehLPmvtCHXae6iM0bHhqJaYDmIYvIsZTZUdIyS7r44RJx6WtpTe8VU
         NjtMkovqa+13VQ8gP7zfGYBV3J82KWIXORss/ICAkGypcz+VmKPPdkFvHsOfdJe2XpI1
         9N1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxuS67QpsgmiVo7SJODgVn7jNGL8PaTVeXELBYXj9Vc=;
        fh=L27C5gR2nCAJagUbMGkxSYtUkf+wfn67DjIXZ+8D7Hs=;
        b=W3ZMcDQIWGR3q5z59qgObyLbJxdTsLybrCLZVYFUGXdqFv4I+08UKOingIschbx7Yb
         vh8oOXTz8T8bxRv1GYvs2kqsEgxatTyHEZx151/JXk4QRb6s81spIQGG/CKQLdrrBY5m
         +dFw/vrvwuH6kdA8jxcaVMoTOduBWWzUBR3UAjLZudqQG1rkT110z0RWLlfHYG9OFu8g
         Gufz9uOkdsZNq4/UZLNutNhKtbN7X+2Sr1qeXdSYs9l+Y9JbnuRBUmX47EUky1sbQE7e
         cl1gi6lMuKdiWCqCJia+0DYJcrKT08wWZlaSgBt/mFOTn3yIk6deS899ASBlnb5+u13I
         +3+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789063890; x=1789668690; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxuS67QpsgmiVo7SJODgVn7jNGL8PaTVeXELBYXj9Vc=;
        b=Fbk+q9D9lbTfVbylvqGqzx2YTSYEr8bUOXeerMb8MQXSAc5bYRvrDhN/cmPghvw9aL
         tdyYBcd1vkoat2JLZXONdmhWPfUlyzrwMpHrklIboA1kVi92xsI5OgN+9DVq3ZUWBeIM
         +8Tx9nXBDIb72qXszb58lINExSgZq2qIpwmeIMSqqxfVZOpBcB7XzEEb/hK+4OWkvIwe
         5zDnPVGo/fZA9syfIVz0VCvr2CUBeXGccHomtR9dq9hD8nYzFOe64wwc7igg+RcEOBy7
         TgGQEz+q0KBcFDmMwTwdXcVdxcAFRFSdclwCtlrntY87yThfhk5fPlOutTgx0c1QkPUS
         lsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063890; x=1789668690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxuS67QpsgmiVo7SJODgVn7jNGL8PaTVeXELBYXj9Vc=;
        b=rbKUkVHgBAbjlkKMpNVRCKsKDskJZbqsCy6nT0beGs4xggs1qZwcvB5jWLVEs6TM7n
         PatFBdrSh0cbq7koTIfuAkFawCVxz0dCPdaNuAAQfP38taLyjHnhIgHx/YP/WDYu0aGG
         meVtxiqEVreIzk61Y152YwK9Zitek2CqOCDoHWm2F8nwjR4Fkc5/xuk5MqGwcWbGKebK
         eGe5e164qfr+04CTBRSzIlzk3c3CMg6wpcDKR54ln1gPA0dDVULwZAmPG3fLELaVNDO2
         vE+JWhB2j/laZsQEUgeeD+KIAToN6BYtgQDABw2LSiZtQD2/djvuhAqVXf9m9nFcMBRE
         6uVw==
X-Forwarded-Encrypted: i=1; AKwUvByNO/7A/TEF2FA4Lcfgv1jl68yumfhVeRkooLX5ctXGAJ7bcLznHA4ofLAB/EjzGT91CnQvqf6MIaKmiBo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nVmDUqwjMGGnjCZ8bBZ8EmZzbKUVyN/uoZVartznBtrssR7dj7
	uvJA5tLtjj3elr1H8cIwHja/iyDfHeI57peF8mwe50L0dmPtAtlu4v7L/toSTJMq7i/12qIevno
	DE56bSFWxzRDjsYpPk30p0OO6nEPQyBE=
X-Gm-Gg: AYBFou1nYJG/W28UAg80oRdffsvszIPsChaNvj/UJ4uBNg/5JJtTPuKsW+4aB3J4Wbz
	3oJ/PTbkB3uDsshF9Bjo9alkn8kXkQGLjTx10ySSbDjkWb6AUOqesCIBGYNiljsS2C1VGZ+zqm0
	VnBKJt1lLDB9sZzY3Aab85w7yJ9LSkHDDz7BUfJTwwaMP48O0VswyjG1V02J5aQNZ+yTMEWZsMr
	5q9ClpjgQFhB5q6bhy9I8Fikum3uUM8AWEQIDvy6McvjzQZ9bnhtovzOf2ssFnLFFPisF063AyJ
	z557kL65W01nP6I5PKqM0yulVF81Gke/A6Iw3E/hH/XaxgwAgVFRdQE=
X-Received: by 2002:a05:6820:55d3:20b0:6b1:ac4f:f708 with SMTP id
 006d021491bc7-6c0bc1d3ad3mr241038eaf.17.1789063890425; Thu, 10 Sep 2026
 11:11:30 -0700 (PDT)
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
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 10 Sep 2026 14:11:18 -0400
X-Gm-Features: AcwNN1XLr_yN2lEzELD3PcXDse2cuW9BBHCwsQpnROCV_SxzPvFmiqhSaiK704I
Message-ID: <CAEjxPJ7hXSi=oLtQPV+7GEvN+txfYwZ-u-v_EysNHM0gSGNrCw@mail.gmail.com>
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

On Tue, Sep 8, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
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
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

We should likely do something similar for the other sel_open_*() and
sel_mmap_*() functions too.
In particular, truncation of the status file can bring down systemd
since it is mapped by libselinux.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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

