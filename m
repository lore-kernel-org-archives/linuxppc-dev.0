Return-Path: <linuxppc-dev+bounces-25476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5EC55838
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:28:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwmD1Shrz3054;
	Thu, 06 Aug 2026 15:28:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785994092;
	cv=pass; b=PtuE1ctD/9Alg5JfsFgLv3g7r0LDfxETN7+ELP//9iA533wb7yth6BvqZKzWghUIoYGGki2NjAkv93YRgecsIPALxmKCXd82f0KS7duv4gbSdtc2hWFgGISP3Uib+cfBBxTxP1AaM6GGaksdi2fC2PwqCKM+UXJ5D5St/VVn41flzu0sO/2T0ujL9J2GBYeH+BgiuBPWjFM44f0omMlUH8nsJ4OJ97JU/NMSn+P2lCaSMD/W+YVkwYdw6ICWoahw6AvkuaQkuYqfNnAraPa4d9hp2nsltuEojezXyopuP7w/hsQDM0kHub6QPiwS+NBgDrM4LUt/W6Jciwi/ilrffw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785994092; c=relaxed/relaxed;
	bh=5/chxC2eDdGa6xrgCohNp7hs/WOpE04paX2N4M4f+KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzOeDxO/n/83eaRIlzUeJbj11mcmUS/uD2GS+hcIph1akCDM8Swrpo9TCp2PfXNj61KLiCMicXsm922R1O+iBM9XxXY5IQiofMTqUYloO0qvJCpkS6RJ50dG0pKdEsQOagC9ccxS8VHSyboaZCWbdmmOAeuNiw/4IZFzQ1O9A+uR3waml9dXnnL3u+9K2uJlExcBwkQYR79XKf6GykUuQ9/05GzRaM/bnQvEHqNQHXNC0D4t2QJWHMX6MlPMQ42OtNm5v8YMkdYeS/GFDZ45UKKKldHJpj1QSu3d7CqzeDv3sKJOXaNpE2USmt++q7AbE/+fTTW2XzHFI3FdyR6tRQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dYbzBkjg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dYbzBkjg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwmB14HSz304x
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:28:08 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2ce98cb8165so7151435ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 22:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785994086; cv=none;
        d=google.com; s=arc-20260327;
        b=LM4bNzMItQPn53Li9EmsUtqaccoUByYdqa9l1nJIR43Gti9dOMOZ4Zc6hyWi96eRxH
         1TfPYJxLLkG2ZDqDMK8RLO/nMUykSGoGwxXOIvqEHV6WNnNlzZ8Iy6PgtcjPsmic/lVs
         aFEkXVETbkmLYYcCqvvWN3G/hdfa6u3f6q6WJ40SgnPFUD0km1Q/Kxdtcvb/8NxBPTVb
         S/dZxwUDz4U2iyQJTQ/J6jPn4IApNL9jDfbD2GhKUrDqkIprM6iZMA7TbMkPirZndSAG
         wNw7L1ed8oQw2cxh4zmUsYxvl0dDcwpoHW4/Ng2dc/k7MdY7Ry+hEsUV3k366LiMn1L2
         u5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/chxC2eDdGa6xrgCohNp7hs/WOpE04paX2N4M4f+KM=;
        fh=KRDldNBfIvulZYyLfFrQeZMAaT6WX36NU0OjPXi/wgU=;
        b=IiknqWTEdBf1zokGl74pydIv7IkDbfZ2UsKeSgV4jjDqXjIcczivyS4Qkar5i/2DMf
         DvHPYAuDmi+xjrtMeYav5U9IZb+Rn3RwGARMUrjs7HF+UP7a2ysD8n0bbMdYE0kxUg8J
         1nOKgGUIun1QFSxCCmnD3UU/t51VbejHBMsxi5CrKGyl+B+xGQGnAHMX0ItH0wuGQy9A
         NA/241bX2gipX1G+haUXdMkbZ0xxq0s8KwmtBb+EUg5weqbsN+c0uhhbP8UodOl2lMam
         zO8SrUvV9CL6kb04+3VKRHjLzJCt0a+/sDRaa/hk3ekjM6gh7tXgehVJwT6XkUu7w3og
         mXWw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785994086; x=1786598886; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/chxC2eDdGa6xrgCohNp7hs/WOpE04paX2N4M4f+KM=;
        b=dYbzBkjghlGyqYrsyIca3bI1BDTEAEjWgyjKkIP7yachldiShvjfSTaZWd9Xz14gla
         uCCIywi7cwW/cD7eLXhwlQRSPg1ONngQqM+CWLjEd2Y0KIadO9bOELCK/kdpsTrWciu9
         USF33wAbZe7Ip+O+j3wfGcrVbGTr3LwYNaVP6TDfC65a3W2Y9/lBJp2Krk5OQF5sY5xy
         L7UOVNq/SeMQmqYFcxxXkRXFcdNkSNSEAaiKpVP8DoAhzXnjVyTOEsEv0lRXDVsHfJg2
         GVw3TlBflxH6iiQONwz9QftjzUE7eW8dbMXpc7jbngoGEZYJr2OM8T6TPEo+6VeNlBJ7
         L0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785994086; x=1786598886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/chxC2eDdGa6xrgCohNp7hs/WOpE04paX2N4M4f+KM=;
        b=nZ23R8Tu7LujF4XGGu8DPZAvuYnYOQZylFAj/c3ysM2LxfK5BaYOacr7ZQ+wd2K+6n
         AkRLB5uYYJHVe+qt3aEwIagq3JEfc0eJRpmg0BH5REULCeenINJ7sP4pYpMDiMsObQ3P
         hz0Eek0c7ZewFz4v5MduvITe/xfUY6qJ8OA4uTMIz4FCpd2hebdCDvs+hO3gAYiBw5lX
         pFX1E1RkMSDN1Ixa1PZerIsHTNnH4vfVXNYb60BQhSzvUCSivtnfaNAMiwgqAj4ILQTw
         S5+sCNJlsw/d/xRoiavJOc6NAfXAUDFBLeamCxSa5vuktgsXC9DkVLh9iwkLBdMnxY46
         AWmg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/DJym+IMJD0li5A2exOjUf9LYsEIgaMeKFyQSjl/LzVl9bC0OYRJXEBr+eqOLzkQji76AmDjaCOz1B6g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQFpRNHtMp1pKXMLgcnMje5RQJfdy/exqXlZ0BsuR0oWbWb8aw
	kITT7dDdHazsLNVyx4ekgv1BioCQjk1ZuPONEkOeuvMi84ovCLbRBIqRNO63/s+U4np/37aoY0N
	Sv4FYxlSfouRkgu3a2e0w4LQe7n8sF+c=
X-Gm-Gg: AR+sD11I9oCMz4ybI0SS/TKF3/KndrwW56fnmUpcdTRORCK0U+AjhG0mqdcci2FmEN3
	dUuV3RERSk1jOgU0yHawE1lfCNlhRijqIB8chi2lSlsXav439U5ZSBeVvqz3p9DcrCrrzdtHpch
	iWMt9QXvYffV9uSdpN/UBy4zQriZRW3DF1e9nfzIkcPcaTiAj4QtOX66xVtLF4Pg+2SOqYZPNS0
	1aof8Mdqa4AaZZAb7VtLgIADZ6K+jFn9cfMhZhu+5c6NiWTfN7ZVsByMVJuZENTHUhwpz3F29K3
	8mHJa23vdB6cSUgQare/mO/r1fYYHowBvSYYMj98720+
X-Received: by 2002:a17:903:228b:b0:2ca:eff:ff58 with SMTP id
 d9443c01a7336-2d0f710991amr9793645ad.15.1785994085793; Wed, 05 Aug 2026
 22:28:05 -0700 (PDT)
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
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com> <anH5i7y3JkB1moee@SMW015318>
 <CAA+D8ANCoc5qOUvTQPRNkvrfqAY3n6x_fbfUveP8Sfv+SL1NVw@mail.gmail.com> <anNtgkZYhoWsSRr6@SMW015318>
In-Reply-To: <anNtgkZYhoWsSRr6@SMW015318>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 6 Aug 2026 13:27:51 +0800
X-Gm-Features: AUfX_myhLzhOuWWyjCG9X66ATeLQftPHIJVdiIW_bTxwa_fBiVstKxt6vFHm5B8
Message-ID: <CAA+D8APMT2eSgrc37n_YZ4PsDZ-_8h4gHsyhADGGYDpTob_g+Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Frank Li <Frank.li@oss.nxp.com>
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

On Thu, Aug 6, 2026 at 1:06=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wrot=
e:
>
> On Wed, Aug 05, 2026 at 02:57:59PM +0800, Shengjiu Wang wrote:
> > On Tue, Aug 4, 2026 at 10:39=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com>=
 wrote:
> > >
> > > On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com w=
rote:
> > > > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > >
> > > > The i.MX ASRC hardware supports up to three conversion pairs (A, B,=
 C).
> > > > The existing binding exposed only a single generic audio-graph port=
,
> > > > which cannot represent independent conversion paths when multiple p=
airs
> > > > are in use simultaneously.
> > > >
> > > > Add a ports container that enumerates up to three sub-ports, each
> > > > representing an independent conversion path:
> > > >   port@0 -- conversion path 0
> > > >   port@1 -- conversion path 1
> > > >   port@2 -- conversion path 2
> > > >
> > > > Each sub-port references audio-graph-port.yaml as before. Hardware =
pairs
> > > > are allocated dynamically at stream open time; each active stream
> > > > direction (playback or capture) on a port consumes one hardware pai=
r.
> > > >
> > > > For backwards compatibility, keep the old single port property but =
mark
> > > > it deprecated. A schema constraint (not: required: [port, ports]) e=
nsures
> > > > that both forms cannot be used at the same time. The binding exampl=
e is
> > > > updated to show the preferred ports form.
> > > >
> > > > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > > > documented single 'port' node, so this change does not break any
> > > > in-tree device tree.
> > >
> > > if no existing upstream DTS file use it, you can direct replace with =
ports
> >
> > That is to avoid any downstream use of the 'port', so not directly repl=
ace it.
>
> Does downstream strictly run DTB_CHECK ?

I don't know if anyone downstream uses the 'port' or not.  so keep it
in this file but
mark it is as deprecated to avoid any impact of this change (add 'ports')

Best regards
Shengjiu Wang

