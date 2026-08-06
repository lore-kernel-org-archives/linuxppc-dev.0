Return-Path: <linuxppc-dev+bounces-25534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78327C5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 22:16:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGM765SfNz2xyk;
	Fri, 07 Aug 2026 08:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786054562;
	cv=none; b=fmOD7PStOGAJOD6qj2oICDoxgPQXIGr76AucBymiXnY/9qI2C1zbr1qgVH7AwXZzP6ooCdzl4M8NcQ/HO56oIsvDLEGxDK54YTFypDt1J2je4d8fR1sVbYQnoKNd8GFPcryvEifBSCQ1XL92LWk+HuiIiJAgrLqQQPgUgtYXIHC1Hdvroa9bv9oo8EGQvvvASgnPcB73nM6LQizIoGtY7S3fIx5q/AGb6f1lmEoPZTqQQZEtu0DKxGy1sqZ2NpJxcxyUUlGI7W4ODYJuFDMGc4ya1tQfglgBJsglHE1IDbOLHes1cphwB1afqDCgIhbGJ8Agj+WYdh7gKRXre/W47A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786054562; c=relaxed/relaxed;
	bh=FAMvGx/Nhy6G1Njdh4xzs4u1ahqLsDIzrreIJAT0dro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzCjmUmLVQS1pAW6PLcPD31ZTQtX2jbkERU50+cg4Xo59BvPH9q6uPUKm/okqczscH1TZ4oZcq0zAc5RqtuUrKEs1xeAi3P7UUrE3ci8DJ13gO0iC6X8OYaofXYmptBN9+mmSSN06Q0ntbG/yeRoPsNbb3BwuRnjjlXkqvDAGHHDMHeB5r/8DPiI5EUPv389w+6PiXRu5A+C15iMSkPDbZCawlhxheeCQhmrTo2c+vnbw+cfuCzk8XsMP7P+rydki8h3TADzM80sgPzI8V1wI8WBewmt1SJI/DqUL61cMu6wwp1RIeBFKYelfG5+vVW62bl4UxZ7hJXaMov/zJ9FqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeHWSf1v; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GeHWSf1v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGM755V1tz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 08:16:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD980600B0
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2026 22:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679951F000E9
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2026 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054558;
	bh=FAMvGx/Nhy6G1Njdh4xzs4u1ahqLsDIzrreIJAT0dro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GeHWSf1vK0xP5n0S8ZIBeWf0LS+oc757SLXAXWVcXXpKzrbfZQZvai7CL/uWGaZ2b
	 mBV0xfYBGcgP6lFuEXMHu1N1bc6xO+br26UKrRea8Rzax6Dmenpo1ZTXl6pdxnuVAI
	 DGO5ZXI3kmXkffn4ruOxj8gK+bFu/JsRruC+cZhxV6OwXUDq6dqiFzbJog7/Tp6zvh
	 CgJipaVj+IdAx57az33LrIH8wm4O652zy5RQzdjTuW4g0qzI55FQQse/PWReGt/Jg/
	 4i6p5vG0bSgIYQPbCkmXduXCBVY8mj7F8DdiwE+Y2RJEQWjmqN4oN530GhD5zWgyJD
	 V950dhD5tvvcA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39dbe684115so11998941fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:15:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrE0Q40zPw+iQby1ikruFktDPYXFrJoJ71hehq4UM/UFgGsDJrhxOLwyVX4V7wAgHTqZHP2kYKiuzboHro=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywkk1CUUPRR5yF9+xrO0Pj877D5XunnJbWj3IG2Hv9IuPdy/Xhx
	6z0EOrJ2trJNm4OSX0AwYhh1N09VB9YpbTVmtlNWnxR856VryczKBQqP4KELJIGUelrREIASb+E
	VyMjTN6WRBIw7ar3KwefXtq7qYa0Njx8=
X-Received: by 2002:a2e:b8c9:0:b0:39f:a24b:bb25 with SMTP id
 38308e7fff4ca-39fd141cecamr10149251fa.4.1786054557256; Thu, 06 Aug 2026
 15:15:57 -0700 (PDT)
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
References: <20260803223539.86303-1-rosenp@gmail.com>
In-Reply-To: <20260803223539.86303-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 7 Aug 2026 00:15:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLmKBR=nHQ5O5URC9qmgA25X9=xYWQAx-dyRyUGMG+hKmg@mail.gmail.com>
X-Gm-Features: AUfX_mx3a3U071bMWwj3yWtcfq77UPIZnA-RY7yvDANb6g6jyCQUBXMBouxKQLg
Message-ID: <CAD++jLmKBR=nHQ5O5URC9qmgA25X9=xYWQAx-dyRyUGMG+hKmg@mail.gmail.com>
Subject: Re: [PATCHv2 0/8] gpio: move ppc4xx driver to drivers/gpio and modernize
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:35=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> This series moves the ppc4xx GPIO driver from arch/powerpc to
> drivers/gpio, converts it to be a proper platform driver using
> generic MMIO helpers, drops architecture-specific accessors, and
> prepares it for module build and COMPILE_TEST.

Excellent patches!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

