Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D867606A33E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8/SWDf+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW22g0pF1z2xdR;
	Fri, 20 Nov 2026 15:11:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795147883;
	cv=none; b=J/532KTErp9XLGfpP5JcWmQZ3/lejohAi0+gqD1WHST64HG6Swgdop6dW0WqGEVh1sehcSOIzIJUZMD0PFc/DTvLdQeyErPTuUdzWqQS/mpEDB5R8ss9XJsgubu2pVQuM5+1+nAyfcezJBgUUji8gOVXxdEaEzh0c37aJL/RSgqN1vS6a3/ZjfUoJBtz7UPtYxi2PDbus0Jm7Biw2mf+bmNalFKVm6tfNVgBzkwRJWnIyuDiQTy9PDSRdnOxNqGNytPQJ9rF5wm0jn3PLLwr3BYCvS5+tcjm7q603fsju11nh36ZVbMvsGH/e18ULK0QQVB4Y/H4YPCDYwOLu/5btw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795147883; c=relaxed/relaxed;
	bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=L1pDbZS5ltvtSfSSviZEgIJO9zWeuknNkKlZM4ZDV8nkftdk9Iu8820UZ6jEYANkHv793JKDVE++z7/8DuBiXSOGDnV0dvBg57j+putH8wTHqvRaTOo6S4INl44p+ZvmCxASt+dIi1dwRPSVf+TMMFUTjxnQUdszp+wXUbg3hL6XBFFXhTifsISumqnMBeg/RI+lW8jr9WPeL+Yi+QxrausT6kOmbTTog/Tf8n9SMihwnfpFKyMsxcXs3QHW4K/JuNZCeR6OC0WBjmUeB2NTi8hobo43Ef7lAdHVjNBol73zBKmMKfg965vEy+rRjvzBd0VBTVwHkyEWp03Ibpo81A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8/SWDf+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8/SWDf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW22f2k8xz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 15:11:22 +1100 (AEDT)
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-38564b4b017so491264eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795147880; x=1795752680; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
        b=q8/SWDf+lFSkmSWLAE2gyp9D1wFzA8V9YkSR0t49H5wxcu/EiYMgv0S6DFlLyaBC25
         BnAsaTR1Nq0FDqhd1gKiLpjaKtA8TLBLgDX03JOaOyrZkxOGX0u+i3jjATkAuJLInUMM
         r3b1BCe9Er74fhICwNGnYnYJtV90KT1k96KZLeijPUsSaqm9YM8PNF/jjmHbxWQpeEcW
         UrPLhS8tM6zTAKvWzasV9XG0PJu+NTpArngLsoN3YGjMtyWn09eKf4PzlUGnbyWjVokv
         qoXM21DYQUGOpZmfU3sKa4noa0FBwSE6l28Gs9j5aGwiJb/k6BXMGhY2Wn42UmYtF20t
         fjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147880; x=1795752680;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pj003ayJ7Nhn8ncb6ekHETw8t8DvYn5mtqcaYdxA9gY=;
        b=NsW+pyyidz86jsvNx4OwTrCgX3HuEFgoDvzeiF5kMUxu5WGcvyWrvHT5ELUmSLlG62
         S2jhFbXh98OmalxlCVB+Il+mHZ1Jkz6hySexuk3SRE4U6X+kRRXG+TdsodRERSbyuoEX
         3+gpTu5Hyo7lkgLMDmw0Kd4auFNbjCce+tSLH/ixVfITKkmqbuhYafMIYW5u2KW9n4TU
         jXIiJLZDLU+Wo6xzVScyscPzqJAdMqUUi1M93c/iSAFKFNH+oBtgOQ8NEeD4n/66m+uh
         hrUM7tfCKc+d+AXc2+7wNThNU9uVHYC/Lfoh20xxAf3mEc46xEoN8FtMhp6vedizM+eC
         Iepw==
X-Forwarded-Encrypted: i=1; AL+hErFFjFUM+A/PaWICeAupHXC0f+HxLvY6uMr92OYK/5C3ZvDk085vRD4I+UEcRIyJQ1Ah2gsEaYfuWKB53yw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+AUW64TxW6J6wNrKYeut/ZemqeGKmIoPLOZz/Num7eLMx+X5/D
	rZuE6TvTc8fRsJ6hIAbkEjm616agfVt1jbW3lG+63n0xvq26+md4bbP9
X-Gm-Gg: AZFdTZc0lNU7Rj5KsxQo/+6AiqcWEuG/wz+jkGzbe3cHdW8g2/4YNj93guu+AJJpWwZ
	RWgCu2ApcGb06YOCR+TNBqtfPXjoKoL5ShG9wus7jHW7wJN8xz78X3oo39qbgqjN+B45iF5iw9X
	bqqBc9iBN1XJc5x3BMGQEjqgrKe1nUg2mAoOgajri+OvVtLTOYIyDodx/b9/E9/0XLWwtwR7p5Y
	9NCK4V4PDT6xAN6nENii/Kjm5iiJZ2odby8tr059IpVF2oBMthTIogOmU7Sa8UtsOTq5IOimpym
	B2HCp/GuXe7SiRH2ppF1QlymRFr9GJ1Vccg4RuMrjBrnOPuETBUClhIWJbVcu6oi5SsYl9OooIR
	jOjz9a1pSzPv5WzS2iaZXQh9J8J+wg76BkgAs3K2GB8JyAmvPFn7QJeXfDRS6kOtlY/l3cKDVir
	DV59X1/2MSzOkFTa93nbYx0wNZqWxus4Tupm9XFTIhypSlSlwQyTuAD1G9NdHWkKUb8pJvvmTi+
	k8T0dQxDf/I3nwMf68rQt8Ks083aQqGD4NlEOb09Mj/QsY5Q0k34O+pQb6kQBy1KAXNFshlipo0
	rgcJ9vOyWkJjCDfw+TnhejTsyCE=
X-Received: by 2002:a05:693c:25cc:b0:369:f17d:efb with SMTP id 5a478bee46e88-384b3e77699mr4201476eec.10.1795147880077;
        Thu, 19 Nov 2026 20:11:20 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646632b9sm3322697eec.1.2026.11.19.20.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:11:19 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Hyunjung Ko <hj351016@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Hyunjung Ko <hj351016@gmail.com>
Subject: Re: [PATCH] powerpc/papr_scm: initialise metadata_size before reading it
In-Reply-To: <20261119034745.1460361-1-hj351016@gmail.com>
Date: Fri, 20 Nov 2026 09:39:33 +0530
Message-ID: <zev4jg8y.ritesh.list@gmail.com>
References: <20261119034745.1460361-1-hj351016@gmail.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Hyunjung Ko <hj351016@gmail.com> writes:

> papr_scm_probe() reads "ibm,metadata-size" into metadata_size without
> checking the return value, and the property is optional, as the comment
> right above the call says.  of_property_read_u32() only writes the output
> when it can decode a value, so for a device tree without that property
> p->metadata_size is set from an uninitialised stack value.
>
> p->metadata_size is the bound for the metadata get/set commands:
>
> 	if ((hdr->in_offset + hdr->in_length) > p->metadata_size)
>
> so a garbage value decides which metadata accesses are accepted.
> Initialise it to zero, which makes those commands reject every access
> when the platform does not advertise a metadata area.
>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> Cc: stable@vger.kernel.org

Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")

With that LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


