Return-Path: <linuxppc-dev+bounces-25698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BBFC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJqQX5CG9z2yqL;
	Tue, 11 Aug 2026 08:37:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::547"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786379698;
	cv=none; b=aQun8dTSlXVMRQXsBCAJJgLUSJyd4bYlSpSma3lRzz8y0eqGKY31Oau+d1NJdBnitIIYpmm9nscIbdHAFlJ2SWupI+9XRCNareWvmnoZ0T477A7EBXCPNo9/UogFO6y2ow5I1VrN6fOEyb8jsyT/7SjzT3rSC1E8xCCP4NvelFPD3LtVnHbMtMrkFRwID8J8fgZMjNqXPVAGzJ2tetibATGFMd9scjAy/BvaOoZ6JfY9AEtwFk7YifirSxkEzdU5JtZzBrEMkRIVplH92tI8V2nfdoxhbCh+WbjyNyiKxUcmXW1vTgYhNhl6zbO/aDtvWyHe0ALCPZYMhYADbhDZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786379698; c=relaxed/relaxed;
	bh=2W9GjrX12XMdTPANAxHOJwxcvmu8lBZVUg7itISKfu8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f4wMjO8iQDOUT/HC3mPWN/ut3l/fyM5Lx+ehgis1aPnststTzvLl0xfQ/pH5BV6//PoRz2PfAguaQIgMjgb6k2VJWg5wKG0czw/OhFf3l4gYbsxKu445X3ipcUU26qSPVmzPJr9HI6fBbTST06aUIuiOyexo34SQCvWS95iXcdbvzWA0YoLM3fpSOHztNHlsui4T+ol0CjMdUhUgm9fF38rqdOrHJKLryq0GIlGyWYF2htK6kxmGXGD09Wm/F/9mLzPWR/8RE0vkknJHqfbABpHNh6i4P+/i078fIv6kSrVqixujpPZ7OmhAXBqOAjm0fMh0qE/uo/QzL2yOv9PUVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=C4AdQ3R7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3rp15agkkdokelcfydlsfrzzrwp.nzxwtyfiaan-opgwtded.zkwlmd.zcr@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=C4AdQ3R7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::547; helo=mail-ed1-x547.google.com; envelope-from=3rp15agkkdokelcfydlsfrzzrwp.nzxwtyfiaan-opgwtded.zkwlmd.zcr@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x547.google.com (mail-ed1-x547.google.com [IPv6:2a00:1450:4864:20::547])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJgMh6C2sz2yxG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 02:34:56 +1000 (AEST)
Received: by mail-ed1-x547.google.com with SMTP id 4fb4d7f45d1cf-69cd6606b19so1740383a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379693; x=1786984493; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2W9GjrX12XMdTPANAxHOJwxcvmu8lBZVUg7itISKfu8=;
        b=C4AdQ3R7kNi8req6b4Qw5aPb1iqrlKYtW6UR/MyOVR8oEkZouXaQWu1WvDKteOfEL7
         Z/RIfsXnhmKTvzb8wWpdnmVJ0frSs0+QEf5hoDyWbxD9kDkqh7KXGADk76tXwzKYjNYh
         KcgeW+N9C/Nt46HEsxJYE+MNl76EJGPoUsMdBMfqzwulXvPlbv/WTH9NK9QjPgyJ+GNK
         JbpH5PhKaOjnGWTqSzeDnjLdsTcmkxYq1I9/S/Miq5w1sFwqYo1iQT5k8yo1DBOuO1h/
         NY6LaDnDqKeJqcKHdV4rl1JM3RCg0bZMpYAaHNHcUx/5qdLq6C3sCow8RFajC041M7tc
         GIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379693; x=1786984493;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2W9GjrX12XMdTPANAxHOJwxcvmu8lBZVUg7itISKfu8=;
        b=QhQoBbKGYd5lwOJ6bL2/vY9HQehZCqjY7fMWuKbM4XHhjgN2oldL3EFINjeCXvE8d7
         Y5kwcCQbURkk2pSUgbCrHoBdueATam7WBbOycIWGdlDO/mJ3FDhjLGr7pA1yqGvu14dA
         IJoeTbx4MU0nMvna5dI38cJy20A5OpEgT0sVkWWT4R5Q+Kc6CRQfJLI+fctKO3XUQfO5
         D39sLulqU2F9ZbAe/ZldSycC+WKfvGFO4JzXB+lbe+wED2AQ/mwIX1ncjArphVHyXOAZ
         FPzG3IAiem43e9nOXKMBHXukawvuezwd8B7p1WZmqqijDRZZfzVVZO4nt13FqfPZv5qP
         0cfQ==
X-Gm-Message-State: AOJu0YzHt4TpR6WkCxnGfvopjHSbE5u4wWL+2IfdofJL/6v0v6ZBMeoR
	1/MHCC4bFFFtnzHGMEdwVljqxWSOLl6cSsEvyPb27HjKlX5Rn1L3CoadaYPLl2rp+3WPKHJoBlA
	E/+g4hPJm6lOxsqp8BQ==
X-Received: from edbay18.prod.google.com ([2002:a05:6402:2032:b0:6a0:a508:c896])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:454b:b0:6a1:c908:1701 with SMTP id 4fb4d7f45d1cf-6a355e2d32amr1548538a12.13.1786379692937;
 Mon, 10 Aug 2026 09:34:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:28:12 +0000
In-Reply-To: <20260810162814.1398016-1-tarunsahu@google.com>
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
Mime-Version: 1.0
References: <20260810162814.1398016-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810162814.1398016-3-tarunsahu@google.com>
Subject: [PATCH 2/4] firmware/edd: use kobject_put() on edd_device_register() failure
From: Tarun Sahu <tarunsahu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geoff Levand <geoff@infradead.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, dmatlack@google.com, Borislav Petkov <bp@alien8.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, djeffery@redhat.com, 
	Tony Luck <tony.luck@intel.com>, skhawaja@google.com, 
	Russell King <linux@armlinux.org.uk>, stuart.w.hayes@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-edac@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

When edd_device_register() fails after initializing the kobject with
kobject_init_and_add(), calling kfree(edev) directly bypasses the
kobject release callback (edd_release) and leaks the allocated kobject
resources.

Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
registration failure.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/firmware/edd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index f980c5b56858..763e7b16d517 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,7 +748,7 @@ edd_init(void)
 
 		rc = edd_device_register(edev, i);
 		if (rc) {
-			kfree(edev);
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
-- 
2.55.0.679.g6767b8d81c-goog


