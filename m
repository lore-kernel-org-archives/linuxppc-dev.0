Return-Path: <linuxppc-dev+bounces-17449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0C4FEE4ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 12:44:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNPz546p8z30Sv;
	Sat, 28 Feb 2026 23:44:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772282673;
	cv=none; b=BqAPdeajINp49ZbRB7egVmmNHAYed1eNxXJfW2z2zVrwKh/vEC3rMosbv0hXDCk6VdtvPYdIEwrKEfSCrlpeu3D+3mbne7IPX8wPYxOw31wbBTN3TKSoPBNdRkvTAyh6HVPI6RZ7J3RoRBzZkXO4e0Y0ZpNIoxeJPuYYyNV93GFZsfcVVre+QmTQeoLXwscvH55pFRX5IeXYMOruvMxXahFkpZjqslx6gaZjR1fD6hsJUnjVwLqcOydcBLO/PmE/TL92fWpWA9IswVDs1XpvsgqHYV0sJPlVWXU4GqoD9rc5dCYku6XkVOnBFr24JU3N77XpPbVYOiwsWVb5tRu7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772282673; c=relaxed/relaxed;
	bh=RH0L9WD4/u9mQiuU+Jc2bLYt2zoxsRLi5sNyM2YzgMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acLoGD7bY5r/kAcWMRxG1Keqjtqxzu/CUgpl2hlL6NyCWs3GWZGZM0zOlwFjE7tmWzTOD13lBstCXDsb0CQKbCwfy9XZs/9MDjlZ2ypX/SdQP3Xy3QmIsiUJb+RygEL3ZUmpDOsDiIcpixkkd/eTqEZ2/CzeP+NcuXOPszS1aF3z8IHrhhzklBcjjGQdamnoAXHZ9MY57ms538Rang43aw1CsBCjneEYipkUNhu2lsC+HVxEXqHeZ1oknfq2NGqF4DM+KuXEdF265hFNTzbKkJKaUm+0amO7Ye/cermVQFmbYWauqcX/t722lO2FA3nJfttk2xzM/hJiiHH6C1B6SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LS+QbiMV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3looiaqkkdnex85z1el483bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LS+QbiMV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3looiaqkkdnex85z1el483bb381.zb985ahkccz-01i85fgf.bm8xyf.be3@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNPz42jQzz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 23:44:31 +1100 (AEDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-483a2db68caso23191815e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 04:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772282669; x=1772887469; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH0L9WD4/u9mQiuU+Jc2bLYt2zoxsRLi5sNyM2YzgMo=;
        b=LS+QbiMV6kUCDmRU/Y6aV/1rWPgK0Vky+yOJRhQySL0JEyrGykCwMsNLgXYbd/veQS
         0V1wCFpVpYv8OlfryiYWaVlKJqy7kSmJAhgxKDpydDU4dU3i8Vb8EQpmQpanoxNfHRNg
         2evM65oP8hKrtijB4LQTb09ulXlrxhMG7YSEz0j+HKfmb1ucjLxMc5kOSv7aNrLKV7Vf
         5XIUl6klQrNOqCg71oGqhu6X05NVpCnd9657vihcS4cnlIX+FKI9lqCF87EXebydWYrk
         jpyosvzFmLxeW74TjQnuw5GiLGoOvI24ZtKLqzR1epA4ftYWoGBMA4pRN9XWeJNmvLdC
         bPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772282669; x=1772887469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RH0L9WD4/u9mQiuU+Jc2bLYt2zoxsRLi5sNyM2YzgMo=;
        b=Ba69SNugl2ZfRyoH48JMI2indr6tAMu4bjrOLk6s+KOibsBJvHpWIPj7Tbx+mvuzNs
         QKKR5XUhZ5likwI/gIobUChxgO1iKWjD9MpEGxmvJh5dAs3RETENP6J8i1nzvQYliuSW
         pRNQIIUr3z/IuVYA4i+spkOiYIu6yVFWnU0ovUFubu0xnjOPHwt2+fv82TkD3XWugY7+
         QZI6Q0hva/PhbnEkltZQeQP2oNNI31NkubgwBjxzcl02uujefOcks3JpsuyEukWBLTFy
         rV8b3M5+3hxX6XpivwGcF1yYlFxkK5w8B33tHTxzRnr2kAX/OoN44VfFn9J5kvyzqZxH
         HCQw==
X-Forwarded-Encrypted: i=1; AJvYcCWe52YU18HEMd2bSqYcRYAw9OmCcYhwFDdrxn+A9YjV7D0KoxvJ+gxxwzxtGVzEjjN8q2+XGj+JqwF0t/Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9jz/lRCyw96FH/LEYvvCna9mvBFPW87bZPV93Ps/lkL7aXD2L
	EKu6gVRbOOfHKTnG2TDuZfKlONQyg9BVTW2QcIM6GcKMzXPu/DALw9HVd+PwaPc4h0ujLqVfshD
	Xw7IKLbs9s+gzjPQVqw==
X-Received: from wmqi19.prod.google.com ([2002:a05:600c:3553:b0:483:6fe1:c054])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr120569145e9.19.1772282668287;
 Sat, 28 Feb 2026 04:44:28 -0800 (PST)
Date: Sat, 28 Feb 2026 12:44:27 +0000
In-Reply-To: <20260227200848.114019-15-david@kernel.org>
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
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-15-david@kernel.org>
Message-ID: <aaLjK2Q2q5ghE-uE@google.com>
Subject: Re: [PATCH v1 14/16] mm: rename zap_page_range_single() to zap_vma_range()
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Feb 27, 2026 at 09:08:45PM +0100, David Hildenbrand (Arm) wrote:
> diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
> index fdd97112ef5c..2fddd4ed8d4c 100644
> --- a/drivers/android/binder/page_range.rs
> +++ b/drivers/android/binder/page_range.rs
> @@ -130,7 +130,7 @@ pub(crate) struct ShrinkablePageRange {
>      pid: Pid,
>      /// The mm for the relevant process.
>      mm: ARef<Mm>,
> -    /// Used to synchronize calls to `vm_insert_page` and `zap_page_range_single`.
> +    /// Used to synchronize calls to `vm_insert_page` and `zap_vma_range`.
>      #[pin]
>      mm_lock: Mutex<()>,
>      /// Spinlock protecting changes to pages.
> @@ -719,7 +719,7 @@ fn drop(self: Pin<&mut Self>) {
>  
>      if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
>          let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
> -        vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
> +        vma.zap_vma_range(user_page_addr, PAGE_SIZE);
>      }

LGTM. Be aware that this will have a merge conflict with patches
currently in char-misc-linus that are scheduled to land in an -rc.

> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index dd2046bd5cde..e4488ad86a65 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1185,7 +1185,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	if (vma) {
>  		trace_binder_unmap_user_start(alloc, index);
>  
> -		zap_page_range_single(vma, page_addr, PAGE_SIZE);
> +		zap_vma_range(vma, page_addr, PAGE_SIZE);
>  
>  		trace_binder_unmap_user_end(alloc, index);

LGTM.

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index b8e59e4420f3..04b3cc925d67 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -113,7 +113,7 @@ pub fn end(&self) -> usize {
>      /// kernel goes further in freeing unused page tables, but for the purposes of this operation
>      /// we must only assume that the leaf level is cleared.
>      #[inline]
> -    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> +    pub fn zap_vma_range(&self, address: usize, size: usize) {
>          let (end, did_overflow) = address.overflowing_add(size);
>          if did_overflow || address < self.start() || self.end() < end {
>              // TODO: call WARN_ONCE once Rust version of it is added
> @@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>          // sufficient for this method call. This method has no requirements on the vma flags. The
>          // address range is checked to be within the vma.
>          unsafe {
> -            bindings::zap_page_range_single(self.as_ptr(), address, size)
> +            bindings::zap_vma_range(self.as_ptr(), address, size)
>          };
>      }

Same as previous patch: please run rustfmt. It will format on a single
line, like this:

        unsafe { bindings::zap_vma_range(self.as_ptr(), address, size) };

with the above change applied:

Acked-by: Alice Ryhl <aliceryhl@google.com> # Rust and Binder

Alice

