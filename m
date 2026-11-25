Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11140606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXjQETqC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZS144P1Qz2xwP;
	Thu, 26 Nov 2026 04:51:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::434" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795629112;
	cv=pass; b=js5iDtZKw1SpRyqemzY/6Ae5ehmmtVWvWkJoVYYN4j2AbkNsW9i+8SUIUSzUAUmd+wFVr9nYJddZqcz2eAKh1KnoKFX6uCS3auaQkunokdCJBSZObWk7A2rJnUSl2ZFw0vycPbY3+7n7Alyljcslqau9fB49+SY79c91/mBEDCtWYvBRTvVHYQ99Q3qfdhTnaOMLZiPeNge6iCljGuXavolp9MJCD9kl/kiMAp1wqoIecpoXrhc7Bi7UfORQGQXyBAWj1TnB42B1SOsj4jKWf2EuW+qHuTgYGlv6LSNLx0+PpEXj5dGSSETFoEwBxq7K6pfN9SFEe67Y5UmLFS1sCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795629112; c=relaxed/relaxed;
	bh=HR58Pgm1rnNyJEAV9sM8Zkj2jhl51J54Nc/8nPl524E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjvkPlVRHJbbjK+AMicxR8yAwkmMP4YysiKq5S14CRsEv9gA3+S9uglYbzZHPgkXEMttIRQua150brX0jdzQBYR05UzziQ6B56aVQwzNUH1EOoq3NS8qvWL2wpOY/S8FouGPmXs6pTdl/Xu0GWIYbP70wxFcRVg+WeqGk7fPSReDMrjcMhipoBZV/kRSAJszmpd/EcTlQwaVqAEkAlrdD24a5Q1DlTnZoszaiePKj8AwykVqWrnbW2Nyo72jiB5H4z4ZNJ+0PcU3rUfhg8kM5Qv9u5GnevIsvlUYv2ALuLaMhYIY2f3jIiSLo1QpWieXsM3bsjHGD/JQ+QuMYXzRyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXjQETqC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UXjQETqC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=ndesaulniers@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZS124bYlz2xLr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:51:50 +1100 (AEDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so5013385f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 09:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795629102; cv=none;
        d=google.com; s=arc-20260327;
        b=jIUCF5qN7rzJ4Xhzq0ltrWVYcp7m6RdzFFNZ0zHu6PO7tt8e3zvwrWa2U0QKn/0u05
         A8mdJ/QvJ40qIUIYu5vgs4WaRjJd41Yug/r7z0bERwVTRHFz3Vk709rqIUblk8uW/wuJ
         2pE+7FppFMnmrVWn+EZSbohkelfYlN+V4xAMqjlEc0C8dDrpZryd5LG1fGKv4MqVYuve
         fNMKcpqs5JCG1yPEMRPnIN8gh9Tsi16ZFhZDXaFuTod01nL3Snkb4cJDSAEUGUJA4A25
         Tulp5F78LW9z1WUBZ0J198+MfDcJ/83X6BgwrrC3u0asyBSLaTRK3bx0Two8yZUnpcWD
         55gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HR58Pgm1rnNyJEAV9sM8Zkj2jhl51J54Nc/8nPl524E=;
        fh=/87tt16RmIH+JaoKCViwXhs7w12kQWLNJSm+pmsHYh0=;
        b=OOleFjYTxyTOn7bG9qI5f2cBkmvCr1uqEs2XSUUAggWwQ84AEbHA3aewBqf3B8eKel
         6gun96IZ6yyDzRNnG/TVt9xDkfrTgngf5wO6d3vfAf5kczWS9fJ+ttqvDdaed0NIe6QA
         k/tp9QkrAc/7gy7mGAN21vjZ5G8zxFXIwfYJZdIjbASNa1yQFC20nDB8DqUtjq2TyWG6
         PA9918myIHGD6Rktl643WUaWXqPax0pgFRSFhM0ZBz9GYl6RMgTLA08Jf/YGudiSBT+m
         sb16r6Gi6DhhjjloCPxCElCB3C9pvzIcQkGaKTIyrriATvsbZw3p3E5yFEGWG4abOooX
         95PA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629102; x=1796233902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HR58Pgm1rnNyJEAV9sM8Zkj2jhl51J54Nc/8nPl524E=;
        b=UXjQETqCLj4iw+KDGM3uKNZxUd+kRJyESW94tgW8Od9iuWsA/BGipkGYunEXLISri3
         pvB7ymb4I5wz/7H6xLp4XdAz2ya1hWKmPNPp0vS3kU04jOJlFKn7tOr/WoYrzV9MMqhE
         pqnkJD9I9daZz1VQqBhEUmSb/ZLtO3/s/CMf4HfG2JxtAaa2EWywBMnutiV9YWS3f8Zl
         bqcQWjA2cu5A3Q/QzU2ark01COn2U/4qAmW52gINx8EsIVM5hIyUDMSulVH/V3fWqVcR
         ej8GaDWRGfvtlFzMLmGSGeOun4NHOkKlrIqbQicL/4Em2kACCxP0trzEcsDnsFoq3LVY
         V4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629102; x=1796233902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HR58Pgm1rnNyJEAV9sM8Zkj2jhl51J54Nc/8nPl524E=;
        b=TUu3GXaRVU2rjg6myWgBrr6w83eXnInU/f2lG/kZ+lkEFkECaA/be6ne/cvSxqUz0d
         4LsbbK9MGfL+763JpfFGBt1BcGMCfL+ZQYf6eoLkonlc0l392QygZb23JqgoGfn3GXmu
         E5OFlR0DMAOqt/wCfEjNGcfB+If6GHJUf0NEYClbfE0NCnTNVAeUIjw0r92dqGRcVsFO
         YEvGUSev4OSDZE9vfXInhrQtgzigRgQpRNPQMDlT1argTweV7jAhVfhxEkuvhOwpUuak
         rTVFoNPoKDiM+HmbY/ODvYQaI6dhkg/U8s9D1I5HzCKaczp3h4Sq7QinrqjHVjMisp6l
         37Sg==
X-Gm-Message-State: APuU4Z9a0r/QIVWeYGFsF5gV4TN7SlAzuzRsM1govGtZ1AO94Hi+E7OQ
	uwlwvFqMLMAFcRE8DH2ZFlFB284cAXhivKkja7V14wPri4tCS3CQFB4xhSfeRVy46SdJEB59oOn
	/KTeNT96BF5RR1tueyJehMyADVxdHo5wxyIw2eiRo
X-Gm-Gg: AZFdTZfadk/TJPcc4foQjmQQE1aZGn1H4ro+dTJJ7KFKBXB1vgalFT++aEjRFoT8rpc
	nw2ZJgvkLbQjJUNPJ2KwQzcf0xTeuJJglI6HCmzNnCipuUN4GP4xSxsuWxz9S5kP8xGBh/zcalj
	IZ1tNHz50zDUcLq5pLkoVzMqAE3cEe527KO64ZHuSHVGa+oJVUR2lKyYsfg7FOlp6TppWpUtuWY
	4Hz2z3KMX13C1KavbIFCfxYRtwclv5wGqST02VUQTt3mxD99wHrqnboTp2V+eZEf2WrapEli1OQ
	ivPXyVOUfJpjbqZtBR6woKdsa1ZUcMFqA8ecynWWjjtRTu4AAr3Df8THZn+pn/mtXnzCkMpQuNQ
	WCdvsJZ5PNG6aVpUHaiqLl0XKZg018wl2XrV23IdQc+8z5FdRxDQXcrm/hGia9vmyVZAWntIs5w
	ZZbkFSHTifXLKV5XsbP27xsvzD8UWtuo9Zy4u/C3l9rSSvStCVSjeN7R+1wbauFd24eiTuvRdS6
	VTK4B4KoXFwjq7PUojlAXomgh/Jq7bKkKiFDw==
X-Received: by 2002:a05:6000:2201:b0:4a8:663b:63e3 with SMTP id
 ffacd0b85a97d-4abaa976b48mr45498627f8f.4.1795629101291; Wed, 25 Nov 2026
 09:51:41 -0800 (PST)
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
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
In-Reply-To: <20261125174035.1412724-1-nysal@linux.ibm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 25 Nov 2026 09:51:30 -0800
X-Gm-Features: Aa3M54o9X1WdWJoRSllfktiwX4MIEHpsBnKmPf0mGd1gEpiEdAxkLV-H4qy3pQ0
Message-ID: <CAKwvOdkW5+xUCg-8Qp=1wJkNFXAJZTmTDuxBi6hKDuiNxUYiDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] powerpc: Implement cmpxchg128()
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Jeevitha Palanisamy <jeevitha@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 9:41=E2=80=AFAM Nysal Jan K.A. <nysal@linux.ibm.com=
> wrote:
>
> This series adds arch_cmpxchg128() and arch_cmpxchg128_local() for
> little-endian POWER8 and later, using lqarx/stqcx. This enables
> HAVE_CMPXCHG_DOUBLE and HAVE_ALIGNED_STRUCT_PAGE, which gives us:
>
> * SLUB's lockless __update_freelist_fast() path (avoiding slab_lock()).
> * kmalloc_nolock(), without which BPF task-local storage creation fails
>   with -ENOMEM, and the selftests task_local_data_race and
>   struct_ops_assoc (timer subtests) fail. BPF Arena kfuncs were changed
>   to be callable from any context. kmalloc_nolock() replaced kvcalloc()
>   in the arena allocation paths because kvcalloc() may sleep and take
>   ordinary allocator locks, while kmalloc_nolock() can run in NMI or
>   non-sleepable contexts.
>
> The lqarx and stqcx. instructions require the 128-bit operand to reside i=
n
> a consecutive even/odd register pair. In the Power ISA, the operand uses
> big-endian register layout where the most significant and least
> significant 64 bits are in the even and odd registers respectively.
> Until now this could not be expressed in inline asm without hard
> register constraints [1].
>
> GCC now supports this through the PTI mode attribute [2,3] for PowerPC
> and it will be available in the upcoming GCC 17 release. Backports have
> landed in the GCC 14, 15 and 16 branches. GCC 16.2 is the first release
> which has PTI mode support. For older GCC releases and clang there is a
> fallback implementation with hard register constraints.

Is there a feature request in llvm's bug tracker? If so, can you link
to it? If not, can you please file one, then link to it?
https://github.com/llvm/llvm-project/issues

>
> Additionally, this series enables PPC_HAS_LBARX_LHARX for Power10, which
> was previously omitted in the Kconfig.
>
> [1] https://github.com/linuxppc/issues/issues/463
> [2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106895
> [3] https://gcc.gnu.org/pipermail/gcc-patches/2026-April/712831.html
>
> Nysal Jan K.A. (3):
>   powerpc: Add support for 128-bit cmpxchg
>   powerpc: Implement 128-bit cmpxchg fallback
>   powerpc: Enable lbarx/lharx for Power10
>
>  arch/powerpc/Kconfig                   |   8 ++
>  arch/powerpc/include/asm/cmpxchg.h     | 100 +++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig.cputype |   4 +
>  3 files changed, 112 insertions(+)
>
>
> base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
> --
> 2.52.0
>


--=20
Thanks,
~Nick Desaulniers

