Return-Path: <linuxppc-dev+bounces-25701-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D98DC5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 22:38:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJqR11tmDz2yrw;
	Tue, 11 Aug 2026 08:38:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786379700;
	cv=none; b=EVMK7HqEgPE70RhkyBkXzuSMuefjRZsCqd45PtLhtO/UwmGRM3xp/ENyI1SNDkhEndou0/b575PLG5IUjAaF6m261rubRa2nnvpEEL2/hCtuo/CDVb0V0MOmfVCdGa7foIjh9vU9JolxTNkRmh0ekAUXaHp2pp3UKzkOsNmuhSQE/2vhmEkv06FRkMwDVcBhzaG22ts3wFTnf40we3kyEWl+c30XsQdofVE8EXYpGTR8S/YLjWbFOBd2UvnZ7U14RksLX3NUBLuWOOZWClpkstdzkCDQHfOdVoITntKq438Uk7QgLyCqfGM2eirONdcVqUNsA0BeobqwVuXGri/xkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786379700; c=relaxed/relaxed;
	bh=iDGvS9HpsrPtLNw2H79kc5fyPEaWVAB8Beu1OXPCfRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TFdDP2+HriHFJUQiBGWb4GU2XoiZmdf3SzfPoDyckDkM1iSvAl886s8JSV1qQJK1BrVKKbvaPu5295drh7RJjLFbKl8k8YoXxdqbOn0XPb91PGEIn8z3uOpeCpHlRT0YOActS6pD0Kwo9QBTENMtfzuEjQi0Th8vVyPgDlbo1/+3skUX47CWJ4N4hhU3+i/hGRfs1QJu94pev7PT/qZWP5ycowUwi2CIbEEQs7PzM35Ujxyu4FOQQJFVEp/euz6p2pFk9V6F3QxjyjUSNdHkX5ykCckBOd96IUMymD12WPvcd4Gi5EIGLymxeGcRLy6Nzof+ypi0CwtCgFe1O2J44Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OZB6cxXZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3qv15agkkdoccjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=OZB6cxXZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3qv15agkkdoccjadwbjqdpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x645.google.com (mail-ej1-x645.google.com [IPv6:2a00:1450:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJgMl4F4Rz300M
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 02:34:59 +1000 (AEST)
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c15fff01a30so128669666b.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786379691; x=1786984491; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iDGvS9HpsrPtLNw2H79kc5fyPEaWVAB8Beu1OXPCfRo=;
        b=OZB6cxXZL4Y5ASgwPgTCHU874g0hwcXIl2EMskLCokxo1CcsPTVzYUP7MDEdcoLYiZ
         LBISNqqEWleIwh+vGD1eHmKdP4HVWaJ7vegEytRineO3gFH+W7qInUaklI1L1eT6BrmS
         bmSmSjBh1xX1T/Hl8Sbr6OnXccCnzaY7kQha5NRjtqZi0zLigcdgkDIPATeFbHM40H4I
         I4x5wbfM0w76y/Y94sdgekSsIK99fZgOs/evv7NJwBHDzoPHLyAilg5ln2NegS+74pNH
         i/CgLv6G1poe8ke9HxP1msAjBbTXDCMEdHKTBDvEFS28M1GGXOzSSb2zJ5BL5TX0SZ9J
         doFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379691; x=1786984491;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iDGvS9HpsrPtLNw2H79kc5fyPEaWVAB8Beu1OXPCfRo=;
        b=M7MPUsyJXpBED/QdRIzXqxg8Y2A2deL7L/T/2EjUPVC5Qe8TkQBScM0Fxb1ajg5xhr
         +bSFKPiVvUcWONNxnBUccM0XCtdSuFIwH7uaPe+e230EZkqdQP/C0eCfnrft/Xsfpd6n
         C85BrSy/dkZNGlp5OEhr6dA5TMi+qT1XfYoEDMZ6TSeIk9FSAe5K/YUQ5NZxvjz4h66b
         bAsgs0hCwK+tasxIB8wv9fpmqZ6vQsVue2Tpwfnrfg+O63cN0LaGohaqv2AyiDiOcqnn
         tPp/iSjSXDPUGqMjU59GFieRQceuOykYxISgiX7lrjbdBoiwhOY0qv0Hk8NFNr8UvLkf
         Ecgg==
X-Gm-Message-State: AOJu0YxHxmicsbiF5g7LAqpeOkudS1YgcJfiujyNNDRNc1tIqnFT+w1Z
	XafoGmGIic5g/KNJyAxunPqBiIZzy3+r9ai4azynxFhTnrAwkqy4B4YwaFsfERB5vHoKi60dd9h
	MolhZOBTlKrip5tqOZg==
X-Received: from ejzq2.prod.google.com ([2002:a17:906:b282:b0:c1c:22c5:732])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7ba5:b0:c15:f26a:342f with SMTP id a640c23a62f3a-c2073392a89mr1505099466b.23.1786379690769;
 Mon, 10 Aug 2026 09:34:50 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:28:10 +0000
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
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810162814.1398016-1-tarunsahu@google.com>
Subject: [PATCH 0/4] Convert manual kfree(dev) to put_device()
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

Hello,

As per the guidelines, no devices that are tried to register with
device_register or to add using device_add, must use put_device on their
failure path. These series contains 4 patches that update these
instances.

Tarun Sahu (4):
  ARM: locomo: use put_device() on device_register() failure
  firmware/edd: use kobject_put() on edd_device_register() failure
  EDAC/versalnet: use put_device() on device_register() failure
  powerpc/ps3: use put_device() on device_register() failure in
    ps3_system_bus_device_register

 arch/arm/common/locomo.c                 | 13 ++--
 arch/powerpc/platforms/ps3/device-init.c | 83 ++++++++++++++----------
 arch/powerpc/platforms/ps3/system-bus.c  |  2 +
 drivers/edac/versalnet_edac.c            |  6 +-
 drivers/firmware/edd.c                   |  2 +-
 5 files changed, 63 insertions(+), 43 deletions(-)


base-commit: dbaafe9cc56a996931eedfe043eb34418cc9cd9b
-- 
2.55.0.679.g6767b8d81c-goog


