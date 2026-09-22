Return-Path: <linuxppc-dev+bounces-27947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFCEC98302
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 21:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqCNk62Z2z2y21;
	Wed, 23 Sep 2026 07:07:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790111270;
	cv=none; b=ZDMEVcZMGTB2aCsTpwJxKdFcqlt27uRYBr5x7YB7dgEjV+BVykLcEYGKNDfubNW6psBvDfuh8xPyEh1aaiznMlh+NUDD0Ukx4VhVIWWO+j73veps3KlrHe+vYys836OxUxR5edzb1yEoSNhcqIYU9/2DFa0/99VxlULjpvE/NoMS9evKkPaf8Vyh/wdR2v6Vm3BTxktJjSEsI8p4huEgeYjmCbW9wNSEHonGoi1/p5rvmT+eUDVSzf2IP3i7K2oI5merT8UCTa7IOCyOjKXAOqBfjVIva/1Se1V/Pi4irmtSKXXMbV9MeUwPkpmZCjdh2mJ2g8I7AT0oQft4Oc9F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790111270; c=relaxed/relaxed;
	bh=EeL85Yka+smpT4FhVZXHXaAJCGYDOpSx8O4lbscuj70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqCU40U3YS3VqHwTlg2R/gzMYyjiNbEBieEOK/MBRn97WCcWYA1le8GL9DgiajELAg9kLhfEp3aH2zmRoNcXhsvSBLLi8qHadfcIGI1nfL3RNkYa5xWsUwv9neVAcP/9nxF1FHFba2/HU7offYySmLkIrCnQ9Vzzk4ErJhWFCUC+2IoLk5BK6fiq5vv272TnOXGkHMuyE4cDB22Bp56xL4Kt0XcRATbZz5K0eaVj7VsI/oj8ffrDL14wE6VsgVSoM24W1yrmxQtAIRTWQbZcMe817mZm6NSptpGmJZoL4ZVwMbcNE8ezUUjveupsfqiPG3P/PlaqQ6+Q6KXUEo08fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BmpwDion; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=paweldembicki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BmpwDion;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=paweldembicki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqCNh4PgJz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 07:07:47 +1000 (AEST)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so488458a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111262; x=1790716062; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EeL85Yka+smpT4FhVZXHXaAJCGYDOpSx8O4lbscuj70=;
        b=BmpwDionyvZHWYBbaWWS80n1sPYT/fbNywPCfiJ4xRaqBPXlDZ/T2qTk2T1nIIhjhs
         DaFmvUj1aICiXXwTeUZzA2VwC00+TlavRa9N10ZgaSLo84OWS3imv0BcpBkAKsSpwQNx
         06/1uK3ZuF8xM2B0eTlG7RAo3JUOxadrUB6hcEIqTfyp+TVC6AZv6lxihPDEHBraop3n
         ZvXYiOZHDdE/2Sqy5BRXYyd1vwS1OhNHzFIFzOvL9qmHq9px/AURXqO8z/YhzKKSJZaY
         j5miD1FvkA6992jxwTjSY2R7wXbLUxDIEzUk7NYLfI+UzJC+3DMk2Zbxl/k5txvd0GGD
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111262; x=1790716062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EeL85Yka+smpT4FhVZXHXaAJCGYDOpSx8O4lbscuj70=;
        b=HT51bPOtTYh7pBQY+m/G11T8tAHxVtJUaqEMCuh2FB/zwSrFA/LeRc/OF4/u9wdF5x
         lL9g4qqL6lzBNKbB4yarLGo+66Y7if2FaEIdrfDRtnzUxHYhX+ejzDcjPBsYwC5cG6NG
         37e/MP6fkD6coylCJy7rhYnJISbyG+GVqJFqHZrYc2RB6Q9g71DKcDAyzDNdbZEFjjau
         aJqE6qtz+DtSg1BV9hGvL1MrB2F4j3eQ1nF1FkSjk4wNs63V7SfC5amHTjvUj92KSnmp
         Kvrei5Xqjv/2wAcTYOGKhACeqa1CL53ORpmISckzVuVzIp5W3eKxFqpSOlnOUAYZe5/h
         OGYA==
X-Gm-Message-State: AFuF++lNd8M7ws/HuCHZpTgmc8cW0CFLf7P5j6pYPpfS/ulJVX6dkjPi
	rO+CHBsqYXqYASPItkT75rwzoXWku/drLl6hC/xXcvTTviCn3Is8HQNH5o2mxHRb
X-Gm-Gg: AYBFou3q6aTichfdRfzBznAhkpR/hFzwGXOAnRBi+T3j2dFMALf0dytS+au96U64Fcf
	E/aoyBiudU2cWgU79ZmblwLWsW62a+h5Z+jJCOdz0XuaFl6uOtoIc6/dLtBl3vv1/jLuoVTxoba
	5iAa/TQ+6qwWfRaXRKxoehd+h6cN8IA9DkjMchRHRvStL/qQg2I52YNSpr0BYKIOOi7COD3p46j
	KmZ8JmbzK8d1HzX9T3CfogUteA4DUke+mJ1gneLSJFfRgh67MulihKGwtuMOm25hfCYDA4fbhpD
	m3RybHvMb72mMhZT2wfr646N5tXOAWhu/C32v74bvGRj33iUN9jDx9TPn4P+xi+ls0xLl9Ezh0s
	M0Xo/jJ0dhKpJYH5pBoFY7pSxy9DokgK5LOliYxAOSUYzoBF5cydKZ8adeKE7lwj0XKJc9AVxWq
	csXDsrQwE9HMrHCxF0C5n6oGbY1+Ckwf9u+tPYS7qRXm4J4yFerEh8gXE4Y7KvN+nQMg4SIN9Z0
	kvn5+auGZcWHcfx47wyrADhPA==
X-Received: by 2002:a05:6402:21c2:b0:6aa:734a:a08c with SMTP id 4fb4d7f45d1cf-6aab3bb3bb1mr430543a12.35.1790111261500;
        Tue, 22 Sep 2026 14:07:41 -0700 (PDT)
Received: from WBEC1813.wbe.local (xt27d7.stansat.pl. [83.243.39.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e596sm316940a12.7.2026.09.22.14.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:07:41 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: rosenp@gmail.com,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: Add fsl,ifc to CoreNet device ids
Date: Tue, 22 Sep 2026 23:05:09 +0200
Message-ID: <20260922210531.1103068-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Commit 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove "simple-bus"
compatible from ifc node") removed the incorrect compatible string from
IFC nodes. Commit 25957f7c3dac ("powerpc/85xx: Add fsl,ifc to common
device ids") subsequently added an explicit match to mpc85xx_common_ids,
allowing of_platform_bus_probe() to create the IFC platform device.

CoreNet platforms use a separate of_device_ids table, which still lacks
the corresponding match. As IFC is a direct child of the root node on
these platforms, its platform device is not created and the controller
and its flash children are never probed.

Add the missing match to the CoreNet device table.

Fixes: 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove "simple-bus" compatible from ifc node")
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index c44400e95f55..fe9e7ba5b77e 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -70,6 +70,9 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,fpga-qixis"
 	},
+	{
+		.compatible	= "fsl,ifc",
+	},
 	{
 		.compatible	= "fsl,srio",
 	},
-- 
2.43.0


