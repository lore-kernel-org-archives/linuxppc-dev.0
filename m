Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B2606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGGJy4MHdz30Vm;
	Fri, 30 Oct 2026 20:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793353170;
	cv=none; b=dd1gdaH1rmZ7381Ka75nWs7q/GZhwatXfNa+WRIwsutJzBkdVsXUXrQ+sAQ5sf22z4XgqaZB7EdFLYa0nl8FEyEzMjN6NkXufoN/2aLs2TzaBzsOjqhlgyCrwYp2qxCQxmLUqO5gcsAOKOYl/IntX9ldEo5rwP4qOvzc3hL0A8P/7aqe76PZDUBVu9GiuGBwojyO01/59FwR1BPp8eSt7pN0tJrj5+XXv6beFcjb7xBB69sSAJt6W7ANnum5AWQBmcP8if2jVkNKI2qpoKwsJ4pydOF/CDUkCK6Qe14hv0uhIdbvadLWSDwu5IQTqn0oON24ufaGOayZTQoRPUr+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793353170; c=relaxed/relaxed;
	bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEvWcb9YYUbPifI4s+8vxpHy0padHlD52/rMCL3xpx9TftYdORUiuFw9llWUdec7zGQs/r3FDarRjnBq3fDY+jChj/rokpehH0lurckZnBA6UzX+TOvagvDyEa8s7JBclCpY7A8pQ1DeKo2Dv/LYpG5DNVS6pg1iVxWClVUjNFrUO95BOKdZgu/mlko4nT20MJL0Jdiv0fUT3+QoSVT6snV2pzCWz12mqccjejFQBFz0IqQkD+DU5BD1NrbyHye354V02L6N1/Md7LOoD+lhsvwuVFf/cbTOPMjC0eAGtAE2NBpSYavxxEWJURpzVDyXShqkQsrWw705CQC2DK+l5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.45; helo=mail-ua1-f45.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.45; helo=mail-ua1-f45.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGGJx0kR2z30VV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:39:28 +1100 (AEDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so1506145241.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353165; x=1793957965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
        b=VRY4Smd0/7Qu4MCP12OHwf4sdm1SSlaeFOlCW4i+4vydcry5I7GhCmEFzPiixLtAL4
         MkoeEd2YreacKGVFE9kkszylVVJRv5trqG6afH5aHf14W+zboRGslBEWkcFnCGlfJ7+f
         wDwPlKtWX8F8DNyOYm3znac6a73NzPjNnOetLHpvfnE4JXsVfY+Se+QdQD2n5Z1eB9Tr
         3R7cChozif/Mc7v1nLmf4W2kmD/+ZUgVJ+50tm0FbaHkub/AuBd5OMAiIJAugdtIZl/P
         /TC2OPYasCG9ouuddxSimEqB04Ychkq0l2qfG/528bsE0iPRGzAQwiWSYG+NKZuRN6Ij
         ZXZg==
X-Forwarded-Encrypted: i=1; AKwUvBymDpt/m4gZdqS/rH2P7vXf/j5suOiBOZDW1YblFQDGmTeRG8562LZjxyly62Wz1uhzbxcdGKOnYiRxEms=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL+2l10/VQOaOxMQ2uX0law9owcbK2jtHvb1FHR6gFe7Qwhg9RI
	T2D6Bq2bw+5L7vIqBx6imWPGhdEWx9CYEp1rnhcBXgWn4kotOqqtvlNNjrFjTHa5
X-Gm-Gg: AYBFou06bvkJ57Bx1wKsRLC0frwdhmf89wB3Ljb+BbVcpTauLu2Ic8BAzmWz6FcAmMu
	g5dUhwaqBj/mV4/UZFr0fDqZ408q6ekIBRmwdRsgDlVWe93T7mpKN3D+mp84EMnCOkFNuExbX2Z
	E+2dGgp2vZYIFtZS3tGS1mhrLPj8L9px7YBWL7l9DDym+kV46QvOe7qCDnUyFAM7lKDwB8fouQ3
	zSR3s0w6ISG1hHlgR4EChmYV3/KbUiONW2heTu6A8LyzNNmsGBAZoGHfC1WBO8YUMQlEhvHZXE5
	yPGkaWzOlYHM5gOYjJvN5tmogzGqjoh5lJ/TEhVGk2YSw0Clok2EXmVTD2GPg4REJ582GmdsnBg
	widWuk6iubemo68Q2de0ajX4Sn10EvFO/bMAIQZItLb5LNHVz9JoEEc5NjowIHUlx4YGrqs0Jp6
	SQHmEFlF5/9dIUtGonLgFWh8F+2tVezjm8lpGy42leyKrcYGdmQlPaJbwzP7gdJwsmi7NSs7W00
	MFkiJP47+lPs+fFM9WwYQURSauzmCJV0MKZUMvMVRziuytJQgIHLLn7rY4WdhMMO2VL+SUYzGAG
	ujwidOeoCWDO+hB+CAdpzvxAq5fX/bFdUbEk1pLSTb4XRR5V5A0Z3nBGQcohCgxdZT8=
X-Received: by 2002:a05:6102:5cc8:b0:7c3:874d:60bb with SMTP id ada2fe7eead31-7d072bc027emr578816137.5.1793353164923;
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d0776039e9sm1515346137.7.2026.10.30.02.39.23
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:24 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9909e82513fso417829241.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBweToG9M7JSZ4RU3upetLShPsmdjbuJIoSqAKE+84dYtmItHBAUtsNW+SBtr3Ey/J5ebW2PZHUcqqpKv6g=@lists.ozlabs.org
X-Received: by 2002:a05:6102:605a:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7d0542ccab3mr1591386137.27.1793353163338; Fri, 30 Oct 2026
 02:39:23 -0700 (PDT)
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
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-2-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-2-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
X-Gm-Features: AclHuK-5feC2ixWlfC3xXKJ1XowEcUrdLUZ-UGAaez_2WzCy_48TVc-7hVrg-7U
Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: remove pagetable_dtor_free()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for pages that have gone
> through a page-table constructor, so pagetable_dtor_free() no longer
> provides distinct behavior.
>
> Use pagetable_free() directly at the remaining call sites and remove
> the redundant helper. This keeps the decision to run the destructor in
> the common free path.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
>  arch/m68k/mm/motorola.c             |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

