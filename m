Return-Path: <linuxppc-dev+bounces-27411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440CC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:57:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhrf08qDz30Nl;
	Tue, 15 Sep 2026 22:57:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789474442;
	cv=none; b=iUx9z6pEBVVBVNdz2NoEIKayjc9ICu3l6yQQtzmC32XTf5csrsatfwdcCWvWmkGggru1TOOncHM4QbfU3A5HxQmxFKaquCVMpbdrnk9GiLV41sCb4vhzE3FZfUwv7K8vrM/se/YGxHveVXG9VZjRihySwjgt3FbtZRNhOBqoq8qeXTOJ2/hjoMFjcyHkc0j5Uq6XhFxOsx05Byf4rnyNizVWrnlMtSlb9GtHVKzdo9t1HRPRelPHtv1KTVqIkc51Xb9obEKVl0/qM9wi1VJQtNHpBuRN5s+KG6wscSK+ae38KML/4VuxHDsjiKB8zv/mXqS3wr4UtnGoqjS7iecLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789474442; c=relaxed/relaxed;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZFRLhvLGAYAH/7iYFQhLO7f9fUrPyNTTQd2R75M3ULePIqwtOaQsJPGvwzRp6qgRjviYOrS9k1Gp6zxxXVTo/9tIsmTYcfHKXmRERQaP3tm26KmWESma3Arjrqwc90pDB4Gcj0QSxgdOI+/4+KIMAOOZ4EYnjTTO0BBPViNn4HKyYc4AAaEEWiebzMgFc0ipOJXE1jzIUuIFuvIGtakDgtFBod35Gy+/u+Xgyv703u3zs7iDSBHGBeDwYV2ozP2k7JNbXlqqSM3gKtIUpm04WUeZKplt378A4BqDJOen/gngFqW50lSbLQ1QWVmHf+whJ4ageJFYIpdeaUTv0EQV7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvwdtYpl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvwdtYpl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgt22WHqz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:14:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 108AF414E2;
	Tue, 15 Sep 2026 12:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2741F000FF;
	Tue, 15 Sep 2026 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474439;
	bh=N/qDC8w+78iGOR02PfeQ9lasCpgoFwlOJHnQ1mx3Dgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CvwdtYplEMqh0mXb9UtTtEzUPZjlErl5BgHWZ3BUuzKN64/50zHMmE8tVi+y1B3X3
	 tAYkfuPSB1IfE0nhCXR7lcqXNSl51VqpY+L+oymG9YPh17XOrUi8G3/Aa+dnQeYFRj
	 NcQX+8avtvTCjCij+9TYtbgkkb7afe60hNSTSaGvh1L3t7pyiz8fuqxatGkMKmaKvM
	 8XOgUv1cgX6wWpD+3GvwOhIJtw3OnoMVeiRhGh4LZXzdsV358kdYIG5GabAq3BtAXs
	 I7hVAiVBYRClyrA05Lt47fHM9pl9LGtyPE+6dxCTPgbrcsy0AbO5y7C+JwxLWRY8kE
	 FeK/23S/8IuyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 35/50] ALSA: compress: install the task
 descriptors when the ioctl returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-parisc@vger.kernel.org, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, io-uring@vger.kernel.org, kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hexagon@vger.kernel.org, linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, "Jens
 Axboe" <axboe@kernel.dk>, linux-gpio@vger.kernel.org, "Jann Horn" <jannh@google.com>, linux-um@lists.infradead.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-35-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:13:57 +0000
Message-Id: <20260915121358.1C2741F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D35


