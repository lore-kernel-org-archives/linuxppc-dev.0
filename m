Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E4C07E85
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:57:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7224214D9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX5mimh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7224214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43824K5GyVzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QX5mimh6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QX5mimh6"; 
 dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43821P2ZkgzDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:55:20 +1100 (AEDT)
Received: by mail-pf1-x42b.google.com with SMTP id u6so7192828pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 15:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/OKhFqwDrt8ytesLKetzsIoezh0CadFGBqURZGIIBDY=;
 b=QX5mimh67AXJzrHJnG6jSrzwEdXlfeKWQxNsra0In8rB3SaFSSzwy3T+GEDQ9kdz8n
 vD00XgPY+N+aJVEo5PCn9sWLqueJrBgvly8RGeuc9CxXFKGoxxE2tbLaNFaWOP9+u/qL
 q38v/qmEb3tLnZV1r3NwL90QDvwrJpujCD3yy5JzFcY4DV6dbYb4Crb1iDdQErFNUGvF
 2OSWNJQ7ZUYcwnPgZmDi9EnAsPGIYCrYMQIbUSsesUP+3KxHAv42+JabVYQPMSnLT/ah
 E5NriywXjo2dyfgpVHH1M3uSD7mxRZenbfx2P1Aqu1GW1r5tbwgNHr1tdh191xhlArjf
 qHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/OKhFqwDrt8ytesLKetzsIoezh0CadFGBqURZGIIBDY=;
 b=mbkD2e4375MrR2o1gayfi5vRmMOG9PSWY1NtaoEjRLdrwbt431NzN1doEqiMx3/sQ2
 IB4TDA4iLkE7laMLdUQvlStoo/JJ10yQr2d8NOeA3e4+NXuWlA70gPpdUP1YK9hDGBJh
 togfHgVHHAIXY+m0dJlsmmhUpcEBib1oscB5Ay9wOjHh4N3akLOSojoJ8bQTOp0mVgLM
 Q8RgJlXfUW6EsQ/M84MJeut3Dmg4HoRgir+qEE7a1fwAEg1Uod8mX5eDJ0X77hI8TZai
 1nBBO4XIan3wuyZ/27ltFOjM8SxEVwBRBlBbcocYZ0JvZ1k78Mr/ZArrHHSMcLlGTvhq
 wr3w==
X-Gm-Message-State: AA+aEWYEvkCmMCyeltfjllZhVS3XKWgYqgP/NDZdbedhtEXsrR3sOLIV
 vyBLe4x6O3+t+8U0JBe1/f2xcvSz
X-Google-Smtp-Source: AFSGD/XDSQLkazriFrgMotHewrJZL4BfALDqG2pnN3kV0wgKPtdwv8rIz87XI0dSCg8v/WSIBnAXtQ==
X-Received: by 2002:a63:5252:: with SMTP id s18mr13877935pgl.326.1543881318694; 
 Mon, 03 Dec 2018 15:55:18 -0800 (PST)
Received: from aurora.jms.id.au ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id z7sm27545150pga.6.2018.12.03.15.55.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 15:55:18 -0800 (PST)
Received: by aurora.jms.id.au (sSMTP sendmail emulation);
 Tue, 04 Dec 2018 10:25:12 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] powerpc: Add to linker script discards
Date: Tue,  4 Dec 2018 10:25:00 +1030
Message-Id: <20181203235502.6366-1-joel@jms.id.au>
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
Cc: Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley (2):
  powerpc: Discard more sections in linker script
  powerpc: Discard dynsym section for !PPC32

 arch/powerpc/kernel/vmlinux.lds.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.19.1

