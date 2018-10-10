Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B5FC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:11:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597D62087D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USm1XORX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597D62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VNyM2PqNzF36B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 17:11:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USm1XORX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="USm1XORX"; 
 dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VNvR52yLzF2Dv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 17:08:35 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id w14-v6so1981770plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4XzZJHjflMG6BUibazEuzQaFsKQxVuNY1xyZhD8uvNg=;
 b=USm1XORXFDgLKCO82Bu0RwGDM0OFuUPlNP8OJPNirbSQwzHOTZ9SQlscPuxiX+kfWG
 QFIq7J0rCi1Px2GIabLuMy8/fvXvMOqodi2+tOYx9PIxVr2KoABNoC7VgaB1ywihLjQM
 N4+0gu04fuZgcKoL+O4Z6u1ku1vexv0JNty5nzunnlknkjOT7wM6uBpMjBsEqjDPihVd
 gwQtELVjShA+CHSYTv40KQ3VOszYooGCw3lxlO1wC4bCDZmS/70VI7nTwn3Dz7eRKZUq
 1Lw8NjV5WlHPt+ZWYGhRh0Ibm0xK7dJs0VitDXKIPZgt4atjF/ma3c0LiV5YadHVJlhP
 HvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4XzZJHjflMG6BUibazEuzQaFsKQxVuNY1xyZhD8uvNg=;
 b=Sq0jhHKENRlcvZbAAHRFteGVpKs2PPZZaVpyubeRGwe0SpLEksIHv+ef1inpnMpNxa
 My96N/Joad3kGuq33mPtIxAOpF6YUJHzHE+FoDlsmBH1N5hqJVBRCXb9XyzpP0R7qms1
 I/xDYSPyVTHkMXeQVpYKnwsy3wkYmybNJ0DIT4NXpZLuM0jnK6WbV8J/JdowEh7nlwBS
 nALzvW/hYEIVBLbmTymRlFjPtlckT8QPF9/AhhCBmq+oVYNZjm9e6NV9wVvg+60630I+
 phXP8cK1cCM79gcO8u/HrdJl9rP+4Ue/T0AyMaYCftQ8kVL6X9Q6baZli5WsyEs/EgAd
 PJUA==
X-Gm-Message-State: ABuFfogPi9gAUVQYexQcCS8usAxlcvYHbyJBOyhyu6/lEsrBGn0Ilb+i
 9ijEdjlwLpI+EMqEOnupFWDH1Nys
X-Google-Smtp-Source: ACcGV60GoJZKjR05nTukAzfVvwpgJ6Wi/qyXrNtGPHDpw9JH1V/+HJTT3ap1VTRf/7nYDoPcz+4GuQ==
X-Received: by 2002:a17:902:8d94:: with SMTP id
 v20-v6mr31872845plo.20.1539151713206; 
 Tue, 09 Oct 2018 23:08:33 -0700 (PDT)
Received: from flat-canetoad.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h6-v6sm31742957pgn.84.2018.10.09.23.08.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Oct 2018 23:08:32 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: PAPR SCM support
Date: Wed, 10 Oct 2018 17:08:10 +1100
Message-Id: <20181010060812.20068-1-oohall@gmail.com>
X-Mailer: git-send-email 2.9.5
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
Cc: nfont@linux.vnet.ibm.com, linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series adds support for the para-virtualised storage class memory
interface defined by the Power Architecture Platform Reference.

Patch 1 implements the pseries device discovery (via DT) and hotplug
support (via RTAS hotplug interrupt).

Patch 2 implements a driver that binds to the platform devices, does the
necessary H-calls to activate the region and configures the libnvdimm
interface. It also adds an NDCTL implementation to allow the "metadata"
space associated with an SCM region to be used as label space.

This should go in via the ppc tree, but an ack from Dan for patch two
would be appreciated.

