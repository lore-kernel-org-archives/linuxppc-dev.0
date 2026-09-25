Return-Path: <linuxppc-dev+bounces-28185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3710C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 07:37:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrjGg2bVXz2yd7;
	Fri, 25 Sep 2026 17:37:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790321867;
	cv=pass; b=XDno2sbevD9IeJ5309oanigl6C8dSXnKLTjx4WztIQn6AtVlGksus5GK4ZVlQRt6uN028bqezICXRfK0krekOkQbMtsWK6KbXbGKUH+oDsbXbU5ccWveJWLlvAAQ88QnTTzsbviLsR9w3sHzD83SH5Md2Is+v8zaLSwfIaQjcsVY1W8HfocTsxDOcSMgFN0g0G6GNPs7w1yz3J6Qvy+QK7G9kgV/mwMjO122ZwETHxle6T9l67jE7+8jK+lYUuRD7A4jdci/1NFBBo1s5Llkl9tUNv1OE3+ewN0nKTKTDvxKHS6mZtK8zmieeXFrNMGuirfbIfA0/TbQ2mFZaWh0Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790321867; c=relaxed/relaxed;
	bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTPgThHfW21Di/pTpmMADqerLaMYa8xan3kKLrA7hE91mQAg2pudTkw9hPt8VwvdPkc3+D0lN/FSOFGrhIrbmF2SkjcD917pVrGCSTlehG7UGFRdgO2r4GAmLAjGoQdyjLgrsEHe0xS1zqtlvSNt9r3UNDQ7uGUze5m57H2BvcRr1hOOy3qwv+zmBBS6juwwWsaGObvAOXjJW60PPAUOAauHLoZw6WeyWIqBoR3mvHWRNWbwitu/Z9ykJ7Mw5DRMCfyeQV+VQOoNZ/BbCjB46H+IXIcVNEHf04bS8r8Wiu3cOT09becft8NArb8/2bqWSlcf9jzA35oNXXmRztTg7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OE8NhLPQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OE8NhLPQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrjGf1yfhz2y2M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 17:37:45 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5566a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 00:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321863; cv=none;
        d=google.com; s=arc-20260327;
        b=gUfxk2PF6MqtwlOlX1gOmjURWaZdVNDPe23gFoMvxDzWkt+7TuIwUNJC/Qr4yJ//Ah
         GLywYeVzJlO4WzFkTad8FpyuBJa9qkEV4d1eXzoi0y+ikuPyUSwqeZZ5MBE627joYbTw
         6zDi7/yXEIhJSxUZRwmIN6CjWIJkgGMkXjGn/TnM3+Io5Lh6l66qDH9NA4x0LAjQW3fc
         F3hnrcxfXDmc8mSy1jsaHrd6LS8JoDsJJ9TbxMcAsohRzFLFEEfBR+sezdbwxjyy3jWd
         mvjgegWcffGkCVTlGBb84NPRZjFNI8ZbSXUlExQ3acoN4FNH9J7HffcifV84HUXjye32
         sEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        fh=FykQOIac6tqNAA0w+WzBLzzhbwxBpuLhFZmhDcCmyhU=;
        b=dBhIlaYLfbcIPVg3uOMnl9IqH44yrB8Tks5Mvm7lFOogLQq8i7nf6vWqIfbatkTt5a
         9QvFYIKtdfMYbMGnxLKzePyiaFTZtloJ9PIT4L7p6zxXMFDN8fK28lR/AUM0KpL/qvMH
         tcDZbBhbBhuEZi01O+a3NZG9wkX+r7a7q3eVFdyZ+9msTTQ1PWZd/CH4HA1/+fKCjcyb
         dVJlaYBoD6PgUkN42+alpeGBx0vKBLBt6pfi/3dDMeWKxYS+oTEapYZ+4F6HMhYFCLpK
         B3q5ACur8JyRjRCDQ68BIhnmqVYxkW8cA5NMO9/8LMPFCg3pS8dL8MtDckM4nw+s1QF0
         DGPw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321862; x=1790926662; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=OE8NhLPQmb6FiAxWUKagw3ELvnstjDkfWOK8S/pZXMHz/zkp5d5eLfS6Lybrg9o4n0
         ICzrmJMqroGZ4H+fbz4NK8YlA20caO4flDVIUFRkdH1w6EAS0QePrP/ZNaAPXxR7AGIQ
         2M97HCt6W/99yzxIzFdNSQiqRPUowtt/sTugRgEdee9wWPgyY+ei7FNMTkn/1z1Gd8Dn
         2rU9uL2x+/S9Ec5jcHplkesIgVjZNL712dlYe5pHJOrGsEaM9cTMUtGG/Lj1A1Hk3SJG
         kvmdyBV8IzFwv+4ToblZ2nbf+T79ZT0ioP2d2wkblNaJFUw5QsDq4G8cgDlN9DD+sovz
         9aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321862; x=1790926662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=ZBb9oz9JKgTOLQnmXsMpLNfBSpQpXh6w1Ug+4al0ecPVPopXAe9sHEjgtRc8Yiq2IP
         mZESlEOIdYStpT6Qcc9mSY0tvCACq+TlZrjg4H0uTM4Ekb5jrybyHtAnHiNGYAP+zv0i
         ringntErJcNYNfQx752KpeJbzWCfdYQt29RoxxKwiISH7/YyQeohhWY7YsydNLKuB3w6
         A6mi042FqL9puYmzN/4GGrCyrz5DP1+c3E/XToKBHaMSS2IWPVAYe+Hacoz7n+aoTalU
         IqI5yGG48rLWRibvHxhC1S6W9wUFeNvdfLddXPXxxS7ryU07yVh7sdU1mYVk7A133ZSd
         4FXw==
X-Forwarded-Encrypted: i=1; AKwUvBy7nf6r6X38NqqRdYSkM329v9wWPZHjjvF0hndJDPtpEvGx90eDb/0ZrklvacsN1Gq5XjIveVOgxn2p6OU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjAUWGLRns1Nq7wt/oFE1nC0U8nPOa1IaxJscw9UlhJ2XJ/ruC
	AadGDPp4I904y/6kijUXWn+Qyrws7kDhU1UykBFDrS3dCa/vCp6J96od1wvkcuPcHJ8BKqxrVOt
	9QS7kbtemhvGyRGMNUEXi35DkCvSt8ZsGxwHBJIRh
X-Gm-Gg: AYBFou1kTxbVTngMP3XKsHAF6ghOxDKzhXSwRPzo5Z3LQSqC31CnHAyovvT+LOT0Bug
	BJfosl1ZN3mULiW6I/vsw4hnINXm4I5DdWr8nkOI2x7wwsl+UETFjlXN9B9SWsfUeyKeZCxhFuk
	EgxOxr3vvSVVrwnD2fs62zTClJxlIh29BwAWNwuRIUk7otHvW59egsYzcMe6cfMxV7/H4LQj+Oh
	QL9RGtF3aw8WXGjVWBRVkDeSFPNkEjllNrsax7ZKVJKr9wfMiiZGpjc+PBsgiBkISeuCqJQ669O
	YU45/zCtp6OUUN5gzaOGBcLXAkzlGz34SHztYZKra0Y5XE+Z8HKSnQ==
X-Received: by 2002:a05:6402:2714:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aae4729638mr36915a12.4.1790321859803; Fri, 25 Sep 2026
 00:37:39 -0700 (PDT)
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
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org> <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
In-Reply-To: <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:37:26 -0700
X-Gm-Features: AclHuK_RUT9CXNFLpx8ZY_roLEZNzp5S3oNdpNL4cW25fJBFg9wRGnSWohuMdYA
Message-ID: <CAJuCfpH6AF-hOo4jU6OeNVpd+fgpqLpmcfAGs11J=nPCgAqG_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
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

On Thu, Sep 24, 2026 at 12:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied=
 by
> > MMAP.
> >
> > Also while we're here delete useless comments for mmap actions whose na=
mes
> > clearly indicate what they are for.
> >
> > Also update the userland VMA tests to reflect this change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 2 +-
> >  include/linux/mm_types.h        | 8 ++++----
> >  mm/util.c                       | 8 ++++----
> >  tools/testing/vma/include/dup.h | 8 ++++----
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>

