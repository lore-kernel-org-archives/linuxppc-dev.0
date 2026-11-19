Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33B606A336
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prugBx0W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVs3d4339z2xL1;
	Fri, 20 Nov 2026 08:26:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795123597;
	cv=none; b=V/raZ0XumJbzRt0w9z4+/lu7SKyVnxGPHBN6YjRsScYiCGxbEHD/Y8g4sDXUWqTJTDg2JqmmVFiYCwegSPALA9pdPrMVdhcMiyH0/uW3x1ggJYTWa31dqKOSfUhESygg4s2QauoUpYvSz4FbftFuB1A1Rw9PunrQvoPcXLkym19RZGmnAjAOf+2FrqjaOFC1h+9atuVGo4dwrg1ZmNqXuUQbE22GTjS5uBGWGJ5D30wHPOPyUobaCytXBO7iTM0yJDYFSnS5cRgKQVwZu8m6vSUCrRome37a2MONZ3JkeYofVcnP1bmDQLenwbUQ4BDoV6CAu8ZcK8c1RQswKZcXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795123597; c=relaxed/relaxed;
	bh=GpzYE3Jc1he50CMWHOLwrLBE02eLthVYkqvqGjNMGAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z5Ancm90WcLYyrG3gRz+v8SX6O30Q/DHyu1EA3ge26sBacey5XM01PHSirzNmnG3+Wlhl/gCfQ3yPd9RDW/TW3TjS8FKaLodISkd1BBZRLtyy1/OMLXXXfzdNvata592IVIosLEvVTZLOHB+VJuUDSz2XkKVI4weOIIcS3IsjeVRu1chNY5eRFV/sS/uIwZ0NdL/binGsMmnLUAkKoyFSBXgbuFUvsYaqbFsenYjmKTmJLmevHF/CkK+I4qKH0yzCSMAHT1bSqLXtI1TR9s8SRfnAivWOU5DpYGiqN3aWzoKVxJ7VymlZlhTQnToOfGwEV1847xfTOo7A3snN2FTTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prugBx0W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=prugBx0W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVs3c5TNlz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 08:26:36 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-8b4d26094beso2183027b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 13:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795123594; x=1795728394; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GpzYE3Jc1he50CMWHOLwrLBE02eLthVYkqvqGjNMGAg=;
        b=prugBx0Wufmm4EocowU4O8P5VXJ7kqDahgHD3xwgmslMo0Cye/gYr/w7lDyGW5m6j7
         7Luxik/OuwVTwAJRS5+r1yMbAQe/Ags2PRJTYmLHSNvRraj1o3q53skRAmtoxaXP8R4M
         moybf0suwoouE3bepRsiMqWQK0/GD3gNbH3lvP2Bjm9BlKoBRi93xYAkSHMzgYvWie5o
         y/dajBk8zrmlDQ0Ni7mRyUa7s/r6087BQksxsBaK+zRILrcxIxOPTJBbzQ0bqBJGLjWz
         guXxhC/ANOEEsamO2t14jyX9vBSKi3avSBVWbqi2xLxWc7zviwiLYw1fC5B7r9R3geyi
         6qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795123594; x=1795728394;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GpzYE3Jc1he50CMWHOLwrLBE02eLthVYkqvqGjNMGAg=;
        b=YaRdU1dhgDu8lXk4mfXN+5Tx1OROYffZAPwcqDcbrvi8fwcmhN6cd4wbODZuHiGWXP
         y3DPMdBL1WPhggy5DHoJv2keJBYyEuylVTJJvLfXDD7omryEOnUoPi3QzrSEpDf5w23i
         780X4KJn+ysrS0Ku6YJI7pI2DCbLMFD5m6iKaT4deFj/9Xeqtd/CzGpbk5h/FMet3m+U
         plUmn5rU1hIOxV+NJodvZSrKb5me8x+zM46moBpSPZ3v+pDljPTqo9COjjRzyjytf3iq
         LKefrBQ2THFBytkM/F+8GtlHgH2jcEwG5Nr5PSloVjh0i0SGZlfz8WP9EwuUw9214vzE
         jIvA==
X-Gm-Message-State: APuU4Z924mRuBibe4T0IhTeKZAfZDdZ360E9KRfkq5hyCl8j9LDcuhrQ
	QH16S5GQXfuup3zfe3wS2czUGXrGTrW4wvHuJ2ZQ9G9IWllXxUpmNYgE
X-Gm-Gg: AZFdTZcE+jiEvSA9yCMHo1Q7jKNqOKppAslWykFmgRTCUecu5VdtZI3hOObb+vCwS1O
	mSHoPmbgT/Y4GpnvDC76RBzZSTEJEBCUmtUVHI2SVv7r3RgN9YuoubMzLRWcRpuEP0wtmfVKydE
	mB2WjhbbNzco2abbjvCrGtLaEzyklZc1VI4IBIga/cKpjmZcLw4inteSr8cPVnAGzzgTEu+6b8J
	GJb4AKnQwT+T5XobLRvpkCifS5GnuOoGovP8UKy1ciIxUxxbeWczNEMcc1ZdXpVtnrLZ3abu1oy
	zQMTyJu58jhKloTynuklKolBDwmad18O/KnHrg+79tSMhwl/kEBpBhdqJE0Qce7QSGeWSKX8mpL
	zNL/Yf+cJh80NdGWnPInO2+aWgrngcmUGewi+/Uu6fZHfAnVPx9r6nYK6pTWiCeJRswgpERN/0g
	S1zRKL0bQGOOtRZLEcuc7xinl8vcBQrwBjz2HHl1rHWstbekEN/Mj9/q14xIQLYsV/JEF8G9ofQ
	jQn7ZKl+DNFS4GupHNTDTVpUr7CbnPzVyc8FW6RdK+mZpjFyEDXonRunS9wUh+StsljeXtD2xxs
	ZPujBNtZltpyg/tzIas4xgteVUBTB0Hhlv9kWGSX8oprJ3UoJDhR++1rz5g6A5d6H96rWkkdi6r
	YwbQKkggvOun5SYC7oXBpWsc8T7ouopeBq3+LGP3sMg==
X-Received: by 2002:a05:690c:3707:b0:8b4:e17f:f7f3 with SMTP id 00721157ae682-8b52045732fmr5288457b3.22.1795123594166;
        Thu, 19 Nov 2026 13:26:34 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bef08sm5583527b3.20.2026.11.19.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:26:33 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/2] drm/nouveau/dispnv04: Support PMU sleep on the iMac G4
Date: Thu, 19 Nov 2026 16:26:31 -0500
Message-Id: <20261119-nouveau-pmac-sleep-v1-0-360c08654a25@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A6Y4AfdiljE+NQBjSFBEcS9G
 yxPce9DEUEQqcseCrgkyuESVJ6RXY1bwDIlky50rZRq2R3nBXOy343luAGebVWiqPVoNRpKoQ+
 Y5f6n/fC+H4tE3q1kAAAA
X-Change-ID: 20261119-nouveau-pmac-sleep-c54e062bc2e7
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=H47g+gZOtNzRvfYRZiTfxTdPkEiWb/7zemgBeHo4gRg=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+Z3Y8nmwbZhz84vhDxks6a7K7SmJ+C61dciotVzqw3
 vTCbh6hjo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmpD8jw8Gwt5anuo
 /u9fhurCLupPTiZugO7YmvNdgOf/x8ePX1h/8YGe5e/zZ52d/b52c1JTn7LWo7wy+wRUlhFY/kz
 mMzPF/NvMsEAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With nouveau, the iMac G4 (PowerMac6,1, NV34M) only offers s2idle, and
when PMU sleep is forced on, the panel stays dark after resume.

The dark panel happens because the VBIOS init tables, which nouveau
runs on every resume, reset the backlight PWM that Open Firmware set
up. Patch 1 saves and restores it.

PMU sleep is missing because boards flagged PMAC_MB_MAY_SLEEP need the
video driver to call PMAC_FTR_DEVICE_CAN_WAKE, as radeonfb and
aty128fb do. Patch 2 makes that call for the NV34M.

With CONFIG_STRICT_KERNEL_RWX=y, PMU sleep also needs "powerpc/powermac:
Fix low_sleep_handler with STRICT_KERNEL_RWX", which goes through the
powerpc tree. The testing here included it.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Matt Turner (2):
      drm/nouveau/dispnv04: Restore Apple backlight PWM on resume
      drm/nouveau/dispnv04: Allow PMU sleep on iMac G4 with NV34M

 drivers/gpu/drm/nouveau/dispnv04/dfp.c  |  6 +----
 drivers/gpu/drm/nouveau/dispnv04/disp.c | 41 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/disp.h |  2 ++
 3 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: 8e2afcd2b57990465f132367fd8fdc2e55c1adad
change-id: 20261119-nouveau-pmac-sleep-c54e062bc2e7

Best regards,
--  
Matt Turner <mattst88@gmail.com>


