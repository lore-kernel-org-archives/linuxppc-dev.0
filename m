Return-Path: <linuxppc-dev+bounces-28933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B29CA5FFF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:45:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz3dK3QGTz2yf9;
	Tue, 06 Oct 2026 02:45:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::445"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791215157;
	cv=none; b=OYAyb8P8zfqSew+bdhn3z0JWKtEJ94L82KoCB063z7kiFUdmc3NOTSB0p/HdJP1/3saTDLXhLb8SMdL43W9mVIR34rYOxvTbISKI2NqOyN3OVWQMN+ab2wcWAdo/Rc26j6BH8pE5SZ9S6hlQMh0xtzyyRN4K6bOqowG6msEfLB7w9hGCGOGGoWgOy0B9Vy2HDYvTHTgI3itPD0QT0FY0+40RuU7xLG89D45UcQrM2fheXvbtWxXjwejOC5xzMmmW0wp1JUnRJeqv+zAhhfiB+SNclNlloOKKwrz49WsKd0USzTyjeG8QT78drr0CwY2EAf4+VOcVn8CTmitA/UJLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791215157; c=relaxed/relaxed;
	bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixDYThNfG0BTwnLJZ7Ux/F3fQxnL648W1//udnSkGUBhhogwE9yNMMYZa/I3c3OjM+o+GmpC6bFd2ZuHojrob7BgMiHIML59D7Pa14ie4c3Yq0QHYpuW+TUejDXnDBxbrrwlqTGLjj81LIB+r8rAThTt6qMYn/u7I7NozHiZ2KYsJYo3OnI80br5D4sMJKQx1wRglV+SezlcnwUmqOjq6eosRSlYLn1CD2zJ18AKOUMFMHf3DJ95BVHQoW5mIbLR/J5+e/S2aAaY6myvrdGyDqJTgM19GtWwIOpqiiyZbV6Uu14LJMVTIzjgQPLd24PsNAlM0UKOJnRFnZ9jnCfMMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TmZ5eme4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3mmbdag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TmZ5eme4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::445; helo=mail-pf1-x445.google.com; envelope-from=3mmbdag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com [IPv6:2607:f8b0:4864:20::445])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz3dH6HjCz2yTP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 02:45:55 +1100 (AEDT)
Received: by mail-pf1-x445.google.com with SMTP id d2e1a72fcca58-8862ed0539dso2482358b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215153; x=1791819953; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
        b=TmZ5eme4AX677JZFvQKNx2HAtBQ3xoAiZ9BB3ZXzDiQmwIWeRn8ibdkMRfVDiOML0t
         7sJ3ZVxZDFCi9ancs4bginxDCXhPJrQY6BPqFn3iWS1Bi5x0KusBVqeTbUiDn/sIKCWH
         b+X0hZ2mcTPGmp1huH8327tD4B7prLv37VuEAaTppZP09s41hgOte8h7DQrT0TilS1iH
         2QXuD0l7EgqdMaKdBf+LL8cJo8Elqfn7o1P4uvij5CxrqOn13f2o2JoLy4KawFwZLRUN
         QS4bd3OPUaVQF6Dv7YWGIN/HNemqMmgfOOnpgmvp4gbUHdiXrsoKafUzrihiJrwEkkM3
         35Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215153; x=1791819953;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0K19+1F4UsN0OHRXHQqyJ7lXT9gNpPboBHoZVKiqBBo=;
        b=R+bwY28OpY48gDxHKfFSh8r/FkGAhr513wixS7/0vrs1I3jX83+stjPm38d9CTfMNT
         SAVIbkAzt9+yZpNjbxoD+DfdNLHEqwhXi3sNqve64VfrRx2SrlTL4mQH1hvo57UDSgLQ
         kyELtB1ENzJcXI5VFcqNxodZoFfkF9I+IixtobZlExuvalI4UBVx7pLfh2psfBg6PIUX
         F/pJ7L8JCkxWs191RBTFCJllHpeNQ2RyNhxM6Rq3iEC7gPlaEpYtsEkVsF3kCzJuTTnd
         Xdbt6ThQWNCoHHu/YMFFUO7I7LZ8Jv3wjcpz5JXnXFS+3j8p6xxF4bw+7jARZJazoTCm
         Mk2w==
X-Forwarded-Encrypted: i=1; AKwUvBymfVOEvMi36qmrcMQ+iAd5HtbSfwzG3QYuUQ46RH1Qh9UpqdDttET2TD7BZbvvSMkPi1Zw/IcCAwJEn0E=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lcrAH0I6s6yy4BKvmJmmciVFhrms5ewm3kUt/ncgAbjD1WebpW
	qf8I6+2huOaQyi3O/J+XkqDkVcMUnfWg5rqAz294GbghVBZML/URya/qIyfnhDQBW2xTDRN6Vgo
	Hvs08K0NXkAQqmJxmGXT6vm3Q8tG/nxXTYA==
X-Received: from pgre24.prod.google.com ([2002:a65:6798:0:b0:cc7:c9bb:ae0])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:394a:b0:3dd:a197:edfb with SMTP id adf61e73a8af0-3e0d6cbdc69mr7305064637.74.1791215152955;
 Mon, 05 Oct 2026 08:45:52 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:45:52 +0000
In-Reply-To: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
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
References: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261005154552.1508283-1-rathodpriyank@google.com>
Subject: Re: [PATCH v2] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, Keith Busch <kbusch@kernel.org>, 
	Sinan Kaya <okaya@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Lukas,

Gentle ping on this one.

Lukas, the code change is the same as in v1, where you said the fix
looked fine. v2 only corrects the Fixes: tag and rewrites the commit
message to drop the scenarios you pointed out were wrong. If it looks
right to you now, a Reviewed-by would be much appreciated.

The patch still applies cleanly to pci/next, and on top of your "Error
reporting for AER-incapable devices" series in either order.

Thanks,
Priyank

