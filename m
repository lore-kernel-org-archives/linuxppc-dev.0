Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC70C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:39:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C7720737
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 01:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+6jjH56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C7720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0SsW2bv1zDqWb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 11:39:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a;
 helo=mail-wr1-x42a.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=B+6jjH56; dkim-atps=neutral
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0Spf00BYzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 11:36:41 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id k6so39153709wrn.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ey6at+iZvSYzekmkbHUkgoPykV60F/6naH0tuMKq11U=;
 b=B+6jjH56ZJIT9Du19Jspwpl2PnGX6r4GTYTogyU2h3UNOZu/NY1tTyGHjkZXisYrPz
 Ari1vS88Q/6SJbPkW9jh/P7O+ctfvHwLVASbY59pRpjVQOdG+DPna7IK9G9CqGw1yrda
 dmXg8ijgnSSsqFBzdI9XxStl2H/IgM3B8yWUPYrMqV6Pv+TqGn+UyAxgL5Q6N/YJ4no3
 WJbAkKsKYv0MvtIF+H3wA8vRn/LRVkMSXCRSWsf69FPfVQRKBz9GOrf5Ewi0W5Ekv6re
 2PKtnYKcPkDshWIppICXpgj/fc39t5R/RsovGAvUf4UtHjXCrtYWCXT2bh5fj39TX73o
 76dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ey6at+iZvSYzekmkbHUkgoPykV60F/6naH0tuMKq11U=;
 b=camAmBc3D/gTXAH6J5LmjwkPMz+J3cdTB4825JAqRapVqbFKhKIV3jk8ktVVBj6E1K
 +iTbO/Jh3bENEluTCnh86rcCyx/kba96bNBToSy51WP2bflgEhZG8indvdAXdxtsF5X6
 xaO6BABAm1vISbv9kSOruGt35L0SM4d3qiMsb46XqK8I3lPSBtS7RoapjSsIWE/f5FXg
 H1ivjtJimbsQgfPmJKh2FnEt/NneZNkZ6aNIgSmAOBy4EVVouh2HNMhPz+uMUO4Hp6mO
 9/nDgzHikE/R+dbuP8TZpeSfrBjEzr7Q8xYB5n9uBfs2GDrnwWp5Mi9yPKcFF63c7OI5
 B7/Q==
X-Gm-Message-State: AOAM533QCbv8SvTKnDOvtZoML20Myo31SxnQ/FLDEpcRWPNx289b90hg
 lCt2l7oMreHFjHbkrXa4Z/cgZ6Ml80M=
X-Google-Smtp-Source: ABdhPJyQzctav6meFbj8SWOyLm/ZVgxX5Z8uE4g9GPYY3yvq6agVhpsU1Q40B4fJa3P8yyKe7qC6EA==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr45359754wrm.82.1593999398167; 
 Sun, 05 Jul 2020 18:36:38 -0700 (PDT)
Received: from 192-168-1-18.tpgi.com.au (59-102-73-59.tpgi.com.au.
 [59.102.73.59])
 by smtp.gmail.com with ESMTPSA id v6sm9533392wrr.85.2020.07.05.18.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 18:36:37 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: EEH core pci_dn de-lousing
Date: Mon,  6 Jul 2020 11:36:05 +1000
Message-Id: <20200706013619.459420-1-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Removes most of the uses of pci_dn in the EEH core. There's a few
stragglers remaining in pseries specific bits of kernel/eeh*.c mainly
the the support for "open sriov" where the hypervisor allows the guest
to manage SR-IOV physical functions. We can largely ignore that on
non-pseries platforms though.

There'll be a follow up to this which actually removes the use of pci_dn
from PowerNV entirely and we can start looking at properly supporting
native PCIe. At last.

Oliver



