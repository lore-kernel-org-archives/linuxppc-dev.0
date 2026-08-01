Return-Path: <linuxppc-dev+bounces-25197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB780C55173
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 12:24:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hC2Ds4KTVz2yfD;
	Sat, 01 Aug 2026 22:24:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785572737;
	cv=none; b=HsEmavcp1kYHUAvOh7D33h8eDyeVUPvJYDBf1frnsf3VqwylSCna7l+8LePSjGsejHBEZHnUIlXEeZ0Exvdc/MeMh+G9fz6TWLwxPebliqC2MsfW3C7WMGe0mCuDXImwsv98xayqYlFWEVvgGjtwhcGzr8RhAkEHuNIQ9b9VNylvNA+f9H0QCxDDIGOf80ePYkmNlSbYRXd5s5A57NM+HJdsDqEPGPdhEtg5aUuEZPw7vfA8GMsSMqXHgPr4XsjS8YN8sc/Q6usm88uUNmrXSAk5V8rzPlX3HjxdHEKZHYUMVSROAlZxEJCo/JIEkjCfJuvBOHW6PAvc+IJxtMo2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785572737; c=relaxed/relaxed;
	bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj598ky4oZpGDfTyrguEdCMATz9B4Oeda1ZjX89ZNMiOLLKzykpoxWI8fisIBGEF45urlg2Cq7x/SfUbWJACsCT8UJ7fSLNix6MZPoXMkhWkjC1GTbI8TsxJuLtPl9C64x9AbHxG9p26FxtFRq/PN9Hb9K8Sv/qJ9wuuxchadOqJq+DCXUMaYnmot0Ite4l3Te2/ONa+KLc+xVSyS7fT3Z6nnknqbFFgYP5hyL3shjboodR3OUm1KQLesOeaOWZVgXnMyJCuwBSLyO6DnvJ+tzoWalxaFDlLmVw5uvyE3w8Ztu9ls8guxDu9Xl7Lgf3I+C8cjJ1e1VodevLfq73Bmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; dkim=pass (2048-bit key; unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=NGR1q02W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=mattc@purestorage.com; receiver=lists.ozlabs.org) smtp.mailfrom=purestorage.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=NGR1q02W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=purestorage.com (client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com; envelope-from=mattc@purestorage.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBwxB4fNhz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 18:25:31 +1000 (AEST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7ebd88be784so1210618a34.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785572727; x=1786177527; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
        b=NGR1q02WS4JnGqPhlFKo5vKfdFJKpZOyOmLoW1HgWaRaVL2XF9y/0hzBgn3LvH5mI3
         s2QjHt+Eggy/9UyMJTDiQ7hDtg7wMCNZiMczUc9GeyUc5wwuxc25MZtXp23NgUcOuvIW
         GhG2NH4o1G4wLv72Ep91i0RT7EZ50OOt/Un+s4pE94Z+vhV0osDGtT3+/keJw1WdbtGJ
         9nsVaKffyf+gpwKXe6EXBNQS5iK0+TVYHj54vMkK/Fm08CPVevWizoPqeAQPnK4R6zBA
         wrhIDaV+6oKXl7PhebIv12YwqRgyVLTQpF781oisDzyEBqCMuOFajcfgsWjSAC2omkRY
         /TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572727; x=1786177527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+CaLhkTCz3P5fdOZHT1VKVnlDou+5WauiE3gIfowDw4=;
        b=M2VakCk9ovrqoiIFIqaTOwXzQOIjayCRF9aA07/VNPec0j6Z4rCy+EgzxEhXSvWp51
         GNgkqwrGsb5B8swR5EI7N/J+PU5AHbYZLBRbOqtxVTFJa45g2pLkxkVwvBcA7xsKNK1v
         iQoVrQOj/P+8NMTvAmQ5yCsUMsGegeMRizAwmZ1Eqv1fduN5dIoO4SfmYEAd2QN9PhYc
         ytz5iZK31do4K/YsYu6QlzwPBI/gDb9U6O/YBODGLBogcj4QCuyCLUHQs+zCbNG2m0NS
         VgcJpTYuZrdC26bQMm/9SiWq1EqVxOGyoJ8oXrgh8M3EJprP2gd7ijXqGzh30dAszxXe
         uPZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqrn4chOJ27HCFPaaBANfrnet59UXPkLKk2kZFEkDSBaNO/W/uE44HGuuvd1z9ck1dUM88suI9R3bMNc40=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymAsBsY1yG85JIQNTt/iV/ihWr/TAB3DReYzfdQdLM5AmIjpp+
	qEOe+m4fF6LQMF1Sbbaq3/BR8PBB774YwLRymXkmOnCiyFcPnsYU3BomcHJxYGZS6Uc=
X-Gm-Gg: AR+sD10/7adVGVj89LvTYo9K7FQvupTgDCZi4S8smylnJ7B5YGciDl5dOY9Q1KmJktu
	XQVyrZSCGd5hOYrxrK2aJYRhxylOSAE+jZDHWbyEdAddQB4hgSWf/Gx0HaSXn6vuqvyuUZSFCA/
	ezPKXOprgbLLh4C77S/c3ALjvpb6mN3vPEPQ34WW4H2bpTV3NRbasyGo1SGvpWKPcIi6qnaocSH
	KidZmjCfFLxQZ7+5rzShVHznaG4UwmfEweeykWs/oxvsHSQCDPxmyULVcYnLwPipff94yhSUNrf
	Rn91F7demGepe/TeWIEVGSpdvJijwFxxEw731UHrV5vD9qJhROnNuwFaGoYMxdT+M1ixa8hSzBU
	UhfFoQll/wsExCmCFa5lIxfQbiqlxGloW6FbTXQYM3ytlsEFUGRQGYpjZIYTrOWSJMH+swT4Sz0
	MEXU5NSc+eGM6k4NMf2yB/1iLWNglGW+LbSe/vkcUkx0suXwnl83oxEcIE3gjU/3hV4kuccyBAj
	SXb0Scc9JC3pIr7rNyVdXaMBOGejB2dfgBTA0xrSUo4hLDNwDt/k086CsfHl5/xKw+rr7RHqwbh
	qxf0PhKLJIj+
X-Received: by 2002:a05:6830:4114:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7f196f29291mr5823693a34.16.1785572727570;
        Sat, 01 Aug 2026 01:25:27 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7f18f0da967sm2998424a34.23.2026.08.01.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:25:26 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: lukas@wunner.de
Cc: agovindjee@purestorage.com,
	an.luo@enflame-tech.com,
	ashishk@purestorage.com,
	bill.wu@enflame-tech.com,
	dio.sun@enflame-tech.com,
	fernando.hu@enflame-tech.com,
	helgaas@kernel.org,
	jrangi@purestorage.com,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rhan@purestorage.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	sconnor@purestorage.com,
	terry.bowman@amd.com,
	xin.wang@enflame-tech.com,
	yang.yicong@picoheart.com,
	yurypm@arista.com,
	zhenzhong.duan@intel.com
Subject: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Date: Sat,  1 Aug 2026 02:24:18 -0600
Message-ID: <20260801082419.7780-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <amztrrIGvz8gPxQb@wunner.de>
References: <amztrrIGvz8gPxQb@wunner.de>
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
Content-Transfer-Encoding: 8bit

There is a part of me that wonders whether all of the complexity in AER
handling is really worth it...

Advisory error is one of those insane things in the spec.. It feels like
the spec makes it unreasonably complicated for the driver to discriminate.
What if we decoupled the message received by the root port from checking &
logging the AER status registers? In other words, when the root port
receives a message we log the severity we received and whether it was
multiple errors.

Then, when we get to the device that sent the message we just always check the
CE and the UE status registers? If any status is set that is also unmasked then
we log the corresponding TLP Header for that. In addition we log the device
status register so users can know what severities were signaled.

We can use the Error Message severity received at the root port to decide
whether to walk the pci bus and do the error_detected() stuff. If there are
multiple UE status bits set at the reporter & Dev Status register says there
was a Non Fatal Error as well a Correctable Error I don't think I care if
simply logs everything in UE status as a UE, everything in CE status as CE
as long as it also tells me the Dev Status Bits that are set.

Going a little further I would be fine with just always checking both CE/UE
status because it seems like it simplifies things a lot & two/three extra
config reads/writes is almost a nop if you're already at the device probing
it for the other AER things.

Thank you!

