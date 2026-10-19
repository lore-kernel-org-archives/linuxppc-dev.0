Return-Path: <linuxppc-dev+bounces-29694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C034CCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:18:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Wj94NTSz2yfD;
	Mon, 19 Oct 2026 21:18:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405117;
	cv=pass; b=E9tHrWLl+2dEeUZ1ugzdj3sPMlseDx2wpZTH9tr07b4Sp+6rWXzlm+Syoye6rIQhZ6KHqaPtaIJrQazq9cTzhl7lj/cNcfkK9rHyzWTjq7edYJBIAU6BH07xt01UajA2s1KMJYOF5wENWhsWG7NC+p5xotUH7deGDQUSxsFREoL21DDYIug5W0jIvTK153+TlwmVO1l8K7sXYQghkpzk3GQD7I6mq/EiSKvAswfPlcjJbEflbs4FsuLoEM1hyq0uWpBE7xGzFGVvAQl+XmaOaaWZv39He7NPWI1qq0vPLuZmrphqjNozVgFjNkCSJ3N6juw1KTIw0lqTtQl8o9RSkw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405117; c=relaxed/relaxed;
	bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoBY0XPsH0CWAqoGaHvw58C9OgFGrVXdOd0YjelQZS8cMX8z5m1Tl5uqOwxb/CerFqToQd43BdDjeX/+2dTKhEqCGYTKqozuvNBpKZVsYHx3wJiMMNOE7XSEMNTiJVwt1ATrkG2uYKbR/naN/pfboVmF5b2bpr+Vw2b3OXNDOzkpzTcyaIrcV7Hc5renEdNwcybd6xkyCuJjRV7QGqkXwlnPW487Nb1PcGDAeMmFR6W2F5s+tzO/Gp211Be1GgyKAA+de4NFhd/z4YpijcSw98rMuVyURY8dvimLyZUu+wE/eA+C3sLldn424CF0HJEcJbki4BWRPzO1fdGMAaxrMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VWU+SSf0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VWU+SSf0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=marco.crivellari@suse.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Wj71BXpz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:18:33 +1100 (AEDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso13772521fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 03:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405108; cv=none;
        d=google.com; s=arc-20260327;
        b=kZNkLw3G1D39DkWkfpe+msdBieZDabdYB7SUbor1jalaqI0zbQDtSOrUo4Ksf+41WX
         ZIbTEovM0/JCRkwILviUbj7flmwb+1Qis7jk1dchaW0CoE6bXvExq4DEuirdfJzWtuuh
         H5WEk6IcArvszwcXV2Syy7OZCsUE+B7l6e7TMi97gXoUZ05UuSYe7wfhzji0I2UM3BzT
         +kjscHt2f5jH6bDiuKP1S0LiBILSwO4oX90pcFN38hNsbKAyR3vxgo5ais9u5m6F9end
         JXtWwzIwCG/3KwseMZHu9klwI7DiRmPxcTfOm0br+01/SY/7wIdGV8rG1EAmdZwmAK/V
         Gh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        fh=sG7usDmcsTT/AVxhz2zG9Y8aSgLZltlx3MkngYH5Mzg=;
        b=It/X7RBY7FYrQG5sjMjccn0zZHnDhDRp0i2xR1FeU+YOp4eCVhlMwHed/WIdZ5iekK
         JmJFYkgyxhNzI/D1XJkfFX04bFpiL1MFnBfFF/r5gz7gD1UUkbskeLJ9Wwk49UU/oJMH
         P+ZonNiCwIsscjqIi22tM9XEX+LTzl/FHiiOqwtLIycXmeXB2amLwJmWqLeIqqnvu2+6
         nSHEPJrXXy8i/9eLuKi8QZPueNFyce0sRNLyurTktKghf1T03jUduepDC7o4Qo7aie2m
         2yyZp5CN/8a6CxnCGzD77cbnt4cTsBM5c+mlSOQf023v2eCW85cux+40hw7DNSw6Y+Bm
         2oFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792405108; x=1793009908; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        b=VWU+SSf0buRz3m/s/xiX8oMmMk8Fkz0BKEDj5QE3EkkuDGQolycTN6IfvgLKb13SjL
         MVgMG31JYcEBHNhiqQ2K5ScBI8UwnWZgK8DnzHI7UhRpPrM+ainNxCid/DRWmJ3lw0De
         eu+Hmp6Amke4yXkuYGBGMUX7PLoWfHIHnVrLT0T5ERRs53hjEUEb5G5UD3eY5bmvyUqX
         JT54jLZt3xWxskS3O3yAQyaVB0AndcLftupxp4e/XPUbMPd3GeWnz465t3g8yV9J4gRd
         TYPkrAsZHW96h16Qc4grM5crEi4jZYNkUhQyVwXg9LeLD3TwR357R9HbhIcXNEluZrEQ
         VdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405108; x=1793009908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0X5plGkx2cbkG2CtOVwpU5mD1drTa49dzUT6iJzQz9I=;
        b=SYPIDZHn6Nlm+PgIf19k0S78Qsd/6b7BeDPlmnYt7cbSk1p+z2O+le7DOwnpBDD6xE
         lVEAwznoteo+hS/bljOj2JOXom+8SberMBqUV7/CMYRddUoFrxL8RqimHtv5TSAFyZid
         04GmcyL7xFSdB5Ia1vLF/T6QiZ9xkkumvXzORXxw7lWCSz7FXSGy8+VwALqBUbQSCMSD
         Wr8dBB2yPoItwEoD8r09oQ3hoz07ObglvBz+0tsWRGLL3z26/q2wJj3KWKXa0WPH4fMT
         /Xl1vd5bpD0zL0mEYPsYm3Yc5q3bE5JI4sroZOh6lp8WEInXylNlMab0fzHffei22riw
         8/QA==
X-Forwarded-Encrypted: i=1; AKwUvByA4CZKyZaMr8toPiLr0Wj4SVfCwpd01Zzz0UXhM44pd6FNOK7jphhUJQw0ojl/2kyVus+miA+gf/SIAzE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxwvIubfhz+zMHJrn9d5bY6FsD9jp7RX+wK+AwP795KaRWMCE8
	WeTgcANqkDkcLdz/E8Gds62pbPk8FhaS710N544sW6yFnKrkmC2bUXw9RdKR7nI2Ok8wAp4a5fR
	D0MBb74gf097VeZHx9cjX8+MHugxSv53nNrp9BGQNBg==
X-Gm-Gg: AYBFou0lVtOYtE315L8Z9cP7tKxJDOFJFBxsr8N9fs5lbAO3JkBJ961ee8Jglv8AXeL
	2FmfrgbHn0rEaoKBqw4xQ0dSEjZ+pCI2wYiA3Iuxt4RVoJNxO/TRHfNwyr146z4OUp0l2QyfNtG
	GMpxIRi4Xc8Xm6q7HNhorLQ5tGyC9PEXgdNxab/RTDSgjyFatGxH/XwIo4cYuSjS0bN/cOE9oYr
	SNpD7veZ6ILk5W/IVLasiRKhoCSChlP0OAeAToOte08/hi1OGYxhdfJO97jsHe3nHyCgnHpDLHm
	oSxi6EKaAJnPBZUrltbjNz3oOSfhH4eFLEm5Zkd3ysPKYwtFeFY9D+61EDHQBjLv6nQz+z48pP6
	eUhyBYw1qjPuC
X-Received: by 2002:a05:6512:3b08:b0:5bb:7b64:340d with SMTP id
 2adb3069b0e04-5be50a73dbcmr2180517e87.28.1792405107931; Mon, 19 Oct 2026
 03:18:27 -0700 (PDT)
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
References: <20261012095452.135828-1-marco.crivellari@suse.com>
 <20261012095452.135828-2-marco.crivellari@suse.com> <de6d786b-fdbd-42f8-b2c9-b175a6a33c69@linux.ibm.com>
In-Reply-To: <de6d786b-fdbd-42f8-b2c9-b175a6a33c69@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 19 Oct 2026 12:18:17 +0200
X-Gm-Features: AclHuK-BUw_TxfB1HhBk8jNSN8MxUezMM1hmofzvTqK6-PRot3PI1mJ4gMma7qc
Message-ID: <CAAofZF4XMmr9ajA=W7g4EHOSy8C_GRR1n_aK+BXTgM60onFVqw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] ibmvnic: Move long delayed work on system_dfl_long_wq
To: mingming cao <mmc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haren Myneni <haren@linux.ibm.com>, 
	Rick Lindsley <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:20=E2=80=AFPM mingming cao <mmc@linux.ibm.com> w=
rote:
> [...]
> I walked through the reset path and the conversion looks fine.
>
> All three system_long_wq users move together and there are no
> remaining users in the driver. The work items don't rely on per-CPU
> state, so system_dfl_long_wq seems appropriate here.
>
> Minor commit message nit: ibmvnic doesn't use mod_delayed_work(), and
> one of the conversions is queue_work() rather than delayed work.
>
> Acked-by: Mingming Cao <mmc@linux.ibm.com>

Thanks for your comment.

drivers/net/ethernet/ibm/ibmvnic.c uses queue_delayed_work() and as
you mentioned one queue_work(). The workqueue used here was also
migrated based on Sashiko's feedback received in v2:

https://lore.kernel.org/all/20260711164434.1691221-3-horms@kernel.org/

I will keep your Ack for this patch in v5.

Thanks!

--=20

Marco Crivellari

SUSE Labs

