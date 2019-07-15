Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E1FC7618F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B6220868
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtFy2UhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B6220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nHVx3k1tzDqXf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 18:58:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gtFy2UhQ"; 
 dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nHSr5LJPzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 18:56:26 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id m30so7106404pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7bw8Px04TQS7KSess3RDbLoN7J7qa0pxC0KhtfOVSGI=;
 b=gtFy2UhQhAhTpyqHSXEcM6tk0ho0cpvxrRHcN+7iSInUZZK/ue2+riFfjpg7gDkW3w
 SWZV8ihyjmT7BW7oXQM5aIDcxxcVw78giO3WCOVTDklxMW0RdHHAp53Fuf6E/MnlBmpR
 p+TmlY4ONTU9UlnBzGJFjBce8jxVaw4akfa6/ch++uyrOJvKr3ToAxe1cxZKpKBRB1et
 HV1jnmsTLiUR+n4Z3101nqqiK1p1yU59Rj0/EqfJQtdaayVy9Vlad/NO5Cl1eYH/GHs+
 FMPcEXonM0kCwCNBwUYwlAH+/rtrzGJk61gm2wOmuzexumCK472pqtVfIvbsXs+3j1v9
 T4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7bw8Px04TQS7KSess3RDbLoN7J7qa0pxC0KhtfOVSGI=;
 b=boQfmsVPjGuczEP/w8UoYnHGFwNWFqX2+eQBoZqsfS/+A1L+Ehh31fRWR8A/P0ksXE
 FpR61IhiGY18vATldnwVx6huRik167y+9hSHievPFsBWdIGb8T9ApXx5M5bueV+Q4HjL
 gLoA/VJbSFsFipZ90P25C4S2I9atImGbzzmu32/qBAHukIch1WDZmfnP6Asy+FchmjHc
 lRFkpFCNWb2iK1knCFqO+XIWpXdWh/GGxNBh7raSYnH21k8vYETiMM/lOZRUcZPyBbgQ
 U9ohvluRncNmjPqSiki/zCeQTupkw/QVnqGozp3vJqOKBAYFCYkCR4dPyqAspaketaSe
 h07w==
X-Gm-Message-State: APjAAAXSte+tYeykMNpah8arDnth2Pg+zeFOmOlguGp2XQbb/MPGQA9N
 nvgm84pCjge45rj66RsFRXHWUihXlXs=
X-Google-Smtp-Source: APXvYqzJ9BmUiqTAYX8kZZbOIgn/Qj4iD7v9OGOAcQuPvaC14NJUy4vF6GEwtZaCGUjyWiiH/NHXyQ==
X-Received: by 2002:a17:90a:c70c:: with SMTP id
 o12mr1456246pjt.62.1563180983075; 
 Mon, 15 Jul 2019 01:56:23 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id d14sm22514815pfo.154.2019.07.15.01.56.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 01:56:22 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Misc EEH fixes
Date: Mon, 15 Jul 2019 18:56:07 +1000
Message-Id: <20190715085612.8802-1-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
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
Cc: sbobroff@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes of no particular importance. I just wanted to cut down the pile of
patches I've got hanging around.


