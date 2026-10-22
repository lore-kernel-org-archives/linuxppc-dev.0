Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD3606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvEFJCMO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9TD634htz2xwL;
	Fri, 23 Oct 2026 01:33:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b129" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792679622;
	cv=pass; b=O8pnITjEmThUBHkYHAatJz+vOu7hu1vSaQM6kFPtGqU3DnQfGvbYqG/reJHjcv4LoMAS5kd2o/cEFi28nhd3obHFXMSLcRQ60v6cgEVpydLsoapfI2LjP9vJsM+Xu27QUjN289t+4TbIHRUEuyAadEs0PH0w7CTx6rKpTdcFrP41ij56rDtz2fxfoIHvUUy3GDvoh8U1a7zwMdiqRyc/hndynXXdLe2oSHaOq2FJ/f3MUYi4u10nfQG3SfApCXa6d0NyNykwXd/QfiiVjEshnn5SD3+P9Td/CJFdlq0kFVhQJldOW03vd2QhRBq9gvL24qYCMoMVDKmwYWs+ZkRypQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792679622; c=relaxed/relaxed;
	bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4NPhgUN6QaqQHK3aQIa/tC4OqoxYrzVG7FenFY1MjR8tRnKBNdbTQYqoN7CwPnrdFtk7vTs5l47dhfgEaK7gPZVpMuNw9X0okO+hAE+Fpg1ffdihDLq/D+EML/02dITlOQ5U+RHYZqryS2AwwBBrVLFt2Grb/BuPM8BODnXV9vU2pMghBLhzO00lQtB+ruiz77I0BYeDtR/MMFTMOu914+qY+yTfCG/Rk+d1KOHDsMnBrA06nbSq5nGWF57BdVqt4wRDIjr/UhW69nLbO1b0tq69eToIl1TvvWvTOQvqCo4Ux25x6VLcNP9+J4ZJO4MOHdutFmdFFyZPOZjl5TBXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvEFJCMO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvEFJCMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com; envelope-from=ryabinin.a.a@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com [IPv6:2607:f8b0:4864:20::b129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9TD46J7Zz2xjv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 01:33:40 +1100 (AEDT)
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-6790c2eb033so279273d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 07:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792679617; cv=none;
        d=google.com; s=arc-20260327;
        b=lpfcoVMkAuWYeIHjVKcrvqSr/HlMDeD470tG4EcbrAuyucAFmGw3t6FYzSS+ZeNGM0
         /SXnik/xa92yQDfQh1/IopTJ2Ml5kItm40qe8jg7K0FGNdpn6IHeTCUsC6LEKo8FBMK1
         vSIdq7g+/FxbWqJiH/Krm8x+xQ9gpr0ltUbKR6n4diTRcPrHMbCNmmcjvXi1g4FAFkrj
         sGiMcqwQ//LHMmi+Nw09x+8+LuiLjnnLXgypt9sy2yj96s0+qMZGJElgCKrHWmXAI4Oe
         MwPoxeB9cYmFPJ4hx2qP9MmHeIlI5ymRFaRgXQbaEMVCUbjanZuD4UTQgd4X1rRzho5V
         3YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        fh=oMbl0x2fGeeLYZrG0O3p6J3mrs0lCIFARb1bxiqmj4k=;
        b=dpwGn5sGIarAgXdQBC5nQhXFlFyKV9GNHLolisr6J/2k6xCtNLlGk7RILDTh/9WU/X
         VP5BJpQSv3MX1UCJrZ+mVatCCFuhe66/X7QIPshBpfNKTGrdcSHSidqz4u151bU88q52
         /XjUl6n4FOpHm2BMhLMBaM9iRrtyRGSWVPJ3zznmqsDnNdIciYvHPqztPDo+DdXhffSR
         sq2C4VuACPuRAQqeU/dMMLbQgECWhD7h5p6Hg4H2VJp5M9PPUosjePhDNBbuhozGC5df
         TnnOalhSo//w/ImfIQL6wbYWdQVaIy/9LnL9lt7/LcxwvkWNlBPvEpDHVrrVv4DhZHXK
         J/Ig==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679617; x=1793284417; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=LvEFJCMOUIUbSNKitKsFRZqwUnMGZeAJlor2zkVLbEeOuzir6ZYmPPb29t0kaHpRO1
         m4T+vv76J9QeYTVraSyizCBDijGdlWzUeSNk7WfAlkaU1UO/2K0H5O3tbtPhhP17g2wH
         uZIiCmYO6Ts/N3IGOYHtkZEwo+5gbOd6QUPEeQMZ+X/qcUzcxn4o+JEIHr0+GLRYUYpE
         xb4xWIfLp+EuKbBd9pcF7EMpfkEy14GivxkxkfP8gPBtDxdjkPjdz2pbAH4leVjGYJM0
         IYbtM/F78TH76sVfVyP2Y2ng5UYU2wstZW3xN5JCOR9ACh6dIhqdHHUAoqEUR+606mHb
         2Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679617; x=1793284417;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/nVz+Qmk+Tq2vmwCZBWANvE9dUy6Fp4Dxh9VLxLk90=;
        b=Kh2rbyPdG7s2m68fAO8dwco6vtv8Tx1iGxZfhrlNv/nyFAqW3QP8lnvhasWL+qB7zm
         XuolFInr7JkUpK9k5K76o5QjP65UvmB1mIb+5WzoDBXNprfGUTTRDy9P35fReCh+UWU8
         2F4PIW2EVuTmWpPyM1MovmVuLGTCPGciHFjWEsmfW6DYUYW18JqBXxuGfB3zL/J0ikWX
         vBWua6QEKDmjUbTJPlUwQMnCWoqJu692xbOXGe1pxbLHqiH3msnk6fnn3nKSH0hhvFEK
         5Qb10ltBIKqUvHKuwMFkjhRwAbKKniYfVXpR7yIQUtnheTW8MMEbWZdEgX/LKaCRgLz5
         BCrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRMHYZidfneDdUwa0eLkIgortGob8gDEj5wRmj2vi+0/xCFrhw9EnHuL7dEr9Ursy1K8GJHcmU2of33Ok=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKQsDxH6OxVtWmgEuOAAe/5bvY+OK6pggW82ScDqT1qYMGlUuaf
	AwNL0wVTsjIPGItMMU1Jh/Fnxmq5AZ2pPNzduLIu2tLqcx4z4+h3rwcjAhGKWF4KBsI66iH3iwy
	Td/yFHLyfmpy28DFVUE/+lJpIE/baEBM=
X-Gm-Gg: AYBFou0Ag4EUCyj7Uhv2fSH28zT8q90IneJ6mYFtJVMbsDbTEXVT23cSkFTRRNy+wgH
	DGy5M1IBOvnJQIwCg74FIsoBt4AHegN9aYpNGt7tZMDAvdHPO+LxxzHX/rFVlUd4jXv0xn9v6HG
	ePQxotx57NaXNMp52lseAkVjwMCA/v6KLuxgsy0oX55ZGW606M2KOVsYJdceLrHbis8UWrWwP9B
	yV3jUP1usiMDtebZrdsKp/f5mQpSOhpdgoWxU2xPRDsppft1a+DN5ECtO1mAAMX3OVPVPdD2rps
	h+tfngZD2GoC1IdVM+i35eS4qHpAMcbSXoN+uEvFlsCYreXmSUYn8h01JxRV44B7imcWrt4l6cA
	JqnrTCYqz8ORBvKeLWVQE/r88W3myrRGXSjk=
X-Received: by 2002:a05:690e:4504:20b0:679:9e25:316c with SMTP id
 956f58d0204a3-67a0e4f7118mr3858513d50.5.1792679616649; Thu, 22 Oct 2026
 07:33:36 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 22 Oct 2026 07:33:35 -0700
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261022021820.1789083-1-odys.yuan@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
 <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com> <20261022021820.1789083-1-odys.yuan@gmail.com>
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
Date: Thu, 22 Oct 2026 07:33:35 -0700
X-Gm-Features: AclHuK9KZnLcDmcb3UzjebEw_JXnOgl4qhgoWZHIOId6L7KU5VJDln5TqsxLBMU
Message-ID: <CAPAsAGyA=WG=z6a==N3O6oan6WVmZS-VrxEA7SrxRQs5d+Dsfg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qiliang Yuan <odys.yuan@gmail.com> writes:

> On Tue, 20 Oct 2026 12:58:54 -0400, Andrey Ryabinin wrote:
>>> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
>>
>> Why it's open-coded ?
>
> For the same reason as read_word_at_a_time(): commit ece69af2ede1
> ("rwonce: handle KCSAN like KASAN in read_word_at_a_time()") open-coded
> it "to avoid having to pull the entire instrumented.h header into
> rwonce.h". I kept the six asm/word-at-a-time.h headers to the same two
> small headers, kasan-checks.h and kcsan-checks.h, rather than pulling in
> instrumented.h with linux/bug.h and kmsan-checks.h.
>

That concern is specific to rwonce.h being included from very low-level header
like compiler.h It doesn't cary over to word-at-a-time.h

> Thanks,
> Qiliang

