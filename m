Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5C8C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 09:59:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCE7221FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 09:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xC0FljWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCE7221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWxrs1x2ZzDqrW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 20:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xC0FljWq; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWxpq2kXZzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 20:57:22 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id p19so5806638wmg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJdlB8xXslxrXWz+83yO6rq8sfEN0xtnjkNe/5k6q8o=;
 b=xC0FljWqdDp0JYyC2N6sRxyC4M5oR8YfJDzzWjOcUUI2nmbP1cPJsYPk+zSNsuZl91
 I2y+3FjkSM/lnfwZcAbKvd4jRftxtMK66fC2xdbI14LiJtQl2H83DDZOATO4jAtyEz1K
 CEr728uOPMjJeqsa239TbdxYsFO6ufLh9/bPVnMS+etRZ5NA6kQBhBbrbESm5lkO1q/S
 xMQjty3iW7tgKcYqnKYaU5RnAcGeNs838Z9B5bRVoVjrZYv3hJeuZzLeFB06ZW+msqOQ
 m1/0uQsgIPTLp6+nN0v/N82+WrU7N66Kfk4TRwhLvXwgZGcLpyjmSoSzoybIjwE5u9Tv
 QKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SJdlB8xXslxrXWz+83yO6rq8sfEN0xtnjkNe/5k6q8o=;
 b=XyhWysOL67NJkml1bXR63y5+MypySMYzdvFtHs48/tzYURSWJGfizVq399oXEpmu9N
 CBc+K7meUJys6IbL3f+AQsuCwIBJb43008O43i+FgTliaOsHW8gWLq1TIk1JqdNZFik4
 KVWwP+025+18d0o5yty/hxiGps1xKGoPTbAj+fMS8Dd4zRFfCr7AB0aI/VgV3XGCH9/D
 zuqJgX469AsxyO/+1GC1Utdw5wnw2vBn3KQRsGMfNM95mgIRWerXo74tK94t/ywwKtd1
 eqopZiIhZWImcnskmK6uJD4fXDrZ1DxU7F6ZJPrp0ORJDGfNCIGXmD8YkrcIo78ECwBu
 C0vQ==
X-Gm-Message-State: AOAM530WyRUpsZpUZUI3GcVCqicGUOOWA9QN1GJkEVkT8Nx5p1qF4Q7A
 WMfwx+kWTWeo67m2k95Vu1yDwA==
X-Google-Smtp-Source: ABdhPJxg3Ef2Soll0LH/c+2LR15Uk1TaaSB8m0drUb+pvQ4sDVM8xS9tns/UgMX2m4xG1FCkRr4LAQ==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr8872342wmk.100.1605175038192; 
 Thu, 12 Nov 2020 01:57:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id n15sm6138792wrq.48.2020.11.12.01.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 01:57:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: jdelvare@suse.com,
	linux@roeck-us.net
Subject: [PATCH 0/3] Rid W=1 warnings from HWMON
Date: Thu, 12 Nov 2020 09:57:12 +0000
Message-Id: <20201112095715.1993117-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-hwmon@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Andrew F. Davis" <afd@ti.com>, Paul Mackerras <paulus@samba.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Lee Jones <lee.jones@linaro.org>,
 Beniamin Bia <beniamin.bia@analog.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (3):
  hwmon: adm1177: Fix kerneldoc attribute formatting
  hwmon: ina3221: Demote seemingly unintentional kerneldoc header
  hwmon: ibmpowernv: Silence strncpy() warning

 drivers/hwmon/adm1177.c    | 10 +++++-----
 drivers/hwmon/ibmpowernv.c |  2 +-
 drivers/hwmon/ina3221.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Beniamin Bia <beniamin.bia@analog.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
-- 
2.25.1

