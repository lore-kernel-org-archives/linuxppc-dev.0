Return-Path: <linuxppc-dev+bounces-28934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164ECCA5FFE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:45:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz3dK3YJsz2yjN;
	Tue, 06 Oct 2026 02:45:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791215157;
	cv=none; b=NrtXfwbduk0FlOQ+PSZc/ntL4WVednYw1x70WfuS9tUtxipZaTNca/eA/NsOJht4/flqjCNuwIawNrlw1zXSRfF7Mhk7Q555/G9FEq4hXoxzFL7OwWtVCLomrEQVRBmAiSIaJtgsR/NRMkIeWmBylKuua2bNVvdYnNWKm+OKofTJ2I12vpcInmzSrMDjuSdDmkDvB+YRi9kj7M716Wgn+F1p2woMk77cKfrT/HK0n0oMFAjUNHzyGgwQTfvQ/gNzZX6nSwdPlt9DlBmPwajLg0kcHgTGpaOFCtkK1bnYOJfGuBA3U8D/SyrwTCJ7Sl/j4U8CgUNk/XQn7gdnKALk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791215157; c=relaxed/relaxed;
	bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWQQQxXtzfMBA/mzIgHDCshlhpAgrB+4zIHCUmxAS7BvbnsQKqFyfmhO3dwr5E5BY1l9FUXIQRKitf4Z2TBWpUC96FWANWiR5UXD8kobSXONwa5PXBessLV59Vyy5MVpyZHL7giOpbHi67ZSo1ZPQmwfDFEb4p77Uyg9etqFmj/MTT8+aTJltzBLe7F49+JFcxh0PH7oZWAzIUuzDA4ZM2XGkgPnaXC+3wtmMgoQqE8P5idzy2C+o4v9g1XUpqwt5r+wNgHAhj0CaeC9a5HzexHBvtppt+gQSn7DmN7brW+0OYD0GRPurTg3zFOwINEdam/BnOpR9dJQWOMAtaExRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GOxYbJit; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3mmbdag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GOxYbJit;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3mmbdag0kdckwfymtiuwndfsplttlqj.htrqnszcuuh-ijaqnxyx.teqfgx.twl@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz3dH6C6Rz2yMD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 02:45:55 +1100 (AEDT)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so3052818a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215152; x=1791819952; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
        b=GOxYbJitAqTvMj/CcClSuyF/OISkNRG62TGycSXZm2WGMSL1AhQGUb7bYumh/bHp7+
         ycR4mf/HzFC3Y+IP/BKUHgD3qirELBFPdwwv1aqO0GeacI25doE3WJODHHCqWEkaqx6Y
         8tS7Rl8xBJ+f5yKO3CHt2098+hZz9iGYo10XFLI1aFRENSZdmduAHbY5i1l/Muwr6PUk
         O+OswtSNiSALn6op4p80Paq/4GvBuWEPBLplwAI3BqhJ+Wx/FW6BLLIO9Z8K9mBN3CTs
         ypS8DNFgX7BHLrJXpdcn47od9jRUWgcVuQ6yFs+cJot2XHrT9da4pl4eDalGd5G0HAHZ
         uxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215152; x=1791819952;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZIMzSNQ5PyWeZjaT/gpYYDCkTtRb/oLmdPXdsZuR/8=;
        b=PqsmdjfDuH7SepmSLCAWnD6XkoVwd0C4+w/bGCpU0BKODgRmx1U4XmhCDTEHJKa9RR
         1mjauigZQQM/Mhsb7PpmVThiY0hMFxO7KUllzy08q1VVOsZFa5HPAcvCeAcY5eX5s6h0
         piaxPizv3X3efFTwFR5ySoWvLWbjKgRwII1k+bz7mJOG3/9g2ioCmOj+6hESscqp/Z0F
         UfUofPn15r9b5J6g4JdqItQHl8MCkolAAwsIDZWDYNo762f67GtzZZ+T61wRrsyRlU8k
         P2FQXn0y6tM9d1E/GF4LCdMHeUv/wnOXhVxxGvxL4S/4ZnzYpl37n0ms0QDNyVnDSCW1
         p97w==
X-Forwarded-Encrypted: i=1; AKwUvBzjDclmudUjlg1dMIDlRAGsy74fcUoUC5sKwVBcNDMpSm0/q1yoZBUpTUgWoc1Eur7jye3hVuyUkIrpqZE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIZxV1lztCQcW19Ig6/aVqByXTFOjVqDTPLRwL9Xnr3KFd0hKTx
	5z/JTxUQlAtPA9MyFd7cVCLLG5kP3ZVA2U5dckRv/ASNXcSyLl44XZ1h4BlSSzAJ/TPPKTby6nQ
	kplYnb7C7nEc/00LEMYEl0ZKCjrEQ/I9M5g==
X-Received: from pgby17-n1.prod.google.com ([2002:a05:6a02:6511:10b0:cc7:d4f0:846d])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380b:b0:3a7:d9d9:b309 with SMTP id 98e67ed59e1d1-3a7d9d9b6c2mr4026235a91.41.1791215152003;
 Mon, 05 Oct 2026 08:45:52 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:45:51 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
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
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261005154551.1508146-1-rathodpriyank@google.com>
Subject: Re: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Gentle ping on this series. Patches 1 and 2 carry Kuppuswamy's
Reviewed-by, and patch 3 is the kernel-doc comment he suggested. All
three still apply cleanly to current pci/next.

Is there anything you would like changed before it can be considered
for v7.4? I am happy to respin.

Kuppuswamy, if patch 3 matches what you had in mind, a Reviewed-by on
it would be appreciated.

Thanks,
Priyank

