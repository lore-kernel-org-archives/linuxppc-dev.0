Return-Path: <linuxppc-dev+bounces-28880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2C8CA5FF6
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 17:10:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyTYs6TCkz30RN;
	Mon, 05 Oct 2026 04:10:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::831" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791133857;
	cv=pass; b=MIr659LSpTxGvpOIp6RfvLnaA889ZYGDfQoH6XokSxD/zQNEPzHxISacozE1hECDk4xDOqOM7fqW/jH/kFekiELdBHVo34lKF/i6F3SCRTByqhN7BwftMpZTWr51cLqJAYad0f9SAzFkV+pyYpEE93VkmQj6P5bdHK5w3jTd24Vpa19LwyBAGEK0ekgi0ZzC2qTjBKJTfjw/IGt6V2vL6s8G7O+zFPEQlgjQDL50DJYP2NT6rF8h0AJRE1vvzdoPrARtD4n/tl43YRa06cbx9xA5DdX34+ZCyMcJLPv+fAp2oUCIR198oCsLSGbEL3ov3XPmfqV6cWtQrvglq1uxdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791133857; c=relaxed/relaxed;
	bh=nXFwGZqE64cDzbgwSCh2JqwiAkclwFSYOp8vtgN8R9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAjRkQ3rc69l+84EtRWgJ07kLQ6obdUkRNZ0gZSMr+Dfn2pupBjC5qPkIzMOEkvUFw7sIY2TgpFvJPoiMDd6+zrPSDkOdPqAH56xO8aBTrFCXQASdZRKu7gbou73mxKm0XnOLENT1e0cEBSlYqM/GQJLBOa0Vaik3wbresc5367r4iYSFIACfCK/vHzMsXRgV+6CoqEzdJgCG94pFB66bLyOwIo26DOvR6ezvLLv2/56BooUI3KoaLRJwAtAS4gVDqtNXsusemG9gaB2oJW7eFEBplyYEkGyjR/k+M5Hbzxn4MSJ1EfwjEMpZp6qcX3BZL7TCYdlkFbEN8w2Hiz7Ew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nzfaaWLz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nzfaaWLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyTYq4kT7z2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 04:10:55 +1100 (AEDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-533202fe429so244441cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 10:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791133852; cv=none;
        d=google.com; s=arc-20260327;
        b=Bz168PqBlcSAAf+a/c+tlfAbmKMA6FqjUW4yMe9+DDyvhew7ymOiaCT6cH8LlSFIpw
         0lcYHwGR3fyxJ6iHH14yqgfcnjaD3muMxji2oMniEz97aj4pbmCTWIf/l43xBfli1Kbz
         tBIgDDTKd/OzQuaKzrNGS87yh6Hi25yH/Hjyr4Jq5hpq151HVt/9fuheo5NmR1ipL9dD
         RQLFwetu+ROHe4haUXYKKkH6hYLifszc0D+ofUqJNEbkMi1PYGo2IVYtFonfVBrYTQae
         RRWn1Ivgz36Kc99WaKMlQEtuKMPwYp1Q2ZitFJeTbvU1d6aSjx/fvo3tyF/NbfI8NRXd
         1t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXFwGZqE64cDzbgwSCh2JqwiAkclwFSYOp8vtgN8R9U=;
        fh=H5YBzKnpqK+FlbUSyhFWZHBBBtNGWVobWB0jGa5fAKQ=;
        b=fY6rVmOsIwOhPP1z6CgihxbhMgocgU1ceNaGRTf6CnSQ0wO66dLsC9LHVvfmDShMBW
         YD1BLvifaFhqWc+2e96kNv4kCvAP7yA8LinqkSOx99A0lx2ZgkQKtR1SpafBJEpvNprY
         LazS7Dtnvtwd8JFcyUkK4s0B5uehKsi0VY0CtQzIZhzT2LR7w+JGxO7jRntxMXZoeh/j
         vBcItfXK3ehZQT1+R3kxsNpPm1z0XGWc697bG12eQkm6UIfY34yABVQ3OihO9zkU3OdR
         g5E63yt8RXGWifKdGHf3Eb+I4d5NEN3Ai8mTKh5VuTNj2LfvNPWn9jFvZdGeqLGzpl7x
         7Pgg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791133852; x=1791738652; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nXFwGZqE64cDzbgwSCh2JqwiAkclwFSYOp8vtgN8R9U=;
        b=nzfaaWLz0bJ5TFvw55ffoQx/WYOiE2wuN0PtBGHpzkddzBDHlDHIcbQ8owIcJsCFLS
         5G9iLXEutKGcUxUlmBlPSlCY+huKUZQFd3hHtJOp3+XWRIJ8Cuw1qgDfy63J3daiDPd2
         oVv7LVQAzdssYfl5YOp8HHyoT7WKdjYmUrfSPbvvUaJ7X5UguL/0MEVktM0mZnByRuHC
         3SWDsy2lRfziz4mT0BjSYipuhzfy5r+WGUVssU/QRDDN9p4bXWD3g5S2zUUF+px0Zetb
         6o4X081Om2aKDZiSw5F8GE0lXBjCRIdlpnRFsKgiqylGuOSqyNL9R1XaVXqL903f/fg0
         siNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791133852; x=1791738652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXFwGZqE64cDzbgwSCh2JqwiAkclwFSYOp8vtgN8R9U=;
        b=rzN1byg3m9reoJ2xFHq2CZXyM5tJukdTDlg3VrwXMIUMNwFSZZv6nq7KM2bwntXuQT
         SoG9AeQw+NKC1KCF90uuBtSHyrrfk+MQUgZkGBBb5WvMfnTbSQzIxF8BGt18UfrvzG0n
         a4AwmgaDe788+Rv+e8CqCYkxEqXx52mFvlJskLexblSE8L9OKmYO4d3sZFf52hVX2qVO
         lLE5cXvhG9aW7MRiRUfWP4MP2k5ERwh8yjXFXriuoRrtUaDHMDCzFAPAASdl14TiJ6za
         9WeMvDCiCbTbWZhvlDo98allz3z8epUSMsXHYk4DwUV6J56ij9TeuVdmPNSi+SNbchh0
         bhZA==
X-Forwarded-Encrypted: i=1; AKwUvByXxp8u5kFFNW1dU0cAeXe14lpKIuNCpePCgBsOCAv1Gupmd9rcuxk2cOnIx9QwxyEem/aqSnFguBYUg6w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l4ShfqxgFNhBw8VQh6oQSHLvC38YBzYKQbIwb52KCpEYmcUTS9
	1jEa2faDJ113hcIZs+yLEUMaaWLVr3WgrUY3w9NMrF1L5HvIRu7vo2k1B7iySnX69uisFzxIYhV
	15tModdj+XMWwptCFLN8nMmeNyFR7rMpfOLphnDyE
X-Gm-Gg: AYBFou0UzgkOhIF5UprQ9SYblzWqyD4V1TPGCHbQRuAyOdv0563l8Wimsvv7Um5Z/+b
	JBWzmnkPFpZTiEsc13/WqXVPMEJuXBsj6yr4oj3wInvBc/t4PLehkGMml8fpmwu+MQK/iA32N4m
	sKQTy3xbDT0OC7FA/DUuS/UHxMtYJJdOfBzfkeuXNtIxlGWQIzmox5IAUKQtCb4AM+I1cgC7dZx
	m99qzPFb2bsmCBLiYiuEbbAjacc6zEJP56uI4Z0bg1cQO2QgjaAkzzENwOKWg5txrwuMCOXV0Yp
	EZBFgyhJMk24SMnd2egmSFMKDUy2oh0GYpvfCjRMy/HLE1CV9rdl8nmJ
X-Received: by 2002:a05:622a:2506:b0:52f:9ed4:8d75 with SMTP id
 d75a77b69052e-5351497fbecmr18649011cf.15.1791133850875; Sun, 04 Oct 2026
 10:10:50 -0700 (PDT)
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
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-1-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-1-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:10:39 -0700
X-Gm-Features: AclHuK-xwRjaaPrwB80Vzu7EPALPdSfCYFBDDTpR92M3U_nW5dShbdAXxId4uf4
Message-ID: <CAJuCfpH04aBbW+mnQY3cX5gfEvOHP7nUMAJNaGWtQ5NoE1JKyA@mail.gmail.com>
Subject: Re: [PATCH v4 01/38] mm/vma: fix mmap_prepare file handling, remove file_doesnt_need_get
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

On Sat, Oct 3, 2026 at 6:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> The map->file_doesnt_need_get flag is confusing and the existing
> implementation has holes.
>
> Drivers are permitted to change the owning file of a mapping. If they do
> so, they are required to take a reference on that file.
>
> The mmap() operation which ultimately invokes __mmap_region() is guarante=
ed
> to drop the refcount for the original file the mapping was made under, bu=
t
> this is not true for the replaced file.
>
> This has been addressed so far by tracking map->file_doesnt_need_get, whi=
ch
> is rather poorly named and unfortunately fails to correctly track whether
> or not an additional put were needed in a number of cases.
>
> Make life easier by removing this flag, and instead drop the reference fo=
r
> both mmap_prepare and the deprecated mmap callback in a new function
> map_put_vm_file().
>
> Track whether this needs to be done by aligning mmap_state with
> vm_area_desc and store the original file in the map->file field, keeping
> the updated file in map->vm_file.
>
> In order to have the same behaviour for both types of hooks, only drop th=
e
> reference __mmap_new_file_vma() itself took in its error path, deferring
> the replaced file's reference to map_put_vm_file().
>
> To make this work correctly, map->vm_file has to be updated before any
> error handling, so update __mmap_new_file_vma() and call_mmap_prepare() t=
o
> set this field first.
>
> Also when mmap_prepare() changes the file and is then merged, the referen=
ce
> count also must be decremented, so update the logic to call
> map_put_vm_file() in this case too.
>
> Also update __compat_vma_mmap() to manually perform this step for stacked
> file systems using the compatibility layer, and update
> compat_set_vma_from_desc() to replace vma_set_file() with a correct
> refcount/file update.
>
> No in-tree driver is impacted by the incorrect implementation of this
> currently (no driver that does this is mergeable for one), so this does n=
ot
> need to be a fix.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  mm/internal.h |  1 +
>  mm/util.c     |  5 +++-
>  mm/vma.c      | 83 +++++++++++++++++++++++++++++++++++------------------=
------
>  mm/vma.h      |  6 +++--
>  4 files changed, 59 insertions(+), 36 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 0dca33db068f..fe576d468af4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -7,6 +7,7 @@
>  #ifndef __MM_INTERNAL_H
>  #define __MM_INTERNAL_H
>
> +#include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/khugepaged.h>
>  #include <linux/mm.h>
> diff --git a/mm/util.c b/mm/util.c
> index bf0513d1d3d0..016932780925 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1228,8 +1228,11 @@ int __compat_vma_mmap(struct vm_area_desc *desc,
>
>         /* Perform any preparatory tasks for mmap action. */
>         err =3D mmap_action_prepare(desc);
> -       if (err)
> +       if (err) {
> +               if (desc->vm_file !=3D vma->vm_file)
> +                       fput(desc->vm_file);
>                 return err;
> +       }
>         /* Update the VMA from the descriptor. */
>         compat_set_vma_from_desc(vma, desc);
>         /* Complete any specified mmap actions. */
> diff --git a/mm/vma.c b/mm/vma.c
> index 55917d097933..c27aea6d58d9 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -24,7 +24,8 @@ struct mmap_state {
>                 vm_flags_t vm_flags;
>                 vma_flags_t vma_flags;
>         };
> -       struct file *file;
> +       struct file *file;      /* mmap()-specified file. */
> +       struct file *vm_file;   /* May be updated by mmap_prepare. */
>         pgprot_t page_prot;
>
>         /* User-defined fields, perhaps updated by .mmap_prepare(). */
> @@ -43,8 +44,6 @@ struct mmap_state {
>
>         /* Determine if we can check KSM flags early in mmap() logic. */
>         bool check_ksm_early :1;
> -       /* If .mmap_prepare changed the file, we don't need to pin. */
> -       bool file_doesnt_need_get :1;
>  };
>
>  #define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, anon_pgoff_, vm=
a_flags_, file_) \
> @@ -58,6 +57,7 @@ struct mmap_state {
>                 .pglen =3D PHYS_PFN(len_),                               =
 \
>                 .vma_flags =3D vma_flags_,                               =
 \
>                 .file =3D file_,                                         =
 \
> +               .vm_file =3D file_,                                      =
 \
>                 .page_prot =3D vma_flags_to_page_prot(vma_flags_),       =
 \
>         }
>
> @@ -70,7 +70,7 @@ struct mmap_state {
>                 .vma_flags =3D (map_)->vma_flags,                        =
 \
>                 .pgoff =3D (map_)->pgoff,                                =
 \
>                 .anon_pgoff =3D (map_)->anon_pgoff,                      =
 \
> -               .file =3D (map_)->file,                                  =
 \
> +               .file =3D (map_)->vm_file,                               =
 \
>                 .prev =3D (map_)->prev,                                  =
 \
>                 .middle =3D vma_,                                        =
 \
>                 .next =3D (vma_) ? NULL : (map_)->next,                  =
 \
> @@ -2447,7 +2447,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
>   */
>  static bool accountable_mapping(struct mmap_state *map)
>  {
> -       const struct file *file =3D map->file;
> +       const struct file *file =3D map->vm_file;
>
>         /*
>          * hugetlb has its own accounting separate from the core VM
> @@ -2496,7 +2496,7 @@ static void vms_abort_munmap_vmas(struct vma_munmap=
_struct *vms,
>
>  static void update_ksm_flags(struct mmap_state *map)
>  {
> -       map->vma_flags =3D ksm_vma_flags(map->mm, map->file, map->vma_fla=
gs);
> +       map->vma_flags =3D ksm_vma_flags(map->mm, map->vm_file, map->vma_=
flags);
>  }
>
>  static void set_desc_from_map(struct vm_area_desc *desc,
> @@ -2506,7 +2506,7 @@ static void set_desc_from_map(struct vm_area_desc *=
desc,
>         desc->end =3D map->end;
>
>         desc->pgoff =3D map->pgoff;
> -       desc->vm_file =3D map->file;
> +       desc->vm_file =3D map->vm_file;
>         desc->vma_flags =3D map->vma_flags;
>         desc->page_prot =3D map->page_prot;
>  }
> @@ -2586,6 +2586,10 @@ static int __mmap_setup(struct mmap_state *map, st=
ruct vm_area_desc *desc,
>         return 0;
>  }
>
> +static bool map_same_file(struct mmap_state *map)
> +{
> +       return map->vm_file =3D=3D map->file;
> +}
>
>  static int __mmap_new_file_vma(struct mmap_state *map,
>                                struct vm_area_struct *vma)
> @@ -2593,20 +2597,23 @@ static int __mmap_new_file_vma(struct mmap_state =
*map,
>         struct vma_iterator *vmi =3D map->vmi;
>         int error;
>
> -       vma->vm_file =3D map->file;
> -       if (!map->file_doesnt_need_get)
> -               get_file(map->file);
> +       vma->vm_file =3D map->vm_file;
> +       if (map_same_file(map))
> +               get_file(map->vm_file);
>
> -       if (!map->file->f_op->mmap)
> +       if (!map->vm_file->f_op->mmap)
>                 return 0;
>
>         error =3D mmap_file(vma->vm_file, vma);
> +       map->vm_file =3D vma->vm_file;
> +
>         if (error) {
>                 UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
>                             map->prev, map->next);
> -               fput(vma->vm_file);
> -               vma->vm_file =3D NULL;
> +               if (map_same_file(map))
> +                       fput(map->vm_file);
>
> +               vma->vm_file =3D NULL;
>                 vma_iter_set(vmi, vma->vm_end);
>                 /* Undo any partial mapping done by a device driver. */
>                 unmap_region(&unmap);
> @@ -2623,7 +2630,6 @@ static int __mmap_new_file_vma(struct mmap_state *m=
ap,
>                         !vma_flags_test(&map->vma_flags, VMA_MAYWRITE_BIT=
) &&
>                         vma_test(vma, VMA_MAYWRITE_BIT));
>
> -       map->file =3D vma->vm_file;
>         map->vma_flags =3D vma->flags;
>
>         return 0;
> @@ -2631,7 +2637,7 @@ static int __mmap_new_file_vma(struct mmap_state *m=
ap,
>
>  static void map_set_anon(struct mmap_state *map)
>  {
> -       map->file =3D NULL;
> +       map->vm_file =3D NULL;
>         map->vm_ops =3D NULL;
>         map->pgoff =3D map->addr >> PAGE_SHIFT;
>  }
> @@ -2643,7 +2649,7 @@ static bool map_is_private(const struct mmap_state =
*map)
>
>  static bool map_is_anon(const struct mmap_state *map)
>  {
> -       return map_is_private(map) && !map->file;
> +       return map_is_private(map) && !map->vm_file;
>  }
>
>  /*
> @@ -2688,7 +2694,7 @@ static int __mmap_new_vma(struct mmap_state *map, s=
truct vm_area_struct **vmap,
>         }
>
>         /* Invoke callbacks. */
> -       if (map->file)
> +       if (map->vm_file)
>                 error =3D __mmap_new_file_vma(map, vma);
>         else if (!is_anon)
>                 error =3D shmem_zero_setup(vma);
> @@ -2797,11 +2803,15 @@ static int call_mmap_prepare(struct mmap_state *m=
ap,
>         int err;
>
>         /* Invoke the hook. */
> -       err =3D vfs_mmap_prepare(map->file, desc);
> +       err =3D vfs_mmap_prepare(map->vm_file, desc);
>         if (err)
>                 return err;
>
> -       /* It's invalid for mmap_preprare hooks to clear vm_ops. */
> +       /* Update first so file refcount tracked correctly. */
> +       if (desc->vm_file !=3D map->vm_file)
> +               map->vm_file =3D desc->vm_file;
> +
> +       /* It's invalid for mmap_prepare hooks to clear vm_ops. */
>         if (!desc->vm_ops)
>                 return -EINVAL;
>
> @@ -2811,10 +2821,6 @@ static int call_mmap_prepare(struct mmap_state *ma=
p,
>
>         /* Update fields permitted to be changed. */
>         map->pgoff =3D desc->pgoff;
> -       if (desc->vm_file !=3D map->file) {
> -               map->file_doesnt_need_get =3D true;
> -               map->file =3D desc->vm_file;
> -       }
>         map->vma_flags =3D desc->vma_flags;
>         map->page_prot =3D desc->page_prot;
>         /* User-defined fields. */
> @@ -2826,7 +2832,7 @@ static int call_mmap_prepare(struct mmap_state *map=
,
>          * anonymous mappings. Rather than allowing these mappings to be =
odd
>          * outliers, simply make them truly anonymous.
>          */
> -       if (map_is_private(map) && file_is_dev_zero(map->file))
> +       if (map_is_private(map) && file_is_dev_zero(map->vm_file))
>                 map_set_anon(map);
>
>         return 0;
> @@ -2845,7 +2851,7 @@ static void set_vma_user_defined_fields(struct vm_a=
rea_struct *vma,
>   */
>  static bool can_set_ksm_flags_early(struct mmap_state *map)
>  {
> -       struct file *file =3D map->file;
> +       struct file *file =3D map->vm_file;
>
>         /* Anonymous mappings have no driver which can change them. */
>         if (!file)
> @@ -2868,6 +2874,20 @@ static bool can_set_ksm_flags_early(struct mmap_st=
ate *map)
>         return false;
>  }
>
> +static void map_put_vm_file(struct mmap_state *map)
> +{
> +       /*
> +        * An error occurred or the VMA was merged.
> +        *
> +        * If the file was changed by the driver (which is required to in=
crement
> +        * the replacement file's reference count), drop its reference co=
unt.
> +        *
> +        * On error, the caller always drops the original file regardless=
.
> +        */
> +       if (map->vm_file && !map_same_file(map))
> +               fput(map->vm_file);
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr=
,
>                 unsigned long len, vma_flags_t vma_flags,
>                 unsigned long pgoff, struct list_head *uf)
> @@ -2922,7 +2942,10 @@ static unsigned long __mmap_region(struct file *fi=
le, unsigned long addr,
>
>         __mmap_complete(&map, vma);
>
> -       if (have_mmap_prepare && allocated_new) {
> +       if (!allocated_new) {
> +               /* Merged, so need to drop refcount. */
> +               map_put_vm_file(&map);
> +       } else if (have_mmap_prepare) {
>                 error =3D mmap_action_complete(vma, &desc.action,
>                                              /*is_compat=3D*/false);
>                 if (error)
> @@ -2936,13 +2959,7 @@ static unsigned long __mmap_region(struct file *fi=
le, unsigned long addr,
>         if (map.charged)
>                 vm_unacct_memory(map.charged);
>  abort_munmap:
> -       /*
> -        * This indicates that .mmap_prepare has set a new file, differin=
g from
> -        * desc->vm_file. But since we're aborting the operation, only th=
e
> -        * original file will be cleaned up. Ensure we clean up both.
> -        */
> -       if (map.file_doesnt_need_get)
> -               fput(map.file);
> +       map_put_vm_file(&map);
>         vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
>         return error;
>  }
> diff --git a/mm/vma.h b/mm/vma.h
> index e97bd2dfa786..f15faa83f3d6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -394,8 +394,10 @@ static inline void compat_set_vma_from_desc(struct v=
m_area_struct *vma,
>
>         /* Mutable fields. Populated with initial state. */
>         vma_set_pgoff(vma, desc->pgoff);
> -       if (desc->vm_file !=3D vma->vm_file)
> -               vma_set_file(vma, desc->vm_file);
> +       if (desc->vm_file !=3D vma->vm_file) {
> +               fput(vma->vm_file);
> +               vma->vm_file =3D desc->vm_file;
> +       }
>         vma->flags =3D desc->vma_flags;
>         vma->vm_page_prot =3D desc->page_prot;
>
>
> --
> 2.55.0
>

