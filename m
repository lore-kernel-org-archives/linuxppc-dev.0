Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3B606A31F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMNbckb+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8Jhp6NcVz2y2B;
	Wed, 21 Oct 2026 04:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792515962;
	cv=pass; b=S7Mf0Z/n/I6qlzAvr2M9P8+MDruN+W5BsKsIw2/jJy1ObgTQtKBBgvZY94z23eEurdSz4uaP1DH7EIsUaqBatoC07JlCRWwQ2jQJeUvfpgMVdglphde2XnaD1L85qS9IhQ2a4ueJej6ZRC0J59b7dOsJnwyV60BGNSSNiN8508C1AEPXW1d1cprHOYVlgsLpPKAxzeUMVQvo7e41d/myuvQG0ImvbwQ0Wouicbxe2s2kwqS1EyIvNNHcXaJxqOnBkiSaPM0xSzJxQAe8N4nZ+dx0uQptXuxfyclDvnWgIJo8TEl1F6d0ckDUMHKb2Ix4kDRfU+04VFUmErnmt7rn9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792515962; c=relaxed/relaxed;
	bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=getJ6mEzPRgBWdmihbr973gJG5Lr94469G27mNGpl94hrmP06ldsdfGxwExA7miI6kO50CVLkcSYg4MWum6q8dFtv012lWqfx3seT/lsDwP2CVBpGfffOvii/PzrIszHB7W1KJ6lbnWkI4cidLHe1nUxx10UEu4Tx9+uuvXmLPtSLMqcospKDN69BpvSU0S5GyjkffHIKP8eq7oTem12rOiVq82jNRx3+IY1Og7O8ws+8xRmnUzMVqgWLYKZzkvz6nTiMwzEzoNiyDrAr9qPewzv9wY4xikBXjmq8fdO2umUo/BZd4KTqkmbRsH5SZEcBYl1dNB1R8fdqM00EAIynA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMNbckb+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GMNbckb+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8Jhn6RJwz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 04:06:01 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b126b23502so976587b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 10:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515959; cv=none;
        d=google.com; s=arc-20260327;
        b=JxSf2aUm0/odx+n/ZezQCr6fV+a+25/F5ffJR6WIIKydutGS6v7+W+N5M2Sa+ghphO
         SfgZIHemPBlVOr0JIv3o0fRuGWfF4rsMGr4GzsPvH62SS/yz/BenTg4Lo1XgYg8VZAWy
         P+/pi/t16KvmqyFJh3ANhRQl1ZpFOhzyJFksjSVPUWxNqhwDQ3P5qsKnAfdiMHhaHm83
         UMnA1Dlw9MW7uTeehMz80UTTMhcZkwMZt/kom3oKC6EEfC6oHD70IF4Zc+jUXJibrPFq
         G/JAi6Te1/MeHIAR/Il9sRIcrH0U0CldygYlAmVFcTK/wRxk7VYIz5dgkBFGQUg5W4XI
         2bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        fh=R5yiqWmx8cxgGGbvauZsJYVEAz+XPLP8ws9L0O0Lt6s=;
        b=FrblKpcE3nLp/VPtGxd6ogowOltFOfOKo2+/Cx/Xuh5kofA8QJ6djs+/Dq9f1FJ/hT
         Hbq8A8p+do/qWX/oBgY8XBYVkurKlOaPy975M3ur2+bDb9W6QJ54HqXpoiM+Fu3TAqK4
         PZkAUMCL0VCzJRgVux/w39Xf1JBhFDAlOyYwLoay3BsnnoYkwRUAW3sDdjsu0BuIABVP
         0CgcC5woaj5B22e2GxP7A3JwCTr/vZwRwluFdcheArc0Y1OclOL/B4gNXRtqSTVc02tm
         LVhByOY+yGl4a54xhg4xmKcwzR6hAEiFzkdlFqfJN4pHjgpmzvnLMWuwK6ECGq2JKkxs
         R0/w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515959; x=1793120759; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=GMNbckb+ZZwFh84GHi7rArVCPnneshbt39UO/R37ni7922TcAks6tyTgyCX3VzgnyS
         HQeKWYE9y+Cba4xB4NEQJSJHJCGsbWhhrw6+m6pgdVfNTpRnJD76qid9dQR3DkiJMpH5
         AZTBK6oPT3q48tUN04P4XkiMJWyNzR88t64GtzeEuGYBRFUAGLjNF6//gk3d3r+Na2Df
         S2eQKqC4YkEOpqscIPctlFrnDE++387qkY4E6ZSDskmMDGY/vXwWoljtwdxK7l9QdwZ2
         TvhNdqa85/OULlXrTL1xwjTmympKFnlvH+HUoaABkuqvDZqii5L2I35DKc4//SFBTPCZ
         DjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515959; x=1793120759;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CawfSGUltcTxf3WieqiwxZVbLh4EPDpBCzdr6aE2BVo=;
        b=Iq/fJcjNzxwYarGMlimlzfg5s5aC3UQjLI+yIePt9+iKX4Gxl51hYE87JnvojVLtGi
         fU5ncRVrKwkiFGhPGoXyTHsvC0u5UCzFK7jOhc+ryaNeVbQUu8q80Jimsrk0ZigYUQI8
         SsYLUphO/Hg9RnyxhpsNdHOi3cHp+LWAnU58ccEvdVQvw/kjwd96B2DAQxzr9rXPIwMW
         4H98JBHMiTApoEQdOTrQZP7SN4Sk9NVtVQ+JF7+A6lFYMc+YLn9GX79rPMJG2xSapiZx
         XTgQnthe9lZFYh4toEoSPPrQl8e74sioRpLYmNXy7kB5UHzIc9tqzHHlhiMENklDxVXD
         ZrHA==
X-Forwarded-Encrypted: i=1; AKwUvByg3wdchorZqSlNlCDnkC38aRYE2oHkiUrSDUSRRVmhVu1I7REILTsXHjY5Ul8jjeZGW8b9t6Huwq3Paz0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIsEvQMh3MQ4uxDCFZKJ3yt1dY4p8nCtGNnhzRXHnObiMgnwN8+
	MXPw+4jzXZHrEDGORPbqxB/UrOXVfRvrjDaCPEfSOOZLw16h/nwVj1xZHDF5DOBurIepVDJUuDe
	eBWAm8BJVrps4z/fjFGYAWO2B7/sUrKc=
X-Gm-Gg: AYBFou0J3qj1IUFVR+sc+9H6zw1t36IaLnvoZ2vGEeUysZhVQZNN9eVrN1tu7v+KCxx
	HGynWFqjE/fTmiJuoQe0zMV9bY2AldnfvcPQDdX/IbSY8u/Fy6LeYbahuB4FFw9OKXhAAAxC3J/
	wTE7ksR7ATJnYHdhPBUK1ZwXO46w4WnDI3wIDE5P1fkMMupnWRgbEcvWoFHU99cYt7H7rGishIB
	VHGG8p4j/i2ATg5bX/zL8ojxQzPxXymcNEljkXI+4xq23mdF2Whtnm0C6xMOCFExHe7ljiTJKG/
	FUMc6q4uGm/T61HLYree+6mqpeLJtAbCGbaJLDjOVcPYjzuJtSO8Og==
X-Received: by 2002:a05:690c:6087:b0:8b0:da84:d1c1 with SMTP id
 00721157ae682-8b0f1f1a89fmr64960787b3.0.1792515958898; Tue, 20 Oct 2026
 10:05:58 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:58 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 13:05:57 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
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
Date: Tue, 20 Oct 2026 13:05:57 -0400
X-Gm-Features: AclHuK_DtrU2XCq8YwSMY07NqOt7wGt-hW6PGZPkgwrcRUr2dimhQIUPQ6PwL98
Message-ID: <CAPAsAGz89aKUHzm6U9PQZfkGq-GnWsm8AYHeo5+4u34LHk4uZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
> does the word loads of the dcache name compare and of path name
> hashing.
>
> None of the KASAN test cases reads memory through it, so nothing
> noticed that KASAN did not check these loads at all.
>
> Add a case that reads a freed object through load_unaligned_zeropad()
> and expects a report. Skip it with hardware tag-based KASAN, since
> arm64 turns tag checking off for this load:
>
>   kasan_load_unaligned_zeropad, x86_64, generic KASAN
>   without "word-at-a-time: check the first byte in
>   load_unaligned_zeropad()"                                 FAILED
>   with it                                                   PASSED
>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

