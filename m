Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64F606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o9QADggy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCzzB2f6Hz2yGT;
	Tue, 27 Oct 2026 03:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793033174;
	cv=pass; b=mbqLERq4yH8HMDkMOweEZCMmnOvtHY7FQOzmW2o7szL0niTDJgGohtVbCQ56GC+T/t8U9l2p6xR/HwMF85knTg5vVT2VEf1q/n63KSx1dfaSnLvENnmkbUvk6A4HRQrf72ny4o9tG77Iw/xrMgx2KmUlNhwtG4ec2zq6z07Y9jG4VLNJ5SuyqzN3s+fcKY4DFI1kuAcnMvS0yxSgXVGwbvtjLbzrJ2wgY2NxI5+Onxss8Etw9fyBmG2t+gj+QVK3SzAT6IajWDF+fTSBb1RY7fWg+bHXaLP1h01ROmSWS/QT1q0slQH2U+GNvO0M9JiAHm1TgW2tm9AiOv4OML20Aw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793033174; c=relaxed/relaxed;
	bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0VfW0PKnrW2EyPzarazZhORYdo2zAc0B940FDAYdC3eyG8U2vHn2kJG+VR5XBdeA5I+CwGVW2fvN67O14qYnl4M9Q0OTgMVb/o2mE8qiRrhfwLaG1prsZ9fRw6XOEzI4zhZkizSHvwQPv0bvwIsBEHrj2whwG53UXQF2ztle/17KyV+wCIYdlQ2Tt97Oee/QDDt4eNU4npQmLgXMWnZNwPDCxioEYGEQJhSi3E2Nzs3ceDc0tmbmHjv3DkqjKR53GtbGW9ka7YhLyLvIlUxXGEfVcz0KJz1gCwP5HTo/R1DKORDdBFTg3ritypmeE5WM5K1QfDqKhm0131H3M+Nsg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o9QADggy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o9QADggy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=james.hilliard1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCzz81mtFz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:46:11 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so3962202a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 09:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033168; cv=none;
        d=google.com; s=arc-20260327;
        b=mAmxslgBy/yb4ERwQpVl5rKKimo+yYFBychQPXJhbwR/XoVAQ3XWcAFlGZsO28Mkv3
         WFM9aGSWDN4xehWY8vBiPScJHF8ZSYJEYAW16vR/JGn6aO2bj5qivETwpnl1FF1TKA6w
         UGBfvHO3g/GqB1U8kBghtEJNHSwbCstviji+7O5Ck2gceoQ317pPLXeru27/2FEbYvyh
         9b9utaoLCb+2FlshOAk95pv7sZgHBSvxrM1/ZAXHJDx++tCXcpRGXd/19LFgyWkNgX40
         JYV/vllWk1UoUgjCryp2NKDHgha/tAU65j05xwdNoFmtkON0VxG5eFL581J1mXUR6CRE
         HQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        fh=VgDBA/I59MYOs9di5iG+1CY3cTywzqNVUnnpYhfSgBY=;
        b=qos0KW2tswKmhyRTXkUmdyknAOhVQ92y248ryF9bNBINihwJLmjV1gty7iAzqrleyd
         8/twjh4cpIyNRYEljDcigKWmlscN34wsRsMU6tu6h1EltDox5RB1EIyT7qLtlQbOaJqg
         jjI2CLXMmuo+3GNzhHH45QYgyOAokaWS4qND4w2vCDu9YzveqxWqyujvjFfqtr/4Ysub
         pzzTthG2VWoud6Q+D18lU0rAuQDhyrZ1wlVITYteJztVjtnwq98enyw2pNK8IzBar5wB
         sUpTp+VcI8yU8fgwgvB5zga5DMrggLtYGkfbPVe7qgB6v0guSPgm098TP0pk41uK81sI
         87yQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793033168; x=1793637968; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        b=o9QADggyormhq7HSWU4PLcEB8a3ABJOdaz4ioUfDdbOyDhJVnWxJCg/8QlHylshQvG
         WLzL47FZ4TYHEwk7n2R8pNaG8dVX9UFs1m8XrgtiMvn+ZWVF+J2lRpG6KQBWdUx1uDxr
         ejyVjpSCb0Gu+tbe3jnvIFDyJV2SevYoBPWUOJ6ivb5KfkASciE2FAcplCZ42jWI9XCi
         Lq1vTvL2DjcS0aiyK1qVhrHTSoiJeOeN/FdrP0K84m7SKLNF+FzPPchRmF+AF/26NMTy
         R6mWhTeifWdLUd64gsFzQviOFEJnii2UUWofREjKxRdUpLVzytFp5oHNCVHFurggb7fW
         bbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033168; x=1793637968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbR6KDZ54pfKvX4mBD6E1CqiOyZSCDGH5Y/Tf8ZG/yY=;
        b=0cUNU7nL9QFBxpR9hWttwv+onvDKEysdYTwNbZEZC1ggCj/T5+JD7YncC5i1vY1/9o
         xQMHkpBfHAaDzHEamumQYJNjP0jHqmz5kOdjN+FKh8FMqIVk7+mcxMc+Vt1UP0TdBLqG
         LJYFP7ict2GS2ju0D+TTK4VncDaedWGsRdv9hdjaRIaGWZIv/LOZv+Td0BlpzBRdlrnS
         7ODntx5NoI1zpLYcb8QoJ5NrekVFtEcGpc6zAauOUmLRYG6+thKS6skV0kyEW9wizjGp
         U9F+nKQgxAPtqMZH4+3rlFZ4HURTpTBymIhrEvkMt8cUgUWjP4guqH9w+4iMxvAECTk9
         s42Q==
X-Forwarded-Encrypted: i=1; AKwUvBzUO4xobN+H7fDXcwap7ygcLl5H0cVWm64lDOoE/eg6YCaVx0zaWAHr6/Hw32k1ILX4UXUSrTr0T046i5g=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI5FU+ev8YvtpE3Acql92yVEv/nnbmSupx2XlFPmimU8TF+Kdwm
	jwj2+33Esr6xU7RF4a4P07OL2AkmLDOgKDnj6J6gfVp9yLfxI5U7VsAl/3AyUR3jEBvmCC9q2U0
	g5Y0yUzpMUDvSgeR9vEKLYIjA0TeHsNE=
X-Gm-Gg: AYBFou1DtxGclpqvoQsQyL5QCPWfzZaIH1oWWWnJvDgY2isjBo2VIuLiqb4Upcu3ETZ
	3bMdA2at8dmJbyH9AOF6eC2MFz1O1w9R7eu9nl/IfeKmFXM5DK8zblV3NKd3yj06QWd6QUPfqXX
	TNgr1MUMcBFjU7iKH7yC0eQHbqzTcNwx/eIXV+Kg3lIIMa/o70waXN2hh/YdAoBBy2Bd0Umqx8b
	95ayz3fDOys4lOsHKuteVNWvbrkSVd6dvRPQf0vGYv9YusydXCah1imunkWnx2KMrNikjOEPfuk
	qGA+dYuN3CZoXiAQk38vyinRaBNPSklpPlCVkCg4JEnCIn47nlmVv9zDCQh39IldbSu8qg9r/C3
	n2D4uKqlA3iLv9GCeNgFeQyibrTr9fGlnuF10Q8ezo6hUbkdd5jPbxrQpiww3W4wq1Zzr8j1hJE
	DTF/pvFzNHBc5wbZtvruczo56l9t1J517iJNQSOqztz2yKXJ4ROVyWG3/99nZYV4GMhxEjQiRr3
	qS4KK532u8Zyjy4q4bdryEdcjesQ7CU39SeN4n02geZIkSmqjw=
X-Received: by 2002:aa7:ca44:0:b0:6b1:b611:a2af with SMTP id
 4fb4d7f45d1cf-6b442ff2fd3mr6024136a12.20.1793033167557; Mon, 26 Oct 2026
 09:46:07 -0700 (PDT)
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
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk> <at4bw-G8czG-G7Wl@ashevche-desk.local>
 <CADvTj4psJcY2T1PG9H8_hJWjz62R7unj3PPgv3FrVquUMFVhGg@mail.gmail.com>
 <at5qKehogAjTa-fA@ashevche-desk.local> <CADvTj4qSgE6Rc--mWuqAcc8HTqN9EFOS_JM8Hp8e_=ka_ZLa6w@mail.gmail.com>
 <at8eDFj2WNaXDaot@ashevche-desk.local>
In-Reply-To: <at8eDFj2WNaXDaot@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 10:45:54 -0600
X-Gm-Features: AclHuK9i3gJhID1qYhY2EyC-ofDyvA_hJVRAckf-dNWT3ME93Ru8v8ikGWkk384
Message-ID: <CADvTj4oNz-bnSZP+kfau-7wBSWLjLTP5jrr6nLfdCHNPo3pS6w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 3:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Oct 25, 2026 at 04:11:08PM -0600, James Hilliard wrote:
> > On Sun, Oct 25, 2026 at 2:44=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sun, Oct 25, 2026 at 02:25:46PM -0600, James Hilliard wrote:
>
> ...
>
> > > Some people might want to test the stuff. And sending too often you a=
ctually
> > > will get the opposite results, people will be tired to even start rev=
iewing
> > > and/or testing your code as it's changed way too quickly.
> >
> > My thought process was that people wouldn't want to be testing code tha=
t
> > had known bugs flagged in Sashiko reviews.
>
> Sashiko reviews are not visible in my or any other mailbox. To see them I=
 have
> to go to some URL and so on, meaning to waste time to see why on the eart=
h the
> new version has been sent.

Maybe the Sashiko reviews are getting caught in spam filtering or something=
?
They are showing up for me and on the mailing list[0] so I'm a bit confused=
 why
you aren't seeing them. You shouldn't have to go to the web interface[1] to=
 look
up the reviews.

[0] https://lore.kernel.org/all/sashiko-outbox-183574@kernel.org/

[1] https://sashiko.dev/

> It's better before addressing Sashiko comments,
> reply to all people involved and to Sashiko's original email, so it will =
be
> visible in the previous version why you issued (actually about to issue) =
the
> next version.

Hmm, maybe it makes sense to enable recipients in the reply_to config[2]?

[2] https://github.com/sashiko-dev/sashiko/blob/v.0.6.3/projects/linux/mail=
ing_lists.toml#L290

> And before even issuing it, wait for a while, people might
> disagree with Sashiko judgement or your replies on how to address that.

I was assuming everyone was seeing the Sashiko reviews getting posted to
the mailing list already. The are ending up in lore so unless someone isn't
subscribed to the list I'm not sure why they wouldn't be seeing those revie=
ws
already.

>
> TL;DR: this mailing list is *not* a playground with you and Sashiko, the =
whole
> community is behind it.
>
> > > Settle down first
> > > with something, put on the cover letter the answer why not all Sashik=
o's
> > > comments are being addressed (for example, due to amount of patches o=
r the
> > > series being focused on a certain issue).
> >
> > So, in general I've been always attempting to resolve known Sashiko iss=
ues
> > in every subsequent re-spin, so that would be a bit tricky since I woul=
dn't be
> > aware of the Sashiko issues until after the series has already been sen=
t.
> >
> > Usually the subsequent issues that get flagged are new issues only disc=
overed
> > after each new re-spin.
> >
> > I do have a bunch of UART/DMA related patches that don't have flagged S=
ashiko
> > issues so it probably makes sense to try and review those first while t=
he larger
> > series that have Sashiko flagged issues are still stabilizing.
>
> Yes.
>
> > > > [0] https://github.com/sashiko-dev/sashiko/pull/389
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

