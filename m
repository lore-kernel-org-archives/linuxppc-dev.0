Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E1606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=meqmf5mo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDp8S332dz2y7p;
	Wed, 28 Oct 2026 11:27:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::32a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793147224;
	cv=pass; b=nznB6FXcVE2ZqVUPSvW1I/FqcIF3zrA4+dOLKGm4feB2DmQt+w/S9Y457jcSiNoZvqPJkR5c8/+oxyin4HWbyM35OCTDZDw/2fjrojih24lVieYr6DZfKnVru9aiBnx22KrtCJIA8SBGXRmP1WKj2HmAvlHe0J8TidoCLXgYmLvwDzrhSt0Qsu7a08dhlrdTnIDTFbOuzA4XaNifzGfY8tPAhKx+2KZSAB7HcXh5l6HT/U+7PZ2T1/ak30woA+KJwFhSsEPNQ3heM5taeIxP1ZSsHTyt8CCKirRFmQliOb2ftwoBkVcx7Zz2lFd3sJl4JN8oIlW+2oP0VCP8XHqtyg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793147224; c=relaxed/relaxed;
	bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyIOMgAl3FM4Drxoie40B9HgcvC1dHuHiYfeBVa46Jw6CeN2CtDEFZr847s1Vk6DFyUPPxB+vR9LdcdajknGs1zZUW6Ca5ZY7WQmrG//hHiG6iv8Msc3bc23WZcXOxGUCxuNGSbawYFixbQ/x0RpUHGMKn/8m6esQyNJ8FyiMJ6fhFk9S4p4hoJEJ9wYF8RjOlvMt9+Ehrp4v0uSe9/cxC24H7tBBbpab4EqyAIFYzneE6jefnzSAb+xEGYz73H0qqTQNfB2bJrWGehM1SHrEj1KqNGyPZkT56d+nfpVW7Kfizo0D998L8F/TVnz/maZ8JRtZ6CwHVrUGDk0HitaFQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=meqmf5mo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=meqmf5mo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDp8R3ttJz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:27:03 +1100 (AEDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-825b40f8a26so205563a34.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 17:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147221; cv=none;
        d=google.com; s=arc-20260327;
        b=GSAlk9/UEAgawv/4VZBkxJwEXLJvmX8qnNJ0CJLWWyr1glyheAOCrV3Dpz7Wuy5ss8
         YB0Cby2YkVsLQc1tG20WdYeh8Zv2zlD55ulSiacL0rz7t8V2ZEpbLQxrnT0kOuQyF3kC
         aJcivxKya0k8EWvQpH9BmtaR6xA99kj72ofLiDu1/iV6lqAYE1/ZPtZ3207+dmlJAoAt
         By4MWYdPmlJaxmfdabHRYyusk+DftW2n5+8kSqwjHOZw0riqARkw2kJu5ydTdDTl9KS0
         1gSB5VaF9/VU2sP/QB0afFCoprxZeAUWNEnaJSlt0gt3ybxk3/NVfuAEtmFHYboj8QUa
         e7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        fh=4/juEJ1VrB/eNc0b6SLVv+RxU51yRfPnQNTKQmW2HsI=;
        b=Hksid/bVF1lk+QF9oLEESC1WThI6uQUJv4DQYzmACzZzAINdF53wzKgG1zHhcjODUY
         nN7XhU6GTnVuWueGWOiymUHtWkzG+U955RQVgMfraYOXLAAw0n5mgQo7kMbzFa4JKfi1
         zLPL6pmUMPMWS96hTU1N60553iMpNwuUqa1+YSb/6OKPFVcNY3PIPvP9DEPV5ecPt9xR
         T+p09GhJ7UGI1prxjIO0TI095JJV1iA9JNrb9h4EJ0rbxnjc2yH+f79ef5nK5y90mV77
         ug1c13rYJ2Rj0/FJ5c58JN+5a/gNI7/TAiZJGWxTNi4NCDasls1gAzSo3E1+QZMlWlt8
         Gb9A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147221; x=1793752021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        b=meqmf5mo2G/P1Z0dI+6WKfWsSXoZd2X29iXGpTsTmWvobDSLEnAJiojzPU1SM6PFwG
         qy8muAerWqvaRhSYTH6Qq0fg2lLZZivsni5Xaqfsl2l1m24GlzxEHg/QTaICXR1BaftG
         ajBB7dyyoQ24fDOSx3rvWcP//EP2x9rL8ZvAz6u3kty08HGYEVAYSkZQAmAhAlY6m0Ub
         PSLKMs4CZ/cR7mm35GzkzMV9H16oWVEd+9gX5OSVsBi9dHjOfCYjmQshBK59H/qvC2gg
         UFmPM0P1beI9of1Xv9rNy8jVtc4kTlsjRkcTX5IxrDwjHXM2Wx7a9Nf7ycoTWeKgHp7D
         PMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147221; x=1793752021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=As6DCk5gwdp2PSifV5pr1LlxEWAa0J6A8jGIhs6cf0E=;
        b=xZPg5efVyCt0gW9dg6fidBVNGhPery/C/VkO6H5oVZuSzAL7dmfCpi7uQlvEqZ6cJU
         hwHQgwJNdl4Bt46G3v0Y/BbrgjkzuGxfOEvrpKQHxfQJhS4TrhMQ39ECOMbJgn3wM3EJ
         z6Mttq+QFcmMmET0UT5J/rXqWF0q4mftnpwR2M8RMYQ46zmtcnGd9tkLwkrpGBmM1m44
         YAnCESh/JWGz7RGD4Y7hQmmUc4c6j1EZLdPTl0gEQlOScQgcNVhtJT0nxuqMoDA6CTHP
         6fPEQaPO1aLxVEn1u8ksLNJIc+0ffAbpuTPeywTHRsgXJlkm8JsRBFVETQcmVapZN37A
         5iTA==
X-Forwarded-Encrypted: i=1; AKwUvBzL74+sxkVmAFLT0BlgT+/rP0w2dR8w3CuJAhuKSxKax/t2xmUOJzALlL4nqzyQSjsoFexGWdHAW2yjY9w=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJqvwa0A+63xq1o4+EMEchPTjRlbfGre25g1ySr3B0Z2ppsEe4P
	oztXI6WMvHPzKZa4YIuwByzOnD9CAWzTAYSdmMkxqpQOy51CQINtGt80GUMqgaY8FjU9uENeWy6
	Xab65a9eqQirfU9gWKOjeZ102rBSRRpaUFDNAIiCM
X-Gm-Gg: AYBFou1Qnba51J6TiF+CApS2zJ3g2k9vpkFVQ39+WAC7jukEPI1sxmKscBXrb8wgahP
	LPplVRcfpDTeRzA4RW7ZUeFaRMgm6d1tVRzbsmDA1Y55pz+OmFrBHnhQ9u2+IopCXmBl6m5FSGM
	Tr6BcUy1rgABaVvHpGfHMvJZJW1msjZDmY+EFziZvkXGwyG2MQtJmlcCLVNalCQgPxzfEJa+uN5
	8eTX+0h/a4eao3tXjUP0lPK0gjy69o8QFGlxmmk3TIf7DujXByRUHl4rQEy7Bx/p0uLsVNM7d65
	UCGtFwK96CvIi/13redpv1KDTTNmZ4L6HX8+YML1UG4oG7yoceCoC1ZEUSY9+MeY8UJR3fVaNR9
	DhqldJOIbBfaTHh9/ff2J5SE4Dac/4BitpP2YphpiomS0sfC/O5y6NgsvyV3NeVEl02Jd/gbRLi
	AJCPNflDM3AIaNcNK2LqfDmm4fyk73PbYoDcmKAVfW3FRg4DQIvxV01oeHrAEgYSoW+iJ7hWe0t
	XGbtsVZ
X-Received: by 2002:a05:6830:230f:b0:7fa:5c68:d053 with SMTP id
 46e09a7af769-85ac14a8d6emr843028a34.29.1793147220374; Tue, 27 Oct 2026
 17:27:00 -0700 (PDT)
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
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-9-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-9-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:26:21 -0700
X-Gm-Features: AclHuK9X9-tagkcZtNpeYN6-ZH2xFAn91vEZn2rqSYOeh808Aib4fY8cPgUneqg
Message-ID: <CADrL8HVtDucwUSnZVb63pQPmo9YJksSTu+E9dDYgB2sLQ_N-ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] KVM: WARN and reject guest-based uaccess if VM
 is dying
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
> WARN and reject user accesses to guest memory if the associated VM is dyi=
ng
> even if the current address space happens to be the correct address space=
.
> Accessing guest memory after the last reference to the VM has been put ma=
y
> be "fine" from a safety perspective, but it's still a KVM bug.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  include/linux/kvm_host.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f3f59bdf7e18..ba8ea62b7304 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1355,7 +1355,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, stru=
ct gfn_to_hva_cache *ghc,
>
>  static __always_inline __must_check bool kvm_can_do_uaccess(struct kvm *=
kvm)
>  {
> -       return !WARN_ON_ONCE(current->mm !=3D kvm->mm);
> +       return !WARN_ON_ONCE(current->mm !=3D kvm->mm ||
> +                            !refcount_read(&kvm->users_count));
>  }
>
>  #define BUILD_KVM_COPY_USER_WRAPPER(fn, to_user, from_user)             =
               \
> --
> 2.56.0.307.g5fe7bd680c-goog
>

