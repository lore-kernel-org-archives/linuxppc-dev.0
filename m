Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182B606A336
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEiWDMXa
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQF146GrGz2yKn;
	Thu, 12 Nov 2026 20:08:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794474504;
	cv=pass; b=EOLp6pee2PpXbzrqyG5xd8Mo/v8bcrraBk8v6vLJNlPMlQqJvfwRCRzB0VDZiQJgaMDQD8QRza/jN7X3ZbMYFYkNehuU02iDhM2+SUxlVzrUGXdX24WZD2qy+kpDxV6WPwwNOypI93y05lIUP2QbEMpeeyShd8QCEbBo1Q+pexeFWtBm87hZULiAtW9qUSOvbvK1msUwxkTwggifm9eTGsDy7koLLx77NPXAqp5wIyiBGNeld27OrSQ3Aijb5/B9q+aBfQlrHFdh2rQybHAj4UOpohJ7nWOWsAQO31BO831L2xzcZ0HbZocuz5Cz5TfbqEvxYnfJSuV0bPtcHaLmKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794474504; c=relaxed/relaxed;
	bh=5uxsE6PqmpKFZd5WTCPldAkadxtOwm9bHGSoZKmkpDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzheAZiG3oe5sXvZykuTkpqQVih05VtfW/rPpnqnNQWHK2u5vr1/aVIhxIUGMFw7ptnzV0AKsNr1jUfkcNcaF9YGzKx/cSJvvRX0hUhvZNTP/99zwCQs4BqZEcxFAxkiQ/8Shai1It9lqUQkoqCdImbTL7n+Xvs+5Y91/AhAZq3Jl1yaHAdJWT84xbI3R9GRhgPPKq5Ob7J6w9vOhCVjBv8+eVw54/X+CKy25h60hlAgZRDbdOAVeScOxz47a5eVGj5e2YmDiz9Ud+l4AJ/xi/W9I81er+nF3vf/AjlC2P04VawonmA9qfvXywZ2P3oh9GF7zqV37XBOVY0L4DFa4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEiWDMXa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEiWDMXa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQF130xVXz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 20:08:22 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so3005468b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 01:08:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474499; cv=none;
        d=google.com; s=arc-20260327;
        b=eUCTKHg+DU4sb2oyEw0TTyBN0kIIkOF5T2J33qXtiXfNjd7wsZaO8j6ypDyXMupiKk
         d1//V55fQWKsrtOWLxdfz0VnM+66hwGwdOPPBKA2oF/DJJPB62QJRX0hmwmhhoszq2sO
         ZNxm6zRFRvsA5Z6nR6nGiWCGHbznKmRxLQWEF6P/o8s/IQyiEEDoI58/0yNx35U2rX/y
         EQpwv4Be9JEc7X71iIXmcwQgq+v7Yjs426UyTamxQTzyjuPYslNCAtVCd7e4wLqH1ypv
         jOTWKucdua8MjRb1npbI2+1JqiJF+VlarKTofjkC1Iw8hbfb0UvpWG8r5yQxGpK7v2hl
         E4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5uxsE6PqmpKFZd5WTCPldAkadxtOwm9bHGSoZKmkpDY=;
        fh=PxIucXtOGllolPR6MaXlxTJKy1Gq0gHOU2dwKA3NQ0I=;
        b=sy45ywamDCGsrnEh42oqJyIn4h/APgQD2BUUPOQJhCpptuzHcZK+sahuGWx4Lt+evO
         ACgrOuG+tWQrGmjcH7DEQqGEZvsLGpLv+sTh9uArpq8He5ho82dTZdlXDGcUDQhGCbCM
         Y8Vci6PFOHq3zxZNpY/Y/MT6/6X56iRLWccHI9HrsJgui7cKYKBeeewVH7G18R1xMMHt
         OjiWlF+W3/3fdGNzyFFhfUwPrf4z3x/PmJXrQG0fiv1a3fRyv7gDCNZVBFV7PmFhYwZf
         nzA842PenzPtGMJKWXAkG+GCP3PdKX7op1FIViX4bsiyQgCd2nXvKx9pifFtv3ndOQpk
         aQHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474499; x=1795079299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5uxsE6PqmpKFZd5WTCPldAkadxtOwm9bHGSoZKmkpDY=;
        b=QEiWDMXa7tSiRrSd6elBvt2NOp4NRbSzN6jWOYEXNaQ5x8oD/Wj7SSsSbFNdgZhytC
         C+CGEaLi4jGMNhkGiLhnj7dlp/B1KCVfTi23iT4h/EYS46CnabDliSdOkdJ4azRLJ96Y
         gEzHBP5lX9fmFXdjp9kPvoAxAwCABMOu/c1CfYNLMct4MBQqX8d98FFkFi12YUcW0+SK
         2z17xXshKrRaVXK3Fj/ib+fvXcxKOi7xTsoePGnFfuuLG2RfOwS8WjZPrWaChyd+Z8GN
         ykj1KWuG6f3F0bVQBy9pRwDlkw6TcTsTSWxiBJnGUoYC4OXeBJY61Nx9r+cjpMOqQau9
         FG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474499; x=1795079299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5uxsE6PqmpKFZd5WTCPldAkadxtOwm9bHGSoZKmkpDY=;
        b=YNHzF1D+oykgLvAAFV6dVjlcQ0FnuVU9rvVAZA+22flg3BoS1E1NrCJjZbKjd8MjdT
         SANAecLo/62gaXqch/HZZAyLAxXOVblFAvdqKPdeLCf2vW2BEbeEo4H6lCR8hKvtcMT4
         fyRwmtKTBkW2PfkVZmr8YSqHAxefOm5WBNqFMJQldP6nXWfEUEljnkmtzwCTCvc4ikJl
         uYAjVlm58ZvTCsb2vVz8AAghhWJaozsFd7Sn49xktxdJLx3oFFzUySnp5q86O8yMJ15G
         X+O0KEVD0v6Kr1zaDAqVZES6QBaLqBz4lELJ+5H3CH2BFol4Sceh+xIV0W16wzyyC98Z
         qbJg==
X-Forwarded-Encrypted: i=1; AL+hErH/csS5ruCiNbcIF7qcTkMuuZ6ZQR1eqhd1vsO0sZvW4CrFA0rUQTDvdSU0yt0IMOA6H24IGn3cDZF+J5I=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9QeHpVJBpWUn3CdBJLPSTYYWymz6pLO63MEi6+Y7YNOkkQ4hSw
	MZ0YQgLAC/Nk70zEgjns2SyUBXSeeGVE1EoPou1PsIXLecsPblhSwsfMOQdU8Dlw6fLc2jWgNzo
	S/DDz6Kdj2k6aa2kILX6sv8iQEH1oSdM=
X-Gm-Gg: AYBFou1GzuRwOP7Z1tObnGFKPALRAHYq3uWTUTr8HvjKTM5sKutdtrhu6Fh06OZ8F8v
	G13t6nboMs7n23SEbwnbP9KMYd8+od9QwKd0/qTtLX764/2chEcsTtL0RQey6Pwpe1GqzpyDjwf
	pthmczRrZV8XWFiRiUjF3jurP9RCh5pUJ1B+JMiLgU6mdpnWmz5D368Y3LAqxR9zAO6/I1vl0Pz
	VINzD85jNKkZmdHMH7J8TI8jDlF7akBcMrAd8Ycnhy+g5Yt0/eOECFg1AcH5WMoFa4nuS8uy/Rm
	ordbcRO1wYWzdbo4PHQyMdqQo+uQdsjX+Fc2XixdfeisI8N6RKEXhGwA2aFl1nb3S2KMcUUEUHA
	/k3DusM8K0xBaNORRCIpmDLLCTR4+q2dXyUECs3v22CrqCMQQUf08mCz5MQ==
X-Received: by 2002:a05:6a00:982:b0:886:3827:c4a2 with SMTP id
 d2e1a72fcca58-8bc19503fc2mr5293685b3a.3.1794474499419; Thu, 12 Nov 2026
 01:08:19 -0800 (PST)
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
References: <20261110120743.6301-1-stefan.ghetu@nxp.com> <20261110120743.6301-3-stefan.ghetu@nxp.com>
In-Reply-To: <20261110120743.6301-3-stefan.ghetu@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 12 Nov 2026 17:08:03 +0800
X-Gm-Features: AclHuK8OFan-61VHpWDbQwD5GQhW_fgRO4OvBxXWkrMrWUfYeFa8VUbGfv5vQOs
Message-ID: <CAA+D8ANdJCkf1i7MUJVh7z7tk3Ka6gWZ0ynMys_Qt70ZfaN0=g@mail.gmail.com>
Subject: Re: [PATCH 2/5] ASoC: fsl_asrc: fix pair ownership on repeated or failed
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, daniel.baluta@nxp.com, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 8:08=E2=80=AFPM Stefan Ghetu <stefan.ghetu@nxp.com>=
 wrote:
>
> hw_params() can be called again without hw_free() in between, and
> hw_free() is also called after a failed hw_params().
>
> fsl_asrc_request_pair() always takes a new pair, so a second hw_params()
> leaves the stream in two asrc->pair[] entries. Only one is released, and
> after close the other points to freed memory, which is dereferenced by
> fsl_asrc_isr() and fsl_asrc_m2m_suspend(). After a failed hw_params(),
> fsl_asrc_release_pair() releases a stale index that may belong to
> another running stream.
>
> Keep the owned pair and only update its channels when it is requested
> again, and ignore a pair the stream does not own on release.
>
> Fixes: 3117bb3109dc ("ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform =
drivers")
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>

best regards
shengjiu Wang
> ---
>  sound/soc/fsl/fsl_asrc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index faf348dd582d..5d97789b5c36 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -216,6 +216,8 @@ static void fsl_asrc_sel_proc(int inrate, int outrate=
,
>   * It assigns pair by the order of A->C->B because allocation of pair B,
>   * within range [ANCA, ANCA+ANCB-1], depends on the channels of pair A
>   * while pair A and pair C are comparatively independent.
> + *
> + * If @pair already owns a pair, it is kept and only its channels are up=
dated.
>   */
>  static int fsl_asrc_request_pair(int channels, struct fsl_asrc_pair *pai=
r)
>  {
> @@ -226,6 +228,19 @@ static int fsl_asrc_request_pair(int channels, struc=
t fsl_asrc_pair *pair)
>
>         guard(spinlock_irqsave)(&asrc->lock);
>
> +       if (asrc->pair[pair->index] =3D=3D pair) {
> +               if (asrc->channel_avail + pair->channels < channels) {
> +                       dev_err(dev, "can't afford required channels: %d\=
n", channels);
> +                       return -EINVAL;
> +               }
> +
> +               asrc->channel_avail +=3D pair->channels;
> +               asrc->channel_avail -=3D channels;
> +               pair->channels =3D channels;
> +
> +               return 0;
> +       }
> +
>         for (i =3D ASRC_PAIR_A; i < ASRC_PAIR_MAX_NUM; i++) {
>                 if (asrc->pair[i] !=3D NULL)
>                         continue;
> @@ -257,12 +272,19 @@ static int fsl_asrc_request_pair(int channels, stru=
ct fsl_asrc_pair *pair)
>   * @pair: pair to release
>   *
>   * It clears the resource from asrc and releases the occupied channels.
> + * Nothing is done if @pair does not own a pair.
>   */
>  static void fsl_asrc_release_pair(struct fsl_asrc_pair *pair)
>  {
>         struct fsl_asrc *asrc =3D pair->asrc;
>         enum asrc_pair_index index =3D pair->index;
>
> +       /* Only the owner clears its entry, so it cannot change after thi=
s check */
> +       scoped_guard(spinlock_irqsave, &asrc->lock) {
> +               if (asrc->pair[index] !=3D pair)
> +                       return;
> +       }
> +
>         /* Make sure the pair is disabled */
>         regmap_update_bits(asrc->regmap, REG_ASRCTR,
>                            ASRCTR_ASRCEi_MASK(index), 0);
> --
> 2.53.0
>

