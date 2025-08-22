Return-Path: <linuxppc-dev+bounces-11224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E299CA0EEB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Aug 2025 23:14:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7wxN0kMYz3clb;
	Sat, 23 Aug 2025 09:14:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755886541;
	cv=none; b=Fq7nnVoDMcIer8APjiglHZubCVqr1zdpZP03OLKSHDwUP0HCtSR+iOlDgmpS1U7W/IP4O5b8qWYyNgHf6C2RdwJZYsW9umuc6VVaLDsm0ryhH2UerQ2DG3PsZflNAb1nYFd2XfLn0p/WvZSAnaWN722nX2rluBZzy12VdBewu9n6zm9vhsYgJrRN94rjttREWTUlyC+DvncQEi5UWAjBOYek2kPWXt0mY2K+3lHzz+IqQ35DJdIi3rz2D7jpGllcLahUTgcvDC+IKjVv4qXsOcTgzhRhAcArRJvCioWoMhKJF/F9ti9hLBe7sLbF3KzQDvO9PEjdNlMpKZD9mr9Aog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755886541; c=relaxed/relaxed;
	bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0TXAt9Wp6nH/EIfR1tSCuVFQg7+UC/dzGglCNcgVQFhv2lqHe1SdgnQKWtesdE7BASAsuLJyN34JqMkcH/DUhpufSRcziG7ITeQ1ExZBTiKUh1g44KG1qbY+vkMEmAIjb0ps27/cjUAHlBUynZCVWXgMKA6mJthviRzDxLGWxzWUki4ug9LB4rstj9HpzLrWZlEQQjJeq2ariGSloT5hSYFJD9zzvNyTiXjwRjq9K67N9yj7ng83WC1ZThsBYN9g6eXbW7roz+I27Hs/Y6hvL8mocK/Uv/mlKfSyXhh77hc3O2Drjq0tAy7c8IrFOvOy0PAAg0pyApbjVaUNZMe5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; dkim=pass (2048-bit key; unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=cnIefc3w; dkim-atps=neutral; spf=permerror (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=mattc@purestorage.com; receiver=lists.ozlabs.org) smtp.mailfrom=purestorage.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=cnIefc3w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=purestorage.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=mattc@purestorage.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7pJq5V6Tz3cmW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2025 04:15:38 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-afcb73621fcso330550466b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2025 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755886532; x=1756491332; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=cnIefc3wivNvmxRC5VCp2s8//SQa38IoHj22HoTBCP2teEc5OKIauIhIR0wtaKUyfZ
         5c5bDc3amTFXP29eoz8EH0b7Ql7seymeogt2m/jJSkvg4rVfe0vrl9qxVPC2kWmkrWTi
         frQVW8J7S+uBWtOUPkct+AVV2zqKOgL1k4v7beyvrlzZ4ydem8UVkXxuQhHwWRvkV9pu
         zACxBKUNlVy3qojyWdGQFLzDkHy/DS/9uy38dHWJeng+Y6THMziq6DezNuLEwBGVt2f0
         qXTwtyBu/S8FhYosSG9wmfNJjSWSeFxx+dxXenvTeMk00NhHYfbrHSVLza3G5y5TMC/3
         tX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886532; x=1756491332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=XOpj+8UylaANKbKJaSy3ww1FF9Mi8SNrzFwdQj35fo/NctZmlCtXS6FObfH4oJEVuG
         Rq5PW2XY6gYzucivm9iS5OVUnI8HyxoKT2WieeJR9axbHxnLdF7m5Qsa/08XZiR7TYhR
         MXnJAmmNYIanQMjANnfnBCa+d/OQgMMpFEsuvTSPJxJLr4MqMSmrq4Xucv/Udb3Kc2A5
         mqUYXPX7984/Vj0oLJ5mkr6JrRcd1j20L/teXGwlRuEABgOwDPFINmI81ymJWesdngAU
         tevwO9rzk4ioSZju/rwPObz+hfeDfuv6pUnr+6uLB6sEvjr/ynzt/rm+e4kpXd7ZC7JC
         IzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0XA66L5wHB1IjeP6k+4TW4afx2SdmHJ7hxvfXcbaLNPpTLKdLOt2Qz0TM5sND3u9VKb5kdKNY9ROrpf8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyDNsJsOHBc5ACMHEdEP/3C2aN6tQl+dFWcXUSaqp2UN3DK/bf8
	qSN+8YNO1c57qVJAPeuMVJkqPxZv/byeOD4uAd6HW84sOFujg47L7ByobrBxXV7anE0=
X-Gm-Gg: ASbGncsxuNQFQwW1MvqNNse2/THKeCq6QZAddg6C+kVLGsxp6rO+Mm7sgnmpi/Cu/Xa
	OgKz0/B5M8UKDOm6XFQR14Ut2hbDMrhLZ8AhTRCLFH+YcS0W2TyrAMj/0g0kql7rPta//ItSnSY
	KZmfr1NZIB0naMhR5oQaik7fvzyio3XQP4UTNt2T2WM7ntaw43f2eb9HY+DYjB+o4Rn3aML5dZg
	zQV1QDYtv4W6nQ1J/aIE5bAhiUoUnDYUyjMuGBqHxM2y95Hw6r0MHcehhuy4BQgFxtfsNtE3tyL
	xXEirck5EBTMEIJGjX5CWS2itq15QDiVzGKuhf1n7gjgJVpTTXH0a2+ChJlrctaTR5Eec+1Krur
	z1ciAIRpHSMnxxAcBRIYDjyDg+XXgD58b4tVAgw3raqiGr3DIIIrVnse+BYc=
X-Google-Smtp-Source: AGHT+IFi/UqB7Uldrm+9VbwlcvS/K9grf+HFQGwUPWY0Y+SNRhjWVo0c6zi2HNxzYpUPo9jAOLRO3A==
X-Received: by 2002:a17:907:7213:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-afe295c0e07mr334350266b.35.1755886532255;
        Fri, 22 Aug 2025 11:15:32 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afe49314f63sm16474966b.97.2025.08.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:15:31 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	agovindjee@purestorage.com,
	alison.schofield@intel.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	ira.weiny@intel.com,
	james.morse@arm.com,
	jrangi@purestorage.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rhan@purestorage.com,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	sconnor@purestorage.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	zhenzhong.duan@intel.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Fri, 22 Aug 2025 12:15:20 -0600
Message-ID: <20250822181520.12394-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250822165112.GA688464@bhelgaas>
References: <20250822165112.GA688464@bhelgaas>
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

On Fri, 22 Aug 2025 11:51:12 -0500, Bjorn Helgaas wrote 
> I'm terribly sorry, this is my fault.  It just fell off my list for no
> good reason.  Matthew, if you are able to test and/or provide a
> Reviewed-by, that would be the best thing you can do to move this
> forward (although neither is actually necessary).

It seems for pci there is always a massive list of things in flight..
Difficult for any mortal to keep up with. We pulled the patch into our
kernel & have started testing it. I'll sync-up with my team internally to
see exactly what the plan is & how long we think it will take.

Cheers!
-Matt

