Return-Path: <linuxppc-dev+bounces-25731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCDDC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:33:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK3JV4M2gz2yvG;
	Tue, 11 Aug 2026 17:33:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786433610;
	cv=pass; b=QXJjQBdVn0ZUr7dOkpJ3BQmE61nn3MDlogKjVFIMDbD6KXyYNJmyjuyZJsi6Pmczh0AkZxL4mKnz1Z+95epWScY/kXFBVQbsoFkcuzHd+uJyD+vz6Q0CSEH4VgVTEoucmlKS00nGkQ6j7mw2tMSuQsgC5u8jmDhy3aM+bbYH+Qb8xTAD3lK5iOsyNNBpUbnbc+YD8pm2psWsVjv/4VSCOxVKziqNnM26rzjRBm48b7eTDAZ1pFhO+Rnujgz5xTzhlvnOAVZh4pcWo8ihZSYVhYBcsG+3up6VLCb5oMLvFuG125yy5jYbJvU+vsIvN4GXYGMHAwI4TxWtR154IFR/FA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786433610; c=relaxed/relaxed;
	bh=xF99ad/0DOf4sVlgM38a6novcYoEr4EV6MAbjOWZJGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSxLjeLirs8agF+KoaOLYcYcy2kekoUXWuJGMEk3uJIjDDUYQNk/ook6JvTcSZ2yaqD27g2AQnMENTjzu33vU/JlPNStnARQyW5UKKkr+vSQJEbuQ/cprL4rKB1wloZjMkKJoa7gEMk0xZDwOFHQ23qsrv/G/q5WsKHVmUboKUi7UM8fJTiSZxKFcwbLPgtBwUZj4yMqJQ6gMqzMiaDXMSmIHvhc6sp9dEp9ytokM7fPufwM4REKv6e3B16ZGAwc4Dd4DtrZd/ZzN73YJ6AjHW0rbGrciBjCQFadB/fhqhqdzFJtzDn7MvVeqmFTiAaKzXnvlA++fBwARdT3JGTpIw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+PV49Oo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m+PV49Oo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK3JS4bYRz2yrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 17:33:27 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cc73e322dbso30793345ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 00:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786433605; cv=none;
        d=google.com; s=arc-20260327;
        b=VEM9/BuDUuugr+xLdUCjN9LODuslxbOxzHlBPKcAqvS1nPmAtsX8dzHSfQjIHVVtP1
         G0WaGN27fFil3gBF+UCf4v4k48xsCaC2+CWBotlh/pun+Yn+uH8wE/rfEAo17oqfqw2o
         +4EpTkMSz4+VihcQpwF6jrIsux2oj23g/xxpIwUVWPC2xhksyu+x1FnBCsjKJo1fffzC
         A5aTqGvRbciIrr2Zj/9mcNtUFvZqLjQpwXlg5+2TtQxj8annj0tgZ9iFWya3ja946a0K
         kqtX9lKFPZKAjq60AMeF8ZPE7QFl0jLDo5YFPEbupImDpvNN3PMUz7GdLypZ83w3hitD
         anIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xF99ad/0DOf4sVlgM38a6novcYoEr4EV6MAbjOWZJGk=;
        fh=c7PxW2KazoXFsmzaUsazkJt+pzpWrV89924PAdqZ51s=;
        b=SiL6bA4yPi25HK2A1WLQctcYY+ZF2A7Ia+WoLN9MkOD5TIYHIr2WIqbYUvEoDhxIDi
         G8PwT1qFiPiedSq0VajMYOmH769jWmu9wgwWBXtaJ1MWUTY+B9yMbkV6o2AUGzSkK9NM
         isEjcXowaO+kHb2NsR0J14J3KvCM3y2dn8hSk4F7im5wqt0xU5fYS9poxLWezkrh6h6n
         VfR/QqHHHRGkRLhPkKzlt8nntyeU3EzCdWpst8/ccqe44JN+4u2w5qQzAae1AU8p0isv
         et5gdzxx6Oh8C9uKuREF6i0oC1cunGT9bD/hVsFCK/s4KfYBp74pi4TpE298XZJSSHkX
         OvgQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786433605; x=1787038405; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xF99ad/0DOf4sVlgM38a6novcYoEr4EV6MAbjOWZJGk=;
        b=m+PV49OobhlmLBozpqLJHkLRblZ42yDmg8QAId6a/vJFkt59bCXQTuFkqFMBIDNs9I
         P+qhHrOq4AaEDKimrfbqlSrY40oJMexR6u/AazH+j6Ncm5t2qmMDMvR42MF6GBPfXKxU
         zz3nawqoZUKmenoUR2ycnFk/n4nsFv1NlgxaZegBMXqji7Sq5S6MNcVsUfWI36LklRVv
         Juyxhs4/pfh65E52FoAi+BvJnee56RMSpyIk2lwgwKaAsozkdrqw9lMI7cM2bTdCoxny
         SQxFYXvBEANiJ2k4xdGzCtQ9UQiE/SQwj/v1u6/3A7f3fE8BiY5U14e/vA2eMdOuAg5e
         oXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786433605; x=1787038405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xF99ad/0DOf4sVlgM38a6novcYoEr4EV6MAbjOWZJGk=;
        b=QYKu8r8PlFz+H41EBI6oa/p+eHWfjQo02/OD64HpsaEM8PhVN79H6YlmGSxCXEzb86
         sG0mtDJscphzUz/Pv1EGoxrYGH5jH//Grvyas3wPDtp0y35erBPrQUvqw1hFqf9UQmiv
         Q6cxkmObBycO/WecJyZzvsGgXsWZMM7m2INQ07lVblZCsJkrN+9p+dt/6JqZgVHoIQK1
         OAGbjAcWcOhkjFZJqKIo+3rfA7qbwsAD/JWTjDVQdo89VFUctFDgStneMdX9ln91v62X
         icibCXVGbu5XQncfQkGXz2NcOt1KQnFkwHzxVDQfgNJXGHDxzSWbKZoNf73fDNVSiBa3
         JzOg==
X-Forwarded-Encrypted: i=1; AHgh+RrjCYiheob8fikMxA6+NxpmtqkkRaFEPzZMjvwRuAVnD3WtxSOOuGIOWgqzBnpn8BHzjHqxZQvlVPZw9CI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx3R0IIzQRx9Q2tSHGhd+a4s3xBnv60KVoFKl+DwyY426asKEc9
	xobu89715tMLHMpcr4dDiOwgMbioxQIozJiZRJqp6LyBFmnjRpE+s0j2FjFLUJoujQIR9bXpWST
	FLI+j6Llh9YOcGxO60j8tV8jFplNthX8=
X-Gm-Gg: AR+sD10j9S9BAzG62vHr+5Gm239arGuJngDQ0rCh6ZwWCnW0TkL/9puNgnVNSjoFgxG
	ACwUF7RWyW3qP5JCcdsiPC6n58gkbeHO5zbuJEYjV42Qt6K1nTfcV54Zpy89LwHQqGUn2u9LgGi
	KuCoNpv6njpDNrhiRKRg2ZsLJjxjH/CMPvZ0xeYhwonkzNk3DV9oioP3ubg1gl6yijtcT1uh+NH
	aqoIR4fNnUwInf+0YXudE6KdzXs4s3tAAAHNIs08siPRjepAL4jyTiWmSGZV/Dz7+vhj6hccJ/v
	JQrVMdhi69W2OPfqjRsOdKYExAS76NDpmaqetqFcij9A
X-Received: by 2002:a17:902:d4cf:b0:2ca:d975:5bbd with SMTP id
 d9443c01a7336-2d3179365d0mr16451405ad.20.1786433604824; Tue, 11 Aug 2026
 00:33:24 -0700 (PDT)
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
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com> <20260810-normal-cuscus-of-argument-4b230b@quoll>
 <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com> <dc40dcae-3017-4e61-8c6d-7e6127e4ee77@kernel.org>
In-Reply-To: <dc40dcae-3017-4e61-8c6d-7e6127e4ee77@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 11 Aug 2026 15:33:03 +0800
X-Gm-Features: AUfX_mz8xzcQdpAVFUpNZF46ew2dm49dWd2moRqPqyVHFf2Y0Ny2enqss2gXdZU
Message-ID: <CAA+D8AOQ_y7BdR4h+X6qxFygPU6h1iFV0cYXHN4KB370yM2Bkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 1:44=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 11/08/2026 04:28, Shengjiu Wang wrote:
> > On Mon, Aug 10, 2026 at 3:14=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wr=
ote:
> >>> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>
> >>> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C=
).
> >>
> >> Which SoC? Did you read this binding you are changing?
> >
> > The i.MX35 ASRC (the original) already supports three conversion pairs
> > (A, B, C).
> > All subsequent SoCs that reuse this IP -- including i.MX53, i.MX8QM, i.=
MX8QXP,
> > i.MX952, share the same three-pair hardware. This binding covers all of=
 them.
> >
> >>
> >>> The existing binding exposed only a single generic audio-graph port,
> >>> which cannot represent independent conversion paths when multiple pai=
rs
> >>> are in use simultaneously.
> >>>
> >>> Add a ports container that enumerates up to three sub-ports, each
> >>> representing an independent conversion path:
> >>>   port@0 -- conversion path 0
> >>>   port@1 -- conversion path 1
> >>>   port@2 -- conversion path 2
> >>>
> >>> Each sub-port references audio-graph-port.yaml as before. Hardware pa=
irs
> >>> are allocated dynamically at stream open time; each active stream
> >>> direction (playback or capture) on a port consumes one hardware pair.
> >>>
> >>> For backwards compatibility, keep the old single port property but ma=
rk
> >>
> >> Why? Did the old hardware change that it has more ports/paths?
> >
> > The hardware has always supported three pairs; the original binding sim=
ply
> > did not expose them all. This patch corrects the binding to match what =
the
> > hardware has always been capable of.
> >
> >>
> >>> it deprecated. A schema constraint (not: required: [port, ports]) ens=
ures
> >>> that both forms cannot be used at the same time. The binding example =
is
> >>> updated to show the preferred ports form.
> >>>
> >>> No existing upstream DTS file for fsl,imx-asrc uses the previously
> >>> documented single 'port' node, so this change does not break any
> >>> in-tree device tree.
> >>
> >> Does it break other users of this binding?
> >
> > No. The existing single 'port' property is kept and marked deprecated
> > so that any out-of-tree device tree still works without modification.
> > The new 'ports' form is additive only.
> >
> >>
> >> Why mentioning upstream in the first place? Either this change breaks
> >> ABI or not, explain that.
> >
> > The deprecated 'port' property is retained, so this change is fully bac=
kwards
> > compatible and does not break ABI.
>
> So why? Drop redundant parts.

Ok, I will remove the sentence below in the commit message.

    No existing upstream DTS file for fsl,imx-asrc uses the previously
    documented single 'port' node, so this change does not break any
    in-tree device tree.

best regards
Shengjiu Wang

>
> Best regards,
> Krzysztof

