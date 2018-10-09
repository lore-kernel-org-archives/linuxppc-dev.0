Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F62C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08543204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 23:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMOsfr4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08543204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VD4B5DPlzF35p
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:30:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMOsfr4L";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aMOsfr4L"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VD1X02GRzF2Pp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 10:28:15 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id j23-v6so1633510pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=fISKgYibV/V103iFzBzrVcok6j5Uh/fFqFYwQrAxL/s=;
 b=aMOsfr4LqFNdcyBzvXl7XPiTPoti6H+SrcGN1ob7+A+X7CHlaq0XJlH+f8Au9Zm1K6
 c3llbkF7DYdH6bCx32FEMRxUy4dvx1PlNk+0OymqkV8ctv9fpnIreaZUX2cyQYiHdcCD
 3wm2YR45aWJtwdbjD906+NssvmS+jl59VdfhdpoiWWUm1p8Ny/cSPOjFqxdle8J/Gi/W
 ldFE/ykAcGg+7xhkgX1cNot67nCogC8w3tnE+vzGAxtCo384COBDQFJ6m6azTy4EKXd8
 3Gz+h+HwuPNpkDKxWUWnJKBObTMNMWAvCUi5/74xWxDUzdAGevffJnAdEt/yW8tnk2sl
 +HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=fISKgYibV/V103iFzBzrVcok6j5Uh/fFqFYwQrAxL/s=;
 b=LXwAeGWiseRqkagHYV6eb8bf+z3JJfCQfKE5joZQEe+/C1+/szgle5E+krP4CyxpZq
 PeTzuwdQUlw20gzqiiG2nx+ETXzulpXpW3NskUwF7bgfDjoJ/IS8xZF2PFjYJ3/GEtbI
 aS+6mKbVG1AuauVIkP4mGQHLedd6B4LjqwmxD1fk707j4LwYjGq7VG0JP2ab79ZCLinZ
 iuhfBSpVMdeIkaAiLmLR8QWELVxNL/P0x4tod+g/uAGwnf/MJ7jUUzNtxirRBbRCqqJV
 MeADD3f+Xzzat9IihxvVW6j4EAf57cYuyyttDjxdKg9qmjHLeQdqELW7UfGtsdzp1AWl
 zMTA==
X-Gm-Message-State: ABuFfohf44GXeADHHc7NrxlHG7Coj1VGSYwxHSw76ZNVhmVar6p5jwCq
 XIgN3ZXUaBPRBvuDdIvJbqJ5XbxO
X-Google-Smtp-Source: ACcGV62nyTrIjg8+16Pc/Xqn5GVcYmhTtUQmIVVCzhDehy8wmI2v60xfUr85T2/r8yXirjyZxYmhnw==
X-Received: by 2002:a63:5747:: with SMTP id
 h7-v6mr27570024pgm.423.1539127693339; 
 Tue, 09 Oct 2018 16:28:13 -0700 (PDT)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id h6-v6sm30798063pgn.84.2018.10.09.16.28.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 09 Oct 2018 16:28:12 -0700 (PDT)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Wed, 10 Oct 2018 09:58:06 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc/boot: Fix serial output in boot wrapper
Date: Wed, 10 Oct 2018 09:58:01 +1030
Message-Id: <20181009232803.15072-1-joel@jms.id.au>
X-Mailer: git-send-email 2.17.1
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While doing some work on the wrapper I noticed we no longer get serial
output on a powernv system. This is because we compile out the opal
code.

As it turns out, none of the system-specific serial outputs will be
compiled in. This series fixes that. Tested on Qemu powernv, Romulus and
Palmetto.

Joel Stanley (2):
  powerpc/boot: Expose Kconfig symbols to wrapper
  powerpc/boot: Fix opal console in boot wrapper

 arch/powerpc/boot/.gitignore | 1 +
 arch/powerpc/boot/Makefile   | 7 ++++++-
 arch/powerpc/boot/opal.c     | 8 --------
 arch/powerpc/boot/serial.c   | 1 +
 4 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.17.1

