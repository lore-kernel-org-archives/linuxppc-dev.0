Return-Path: <linuxppc-dev+bounces-26391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00473C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 13:41:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ6T42fWvz2xmh;
	Tue, 01 Sep 2026 23:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.205.69.213
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788269618;
	cv=none; b=aZarJ1/tc8qqQTAs2ek3uDyVdsAu0h3D/HguyWT8KhtP+CWmAZ+7sjHoqEbJp/WMSOyyS/zoiv9Qga6lQiIwpdvvX0JYQymFQyPef0dGHlXZotSIrGNHyjwUAGRJV8Y6xCVWSS9aAzkE139uLQldFbqIg6AiqbQO9Jg6ldE+xbvwIiEgjbWrDcaH1cy7SPFaLC7QV7KLn6FA2Yi9k+gPDmJ2Q1U8mOp0fIDE7tXbCwd+axQV+ARMaYKOqOJXm9e55WQBN9A0g7BP8qi1APASfVNAIJT41QlDRMGjsFgtRmqtzTCwbzSa79FqKFtb0q+Cj2DGWv95uozHRAXy+sjjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788269618; c=relaxed/relaxed;
	bh=q1EGlJo4k20wtjJ6LeZz9Ga195oecSYq4oH23A0N5nY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=YI+u1P3zaf9dz5gr7sK1/MR3SAfF9/6Zp4C6g5Yi3sM3ga9haQCL7ij8Kxnp97usfyPjcmTd+3/zGPjAQhnTgA7E3jFfwHfF4/vaFdGR7mUYMXc4l+2SdZdh5PQbQQrwAE7ARttNGnbhj2ThzNXS2DVBSnI9ZslBZYhHfwCqEhbxwTjC0q5KyfLitXpdjhd+/3dwgoGAeyGuUJkgBlVZhq0EKIHQ2efonx9UC7nLTOhIBeIzI1jli4U02Gz6PEQpO2JIkUskAS2kv3J8nS7VEZ104CrzMf/ZTlmCC2ieyL4WJ/2SSMjMUADImUf7eu4Vw/vl21D8b2FLr6naWshV3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; dkim=pass (2048-bit key; secure) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=knKc+KkZ; dkim-atps=neutral; spf=pass (client-ip=185.205.69.213; helo=mail.w13.tutanota.de; envelope-from=nhuquynh@tutamail.com; receiver=lists.ozlabs.org) smtp.mailfrom=tutamail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tutamail.com header.i=@tutamail.com header.a=rsa-sha256 header.s=s1 header.b=knKc+KkZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tutamail.com (client-ip=185.205.69.213; helo=mail.w13.tutanota.de; envelope-from=nhuquynh@tutamail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 365 seconds by postgrey-1.37 at boromir; Tue, 01 Sep 2026 23:33:36 AEST
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ6JJ3mPZz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 23:33:36 +1000 (AEST)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id F15511787C43F
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2026 15:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788269216;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=q1EGlJo4k20wtjJ6LeZz9Ga195oecSYq4oH23A0N5nY=;
	b=knKc+KkZRsw4D1XOLeg/t19fbEy6xz2ObyD68nWBBhryn7haCmtg9A9LsPVg+MNO
	GKR8nReUH7QgN9BN7eE1pggA4wv0TkZn7pF2YLui76lyQlRfacx7ZyVKcaHQgshI3gl
	3Z+CVXNRHmNSfhw53H8yfOhR8FVU68HqMho345s2zGG+Rl8d9h4jN6SigWFHFekVTMJ
	iXx7ZQyGJ54X9EhvyeZThTlji3DwglkL4rgL6agx2ef63DES3teqgT5r0rTwXeVheBg
	XCUEPpl+J4pUPIIgIE70DFmc+eNSVQf29/RzoKurylNUJ0hfO0N5/EWRCDOmUf4ZDEP
	Rrd5+K2iZg==
Date: Tue, 1 Sep 2026 15:26:56 +0200 (CEST)
From: nhuquynh@tutamail.com
To: Maddy <maddy@linux.ibm.com>
Cc: Npiggin <npiggin@gmail.com>, Mpe <mpe@ellerman.id.au>,
	Chleroy <chleroy@kernel.org>,
	Linuxppc Dev <linuxppc-dev@lists.ozlabs.org>,
	Kvm <kvm@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <P0S7RHx--F-9@tutamail.com>
Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 01f623faf350242ee22fbff0b8773ebd8a7767447f9b594d83172fa356399049e52c0826425050c9f5eab48b0cde0804d49efbc89e5dcad8f064d92c63df02326c:TurnOnPrivacy!:tutamail

From 80fd05e6d156d5a90d4908f2498bf6cc7acbdefd Mon Sep 17 00:00:00 2001
From: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
Date: Tue, 1 Sep 2026 19:39:49 +0700
Subject: [PATCH] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info

The kvmppc_gsm_refresh_info() function incorrectly checks for the
presence of the fill_info callback instead of refresh_info.

This can lead to:
- NULL pointer dereference if refresh_info is NULL but fill_info is present
- EINVAL return if refresh_info is present but fill_info is NULL

Fix this by checking the correct callback.

Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers=
")
Signed-off-by: Bui Nguyen Nhu Quynh <nhuquynh@tutamail.com>
---
arch/powerpc/kvm/guest-state-buffer.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest=
-state-buffer.c
index 42843eca6727..aeb586ba4523 100644
--- a/arch/powerpc/kvm/guest-state-buffer.c
+++ b/arch/powerpc/kvm/guest-state-buffer.c
@@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
=C2=A0=C2=A0=C2=A0 struct kvmppc_gs_buff *gsb)
{
-=09if (!gsm->ops->fill_info)
+=09if (!gsm->ops->refresh_info)
return -EINVAL;
=C2=A0
return gsm->ops->refresh_info(gsm, gsb);
--=C2=A0
2.54.0

