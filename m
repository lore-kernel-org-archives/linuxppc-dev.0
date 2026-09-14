Return-Path: <linuxppc-dev+bounces-27271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAD4C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 02:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkRHs6HZ3z2yFW;
	Tue, 15 Sep 2026 12:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789427843;
	cv=pass; b=RCUoSFVP6AYxDjM8qRzOqGRte6v0nlszd83ma6EEsDLGLQAETPREXzZkN6ld5vBC+nr1GH3z0MXVZXssSTd3KWfa++QiQvmd0izuSAQN1G6M5P5Dvvbakl3GUqFVbhLKFjZacSYOKCHOyhYyfLGAw3eESaexXeiT0ZuaeUSV24GWu8pdz1xUS1W5juZgO09hGNykkGTDI5UfQ+cXZhJQtSDoYw6Oq4shRS3GVdqqVNM0FG7SUYBKBrTtnYiKku5CNuHVSKJNt3rk1/k4hzpSPvrREWMVaJOzosrQXaBo9y3AgwCDWggTTI6x6VgRX65arlXaZLdX04+EWFlPfw/vqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789427843; c=relaxed/relaxed;
	bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfsI3n1MqSlNKao0VTKcMlntt0V+ou9GJGcDTHeCTsvjTdRpXwp69DlmzAuyvJxyNgAN8BZBVsj2KQhn9jUdpMkzYXHp6B5gTLT9KSZiXsg2VPFrB9/rY46S65fZamUJFVN5GaobBSz650eZzHC7HnAA5FdcLIXnI3QMmdI5hBGPzN8rEk9hraggpzyRQfUh70ass9AIRS573euH6AgkOZKlMGboFNAOddS9WpwtzxNQ5Hq+vmpO2QebYAFusmTey68NTZHsRQfYyIM6xinw5Ty9irZkazgNspUMbdOTsuIloanyppZPH2Szxzp/t4iSAd+uibqok0dmWhocFrt90Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; dkim=pass (2048-bit key; unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YbuFwqGa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=emil@etsalapatis.com; receiver=lists.ozlabs.org) smtp.mailfrom=etsalapatis.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=YbuFwqGa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=etsalapatis.com (client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com; envelope-from=emil@etsalapatis.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com [IPv6:2607:f8b0:4864:20::b12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkLdr5Ymwz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 09:17:18 +1000 (AEST)
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-67124ad72e4so3938774d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 16:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789427835; cv=none;
        d=google.com; s=arc-20260327;
        b=QbSoYWeMVEOOOETEijsHylERjtAZ7+ajcJHqTKkrYX8SOO7tIjdgjb+Z1d09kbLAQd
         HLcP8RJf2v0/uSAE7zwL6Y7Xveas8CRubFa4l9pAz6N0rFHrL4kxUzt4sYVrC1+ruUsM
         7T4qfskkBx8Khg66/i3DzJ7NiY94ALFD79htqA2EnZARHhM/fKKPIlieIDV9S3tR2UUu
         kLGymu/SvFMp6rX3jvQ/iQJNoz/JjOuIvInVJgNNWEw3bUUHXuNYqr10EXOm6dr627nl
         1C5DgeMKRPKyvAkp2fVQmAbKAfioNN9CnfIzRvVRn61RHii7NrrhOwsx6nlDOc9h97TK
         8HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        fh=uVYhAH7Zx65Fls0rWSy1mNDM3VievAishoE6Eex5VW4=;
        b=XYo8Nxn5RF1ucWSF5CNzWHuyHNEemyjNwiJy2WmnWT9hpzwYZEqp0ivDVJHnkFz/wA
         XVpzx4nc5MJrp+8OLuqClwrLuUsFkH9s7IT9xJAKpCLp4fJyxLU9aMXDWGfqBe9fgLe4
         WaUfQkvGfpUsWGJrOi8BZ+h9lUmIYV8JQ5AgwGNqY/OJztezwsRKTgKuv6xbsN3RchSK
         E1D7i4jmbsq5L+thAeB3tqtkxFtcQUGEYunMDI1WyyATTNx7lCx8G1eQbUaM+td3NhEc
         TFJT6Wc/mLkH40+bGdaL2Wg8pjAlZz8se9agtmCymmayZ/KcanOME39AToD0nqjTnZYH
         ngww==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789427835; x=1790032635; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=YbuFwqGa3d+IyhP0vxGLvaRcndAhrRwANftsw67ygA9NNrIHGuKKQAcpOb7V81A76w
         Gv3C+ya1hWn6qYpaeup9E78rUz/KjlZ4F533J0e7nmHqiJSV5BEkQwq5cCcZ29T1kRf/
         0MBDhNDXGHqzdC+hw/d8XZqy4/wJxyZAJK6V5QSMvqBSCMHBO0HFjegSGn6xVFKwKk82
         za60nbiStxAGc/L1/ZvB+zQKsaJd6XA/EVNpQevv5D4o5332zltxUcsdCDGfX0kh3Ydc
         8tjVOgjIt8mQOAegnCo11yIqhszYZPLHn1b2OkUCdQGeEyDGgem1MMGeXPR5o0Zl+mDI
         p5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427835; x=1790032635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPKM73fBOFsSjy59aqqxc7UWTKxXfj0ZC9NrA+w1XGc=;
        b=QHP+iMXGdnZ1xW6p1dPAqJ6djrz4ax6rYAmi0dFHyeH0GfHQ6hojkC9aDHDv4yJylL
         SgWxuAfS+kcltA9bNqySI0haTBxbCaHqfgnt8LKR5Aa995KWikM6PBUN5F20qslFfJjP
         hKYosudi00RI5MRpDfFNNNIGKnjrEt7Dsq/j/o/5jX0GBdlfQdsrl9wg+NaaQw7ltop/
         4VSK4bb39iGooKBTZ67loyvs9merhiRLRhc0sJV6GrHyjNpnupqTSiCg0AuO9VHKoiRA
         2roOa9n+SQFkj+qlbkZ6HMIyJs2WgSYmWWTHRezEAxdrc4OTnPTdCZMyWU4mgdVhnP9u
         +LNA==
X-Forwarded-Encrypted: i=1; AKwUvBzqn47FjkRyNITMWC6LwpCXe/+iQZ66QMWmNMXfjV8u5iM96LDPTSrGGOsS9WejfJbUBn+9Xwvq2rlzLDY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mx2z1l4Z9HzRo3sajR2vKgtQzlo/XipC/pW3PB7bk86htKC8a/
	4oz6oXUCC2yhAZqeBJBhWEXgHDYRanB8yLnF3BITy9yl4bAH+4XCJX4TvZcVHX9iF/H52fx6FoH
	Rz1lvVcLAm7ri0q7ZXml0fy9bXlPyXMpEy5xSPphBHg==
X-Gm-Gg: AYBFou1Rx61CU4EQ3HRsVgf7k9BdcRE9zb6utl4TKns90PkhRd6ULA2j671OeEysgHI
	7NTCHuenHSdCA0TMidt0bqDbX+KBfd9drZPfvEvhxbbzcN9rVR3HBxI+6feI6O4XsWqmsXBUHc3
	s8KiTxEUiTj9Sgbit9x7E35+qS7IrmhLJ0BAWmXl7NHMFdOtZXwS09UOVs9XoXl+4mjewNVa9pT
	6F3B9dbtPL2Po50I9PLadccoBddC/RYv6l4/bXtuTl4QV1tiacjwO45J6t7GO6Kf+eCvDVnz+3d
	17Wij13a+4nlJ3J9tsl1An/rjQHO2Ji2UfaJvDUWnpNV++g54i5nayM=
X-Received: by 2002:a05:690e:d0a:b0:671:2382:d57b with SMTP id
 956f58d0204a3-6714e00a7efmr1347187d50.44.1789427834988; Mon, 14 Sep 2026
 16:17:14 -0700 (PDT)
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
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-14-7d9781ed5361@kernel.org>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 14 Sep 2026 23:17:04 +0000
X-Gm-Features: AcwNN1UnQs5y9ap_T4Dsaa6llmYZN4_govFYy7UyV78s5E1rt3VhMagl8qfkC_o
Message-ID: <CABFh=a7Sa0zMKssts1TVZ+u_x3roWcYVSmJF34K-W++oHEsbEA@mail.gmail.com>
Subject: Re: [PATCH v2 14/40] bpf: arena: mark arena_map_mmap() mappings VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Paul Moore <paul@paul-moore.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:21=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> The bpf_map->ops->map_mmap callback invoked by bpf_map_mmap() can be set =
to
> one of ringbuf_map_mmap_kern(), ringbuf_map_mmap_user(), array_map_mmap()
> or arena_map_mmap().
>
> It is convention in mm to mark mappings whose pages the kernel manages
> itself with VM_MIXEDMAP, so the core mm knows not to treat them as ordina=
ry
> page cache or anonymous memory.
>
> The map_mmap callbacks ringbuf_map_mmap_kern() and ringbuf_map_mmap_user(=
)
> use remap_vmalloc_range(), which ultimately invokes vm_insert_page() and =
so
> marks the ranges VM_MIXEDMAP, and array_map_mmap() sets VM_MIXEDMAP
> explicitly.
>
> However, the exception to this is arena_map_mmap(), which doesn't set the
> flag.
>
> This patch corrects this and updates the comment to reflect it.
>
> The pages are refcounted and vm_normal_page() finds them regardless of th=
e
> flag, and VM_DONTEXPAND remains set (marking the memory as VM_SPECIAL and
> thus unmergeable). The one effect is that NUMA balancing now skips these
> VMAs, as it already does for the other bpf map mappings, which is the
> reason array_map_mmap() gives for setting the flag.
>
> The intent of this patch is to be able to establish the invariant that on=
ly
> PFN-mapped or mixed map ranges may clear the VM_MAYWRITE flag, as is done
> in bpf_map_mmap().
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Dropped some CC's as Gmail is refusing to retain them in the response.

>  kernel/bpf/arena.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b43..b69fe5e34339 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -620,8 +620,9 @@ static int arena_map_mmap(struct bpf_map *map, struct=
 vm_area_struct *vma)
>          * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
>          * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
>          * being copied into the child process on fork.
> +        * This is a kernel page so set VM_MIXEDMAP.
>          */
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTCOPY);
>         vma->vm_ops =3D &arena_vm_ops;
>         return 0;
>  }
>
> --
> 2.55.0
>
>

