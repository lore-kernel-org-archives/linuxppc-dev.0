Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000BFC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:57:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA0D20851
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 00:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaX4UvoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA0D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4383Np742WzDqg5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:57:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaX4UvoC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaX4UvoC"; 
 dkim-atps=neutral
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4383Kv3xVVzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 11:54:43 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id y4so6508981pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 16:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c7EGRy9zDiLUHmZ6bT+gW3bsYXfHsaQYGz94sGc/9Mc=;
 b=MaX4UvoCfj3zN255D1Np1l2bWoECWvl7DD1od4ScBJvjOBNzTf4eHw0yBDqo6fguak
 F9RqxYBFjHrobPb7lOYznqjGgyILNcKORKUP2daee639i8xpZYDdTmbllSsO4VM+HuHK
 Da791om86NxXQeC9pRBs9Sg82to4dIzq7ZQ1aD+iMynt7jHpgDd6oeJNZqeXu73bFd0y
 3KvpB6QupQiPAFthx6bvSzpd08Xa409xTlUROfMm5htKc1IIhlanr8D+qdIex2Y9GDT4
 mVCGaH0rjkxHq/bikFzMKsIOKBsw3c7VW0iymYtX+kWsvWdcXLUvZbW1YMEG+a5KMAYr
 gm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=c7EGRy9zDiLUHmZ6bT+gW3bsYXfHsaQYGz94sGc/9Mc=;
 b=RWqMckGQwchKk02ptneRabRSR08/RD0I0FwP4/92rpEZ+lf6Y+JkLzpsyL6ZDqiWj3
 taFNfODWrv7oC4N4sx/FSFztoJsosklxiO493W5YhWYrtT0LMuVnQ1ik/tjb8cfnMX6S
 fmOloX57LRX2Hfla/vpf6/A1WXW8X4VpER7kpHerDvKm601PSN8a8yZwGS3PEp4tgO5t
 FwKQRVZQLZT9EhmXrkSvTB8N+1xLwAu34Vtw2jzsidr12MVGN0jEU4/oosZgTzVa+jx2
 nikYWWg+fbpYUdiwFSbYGT90v/lXwr3VSYZJn7Ax+NIfFmF9mU8PQx7H1NV6WgLiIPim
 Mn9w==
X-Gm-Message-State: AA+aEWZCXRv4XiUCO2dX4nJKztRn5AJOiJuVq59EfYbUXObmTHwREvnY
 uaUqzK4RFEEtlNFHD27nbUDCIBJ4
X-Google-Smtp-Source: AFSGD/WspqwGPju9jO4Mi3V76SUReTXFYMzIM4gTAyVxQ6XUBSLK18amwA+1TQQx0LpRZkAW0dcfbg==
X-Received: by 2002:a63:d10:: with SMTP id c16mr15180863pgl.382.1543884880832; 
 Mon, 03 Dec 2018 16:54:40 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id u78sm33008750pfi.2.2018.12.03.16.54.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 16:54:40 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 11:24:34 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] powerpc: Add to linker script discards
Date: Tue,  4 Dec 2018 11:24:26 +1030
Message-Id: <20181204005429.32681-1-joel@jms.id.au>
X-Mailer: git-send-email 2.19.1
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

v2 pulls in the branch_lt patch too. No changes to the first two
patches.

Joel Stanley (3):
  powerpc: Discard more sections in linker script
  powerpc: Discard dynsym section for !PPC32
  powerpc: Discard .branch_lt section

 arch/powerpc/kernel/vmlinux.lds.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.19.1

