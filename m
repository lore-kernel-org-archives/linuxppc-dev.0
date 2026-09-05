Return-Path: <linuxppc-dev+bounces-26593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526B5C624DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 06:16:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcNQF050Hz2xlJ;
	Sat, 05 Sep 2026 16:16:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788588996;
	cv=none; b=TtvCeKoB8TxhCoTReQh5lh/qi6RgYpWKTGCO4ASbUlctADO3zryxgHzMsFVauDRzh8V8o5GpNcySitO9uMnm6OjNfe9iDu26kWeC/NklCdgo2lpyEqs1k8E6b/WTT58DR714ck8/VDeFzOg9MusGgGflvK0pONGxbwyAQTXPBaKhPS9abQC/ZU5n0hskVFfAKCPCVRXTr0QNevRO8Fh4Wng7a6IqfRI7zFlqsyPT82DmsDaMDG1PV3cTCQK/Qm2BiwgxpXYQWXTfkdxObY+jg1EDBQ2137M1KDT97DKJJXylkL9mVQVqdsEcEwm7SnV6KZo6cE2Qe5zPJFW7Y1aRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788588996; c=relaxed/relaxed;
	bh=wroX+IXZ78hb2aQP5LUDjSlqEruTGuDIlApEgq/LO60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLNQys8J2RRyhZTxiTDJLPvO6q3FEKoFnHHLEEF3Od5dxlV+lw+7/3duEIZ2412vxC7R/NNqFkKJ9fG8iD5ZPX4nb092mOhULVUN/HOv0Zi9/k0oLLUe+fV+VsTyfGoXua5l/gFtAdaCYqBJpr6b3u6zoIC3/K6hjZPAjTPydIxz7SBS5E+Ca1U7xA61ZFgQOLuA5twWNiLL+uqGUIel50CbOT7FqHIj/tZeljpozDv7C2fVwNyvbV7tHaWtHZchfrYyyPG/bfaVczgoMLWxPSsmyohGGis2IylVdmAgeZe5naTtUpROBJgpWkECLMcUm8dJV62au3+Jpq9hVJPm2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eG6Yau/S; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eG6Yau/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcNQC26qdz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 16:16:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F29E4411A
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2026 06:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF5F1F00ADB
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2026 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788588992;
	bh=wroX+IXZ78hb2aQP5LUDjSlqEruTGuDIlApEgq/LO60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eG6Yau/SZQyADBf7WEKKvoXO5elZ/bvCf/rLi+iKt3NTLV7xty74rhFfmCtOpPiim
	 KsAmLG9Gn+z3shv/KSeuw44rHL9DtjgoqL/rXuxlacLkIVZF2+hqWRGRtWUTXi/qmJ
	 kZl5s4svuLfbc9Q0nHCHcueEtH3KiRVj1uiGBF/HJ7S7HftHqGrPtY0Sno1Rhjpz4S
	 r4ZM1gDlCVp9/4jsn5pfGOohCmBT4WDB98quAjGdOyMWd9pF1NAdOgRtz+4BlRvGeN
	 E8KPCW/IB9VA/PTkef8GQF62ljNlTZ7dJCjGnGxIPtOxwhbNeoezclLf0Kn6pu8kjd
	 1SF3HTI8TDArw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so538385e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 23:16:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxf1z9aky2LfTGUnFyhneGHKkbDRNY9ODqFMHexP1xgCzZTRkiLkgZnKrnDv7qpxqrnLggMD+BrHRQTELM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kt9ffLQmqNF3c6hb33ixWwId0DkPLTjgipgC+ov+O8kuoDrGku
	Uq3jwi2V7EGPJunBwG91nZKFv+SBUSusSSnNSQQtgC12QbphFUufsvwTk9otYj7YzetJKG8d255
	32HAx+LozoVUh/+7DAHVdVkIXTv7l6UY=
X-Received: by 2002:a05:6512:2c0c:b0:5b4:74a2:cf2e with SMTP id
 2adb3069b0e04-5b616f235cemr3181239e87.21.1788588991087; Fri, 04 Sep 2026
 23:16:31 -0700 (PDT)
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
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com> <20260831082335.1184605-9-wei.fang@oss.nxp.com>
In-Reply-To: <20260831082335.1184605-9-wei.fang@oss.nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 08:16:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+DMHzHiJoX6LMY5wUGMOWm3DN_yAHUUSvFKLKgFwJZw@mail.gmail.com>
X-Gm-Features: AcwNN1VLKzpVVc3BcKIIuwpH2P20ZdeitB0o0lFGwyQdTkbcdnQSy6KPeNWVBSI
Message-ID: <CAD++jLk+DMHzHiJoX6LMY5wUGMOWm3DN_yAHUUSvFKLKgFwJZw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 8/8] net: dsa: netc: add PTP one-step
 timestamping support
To: wei.fang@oss.nxp.com
Cc: xiaoning.wang@nxp.com, andrew@lunn.ch, olteanv@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	richardcochran@gmail.com, wei.fang@nxp.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wei,

thanks for your patch!

On Mon, Aug 31, 2026 at 10:24=E2=80=AFAM <wei.fang@oss.nxp.com> wrote:

> From: Wei Fang <wei.fang@nxp.com>
>
> The NETC switch supports one-step TX timestamping for PTP Sync frames.
> When transmitting a Sync frame, the driver reads the current PTP time
> and writes it into the frame's originTimestamp field, and inserts a
> To_Port subtype 1 tag carrying the low 30 bits of that same PTP time.
> As the frame leaves the wire, the MAC captures the SFD transmit time
> and derives the residence time from the timestamp in the tag. It then
> reads the correction field at the offset given by
> PM_SINGLE_STEP[OFFSET], adds the residence time to it, and writes the
> result back.
>
> PM_SINGLE_STEP is a per-port register that can describe only one
> in-flight frame at a time, and programming it requires reading the
> current PTP time, which may sleep. Both constraints rule out handling
> one-step Sync on the xmit path.
>
> Instead, defer transmission to a per-port process-context work. The
> xmit path classifies the frame in netc_port_txtstamp(): a genuine
> one-step Sync (twoStepFlag cleared) has its PTP header offsets cached
> in the skb control block; frames that cannot be handled as one-step
> fall back to the two-step path or are sent as normal frames. netc_xmit()
> hands the classified frame to the switch driver via the
> onestep_sync_enqueue tagger callback, which queues it and kicks the work
> if no frame is currently in flight.
>
> The work dequeues one frame at a time, reads a fresh PTP time, programs
> PM_SINGLE_STEP, updates the originTimestamp field, and transmits the
> frame directly to the conduit via the onestep_sync_xmit tagger callback,
> bypassing dsa_user_xmit() to avoid double-counting TX stats. Only one
> frame is in flight at a time: the frame carries a TX-completion
> destructor that reschedules the work when the conduit frees the skb,
> keeping PM_SINGLE_STEP always matched to the frame being transmitted.
>
> The one-step context is reference-counted and its lifetime is decoupled
> from the devm-allocated netc_port. In-flight skbs hold a reference via
> their destructor, so the context outlives port disable until the conduit
> frees the last in-flight skb. Port disable clears onestep->active under
> work_lock; a work that runs afterwards observes active cleared will
> purge the onestep->queue and return without touching the freed port
> resources.
>
> Assisted-by: Wchat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

You agent produces "dostoyevsky commits" with too much verbiage.

Tell you agent to "be terse and to the point" in your AGENTS.md.

> +
> +               /* dsa_tree_teardown() calls dsa_tree_teardown_ports() be=
fore
> +                * dsa_tree_teardown_switches(), so netc_port_disable() i=
s
> +                * executed before netc_teardown() and onestep->active is=
 set
> +                * to false. In-flight one-step skbs still hold reference=
s via
> +                * the destructor; the context (and its work) is freed on=
ly
> +                * after the conduit frees the last in-flight skb. By the=
n np
> +                * may be gone, but the work no longer dereferences np be=
cause
> +                * onestep->active has been cleared. And onestep->queue w=
ill be
> +                * cleared by netc_onestep_work()/netc_onestep_destroy_wo=
rk().
> +                */
> +               netc_onestep_put(np->onestep);
> +               np->onestep =3D NULL;

This type of stuff is over-commenting and is considered AI slop.
Tell you agent to be very restrictive with inserting comments, essentially
it should only do that when you explicitly tell it to, such as when you
yourself feel it is really necessary or you got a review comment that
this is needed.

Yours,
Linus Walleij

