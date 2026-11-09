Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF48A606A325
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvoSZ8oh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNGVF1g6fz2xdb;
	Mon, 09 Nov 2026 15:08:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794197301;
	cv=pass; b=ftOQW7nXw1U/C6e/NTZHtKWMo6VSkxm/BzYyHfHgiH7M/3gnVvJkAaBm8LFhTzbxHwxw53j8RUOYmBAZBDDtk2y1lqNHhvc6E3sOSNTBK1T84JUEK1GDu8qX70Zu1rvmOhq6xw9oplTEp2y2io7Ie1vtYOsCpL2455VKLq6ZKmFOeFI+X8o9+Lu4fvXrC+u8XrUtOrTv4iQ2MFxr7L+rCtOPx1dIUvMPxp5tZvkvA2y5+e7Ek2VepvCakRAQjzUcycE3E7znVuy+C6b8GCBd2J7DZV/AD1WLnuYPVF1XIxO3j90DOGxc6WuAHkVYH+rZzUXVrsOekC/k+EPIpcBWmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794197301; c=relaxed/relaxed;
	bh=0IEY2oUkY/Exy20gttekfGAPLEe1995noJ1eoGIVUGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0WPExU8dqP8kpzDt5FlIyvguU/0hnK9AzkIRy3U7B4A9Y4YyrIiIz6PEKNGqLbWdGn3yEOAbB9puTzQKqVWyresaNmtytFirngm60tsaer87Cbsr8cilDDFU+ppEzB/qeWWAizSx5xHwGbKJaQMmPRsZHvcAkH0PncQ/ywZMhzo8qYv/wcSFs0H2YkcHkgJy3JzvYZIgNLva7kfO+cMtErJXXsNoL9yIE2M/QUlyyk+33LziPyQrSZSRua9usjmKCWuQrgB/1LyS6bw+lSt8CgpgnveY9dmmHscnfmbLlh83oV2bm1di8anA/B4UEwcsG+daxxqGABk3DqvwA0drQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvoSZ8oh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvoSZ8oh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNGVD0JqCz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 15:08:18 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2e96502e447so3953565ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 20:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794197297; cv=none;
        d=google.com; s=arc-20260327;
        b=WxopLshCVZblj7Kv+SmH8/vi5CRPXjMGsb08AOjZaWc72EMnrxzJVKxheYoCWsJTKs
         lHBEZo6Q6aq/B7ZgBi0JuYhYhq7HWem/DeYCc5QFJYdzj61lTOMypu5km2GT8eVQwKzr
         ys97ncXP1K3XL9QYJOeQ5+97TyUwTnVIkzofI2Wv33CUv14VrYN1/tzHZzNtxbyAX4+Z
         qjl0AmoE21X/bgqgU1LDNqLV/D1rdvjuorKqudXAo6+UNFGcdYV1xOIQAliMduor/C0g
         jc2wnP4Sfn2sIrEVmZDGLtARGOrO76R9nCgdcvcs2SD2zS+NWNnE6osSclhlh4UU1p7D
         YxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0IEY2oUkY/Exy20gttekfGAPLEe1995noJ1eoGIVUGo=;
        fh=aipOBJVUGU1945MV0C87Dts5aMBYRs0R8hrEoIvb2aI=;
        b=mMkkrYfup3c5RamOgKJsUBNWUX9ELHnmqRPTFYYuYGmwbAs1CXaTV6lx72VfJY6VBu
         LUE5UjTcLuC4lEAbO3+mqtfbnULlZ/DG+J2LQlVTTqsDBViq5zlfFg4xNfGpjZ7YvIoG
         tulvhfIqXttUJIEROXMycZH6b/iKajtn0Mpe0R3h57Rs95DKaqhqVj4HJiBvuDp6T7zg
         kjUuOGoMIkD2ORy5fUrYnI3WEGf//aAvsNV+FnU9W37eGP9WmtgG82VK6q6znfvpjrQK
         T90eJTh/DHyuXkLZKZEGgq6hphnimktL8WilWxg2ao1jAcNA4FSU/pI/4XH1yvevPT3a
         rGzQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794197297; x=1794802097; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IEY2oUkY/Exy20gttekfGAPLEe1995noJ1eoGIVUGo=;
        b=dvoSZ8ohVP6cX+r4M1OdB4d8qK+BibzB1GpSjxRs3UbGmGIXZs79D+gWaODC6HZhQH
         NWjqyAFkdcd+L7UajdqpusFqFRpAb116vcJVpdeTzm/tAttd9SylaDBsNV9KMoE6tfVa
         KGehXLdXSnW97F2LSD2F54SvEv5xsYXaxEXFG/NXYCGnnumnmU2ghzAEQT19IVFfyaxO
         E9ti+A7eaRnLr7xFJWH0tBkqCqVuPn8Spx6OKlpsf4nHDyEKpWIwbONQCHurSKx1hxin
         fwGHhmh6KGNHZsujwgFQ1SJia+raLEDDSkHTWv3cp/MUEP4Bh/D8H3XjlRQxSpq0RDm0
         6CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794197297; x=1794802097;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IEY2oUkY/Exy20gttekfGAPLEe1995noJ1eoGIVUGo=;
        b=P46obJyr1rlVWLHkfHvg3Lx2XjRIuSWSIiuIifQGEC78FZyE0RySnGFagyL4+vX10Y
         fq60A/EfY7fqy/zk5MDuHpS4ROYfiE7bwG8GJGvT0AkE9dCb+Wl/G035+Id4gZIPMAtu
         jYvXZyBM1Pj8RUYQIvUZmbNCsLvCMZUOk5N6+l6EkK38XZuoz3M30RAIhUI6SYi/p6we
         h1JM6bndSUupKERUKgtn5Qd2BTVvaOX2O82OrUyc1Kv3Go8GzA+KBQzCFceb7DRmFNpv
         jZUstZP0f+/bViG1oUilcrX8/ruTrCOripzJ4swJIGeRDUCMtT7uBYCEdFu5FNim7Feq
         LonA==
X-Forwarded-Encrypted: i=1; AL+hErFCCJkEBeg9+D/JiYcQUUlsvDQx8AUk2yhMrFc8qDHZGn/2e76OKs2tkRaoqoFKcQk/h4Z4ViCOC7UfpW8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Y5pYcPWjKWouizESo2mdujoBR3nfil73pW3ya7V02rLhyqkTt
	t9qJ4MnWrneVkN68N615d7rNuTBLSUgf5zx32M4Av36B+GkdSoLBxpWxGst9Z0Bt1Sv2/52N3Fg
	Fmy935Ylskb+DU3DFPIh5yRs2VqqTIWM=
X-Gm-Gg: AYBFou25opuKqcKi6vMUEGB9uhihse8o+eTrf1hza14TblVPglowvDClQXeYKwUXXux
	Mv1B3HmMqIimtsH4+SqQFKRtNyA8U2URfrIIwBOcL4HNxvuxo+UDBkWBRMZTXpRm8ExPYAh4l6g
	fW5/+PRNS1WfJKciP2BWH7hWcJUjPNvviwPf2pLKwGc63vH6dyxAW7pUU7MBrKtWmGaOC7hj2QK
	pDBAetAVrWGVPOa18JpL6Pl/8VLMJJFUJCq5tP+Gx4hJzaPSd/b4T2qsfy4kSuzmDD22UkfudpV
	2/KzMTFJNYM/HLjPvcqLtXgY0/86AyneCKPt4NgKd20HSCbreTioGzmeb8trfQEXAb6PkyfxQfr
	ogB5lw439nPy4euloLicvppFMhGxpfkrp86UpXgcXumMtWOb4CNMAvIAGEgALtWZDwD+CsjZFui
	U6f+iNeyfYLPq/Grsy+6+k53jIFDzHMw1C5hmHMYl/MUTI8eASjbWs6dQQmAFXqVvCXim2yw==
X-Received: by 2002:a17:903:2a86:b0:2dd:ad73:c938 with SMTP id
 d9443c01a7336-2ed8377272bmr30112565ad.25.1794197296668; Sun, 08 Nov 2026
 20:08:16 -0800 (PST)
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
References: <20261105104237.38542-1-phucduc.bui@gmail.com> <20261105104237.38542-4-phucduc.bui@gmail.com>
 <179397468197.3073895.1522608204443678480.b4-review@b4>
In-Reply-To: <179397468197.3073895.1522608204443678480.b4-review@b4>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 9 Nov 2026 11:08:05 +0700
X-Gm-Features: AclHuK-zMhWEuwFpd7MBkxqEDP76pBnSJIU10D20h7lMcoXH_TQWFgwLNT2WA4M
Message-ID: <CAABR9nE52Rk81oyoM3L5hHRn3n9OCP3PWSxA8nNt+aEPoeRtqA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ASoC: fsl_sai: Remove redundant error messages
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mark,

Thank you for your review.

> >
> > -     ret = fsl_sai_reset_hw(dev);
> > -     if (ret < 0)
> > -             dev_warn(dev, "Failed to reset hardware: %d\n", ret);
> > +     fsl_sai_reset_hw(dev);
>
> This is the only caller of fsl_sai_reset_hw(), it could just return void
> now.
>

You're right.
I'll change fsl_sai_reset_hw() to return void.
Since this series has already been applied,
I'll send this as a separate patch.


> >       ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
> >                              np->name, sai);
> > -     if (ret) {
> > -             dev_err(dev, "failed to claim irq %u\n", irq);
> > +     if (ret)
> >               goto err_pm_get_sync;
> > -     }
>
> This will only print an error for a subset of errors, things like -EBUSY
> will now silently fail.
>

From what I can see in the code, devm_request_irq() ->
devm_request_threaded_irq() reports every failure via dev_err_probe()
in devm_request_result(), so -EBUSY should be printed too.

Could you please point me to the path that fails silently?
I may have missed it.

Or did you mean fsl_sai_read_dlcfg()? It does have some silent
-EINVAL returns.
I'll restore that dev_err() together with the fsl_sai_reset_hw()
change I mentioned earlier.

Best regards,
Phuc

