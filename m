Return-Path: <SRS0=OkVA=BO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969FC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571DC20781
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTGpNFnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571DC20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLGY50dNZzDqSt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 10:56:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sTGpNFnA; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLGVb0RXxzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2020 10:54:28 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id ep8so1071273pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2020 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wxahb65GNWj1R6uBOeojTKDh3TsLZY6fIM/W/sfGG3U=;
 b=sTGpNFnA99HTL5yhxxk8w7LGhqQdzd8mE375c5DkkoQb+MikviqGbzOAl/YgqjAFHu
 mP+a3uwVa85Izz4SfjoC+CTJHuDP6e5Jb7iZO5UltqG7WAfg5g4jfY6qY8y7qcGH1xNu
 1fyhOINhEVAL6Z2rHjNWK0LfoSOk+/0ykdFK8zKW8pR/Q6RLsySJ8M5fzd2Ti/3lbTAb
 HLBQfcfYE5wZASOXABthX7BTwuI9Ndi5d7Dsgc0YvLJn3ce82lx+XS1p4Dv1NsGdmqDZ
 v/pIUNUn0dJqn81Yxr9gZ6E6GnP6hZz7imLI2dXm10PcOxvWGUgV1EQFp1YJYQk1cAjU
 Uz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wxahb65GNWj1R6uBOeojTKDh3TsLZY6fIM/W/sfGG3U=;
 b=e0I2iB9ZddIWMBLjQG6oHjXqByLcqy8c1ANun3rhbri757F8U/RdlaCuOuKUKBoSnX
 tPz7IdVVoSMlgwSzskZwtgbc2FE/cS4jFjKHuPqRdNehe4iLy5cFuBUcBomheBV5LDvf
 ydu25MNFJ9qS3z+++n9gNgONmZk58eR/xqObNs3CAKY64AXAnT6cKwR5fYiGsAdyE2pu
 EBXNUsK9JKLER7G304pyXJaikJzhoEI+S9PkN8+Icm0ulRo6BLB0oK2PbAOe8gni1tzB
 YVZfHfOHnD1gySsNGBo5ttZhW6ze8uVPe4zqsly/4TC/AT+dtBZgm+gQcSf2DzCPL94D
 6T1Q==
X-Gm-Message-State: AOAM530dVKVuK+iA/i93kMIzlfcTekGGGKiKR6+FbPDfhvbyTFKzT8+7
 txPRn//YqlN7OCfH7IDGhLX0YMsr
X-Google-Smtp-Source: ABdhPJx7S0vH5FJYpwNQb0dBfxfEZH0owhZk8MayfUkvbT40uKo+UHjervsbTH/tnldk2/c7W4IIKw==
X-Received: by 2002:a17:902:b282:: with SMTP id
 u2mr16338319plr.225.1596502463366; 
 Mon, 03 Aug 2020 17:54:23 -0700 (PDT)
Received: from localhost.ibm.com ([120.17.110.210])
 by smtp.gmail.com with ESMTPSA id 80sm10381327pfy.147.2020.08.03.17.54.21
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 17:54:22 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Clean up W=1 for the powernv platform
Date: Tue,  4 Aug 2020 10:54:04 +1000
Message-Id: <20200804005410.146094-1-oohall@gmail.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes the (mostly) suprious errors we get when building powernv with
W=1. More work is required to build all of powerpc with W=1, let alone
W=2.


