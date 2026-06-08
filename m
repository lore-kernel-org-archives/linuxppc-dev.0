Return-Path: <linuxppc-dev+bounces-22294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB1CD8CA7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 22:20:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ61s1V89z2xdb;
	Tue, 09 Jun 2026 08:20:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780957249;
	cv=pass; b=n3IufQHNOd/1M4xZ+MpPCFDho9USeIan0k/8RkBXJaSc/ekOaI4FONPDV4iyIb9+6kuOT2puc5Y6kVYWMypEgCc14+83ps4uthGfwszeIG+UoLGW/wuczwaKhDGldgLrPxfdPeQrnPODx15VPjM9NRzPRyoFiHx7l9cKq4W2u4X6LMC0tbzF6XTDXos60ti4c3C3GF9dey8q7NjyTmPHTZ6gH5gDHSY+aaDgc05qzcXtfwUol3X9utoQu9hehOrHPp9hDiCZRr2bZ28GTVgdXxzFnugyFjXy9sGT9q/J/dNXzwrgkfaaGeymK5DLDeKkswgZJgIPwb8/RfofgitDSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780957249; c=relaxed/relaxed;
	bh=PIx6RD1wfhBNe+wNaNSSZgpl+7acekIC9L2IujVBANg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5k26HjdjQpey7MzfgpbrX64t+VEArFx+G1bhY8hK7ylp7aKTXPc/+9Oif7uMEFQcckFFvI1FatbGsHNKETCeac/yVEDVKi/QJvBdx7+J1TO7q4o60YamgVCgDIduFy5mYB48sXFjYkFb1EAvyHEIAuP/4BfydRtxMvMeYZqSXvQ8YIffWg5GC1ScLDziq9eDrj+CTMH2K9AEXUnIreVqij3Acczn5Djlovpo76hBMBDD17oCpxFOnWbxTwlBpjeSvwv3W7ggqqmNaFwrZGJcpNtozB32deo4X4BnZxLU5jl9dyN6GADWQuK8efQT7uMOTDGLtwFw7QmbnWlsLYYKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZAPhato; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZAPhato;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ61q3pG5z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 08:20:47 +1000 (AEST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so2421348a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 15:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780957243; cv=none;
        d=google.com; s=arc-20240605;
        b=VkifOLiaBTHiTKTsXztoI7gD66pFqWKWd1uF877mWmhJphaHAiRMuFMCx4FPeGFZyk
         Aoyhxk2Ls8ZEiuq3f+yXyOpBcXmp01Y7tHgFZGNQePUqVoQzd+9USnEpvvtLrAMHhQ25
         z/bEc370ftEcxuRf3iUiYohJumKBZ0IIjWRxu1WyoPXs/Qckik6rq1jSusMFxL7F6qSG
         HLAw+JBHB0gk363OJCLK5EYBZphC9QjPAbH0AwkKREVGe6PUT9sKyQ+Wc6Yt9GXY3RLs
         2TApqtAy8+awx+J69gXYU/pniPY/ZmYhyH2CtsvhTUCbyUndIlOL/V46AsDfb/PgLiI6
         yb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIx6RD1wfhBNe+wNaNSSZgpl+7acekIC9L2IujVBANg=;
        fh=pYoLXfEhUWNK4FCknNzQjTJEo6wirKkSD0RICMBSrWU=;
        b=InAFvHP6x3bn+xnJwl2RBzZOCPiMsHmyXmA2pHFUpFc6cYYU3Py1PweG30DmMXHN9y
         lZsqhnYufyp2P4qZU5ottIRp0BqKlWLRWRcNEDOSlSxyT902vs7iQSkId2mtAqkBmoF9
         0/4cPzFC721mcjBnzT5pGUkMdEscTbINlSeZqhuV+qlnF++t6Z+oYhd3f/Io43xsQ52j
         iSg3t4HWrTDh361jnc3/ukUWxRN/hL2IJ6SwDZUDt+MYS1CbyfHnZlweTYx3sp0GHQvd
         /hDZ9WHwpxWcyuNUtOmx9KGAHrlcrEZJ9qbK2a03u1GCsv6bnlJVDonyVRvYiEi8UM2/
         Xlew==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780957243; x=1781562043; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIx6RD1wfhBNe+wNaNSSZgpl+7acekIC9L2IujVBANg=;
        b=BZAPhatozOjwqgwvmFTlVpnVm1OHMjnw3CRTn3hp9K1wQia2WB626W+P4uOEBYtDY3
         eRylYm040LogMJmxtf5LrSwgqCerlJr8hoGU3eebBn078LMiV6rAvqw6iuxmEV8LH4jL
         sI6EBPAGdCqzryhXEiV0JxbIa3XEAy9thajm00LlK0bCBWgkHW/WkCdJDKmBpTSSx2Iw
         meVpljcSx66onwTcOxt/2C+xQTIuox1biJsI/WRi5LyzbFn+yHbtP20wYClcWQt825PN
         DEogzGn02rQLMf4kYE6hfyDCzrEtWucZvCv1D5sJxC5PXFMCzOE2xzbdDJeAPOgQRfbv
         uzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780957243; x=1781562043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIx6RD1wfhBNe+wNaNSSZgpl+7acekIC9L2IujVBANg=;
        b=k5rYP3WygGd3VqUBR/CdnnXsF2KD3LKkkMsYFB6GsHAPBPRfhDQNRtWolRDCcAfddq
         US6L3Dejt+yh99jD2MP5UaW0Zhsj/DcQp6Kjicc7m6uZpjeCW6XrBMGN9XV9N+sX1rR1
         /GKfGvu3ZMjLVI/QFBAuVKOtEdhPxop7hJDTChpzMbQB9roXh7vojmqy8Hn7j1vQCPPt
         OkEaCZhO47oyWuxUkyZA/vxLCgJ+zP0avkglmze47PJ0SmhNmP7HgJRCipTwnnWbfFiy
         bDM/tN8rMInAAQ34qTGcJT0AK34KBVe2yXiD2GIg7TIRWksWh46P1OfUbrOpUTT60BIv
         AdmA==
X-Forwarded-Encrypted: i=1; AFNElJ/gtjrbSU5bm1mZtFJr8m/TXpwJiuHY0VD+6IJl43MvlGRguEimhr9t95YqtZTb9RW7DU7KVChuxcEK8Qg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWKCJBBASs3Ufqn3Q4pKkVMazB7m0I1zYai5l4mErIGqPchkEi
	SvBm65yIEuaDQ2A3JsAZul4qPDC++tRJlflfzUuvHoYlSRXScxgsFuhbdaqSwX4jJfxsIgHC3AR
	VQCzoE5aXF4k2SunzjTQ/59k9dpicLqs=
X-Gm-Gg: Acq92OEQOAj4IhZClGLI0kSMO18HMs1q2WxiOtSJOmvKNNRaiMYIywT4mdoXDaHwCjR
	hlq3aemXAuv5ljLKekgtdGPHLUVRKt7eYg7twwBoziPyUAXpr1XO++Mkidh7irhpM2o1AYsqyBA
	6FXoQMfyx5kO0qrf4j/SgQul2Pvt+8bBfA0Bm9TfvQ5hqfH/w/6QW3rUAW3XXCdo63jwU+QxAS+
	hpKsRfN1XzfPWBlQGdPahMznZ8TpMb9LHrRO8FKp476M8jnbcFjWXOihTFUHGF7XZVSrOrfiKRK
	RoY/lvzFPlz75cGUTRIlcaze4hS1jyaA+NCNCa6qU44fl+Z8Qmy/rYnwsE+R4fLhl4eu+vxs3PL
	eI5GPYHgCZVoQDQOK9quluU+kNTdp9zOjN1zPw+toggr3NJbj+f/FlNlpNSjlNZ6tQVyj
X-Received: by 2002:a05:6402:5384:b0:68c:bb66:b23e with SMTP id
 4fb4d7f45d1cf-68fa4c0f935mr7904026a12.8.1780957243084; Mon, 08 Jun 2026
 15:20:43 -0700 (PDT)
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
References: <20260602050131.856789-1-rosenp@gmail.com> <CAD++jLmk3jMFS0DD0GGTV9AWu-oHJAoxymcyOKQycVFqKCRnzA@mail.gmail.com>
In-Reply-To: <CAD++jLmk3jMFS0DD0GGTV9AWu-oHJAoxymcyOKQycVFqKCRnzA@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 15:20:31 -0700
X-Gm-Features: AVVi8CeE2gQXVP0qwTC4BwyqXNcI_TL7F-lX59gwa3gCUDmlY9Xhxsni3AVN22c
Message-ID: <CAKxU2N_LhgDj-+-gd0_N9gQOzCddq7dypYhayFQ_09zggpor6Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] gpio: move ppc4xx driver to drivers/gpio and modernize
To: Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:10=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> Hi Rosen,
>
> On Tue, Jun 2, 2026 at 7:01=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> > This series moves the ppc4xx GPIO driver from arch/powerpc to
> > drivers/gpio, converts it to be a proper platform driver using
> > generic MMIO helpers, drops architecture-specific accessors, and
> > prepares it for module build and COMPILE_TEST.
> >
> > Patches 1-4 move the driver and convert it to standard platform
> > driver infrastructure. Patch 5 switches to generic MMIO helpers.
> > Patch 6 drops PPC-specific IO accessors and enables COMPILE_TEST.
> > Patch 7 adds the missing MODULE metadata so the driver can actually
> > be built as a module.
> >
> > Rosen Penev (7):
> >   gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
> >   gpio: ppc44x: Use module platform driver helper for GPIO
> >   gpio: ppc44x: Set GPIO chip firmware node
> >   gpio: ppc44x: Use platform resource helper for GPIO MMIO
> >   gpio: ppc44x: Convert GPIO to generic MMIO
> >   gpio: ppc44x: drop PPC-specific IO helpers and rename to ppc44x
> >   gpio: ppc44x: add MODULE info
>
> Overall a very nice patch series and happy to see that AI can
> assist with this kind of refactoring!
>
> I guess we should provide some slack so someone from the PPC
> camp can test it, and if they don't test it, then it is abandoned and
> we should then just apply it anyway.
Hmm? I have the hardware. It works fine.
>
> The series:
> Reviewed-by: Linus Walleij <linusw@kernel.org>
>
> Yours,
> Linus Walleij

