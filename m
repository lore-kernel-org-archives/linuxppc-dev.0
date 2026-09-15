Return-Path: <linuxppc-dev+bounces-27399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5A8C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhnG6T8Cz2yqs;
	Tue, 15 Sep 2026 22:54:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473879;
	cv=none; b=BbAlsA0U2zp+Z4mcbvcDLo32O7au0aYkPgxEIbc7HEjd83eI9KEX3LQBtjm16oF9S2oU6frISi5ja/JlK4GbrpNvdOcACmSYz0/gwMlFKua+5V1yUTv8qssba1kPjHhfB3hAT8PAFEPeClQ6NPzGIKHHY3ZNmcmaHDALWa2LRGwxMj3J+q/3yLSe//Hal4m+XnmOzvTkWsG/0RPiqSZ5hTjnW0NA0EGop9YuqfGoF2cPWBPzYe+adh9VPMzapz7RveUO0yK+xayVCLagXTqIlinOlkInjhhhJKFhk02prxMYOVoAV478TvoQWMV2epj6DJWk/7+qjgwkeWDta8L5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473879; c=relaxed/relaxed;
	bh=J5fP9X9CyVcuvKEYfpMseQ+In05Wp0Z5tRJ1lE5PSRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BC/r6+PZYc1WHEyw33laFgO2O4vEDhmhgLlfnCldsWrMQ716TN+efcQYKRzyqfzYzIvvdkxQsDM3zOyRVI9Poog6q6RoGYqnE97QXMhlKqYqIB+w7wjbqlAJmJCQ2pDzP+ZH7+gWoOc7lG1VkfIfEEh2Npo8DiyChfpqjamR3cZhVq8F3gsaHPcPNz/Wsmj9EjL6UqZjOXpEjwr/ee7wMMQXEyHOqeSJyh6YJK2X3C8+i8v4Qgca3rCMcuqVvKHwxgS4p+sTIYmcZmdxajeflq68rgMgLlRtawhsWd98eR0hJl2iUtUinxOnh7paR9WCFSfYIfUj8yXSQddvAuVavw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuq2lBlL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuq2lBlL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkggC0QQcz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:04:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B3B4360261;
	Tue, 15 Sep 2026 12:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E9A1F000FF;
	Tue, 15 Sep 2026 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473876;
	bh=J5fP9X9CyVcuvKEYfpMseQ+In05Wp0Z5tRJ1lE5PSRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuq2lBlLoUw0Y72t9bFSWoR4MpMhbFj50xeEgbG3mMkdmknSMptpwSK3xFErl6Es+
	 ul9rPuaoVaEF1rSc09McY1HCQ8/KvrsXmDJngtm2g8pGOkK8SksKn5c2XZu2qd6neC
	 /n8PpaNv6M0cIf41/P5ePeN8jF4tTMI4A5SgldO4z9TVfn+pUHuseWjwq3FPjMZVL+
	 /A1Dp6mNtF0UCTI50gLLUPpKDrqKyRhLmvgM/WajGKJ4JWHsivD3qdtc0trmEiG9AU
	 uvPQ8IW2ncEh1yY23HCpFM+zP/B5XadcfTF+40CtiH7dhqHPX0XUxaPv0A3g/x9nid
	 zNRhKlOBXH0Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 28/50] drm/msm: install the out-fence descriptor
 when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: kexec@lists.infradead.org, io-uring@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>, "Jan
 Kara" <jack@suse.cz>, linux-hexagon@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-mm@kvack.org, linux-csky@vger.kernel.org, linux-um@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-arm-msm@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-snps-arc@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-28-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-28-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:04:34 +0000
Message-Id: <20260915120435.28E9A1F000FF@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D28


