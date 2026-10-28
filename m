Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137C606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 00:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ag0un0a3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDp4Z29LBz2y7p;
	Wed, 28 Oct 2026 11:23:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c2d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793147022;
	cv=pass; b=Ug1G2+GZnZmj5DpwvFIQszSziQAgztxvzOA5/R8D/JYlRmByeAxSvDLlxOS/Gq/EqRfN/fc16H7BLdqvubKNXHJQLyVd1y3yDu2bjnVi1+lMoive1UWSD0Gw8YdK1V2L/au5IFaVOUfcnAk7iZ1leb2LnGkaRX2CSgIs0vC6Oa9tlmaiO9CJ8c5ByYMvzaf0pI4AQWV1Tbe3FcXvMDinuuZ4G+1eJg2deNQ8dPf7hYNOWO5HY48Q23nXGOSg6lPslUD9EJHWtLdm3cyRJj/HsHmjLhohUiLfXDimpJvdJgkKzRvquXq/u28ET6H2SL8eF2XT6kMMHXxr1iTts5YBow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793147022; c=relaxed/relaxed;
	bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boLPTaEFNlLZTn07BHj3adL0+TYrc/WH09jQZ74b1NBiRf5BXxhy2zMXRLZ9299pp5/25+XD8ice4X3oeA2+KvssXRLFaMtvHbeaLIToiHe028Ze8yT9W/S2oSi60nU9+xMUWK16oNdJACmzfY5IETRFNpX9oC5hXkZRlPIZGsS3S5xBHWcCnTW5QNVhURMiIjjLe0u+BB659cyJoPklYqAabcLn7LDd6hhb+9VvtiM3FAw2x3nwoF5ge75nFk5cd6JwyXKX9wt8NvkFCQ2TgvJOFuMFLi3+81Q4zdvOP9FyUQQBpoK/5URF9q+IBsLi2yKOBTZvJfZ6sDZwhzCaCg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ag0un0a3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ag0un0a3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDp4X41qlz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:23:40 +1100 (AEDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-702dedeb70dso357225eaf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 17:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147017; cv=none;
        d=google.com; s=arc-20260327;
        b=IcLDW0DzT4Wcfyx5j0gAPROq7rvmTGnQJnpHRj5m91KLHKhhmJcvX6zE4yNS0Awe5X
         dmzBwFlnShX+0JRxphH/GboPoPRNNhR9jaSOQCimUm6YMmvNlfCyuB2Vf6WcxBMpsa03
         /HL9XCjkasomoDXvDQaagQm2apk5Wy1BKoj786ynTUmj7OV8m/nzxf42YTGi1uBjpjo6
         p4qjpXxAKONreEcfpiRHbIE5zvnRuDmeVIs8LMtbON9jrBKxE1pRe4ZkuDQQbQh1Z1SP
         h1SY5S66WNnTufdP4Lkflvu+dSG36bcVvI7C50/nGkD5KK/tHgdgDkouFNZV2goTIhsz
         0oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        fh=Q+cDzvIQTx8iHZ3TfTigz8JOHJ2zUsh8c3DjKgGc7Tg=;
        b=e08Iu1+S4PT5tEx4R3z6PK/mwi+1dBw6Wjp/8F2iaX/xTY3m1q+AOvnLNyu5BLfCLs
         nReRlqSBfp7o11UyXWscbnFGqnCgc4Dyn6cXJWjdKpWOOTu68eWcFzm0nZOK7X+sz6dm
         nZto+epY9AjAjuhtc4FiyXkYkypDJpTEuPsRv5qAm/bnZkC23IcQfRE8Qn3y9xoub9R1
         6Z3rua9S825qKXZdSnLOTE3E+5FKZ/PXxK3/GR2sJDwv48UR+WE+egLnFPVbwiNeiRWB
         3rv6CgW4aDF3eeU+3RNygPQuONSjGWlaApE8I/cUVvQUV0IwDTkobUFJkoMM5LixqZms
         bu+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147017; x=1793751817; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        b=ag0un0a3FFYnjOWjtYbwhpAMuqtc02g9SwLjolw6rtyQ0va+/NnEUASv+TF+CBMt27
         o5MOIfGkNSfOIejhyVa03h/w9f1N2eTgwZoLd/f7zVmc3sx/WU3RDwQoSRLnCNpLoXKX
         X02EcbQEVxIlgPzeG15KNkLWVt9tCrIo3IAkZbRenanVAgFav5CfYMM2zrA3zHc8L38Y
         ZPy+4Q5mUGFFUAW4ykxc+aTe/gvVKJcdW3rao8DtX6tOM8bDPU3f4S9ZZ0ag/3BiI7rc
         M7b+p95CovC751FWxM66pP2x1RFA9kQqaoR0zEdIslzLwo81LCWMtkf+VC4UBmMEKOnu
         MmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147017; x=1793751817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        b=rmQgFTRXzQBLLRLVJXIHlGahkHliD3jzzY4VECvTmxQkASePCH4aaW2twcjnJczsCh
         0vS5sQl+hiT7pjSouXHShswun/uv7ibYg3DNMftfAvlMYDemoyGNDcs4NWfKOU3SgVSP
         niraDc0Xtmf6icmrKV723XVOWWcA1piBwN1olw02snKrS9neXB6YJF02QtRPXpGVrLTs
         83XDuMz6vJ9v/u2jZZK1HRldZu1hRcyLM+GkgUVpgG8WhaGs1DFDgt68w1nLXIH+v1qb
         N6MgFfvnj8GHCLz3OtuwN3CarCG+GQO7rAELWqDTlOIqwC+1roqMHEroPbL9VjZmpxQr
         Ft/g==
X-Forwarded-Encrypted: i=1; AKwUvBz0y91WbMI+IZ/+8WRjfts7H/jt9nwacxOuBgN5D2Jc8/uWb5HbPPoB6+u04qCn3MDArIb78OlJQRmDvm8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJeJ/t68oVro0o87Gg7u7QZkqdhRila+IYnCa0uN3IhM+5RSahs
	jeXu7i4AtM6eJ75vzsJrvWrc2rv0OmdPSvxVHeIoYLfXQ00ogX/R+CKcTv8NH61eTGmrfPVyOMn
	2uXfxlad9moIFE1A4AHCfw2/7ZPD1cZQluUydnu2C
X-Gm-Gg: AYBFou3rgvge84DBFxU9XQ5fVAsu+twF8bSOrv/jWKZ4keHF7rB6a9b5mxUQI4/Wbx6
	G8exh/JenQGLt5GZrtJlnueLG4qcVAZlbRNwDC8g2L/Z+5X02RGATAwPLEgj5w43wuyYFesM0WL
	+2N489jfomh+zISMepp/cQpFrNYwxoe3NifDU07sqXCsxkYlqKKyz15r+zIVRmHCajW184ZCbmk
	tKe0Y+MLSmPru8ZCEcPhO7zuQNB1jXtbKtB2lGiBCqQyAlIw0YiOOwUVPHXmLzK3ByCdzjNv8+A
	o+29sf9UMFY8L9sfwgZd6+2pMekxK6xxVF3qUHzRAj97epoaLurXZ0HDQDlNEVRebjpO0DA8Blr
	xRZKk5f0qg/z59pt61wQ6ab+6c4c8N60nNOqHdjrN2MPsajinQx9SuoHPpwcQTDmnjO49U7MoRG
	I7nF/39ufMvhLh8sCapQmISZ5oV6mi8oc1WdzqNnUkG8QBS00taMlqqPryEKIsHW5NBuaRi2ZfD
	vRiDl/gfg==
X-Received: by 2002:a05:6820:f02a:b0:709:d804:88c4 with SMTP id
 006d021491bc7-713f05d151fmr475759eaf.89.1793147017029; Tue, 27 Oct 2026
 17:23:37 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-10-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-10-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:22:58 -0700
X-Gm-Features: AclHuK8RRqKY_lCjk0ArS-oHYaPKalWvy9KfBfqSoDe2ANJo4dTrcc5mcvnFu40
Message-ID: <CADrL8HXL0HCHbp_vLgcDGR8F462qT_DN5A3CvVBZW06xxE1gmw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] KVM: Pre-check uaccesses in KVM's APIs to
 read/write guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 3:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add a check on whether or not doing a user access is ok in KVM's APIs for
> accessing guest memory, *before* doing memslot lookup/validation, so that
> buggy KVM accesses to guest memory more likely to fail noisily.  Because

"to guest memory [are] more likely"

> KVM installs dummy/empty memslots early in VM destruction, bugs in the VM
> teardown path will fail on the memslot checks without getting to the WARN=
s
> buried in kvm_copy_{to,from}_user() and friends.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

One somewhat minor comment below. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  virt/kvm/kvm_main.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1058b864d427..d8b914b76f90 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3298,6 +3298,11 @@ static int next_segment(unsigned long len, int off=
set)
>                 return len;
>  }
>
> +static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len,=
 int size)

Hrm... I think you at least want `len` and `size` to be `unsigned
long`, and you probably want `offset` to be `unsigned int` or
`unsigned long`. The *_cached() functions are the interesting ones in
this case; I've left a note below at the first callsite.

> +{
> +       return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > si=
ze);
> +}
> +
>  /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' t=
o @data */
>  static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot=
 *slot,
>                                  gfn_t gfn, void *data, int offset, int l=
en)
> @@ -3305,7 +3310,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, s=
truct kvm_memory_slot *slot,
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
> @@ -3381,7 +3386,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm,=
 struct kvm_memory_slot *slot
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
> @@ -3414,7 +3419,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot(memslot, gfn);
> @@ -3544,7 +3549,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, =
struct gfn_to_hva_cache *ghc,
>         int r;
>         gpa_t gpa =3D ghc->gpa + offset;
>
> -       if (WARN_ON_ONCE(len + offset > ghc->len))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))

Currently, this truncates `len` and `ghc->len` from `unsigned long` to
`int`, and it will change `offset` from `unsigned int` to `int`.


>                 return -EINVAL;
>
>         if (slots->generation !=3D ghc->generation) {
> @@ -3582,7 +3587,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, s=
truct gfn_to_hva_cache *ghc,
>         int r;
>         gpa_t gpa =3D ghc->gpa + offset;
>
> -       if (WARN_ON_ONCE(len + offset > ghc->len))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
>                 return -EINVAL;
>
>         if (slots->generation !=3D ghc->generation) {
> --
> 2.56.0.307.g5fe7bd680c-goog
>

