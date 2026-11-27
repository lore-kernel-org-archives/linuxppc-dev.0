Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2660F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5gMUCMY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbM604cWkz2xqh;
	Fri, 27 Nov 2026 16:14:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795756456;
	cv=none; b=JQ6TA2V4JY+I0mau92uUNL5DkFCpBlyTyGCx16fpaR9EaUbrzY6tLHng65wn4iE1PYhqhDJI17xrkMLYzxYdx2tQyg2qRIlU4dfw+VNRPD8zEDh2dD858Ax4CJBbrSdwpaqqufQrmkMFM6Ug93W3XOUl4D9QenZgT/V78eng6xYXxaCAvLfh8tICtv1WbuzLnizLudj/mlg70hC1AnPvOJTH3eY7/4qQo4aTzVhIb29GsGI/si+4xUtBgWt2BC+6CPqjKeuDzAUYgLS5Ng1481iYpkNKuwB0gSgC2+s7o8ZgOBHbaIGaoxHjuEX40RkUsD325pSQcUTpzqDew3xeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795756456; c=relaxed/relaxed;
	bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc3l8+LaExYgYCHRNjtbER6ZtsRUspWcW15Ij0zmoKQGGg0GihJeUd6VGKbVsON2eYQJqdhdaKxo+xidROMzhMTv200IKSNpuPJxD5gc1Axl29vEw8pCWR9Xqgl7CmJO7rggWwtbtlnp1aaqLVQ5K+DUSP//P6+zrASpbf1xDNEImf/6/cjuRyyiaqU8mYLDcp7pAwXU+z7sthZdzbOy4FUjOycZfmaLA5v/us7sEdBtgGWnaL9Mpur8QsfQFDWKkxTk4YVWR8O7RaR9HEIROPQeCwM27Q8s3uXj4uhvFih6e2nOlCZeyTNohogsOYBUEZoIDvJGf78eMJIyV+G5yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5gMUCMY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5gMUCMY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbM5z2Yqsz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 16:14:14 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso3701738a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 21:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795756452; x=1796361252; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=d5gMUCMYgpi+MMmaCwjV9uR/pOJcmgTbBmFkVHXgufA+vgoaAJIlczjvycblxVvLl5
         FeZCUqTBTPFQhnLakkIg5LqWu3Td2xWt9znA1r53deEGa/N6YkTWY7g6kQXoOB/cEr/D
         J+GVr0egVmo7qHESIUN1ts7pn1UuyL1lDgI9kFQKnsx4ZRnIkMYRwVv2TpgMWRX+W+jm
         vJ/RKpiSVszBa/Iv2OhRm5Lx07OgywhD9+hoSTkJtscV0KMlGTiWlpTG5WUl6f5vr58r
         +XP4scfUQNmqBSVuzQPe12XZZMEmyJZ6CfveGzNiCxZog+uvq0P+MnF5hCADYHJLwMYL
         A3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795756452; x=1796361252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKPPhHAxB9p6FLiS97eRH3zn7f+B3nbBCbyzaA3weeA=;
        b=UxHGjuaeGnpdCYZKOoxE45Ok3OGCAg54JuZq17kygW9UIHFdigBuz43ui7GpGafPvQ
         g6IEV+lD8QHpTvq/3M5J28gwmQp1R8xGTJglMdZpTb5OkwSxCtdl/l1Ye335jiMQYIH8
         WRI60xO6KSppGBlleDwCXWJJQpNPvhtWbiz3HEbWysYMuognaz/xgCz9JdK5N2qy05gl
         yWzByw/nzdcJ2O7ByzP7vGGYJtoDq5cblwIqaNNXnzP9/9ay+b7ZNu5KkWjyiv7qjDMj
         Jwr+n57OC3AZ2Ib+WUAUexiltOuLPa65sctCMphklSXUDl27VajAgyJtNIvQRPFio47k
         SPiw==
X-Forwarded-Encrypted: i=1; AL+hErFEs61Yuk3xJMopSGuFGFTEI8xHtaJT+pWGP5EE1qEFLAQZ6L6Z8hr3uFK6MboOsXopi10KASg/TmaAFTg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/nhqtA0xOkAgxMtdyoV/ULHEIaeVq044bxRuDtrOZ9sv5RJ7Pi
	4kiVSJ0TzDndOjwPYLx9ttHXI96MNhh5DmhkPoDTfy/ZE1k9nRPPiS9E
X-Gm-Gg: AZFdTZekLlsiqqQYQF3yOiK23BR4E9J0TmYtssCzDtEHh6Q8NVgzkLUtHcbZmR3AzeR
	15BvitaHKUhByoVz5xi4C6Tz4OxQ06j9nd/f1BBD5fg2bkubfmcUVKsHirExHNvpZomjeMQM1o+
	+lktgLgYysIdWimxO2no0veMJYQYIyFSWLkVBdZHWbatROryDU1IlNgHpEEbMkPtel/nU3GwIbR
	W1raO7bFtDigdvpGeG+t0twIHJ3u2RU2lM+CU2R1MfRslxNyhbaSb5IgSANOdRa7zn0cfTXnEL3
	O+IUj4i+DXS416qHhf0vhl0HfhFQrW0mh5Lg9CEqjrNNl2yqVE+qnY3oufGIYRcgB+1Kja3+dGJ
	6fM0hzbC+7lPZvgVNuC0ThXJhIUNOZxzfVWK9hnn24hvrT5Fd41U1ct+7acO99aCXueIfRNhrpn
	pOY1RJLr53BAaZK5FL5AJ0eQUvYfsh2Ua/d2NUinY3jquHBoVr883uJrytGO5Aw4Xulda/Vr8rc
	XfqekIyM8FXcWWl48vgWYHyCVNV/qsb/FOt2MR231mnKwuLuGZJprd2RPSOEWPRRhVarOsfkWZc
	YN4bdVdZsgyLXC3GvzAWCeEES+VEM5m1iasRX2BARjSR7vvKD9dT9uPtzd2VhASX/Y8k52DYz+X
	N
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b41c96151cmr15079773a91.38.1795756451942;
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm26265061a91.9.2026.11.26.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:14:11 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: lance@osuosl.org,
	rcu@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: [PATCH v2] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 05:13:59 +0000
Message-Id: <20261127051359.852628-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Discovered in the Open Source Lab of Oregon State University when running
RCU torture.sh on a ppc64le VM.

With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
omits the references to the system sleep callbacks. This leaves
tpm_ibmvtpm_suspend() unused and produces the following warning:

  warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
sees the callback references and can discard the unused PM code when
system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
called directly from tpm_ibmvtpm_send().

Tested on PPC VM of the Open Source Lab
of Oregon State University.

Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Changes in v2:
- Remove the blank line between Fixes: and Signed-off-by:.
- Keep DEFINE_SIMPLE_DEV_PM_OPS() and its arguments on one line.
  Both changes address Jarkko Sakkinen's review comments.

Only a targeted compile check was performed; the full RCU torture test
was not run because it takes too long.

 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..dd577f075c57 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +714,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2

