Return-Path: <linuxppc-dev+bounces-28773-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F6FCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:46:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxK643LzZz30DK;
	Sat, 03 Oct 2026 05:46:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790970380;
	cv=pass; b=asdJcra+4/RpmRgOJ5ZT+/fugQ68rt7g4Oi4LRtFYbuUoUST1MLlD+T7M8drVpk20du8zIg6W5g/tEGtGPX9wW9Dk3YU0rizWCNlZcBfUVvPm8rWTfHx0jMLXY2A454n7ixb+kIHdQ5U5xUpDdVbnODLbDrbiapvW+pffRSorg71N0udPmWs6pE7Mst1nbxxVLbgapuKFinDDBSf22Z2JN9cMrWKNPaeRSzmp+RkA9xjLQdjOZ7VUBTOJhCRrtwKDYlUaVE1ofDNvBJNylUzOUa869i62avFCLM71rF01nwzZnx8VFmTpa/cDmRRbUz9vo+OOmXk4zvLOsmm5WHscA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790970380; c=relaxed/relaxed;
	bh=j+6anAjBWwwyq2myOIAQCnGt8ykxWfOmfyjZNrQsOg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2pjXhCk1Fw2eTEbvygW9GzSFrGjl07CCJ6rw3hfPU2o6l+5APMLhyq4AzIBy07NQIuI/AoXizSXGAvJ+V/AlbiafzkgZT/Qxn8CT/SqbnGdi+kIDKhpUnLtQ1lml4PpK7Kw4id+xz5HOleNcwHE4QosLAfX+iktXwvexPttLRoQVpX2VXO7BUyAgyFFXYaYEwDrp7uLxkaBP6NKcL4TxoRiYTgGxcCEGl6rMcqx57iCDjOrBOFKLmuX8/+xJZdcyybP0aknTi3Hn3cTQPtgzQ4Gq2ebiscD5yzzetMVQ5DNyQH8r7bMcaWAS8d2pjNx0HPCKJfQyTt91SZMaGqnoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBlIaq6i; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tBlIaq6i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxK622rpMz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 05:46:16 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so1647368a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 12:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790970372; cv=none;
        d=google.com; s=arc-20260327;
        b=dZgcahpHAoAWOLRnZkQycLL+g/RgASuvC/dBbpBMUnZcuKscYIgP8pyNPhTtJ/KvNt
         b2qFpJipfsOt8QFzckc7l07aLLKB12fVUjoGUKevWuifuF+LWiMAiY2GhaCllKPZzgQ7
         4YwG3R4YwYqaN+yjTd91Mgu6giENcGZ74/xxp9UI/1u/RNzuDsckQvKpObFuy0bs1ldQ
         00X/a679fr1RtjSPFC1x98E7oiLL68QjNY2cxA8UbTUvysjSAfluv5/6zP/uifRrqinQ
         RFD1mYY6l8u+octtb3U946afH7FoT8MQQ3a4TUgYAOSdZ/MlSuenresqLGXmqS+vUD6/
         rKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+6anAjBWwwyq2myOIAQCnGt8ykxWfOmfyjZNrQsOg8=;
        fh=+WHVAFOYd7pm0TV/eQOY/MNwRpjqwTPyV7OPSGCn7Ts=;
        b=U2Orrdwm77VE7pKOFT7+ymSWt8Xxa7eukMWDKFYnRh3RMstjxTbuGDHMyb9Eh6ov98
         LNHa6XWy1vmy/nmCYorliYGTCkqeOjhOfh+BxW+un/qmITzjw7rYNJD4sA0AKcMBQiU+
         XV5P1kqr/AGeW6nFhSIWbgnxzLSqH2tX7y4Zhp2BCQUaigtd0bSISXEIU/5xj0alQqwW
         Ph+F1mXxebkHgDvYgeFUBa0X3lYTIDwjRvNFQ5oVFAA9Z0jc0JlYZCLPsbgcnZHcOjpE
         bH6Xe0letKNhJYHnmwkrxCl8SD9znr0nnxnPwqE4oEHGGM6yhWOZGc0p5K4qibKexI5I
         4Gog==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970372; x=1791575172; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j+6anAjBWwwyq2myOIAQCnGt8ykxWfOmfyjZNrQsOg8=;
        b=tBlIaq6i5ElncolJmADgSbdwwO3qfPl+/v4HeFvU2A02ZZGUklTs/mrQtJiAZTkC/k
         6estJwiT62+7TDA42N04qAENRNJzpzD3neGwez43wXUwluGo8AYwPo2mN7W8AZsnKLEe
         OH86GKbfjZcvGexChEyL3uuHMKLvjzSezvXvfbCpfDAtvAisvkFqqjAWM8Rbv6mYFQox
         uaPNsZdu3PphclV4aMtku8wYkwuw8nfAOLxztrukCGjv42qQ+80oeLYpKXhMy8/vKYZp
         MajM3XrVoxCCFufcRWEod/CXylcakg2DQUuYQjeHMEIwYUQ0fd7b29u/9nQfBkR9V0hT
         xp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970372; x=1791575172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+6anAjBWwwyq2myOIAQCnGt8ykxWfOmfyjZNrQsOg8=;
        b=1fVMGfBpZBYki4KU/rm04rVsilqRXwkqqVGSdv+ICst6KYsrKdadHAbYm/nUoJYZfj
         ZD98bgus6PoyAJA+/BJB1I0YQAocmOVn+q/48+YHN7diNqc48tQwQkuwgTvPgpFvEncx
         JBfhj+WvFbHU649zZTZZiFFvt1nRsvAdFhXIAJFhFOjZBrZjtBov221u+uOy9P4Z27Yu
         1tK62XgJyt0f4OLM1NRqZvq08RlVKv6YzUMqtBD6jTBnuJZ/qqi2yfbTcVFQaZH+KCmb
         l2MdppFpHataC5W8fdiIQEcT2k5btN+z+YsmEeeY0tvN8WqTrpAGEaedV3nJJkILaYzG
         vuFA==
X-Forwarded-Encrypted: i=1; AKwUvBykeBN0XZE+ruf9r6jIFyAMkTyFG2EzyWBXvF62Z208YQ88KKv4PxrQabQ8UNjpXylvHV8b9+1is06PQ+g=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJO92WRXINdyv6K5M7834mr2ga++rcO8OLYCukvjVGuT4DHYnnL
	YUA3TigFo6En+QumcIKhH715esWV3q2/5YEJP77tgA19++aeVEoA3zLCxbdoqBm0LeoOOdQoF+L
	/tBC5AePXkkd3Xi0ALIv+OoT83qfzYQ==
X-Gm-Gg: AYBFou3H9a+QXFIrgFJ8ZOKu/+oI9+0ngNLxl+J+1Ihj2SDlgZSW/QQenA4/k2cJ97W
	44n1Pl1KM+LdaAZtYKM6TMuZSf21zgaGzj0rMAk70ZwYMiKUQ1Ltcj3i2VG6W1MCdrVsA7vR7Cz
	s/6qH4Yfnoh48IKUjAdXcoTw+YVBrjZ6B4UMP09dF2uACJqGxUwOY0kXNJF+worM2NEm00KdgqR
	rSIWdHnEKYnkvvoLP/0YEA71EXB/Mw2zWyUZvohgSHEVHoNV72ikF6AGmAs1571fsN11IjY7PRK
	V0TeJwwUCpmOohXrryzECp8BvbF/7iVOtDQdI4HbWDyHMeGrQ5r9nVEK0ZqBM4lQGdVD9DBFo0A
	i5svMF0g4PTpUMbCM4IqREPb9K4qXWKNjP0kxHUFU0pnL20FKQr5xcE21yAiINspGvCbO
X-Received: by 2002:a05:6402:5389:b0:6ae:16f5:5bf0 with SMTP id
 4fb4d7f45d1cf-6afada04d25mr366851a12.29.1790970372050; Fri, 02 Oct 2026
 12:46:12 -0700 (PDT)
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
References: <20260917200136.75721-1-mhun512@gmail.com> <ajjy7y3ycnfqrofts457he5zlv34ncqg3n3g2qxgdgod5vbb2u@u56cc6pxihau>
In-Reply-To: <ajjy7y3ycnfqrofts457he5zlv34ncqg3n3g2qxgdgod5vbb2u@u56cc6pxihau>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 2 Oct 2026 15:46:00 -0400
X-Gm-Features: AclHuK-OVkulTTcELXTW6ppNQtuiiKOubv_hU1rUhsWYHuSBkRjxBxVA6Daq1vQ
Message-ID: <CAGEsz8FO4vN2yg=n7-Md9PBm5XVNjSiWAkH0fXNANZkYgUOkhw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O object
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ioana,

Thanks for the suggestion. I've moved devm_free_irq() into
unregister_dpio_irq_handlers() to keep registration and unregistration
in sync.

I'll resend both fixes as a two-patch v2 series, with the probe
error-path cleanup first. That removes the unnecessary unregister call
before the second patch adds the managed IRQ release.

Thanks,
Myeonghun


2026=EB=85=84 10=EC=9B=94 2=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 6:44, I=
oana Ciornei <ioana.ciornei@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Sep 17, 2026 at 04:01:36PM -0400, Myeonghun Pak wrote:
> > The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
> > releases that object before tearing down the interrupts. The IRQ was
> > requested with devm_request_irq(), and unregister_dpio_irq_handlers()
> > only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
> > to the MC resource pool without freeing the handler. An interrupt can
> > therefore access the freed I/O object before devres releases the IRQ.
> >
> > Explicitly free the managed IRQ before returning its resource to the
> > pool, and perform IRQ teardown before releasing the I/O object. This
> > also waits for an in-flight handler while the object is still valid.
> >
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> >
> > Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driv=
er")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/soc/fsl/dpio/dpio-driver.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/=
dpio-driver.c
> > index d5198ffc4455..fa82cdcc4922 100644
> > --- a/drivers/soc/fsl/dpio/dpio-driver.c
> > +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> > @@ -263,6 +263,8 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *d=
pio_dev)
> >  static void dpio_teardown_irqs(struct fsl_mc_device *dpio_dev)
> >  {
> >       unregister_dpio_irq_handlers(dpio_dev);
> > +     devm_free_irq(&dpio_dev->dev, dpio_dev->irqs[0]->virq,
> > +                   &dpio_dev->dev);
>
>
> I would suggest moving the devm_free_irq() call inside
> unregister_dpio_irq_handlers() so that we keep the register_ and
> unregister_ in sync.
>
> Thanks,
> Ioana

