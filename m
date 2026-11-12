Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DB606A330
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GZEiuxex
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1Lb6S8Gz308H;
	Thu, 12 Nov 2026 11:22:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::835" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794442967;
	cv=pass; b=Ptisw43F4xU1VgDwcmCqTgiGCF9EUOqaJ9CI+Lo6uJRFgrLFYmpFbUJV7BddfD3BsPgDbeThvWZFATYWncTkT6qzMuKBCzi8uoPKKtr6gRw8vlUDnLtzZqfsPUFYtCrX1Fo/MqrP88Gsr774hKayjVjVcAhdqhE5Ww7VGSYMljs/qo0ndi+vxQhf7kIGBnzLZHcfI8Ka/6e3lcVUAUBQcJWFUwBNrW+rj3s/Aq3wh5t/WQLYzrrUX2NbETTCMoAzpA21qWsgBZTCLSh/ZnZSQFWU0FLjzgu1mcpsK2z9LsT0UaE7Z/blwvh0/vBYVdWxT/0IVlC9NpJL2BTdEA626A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794442967; c=relaxed/relaxed;
	bh=7gFvsNqBDXUT4BnAgicfRx6qITAPLA5lFq/xnuZcz3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEkeUhNyQL7Tj1E4Va7Wdc9Yob1i9U0iJbMAUEBaIyPvYX2AZRC4ZDCAvjD+ocLpJCc0keCqSCOvBOj7NNSKEwV/W9S89X/8DB3se2RFBlkp6bQBUoI05oJcIusBDBagQ84SjdNbPdRfcyFakM3hDq5YTwBnm7MDiv5dluLHONnW1MvY8DWzttr/j12CBnrgsZHU84pxBeJzRJTQTWz1uG1UAe7SFI/IuU9SUXTub8arnoI5YJfTmfSKV74atswDCfWRalH9PMkSQq4ULwcH7ynMQYTiFmbNjIQ1+KBTDHH0VHVU1NFj0t8LMosJF2Bu1NXE+JUoCOMjq6BJf7seTA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GZEiuxex; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GZEiuxex;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1LZ6QTVz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:22:46 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-54492d8a988so55111cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442964; cv=none;
        d=google.com; s=arc-20260327;
        b=kt4/p/15jHZgInPDuIWBeA0FhlNhM5WbLPoIQb8AScs95JP9AAeeZu1Bz6Lcst3SD6
         wWRYCfyIYIPRgO5vW72vICfJCXOO7bRmtKp7/SE1duyZ16UBTKOmDytyyMYCdoS0p6us
         2ykYrcGeYFqaypBCLBWojB/mTIxIPHe0wxHvpDkSoCAhUnNzScuHA/JDi0UW0YtXLGgX
         3NAvk25AMlMd9Zk9G12WSM74Hcf6V4kiDJirdcdpfuEnm/iuFpClH0cOzuOBHVeXN6p2
         VpbJsN/bnNMM7wfX9KMfj5MzO7+CPMr5CKe6P/td8CbYOqG8joOLqJkJGyk/e9XW9Yzx
         4PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gFvsNqBDXUT4BnAgicfRx6qITAPLA5lFq/xnuZcz3Q=;
        fh=M03tyFqkDD1AzEw4Qvhbz/kAw2aILlrSwvB4VD8Yz54=;
        b=VCGkOcdwlUQkakW6mPxcpcEpL6sS2VFRNnBbRnatwCxd4/n4Jc3yXyNw6tJznI6+8t
         ltmya8PBhdFHHCgwV8zq9HrmU12emBAWkw3V6/osH8YmqHnQTWwzCx69LfY3e15IOAdk
         Xc951AJ8ryRJ/NWVnmA+jlrnn0dTkStupd9tbB1I5Ff7OCkI29x/U9I1N7v0L8mJSjGu
         dLgnf1ENc9NKWp781BWMRlvpfLdjZbYNnn/JekyhLhpXf4C29KlEkonWaqCGHt+U4C32
         ybG2hsW1vrJgMZrT9BHAPqd2itRPgvFJ3uAOmtgoW+udAPCmwfxUz4C80zFt+5tXynb2
         r/dA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442964; x=1795047764; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gFvsNqBDXUT4BnAgicfRx6qITAPLA5lFq/xnuZcz3Q=;
        b=GZEiuxexRs+ANYXglU0vdVL17Gw+KYMQnnRNFmFEF5kM9BqrCpcd46DTHT+2cJg/eJ
         YAGn1cXmnPDeXKEPj1zaJvUOco/ELiFpiPa/MenI3wpCHU1r3YPWCrvxklNlaG7xFCwv
         PZYBQSHPv08CROBxHOo308F7KS1H81iLqT6HBtB0Y8rp0iVfOyuD+logqpP/ZkuHx1aJ
         1jH8TCVEFIUvoa20rswcJ/dWKZiGna+j3mzQJByqiFEfTn/TGVgVgNR6A9vpPwq1Nd+D
         G79+cmiXCF+jtT+y8oEgBfucPv5I5EcdKxb772Wn5cbP5WuVYZMarn36ykG2tLol8Yl5
         4yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442964; x=1795047764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gFvsNqBDXUT4BnAgicfRx6qITAPLA5lFq/xnuZcz3Q=;
        b=AKGzRauM7sEf/TawJSK3aZyMLNaW8Hed0AKNnsp1uEDd9pdkNhPE6ZTCbW0IkqqiR/
         yybTEpfWPEs+aEm8CYow9NbqTBjMjqCJyVi2BInjntKP6FGPAmOO9E+Y0G91HdVrYW5W
         O3pGbO6bzL+xZ5Leek5pSJso++J9L7RTdB0LPK7F+QdOGcFmXG70cacn2lKNmziFuzW8
         WM/CClLaBSAavGoqD+0srfy2gZ4qxiHZWGh3klBdzp5hIalbb8f+ntdsbETTfWgaOqzE
         Bxt/JR1stMQyfSLoVkyTTOmK3HK1LzXH8eDBko5Uxv6DYsAhhcEMa+R2th7X7pN4Y9QZ
         3vbA==
X-Forwarded-Encrypted: i=1; AL+hErFJM7zANZoT5om+rsVyUc9tjVsabEysWmYYf6RAaBJjBI+73l3Tv5bHoqzq39cHOpvjLxhAkqmuPmC48zE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z92iujXVAoAbmudVSyxEuQMRPbT3EsNUQnZgSgFIIGConaltXD4
	BewuS3Igx8ZIzSnaoU2i+RcTMYundEshebGBjbPXQZyoqfM8KDym0+Q0TtuM9PDnk6iB+auOsWB
	bnOg/8uzeg4xNn2IvTHUBXZxrRJ7whh+E9d06Tnzu
X-Gm-Gg: AYBFou23p8fDLhnKa3fRIBJiP70QDUZ3zVXJGEROwgxaZ3a8vOfH684tJC+nrkRHmCm
	KRQ3gD/07zB9oKNU0JCvh5UwPz88IBhTIcJ14Z6/jTGg8yiA/8bR14cJWMESXz1n6tIPt02kU9/
	xNf9VnGwfMPXLTBYmn7wYiEce8YwucDb1hoi+6AotsZYpQJDQ9p5wqq1oym7ieVxF4/Kniiylh1
	U5zmzPePGOBd0gSeHae7t7FlMIQnikX1WB3qBbWOif3/s4yBglXT1XqmLfiFoZN4BJvveL9RlEF
	Jn8RWfC9myaMCoc0ahz7IxMm2E6jOGdQt0F6XPufVB3/4yFnrQv/Epj96o3zAr1QGvJW1TaCwhJ
	XvuQu0j8uSSuwzXaF37fX9r3QQo4sU7X9tvLQPLkVBDm+gYngz4R30WKOWRkquU271CmyELqrGp
	IJiUdsciBPkB81RW8TqufH37jXNg==
X-Received: by 2002:a05:622a:a15:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-55990ed99a3mr5033851cf.14.1794442963091; Wed, 11 Nov 2026
 16:22:43 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-6-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-6-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 00:22:32 +0000
X-Gm-Features: AclHuK_CzL4RP99FDahiZaf4bltPjfDSR925sbwaiHf5mOE6wBtoi0bQgJsZ6U4
Message-ID: <CAJuCfpHWe6gB7rYvTrW=ufqPtFtquGW_u2v1yV_9uuXtnn-KbA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] mm/vmalloc: BUG_ON() on an unaligned range in __vunmap_range_noflush()
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:25=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> The PTE loop of the unmap path stops only at addr =3D=3D end.  With an
> unaligned end addr never lands on end, so the loop walks past the
> range and keeps clearing.  With an unaligned start the loop begins
> in the page containing start, which extends below the range.  Either
> way the unmap clears the mappings adjacent to the range, and that is
> nearly impossible to debug afterwards.
>
> vmap only installs page-aligned, page-granular mappings, so an
> unaligned unmap request is never a legitimate teardown, and there is
> no way to tell which pages the caller meant.  Check addr and end at
> the entry of __vunmap_range_noflush() and bug out before any PTE is
> cleared.
>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 86fbb1d2b27a..0565cbfe325c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -518,6 +518,8 @@ void __vunmap_range_noflush(unsigned long start, unsi=
gned long end)
>         pgtbl_mod_mask mask =3D 0;
>
>         BUG_ON(addr >=3D end);
> +       BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));

Again, not pretty but I don't see a better way that does not involve
adding early exit checks to all its users.

> +
>         pgd =3D pgd_offset_k(addr);
>         do {
>                 next =3D pgd_addr_end(addr, end);
> --
> 2.25.1
>

