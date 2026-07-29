Return-Path: <linuxppc-dev+bounces-25038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C93C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:31:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9LXG1JYbz2xwP;
	Thu, 30 Jul 2026 04:31:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785349918;
	cv=pass; b=d/YZiAABNfGkJtACuYhy0y+SMNDLAcCyXIRhHcYyX2sF4cpx+TJiKyz1rAwRwSpFqBiqqB9sVch1BpI2E3jgQBxYk7k52aLlEa3rikBqyr2UL5rSJiCeE0MES7dccLPo6q/T/+JywDsXlsrDVpxYX0NidX1SvkvqydPOkovOLRBgn8dOvMks2GRsr2tZEAzPKfguQKH+sOKokqyDIgUhjLQlaAyXNgoHOw9a4q9784UwIdAPyMuo4u88RnGMhUsD9FW+XtvXWI/13OYFK/ooHTgFt/xw9mVHq7yCxftJ7Q2xGUN+CA0SeH3LUwQ2VmzXtOOfEMvPQFiTroDo00KwHg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785349918; c=relaxed/relaxed;
	bh=v4QmJ/SaaPJq1jDPqnjiO/k18kGbmkP2+g1krIrs3vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU3SX3fYQPGeGhpZylxOSPKyCb1o+bIOgTaTAC7NpmMyaTxG1beBJhF6YOlySccAvEUw+y0sNdiZ2p1cH75EVQ8FbGS38qaWDmLkQZ6T4uOBSZGk4gJH3IReWFfPC0Bos899+j+TKJBgk6QIgKFxwLFXCRDYM2wkE6hImTtgg6PVFkMaxKICRDJUlGfkSBR3s+CTD+T9KZ+hzLm019k+hXUFxRHDsnd7opbcx0dDWtXcyMLGqRNk0wfLumA+uQV60KrfBMOtXd4mN2+cBjVWR6JcWkj/uREQc1/7kK6tSgqMBIHVSUXqwiFI9qIx2gc2RVwZZBJGITuTqexwDSbPZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ElEanYj6; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ElEanYj6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9LXD5rxqz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 04:31:55 +1000 (AEST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so2072532a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 11:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349910; cv=none;
        d=google.com; s=arc-20260327;
        b=E7PIEqrjCkmiEN+a2pKd1lFSYlUgVC3BzA0YbagjgNHqozkKv9jAB215IDEH8eV0ru
         ic3tU1IvDiRcELf664ZHWYm87vow8ozrAS7+moXOWraHzbVGT2J6G8ini9Z1CRhb+7fJ
         bQwUaoK8zwk30tuKdUfrThBBOHgSejINk5pfXyZQN/ux3rr1ljWWhKzNn3InYSFDA39O
         ZkC/ECRNKKXJv5x7a8VD+NO8zNo60xKXd4yPDrxu2Wv2HK+pOK59mtHD1uqzMQP0z/NI
         mask/Bd41AWIyKAFuVw1uOkKf1StYq8hdF5MXraHx1c2lxzo7403qSXWgGypIGNDdJWX
         TESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v4QmJ/SaaPJq1jDPqnjiO/k18kGbmkP2+g1krIrs3vI=;
        fh=fwFjGJ02OYkrlm8HcAg9ZJVqZ29KIfR74oeUrBFssmA=;
        b=VsdZsNk8al19+9LbKNQHHm0YaE3uT+ZTLJaUl3KJmVQfaXEJz7ewyT9oiDhdifj0io
         hp7DO1KsmfqUFEl9y85d8O6lUPmubJGviAJgOaRAHjbZW9qakugw3wMhlUPY547iR5EX
         DFGxaxNzIQGscsG7n/6LIi0A9T4GtvA/VtIbCGo9ZcS3VomchslYM9R3BkZITN5nk9kf
         UvW691JbEeiK81jiw+Svky3yfjzVpVi7CjOKV937Jz2ETRy1/dViCr+4xKCYg3GQiZou
         KIWnsDCymIMPI6wcfm4VZIDRs5mO/wzVVJXG9psCfUAvHC1O8fo+E0H2Wad4td3Kj/MM
         si9w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785349910; x=1785954710; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4QmJ/SaaPJq1jDPqnjiO/k18kGbmkP2+g1krIrs3vI=;
        b=ElEanYj6bzgXfkg/rV6PVJu6B0da1LvfEkMnXJf5ECpJ8BDdPyIDobYNzu4+2hKYP4
         5ONJYOh8JHA/X12KTz5O1ivD2UahJGQbSBgISkVXfDIRRXLxWEtNDz6SLlj69JGMfdAC
         b0mDe3BgbIoXxH5WapEsLCRg3YtZcyjbd8uonrhS3L+x9/g6foyWHjKpC4EO7vQSgatm
         4n+72aU8cUzhlDdN1kv6td8GHzERROm/7Q6BL8XiM8FqHMjP808qVknh16yN8K23mm7j
         /2MrSiQ3vHgz0hXzD4v9mPVXz7mV8I8B30YNsV4VQ/P+NXKhwz7Y9Q3WdLQXUC6MBXuM
         0qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349910; x=1785954710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4QmJ/SaaPJq1jDPqnjiO/k18kGbmkP2+g1krIrs3vI=;
        b=a+TyGyGyci8/Ldiams4P4cTRFRYR8AsA8n/dgDYN1qLerhBR1Km1TISB50FPosvw80
         /XUkZbdSe+Y7HVIZVwOFgfuPrlHYqSVfzZB9PVfAVQ9W1Y657i5Ae0eYRTNTqYIYPMSW
         eN/kCK0mvmZKe4sQGMhxo+0EfOd7rSn1/w70czLnWxHWDi3RgMxnSJKGxmJ6Zu2udlxn
         Lu6mX6BT3ov+w16gYyoGkg+rRfrzOpQiHMF8CzV9IAG4cW7OEksPM0RGRZXQOT35CIuF
         Q6lBh1e47VNXrDnoMJVM9iTFL5Mrl4eEvStUpZuNAORNbZqDkDASMcy5/oi3n9p5EYH5
         3arw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa9yKdxEKqi/qPoo8w8bkuB9zpE2ChXwE8bIQVrKIIGVt6ArLjzHsCXNbJpIwbfZiy4TvIWhuQzgCenJM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxDJ8lSF2OkcMTNCwVSxE/VeiOXipsNodomyuXC6UJdYETjPJMN
	ej9iPixKcgtawNQ7g5Dw+Hsy/aO4EN3j8dfcSX6Kp97EXysXSIgc0xTKA5ewyyCWAj2J2Y24lNp
	udnUGEZ8dYUVe1pRofsHbfJ6UVSmyI9M=
X-Gm-Gg: AR+sD11olVIZKwhlM1L5cf2JW5/weNobaMMM+yGV7kjDahedLpEl8Br+gm9O4TF0yD2
	em6NTXxD+YqMEtCvlsqb3JB+G/Nl07UWKv9xoxiUi82eUlMqdQ0iYN/k/ZumsEJ4f28uCvI0pmX
	nbR6VtG0m8hKWMQuLZkd1tQ4io20C5n2nxn4ipWQRE8Dk3RVF9q1/5CCnr6BtNNxxVVATLBsJBe
	HUY8/lIIK6h/iFdg/Nko1pvO/JZiYKsH9ih72nKYeLxX6Hmewo6f18ChbMBxrMi3IhT/LifxTNi
	DLoliSUS/DpPLtG+tA6bcEKW1TaqsdKyacY6fi4Z7KL2R8v4aOJYSErPZGob+R9ZmnF64zQBSix
	FBcQTj3BjUtr6S0Xn8f5G490k8P0qe7ipexjvaB1GRwAGJeP4T49PiyGqVQ4q4LoERukgIoF4ww
	pzbmkELSDclIKDOBpQ5qpmCw54H8oGFBHOSo8dN0jQkn/V0UIiA5frO+E=
X-Received: by 2002:a05:6402:21cd:b0:698:351c:979c with SMTP id
 4fb4d7f45d1cf-6a0349e9d99mr3749083a12.2.1785349910290; Wed, 29 Jul 2026
 11:31:50 -0700 (PDT)
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
 <CAKxU2N_LhgDj-+-gd0_N9gQOzCddq7dypYhayFQ_09zggpor6Q@mail.gmail.com> <230cf7f0-600e-40e7-8056-6332c678e14c@linux.ibm.com>
In-Reply-To: <230cf7f0-600e-40e7-8056-6332c678e14c@linux.ibm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 29 Jul 2026 11:31:37 -0700
X-Gm-Features: AUfX_mxsf54gYiW4yX38vwZBjC6BKUBp5AuSPAo67d0COlzbbPx1pWEwYjmbywo
Message-ID: <CAKxU2N_qNZj3dJaHQ46LXA3Q=_sv6r-6WGG3iUDnOT5F=VtNwA@mail.gmail.com>
Subject: Re: [PATCH 0/7] gpio: move ppc4xx driver to drivers/gpio and modernize
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, chleroy@kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:20=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
>
>
> On 6/9/26 3:50 AM, Rosen Penev wrote:
> > On Mon, Jun 8, 2026 at 3:10=E2=80=AFPM Linus Walleij <linusw@kernel.org=
> wrote:
> >> Hi Rosen,
> >>
> >> On Tue, Jun 2, 2026 at 7:01=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
> >>
> >>> This series moves the ppc4xx GPIO driver from arch/powerpc to
> >>> drivers/gpio, converts it to be a proper platform driver using
> >>> generic MMIO helpers, drops architecture-specific accessors, and
> >>> prepares it for module build and COMPILE_TEST.
> >>>
> >>> Patches 1-4 move the driver and convert it to standard platform
> >>> driver infrastructure. Patch 5 switches to generic MMIO helpers.
> >>> Patch 6 drops PPC-specific IO accessors and enables COMPILE_TEST.
> >>> Patch 7 adds the missing MODULE metadata so the driver can actually
> >>> be built as a module.
> >>>
> >>> Rosen Penev (7):
> >>>    gpio: move ppc4xx gpio driver from arch/powerpc to drivers/gpio
> >>>    gpio: ppc44x: Use module platform driver helper for GPIO
> >>>    gpio: ppc44x: Set GPIO chip firmware node
> >>>    gpio: ppc44x: Use platform resource helper for GPIO MMIO
> >>>    gpio: ppc44x: Convert GPIO to generic MMIO
> >>>    gpio: ppc44x: drop PPC-specific IO helpers and rename to ppc44x
> >>>    gpio: ppc44x: add MODULE info
> >> Overall a very nice patch series and happy to see that AI can
> >> assist with this kind of refactoring!
> >>
> >> I guess we should provide some slack so someone from the PPC
> >> camp can test it, and if they don't test it, then it is abandoned and
> >> we should then just apply it anyway.
> > Hmm? I have the hardware. It works fine.
> Honestly I dont have the hardware to test this,
> but thanks for the confirming, i will pull this for the next merge.
Can't tell if you mean next merge window or not.

Anyway, https://lore.kernel.org/linuxppc-dev/20260517063754.21819-1-rosenp@=
gmail.com/
needs handling first IMO.

It's needed for kernel 6.18. Otherwise my buttons and LEDs don't work prope=
rly.
>
> Maddy
> >> The series:
> >> Reviewed-by: Linus Walleij <linusw@kernel.org>
> >>
> >> Yours,
> >> Linus Walleij

