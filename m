Return-Path: <linuxppc-dev+bounces-16737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CE1E81BA6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:52:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8jk50nqkz2yFm;
	Mon, 09 Feb 2026 22:52:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1335" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770637965;
	cv=pass; b=L9vBHRbMFrtBGzpyZlFcY49efQK/Wqlsr52DP/HbC9w/HvHJNPnQPRsRtH8chKfPDRGNRXpIU8j42m6hkh+oJSBtV0UDefZy4xfyHQEvtmoTEr2cSqYHU7jBuP/mJqTVbm7oiBmfYhZ7eDSAGCSlH+0/stXf/5npFTIfnwoJm5Uwr4EQLQqdEtvtofOvBnvguZHa+vMN5PMk0lls8Hz6nXQcFzsK6ujYaKYGWgSYPC/4FCKkt7S2riiMmHdKemg++LiGJN8Us0IvoajIjhUURC86XFgojAULKl72eN3zhLWQMDlixrx3YrJEsltDGpkANshDRM8U9BM8+epVwmjwuA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770637965; c=relaxed/relaxed;
	bh=TY6n6lWqMAjZ459keizyTELNtiM7fikiKNyHcAG5eMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/XXakfPcJv5EsvSpdjrcpJdDsHa1aMdH4epe2uF68wP+LhvCq+jCvs0EBj04+rNS9WD5PU+UczfbAZsog6jquSr+EN0KcMPaIcykjvmDHHNsxY2TA5gzvQif2R71fojq+GB5KKUl3RhEiMDVnCbIBucPk9To5uJgfCYj/aMKrBWw9zRlh9iDGFUV+ryuqWccv6QiA9Tb2/4mtVDKjPAjk7Xv3u/PXX1LZwya3S3kNRIOecgN77WJs5VNa1wQq/1MLl5nJRAktFhU4LfT1S9f15RgQc5hAm6/vkc2ujoa+IM4m29e/IuhPMdKKSEZaKDFtpsBsLwxUJM0kAjqAQWDw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QXpMAI8i; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QXpMAI8i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8jk3621Xz2xBV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 22:52:42 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2b869dccccdso93468eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 03:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770637960; cv=none;
        d=google.com; s=arc-20240605;
        b=hmagaSmIfZPpnPrVtyCDMHPeq0oCirtmEX8T6tlbWX7DD3SQuZQ4Of1yQ1yQ+YhUoh
         Up0I3t1/yLwpL1DcoAvSqdEZdzm3chhKcTT9q4i1OgJpUkGAjGAwgeIK8wTB1kYvCnfr
         vj9cO8TB98uKIIKny5//EIdht2KQ2H2Ad2oppYD4KqqLYoPnIxm+nqr06aQl4VR4gSIL
         SVXKC5+oArHJj8KP1GS7/SYrk/o1fzRM8QrldCbP9HK2DAM8AzMNPJ2PAo9oNBYSwLXw
         /KRbl69BueTARV/G4e2NPBpuycoD0vN2HayfRWHtp93d5S4FRWaJi+MPQf/J0q1d8Ard
         xi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TY6n6lWqMAjZ459keizyTELNtiM7fikiKNyHcAG5eMA=;
        fh=PmLg0z8pPGO5NHDlzLPDua6XvzubxipbnfMVldkbRUU=;
        b=dmVF0bVrmsAj0we41+As1g8MixpxBTXC3Y3LS3ypSINMHysGJYK96WPog8BT2C3IJW
         hX6hH0ZYEiHZhwbU4H8T5h842je7fpmEsvta99MVLggqwxsE/E2ep77VBVAr2Ss+ueec
         jIAFrg+lVklwViWHzNAi+EpRZt0Y3Jv3C/XLf9bKXrDmW4ZEj2AXed5HkbROOXin2VU0
         94BxZd4SHMRTIxu1W0Om1GsPyb+nRerNegbUpSOdKsOI6bmBrhma6Si8SDzFbdPeQ3qz
         jOYX+TWvPyWLi58CCjq1AEiel285EHqWd6Xfsg49cb6uD6YWYUl5N+gkFYDxdJHI2ptv
         pypA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770637960; x=1771242760; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY6n6lWqMAjZ459keizyTELNtiM7fikiKNyHcAG5eMA=;
        b=QXpMAI8isnVeDkfdczVyKRQjyAdUKQwOXEbs5HI8PgSVAiljra2ibKBxG1vsC3d/xs
         D9Qdy/Pwu6cFCKizi1K3puWuAT7gvEU63LzLpCvLInJurUiDJJSReNL96eC8Ur7/yfKR
         La4cxoXvZ65wFEnjoGL1B+3LkreWPr9e+8m5buK461Hi9kzeNPMAW38LzBj7104MEtdk
         BtdukmLIGJk+k4sosPivm/e+1q8GDdKvMxemDYBEd7qmGYJrrnHt3S3JLDH0RsXpBhge
         XsF7eHJQ9sMRvgvUAePdqA6FnaC12Utq5NddfKgUDo6C6oKBNIxRG0zGc14lhonAotaa
         DJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770637960; x=1771242760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TY6n6lWqMAjZ459keizyTELNtiM7fikiKNyHcAG5eMA=;
        b=iKDsiVF/T3Ui3VPiU8TQr4ONgO64eZOimWsR/0KCGJILFfoFjQgQXGiaCMCdk65NVn
         tAF98yn2U9Uat4jK7bFG8CN3W0HMy83LJxtwMA9L+YXCk9a5XxjOG2Y79EQ33xRteP02
         EUI+33lMrVy28yweKucIkFgW44cjuYH6+yQl21ecQXx2qZcg6nOjAkcNF7IWtAlXPIRY
         hH3cTFf/SiuZvJ4BJtb9C7Q90Lgnc2s0rmlfdJe2XDsxvWqL6ovB7h8KXJSiEjYKYwlA
         +DoSWJSA/61X2G3kODzemUUCMP9E4ExoGNLLrCWaLGzd0jJTe9VQD2yoMLxzwgPoLevV
         bfgA==
X-Forwarded-Encrypted: i=1; AJvYcCXlEfq7cI+UsrG2ay2ttUC3zc568eWhFegsC4mdmC9JMeCpRcQASllsQUJ+hI9rDmI25ucNFxmUJIWHLcA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YydfnyobcpongYKtuCV/9Qdkq9rWoOL6tWIOlcAAptp+RLj2kGW
	PBLRxLWAx32RB8zqC8giYQC8JknE7PSSq+xQicm/EvHLXaPBIiFLvlMMk8s/ZqGLI7aH+GB6tsh
	bcY/GqLdqv/uiwvV6EdeSQre250ctCGE=
X-Gm-Gg: AZuq6aJFo09oH8HhDyw+c7IAndhXnLZCGDRG9ztSqsTQadGJoaFEj7NB6DhKyQW0CnO
	B3WvcIp4q/aasszG2QREtuesfRVwNRhm8TfutuOmsL4lCOmXJNqG229WGgFcQ50munnSqmZG9tT
	JGWXr6WKqNkw+i9LBMkdMPXSL/NSucgdlTzGjCj4/S9KrCgizFux78y/Ko6SFxzNOQOYX+XYoOi
	t/TIuOHtnDBGeEdpsfCvMpGGX7/IyxJR0RwzS5JwJqXFBgWV4g06NcAwgY1LZVE9GRNgH2nGhAH
	TM0VoaxX9UOG4noFJ/N630izMb/Tbladz3z1UZFdDci82fihNe3HNIeMEW+9gV1Z4LYo5ud8Gfz
	FdGrhoZMDfpSEXkZGSyKYyFw=
X-Received: by 2002:a05:7300:caca:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2b856a4c911mr2268911eec.5.1770637959977; Mon, 09 Feb 2026
 03:52:39 -0800 (PST)
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
References: <20260209105456.1551677-1-mkchauras@gmail.com> <20260209105456.1551677-4-mkchauras@gmail.com>
In-Reply-To: <20260209105456.1551677-4-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Feb 2026 12:52:26 +0100
X-Gm-Features: AZwV_QjceG8JgoEw5aRWMbymspplt_fvQ7_cjaWkDrX-7uHBvZ_bbKxcTrecCgA
Message-ID: <CANiq72=V4yyOwsxvWzGkXQAcMhoTaFZ8aNAe15Aa4BU9JtDGhA@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] powerpc: Enable Rust for ppc64le
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 11:55=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> diff --git a/rust/Makefile b/rust/Makefile
> index ae22f2c5f0b3..14febe9c7643 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -392,7 +392,15 @@ BINDGEN_TARGET_x86 :=3D x86_64-linux-gnu
>  BINDGEN_TARGET_arm64   :=3D aarch64-linux-gnu
>  BINDGEN_TARGET_arm     :=3D arm-linux-gnueabi
>  BINDGEN_TARGET_loongarch       :=3D loongarch64-linux-gnusf
> +
> +ifdef CONFIG_PPC64
> +ifdef CONFIG_CPU_LITTLE_ENDIAN
> +BINDGEN_TARGET_powerpc :=3D powerpc64le-linux-gnu
> +endif
> +else
>  BINDGEN_TARGET_powerpc :=3D powerpc-linux-gnu
> +endif
> +
>  BINDGEN_TARGET_um      :=3D $(BINDGEN_TARGET_$(SUBARCH))
>  BINDGEN_TARGET         :=3D $(BINDGEN_TARGET_$(SRCARCH))

This looks reasonable.

My only nit is that we could trigger an error in the nested if since
you wrote the if already. Otherwise, we could remove the nested one
until ppc64 is supported, or am I missing something?

Either way, for the Rust bits if powerpc maintainers are taking this:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

