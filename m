Return-Path: <linuxppc-dev+bounces-20561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7B6CD3442
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 08:58:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB5km6Plrz2yrD;
	Thu, 07 May 2026 18:58:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778144304;
	cv=none; b=NsJP7CpPWyf/N4UExuiBs6DrV779xA6lrOkywpc4xwbH+9+2PwrlnqtxOZGcr8Pztq4f+f07c8kzbFMbsP+d5JNs9EKqgjmoC6gbP53of4uEgQiePBUF5abI8BLP74bB8uzRZ1fsxvuwjHxB8apd62/RUqfVVZ18mt1FXqbkGY2iJAbJsym7e4I2v7xZnnZoSyI9UU9Qh09SOihD9ahLtfWToeCx4xA+uojWMUREbQKQl++CZbrv94GgBAsZZu1jYEtUfDDBHuGQmEMsSHR4yCYyZxq1W42MrOk1BHOx3tclmbDbEbt3rAnnuH+/sITVSvMfjViLumGDHun2IE439A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778144304; c=relaxed/relaxed;
	bh=TU6tJ4jwf1VbsDe1Q2KJJ4o9JPUWPeHHh2buzZ1/4NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiQ9NoU1t/EJQBiNDgJyTv5uQ+rsN/N3KhPcW1vrtYVK7u/RbGBrnDDUgXsndVKAjWGCRHltXw8Zmpj4JFHV5XWa8vf+M6mayZUXSpB6L6xDe57UREsQDKBrsxeZCyFCSfVHt08IPoY2YDhAXAtf9cG568dBMJnSDJCCmot7mnVo9a1EZxbOxed+9QvsoTeAME22zBuU5ct2nI7BH8+O+VuPMuhOjoMu7jy2R+EvJIwQ8UatPWeo7jqAbvzd8r5f+Acl29K0bpzxXYxK0+1SpKm25NjZ0j5zcow3tvvto8+/xDDiQBOhGzr1xK7sWQkGovu3k1uWD4NSNSGW2w9bbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rsw3tZxD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rsw3tZxD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB5km1QWXz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 18:58:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C21F043BBA
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2026 08:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22EAC4AF09
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2026 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144301;
	bh=TU6tJ4jwf1VbsDe1Q2KJJ4o9JPUWPeHHh2buzZ1/4NQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rsw3tZxDs3paiI593HF9GZ1XryqiBUHL4OtibVBFtXzQCPLWaCCihu2fVrCPqnzli
	 nSWAHer8A0mQ/F7o29z2AgPNKebusXJhZtL3wRqFPyhNjyJysp5CHvQisTLHxj89WT
	 rvkylzFDtm29ul2BMnyDSC42Lcw17Vsc4Bq2gnTmDWaNX1ulK0AOHAcfnNHZmE2fuI
	 G9zjnsdU8mlntvRCkttsbdr0YNFP6qH3ZLUcMmJ1Zv4RaI6M+XWy9RP/4eqnEp6/nZ
	 5HMwPHEeOnagcMTfizIJVFjKASRy25XPNOzQ0mB+cmhEzpxMp+zsCEr836hMlnoMlA
	 6SSDTGpDFmv0Q==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a87782588cso815823e87.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 01:58:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/mnRCCuhqjxS/Ja5pbM+Q2/SLZNwoNsJasq5RO5fNv2owZ/P2Mj4q5w7yelwGl13X+dd1ZNaDx9R3ZAJc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwS4WcIV2hDZNwBJ6kmNAoq7WsR4zLkHiy24WgkDETsytMqakgI
	kczSI7cWkaUgQEHVkLcExnL6AKT0HC4rrjH8XfPfb+sxdZjFWycjNzPse6PDUnbQiL3yWygH9RI
	+TS/RCGfeWmsyo8TlzKXGYUbGmHIPG04=
X-Received: by 2002:a05:6512:224d:b0:5a4:13da:fe8 with SMTP id
 2adb3069b0e04-5a887cefdedmr2772735e87.38.1778144300235; Thu, 07 May 2026
 01:58:20 -0700 (PDT)
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
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
 <5a28c484-5500-4b68-b837-28d30648e592@kernel.org> <afxS5S86eynCQaTd@gate>
In-Reply-To: <afxS5S86eynCQaTd@gate>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 7 May 2026 10:58:08 +0200
X-Gmail-Original-Message-ID: <CAD++jL=hsf7UiyQUXgYTyRhjTgALf1tV4yLi-koHdm1=8q7QSQ@mail.gmail.com>
X-Gm-Features: AVHnY4IzoBsIAgYM6m8jX1LDk79qpN491S4jlhKO0N_erGbuMP1QJk6GNyuh4hE
Message-ID: <CAD++jL=hsf7UiyQUXgYTyRhjTgALf1tV4yLi-koHdm1=8q7QSQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 10:53=E2=80=AFAM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Wed, May 06, 2026 at 09:41:51PM +1000, Michael Ellerman wrote:

> > You might be the last person on earth booting Linux on those :)
>
> Booting, yes, but it won't run for even a minute ;-)

Yeah what I think happen with Debian (which works) is that they have
this driver in the initramfs or rootfs as a module so it gets probed soon
enough, but it feels way safer to compile in vital stuff like this.

Yours,
Linus Walleij

