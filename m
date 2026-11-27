Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33E606A323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbxIpWcb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbFVX4qS3z2xqh;
	Fri, 27 Nov 2026 12:01:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795741300;
	cv=none; b=ElAy/cGfwIhWBSFgTHjYF7JPA3pOYlCd5Zw8UthOcsWJGeUSgOHI+rOCLlCIysg1mR/SqZcN/mT+uKd0Et2TcpwrNA+Hoz517lVIrsoyjOpVh6EctD5AVDL8zT7mm2PWvkRu0we41fFb4Cm5GEaYDPhsBtv8KykPuUHyDKm0jCjGSpg8QWjD2G38WZIOtf/QVhNuCMR+SBF5lcWSscEQ66S53Bj8B2TO8bxTMgoH7qdKjJGFzHsQwMBnmV8kV67Nlau90u2dtU8ZyVAnQd4XjYT5u264GdaHaiDGiPtpXLi6nCjX2fDzHvl9BOeW85LdoyscU4hjY1IJH9s2qwVzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795741300; c=relaxed/relaxed;
	bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MC9jG+2pgmmWwuFdHwsM3H8vdxb6XC6ZV8JbKwMV4AfODubucvNnoRlQjWE2nw+7oaFyoTZ2ZN8OGtXKWiTv2CYjaFji80yVcuWKIUbGirGkMA9s0T9VzPs1rbFPRqyRu5SVLopSaBirKCjzTomEJzAssi5IBwjDlgl7wgfN0z/E4ZtQFUIxBeMUgmRvtgbbjfj4bwbkfJ9Uz9E1TwfdKwAPfaVQsp1o6rDskVFbze1zy5HiO9sxYC0Xu1+zfXQ/oI5XHeUsGJbxhwSJX8Bd+rJoYSpOq2aR0crGg4nMdqmw51vAgBf9TEZJETGlXxbLqVqeWITML5gvxyfmN1Vzww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbxIpWcb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NbxIpWcb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=zhouzhouyi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbFVW1qxnz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 12:01:38 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2f0414c1062so45362885ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 17:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795741295; x=1796346095; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=NbxIpWcbtgucyb/ACXa+IUOd+6rPcNJZkIWby48BDP2/C4ucjEQx1DPT+6YYEbSX6M
         oDMsiB5HXdB3jaDl8jcYR7DpBbqF+oFDh5I6eABE01ueDsp5Awu5zXXJVVtZp3gkC97d
         0LcJzvu52sy6xJGZnfPG6zwwtYiQUGuJ8xjg7fViPm9YMrNbwYZUIiVbR+XQA8/cA43e
         x4ertazR2Ak3Zq3kDTLN75X+jj646WLQP3+Yws9pXckIND6wAse6eh0Y5uWS35EU3yuH
         1cRHNm2TC7KSRB6jARJI2nGawBnWQo38ob/LXsRYH4MUdjNYnxQlUfNED09xUh6Pf/nD
         lrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795741295; x=1796346095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=qwY9lNLXEhDVLaIvIkLVFDIXVvF1u+Tk072PH6g0HmZ0sNE/IXUaJUAv3o6MMAMECX
         zPwJo0I/mitr5JqHUSwxMPpZhxRT9dCJ7yD0qlfV9dMGdh2+COhyISkrIHSp+ftymfVK
         u4hdF/XGIRL5vcb8sRKyGblQ6Im2iTt9otpuAfpVedro6R7sOnJrcQVMEUtwUo5Yhi2Z
         VzW7EcHjWtmwB5uJR0fLidyKz94lruRhDwwRTIx4V7LhOLcESYZb7Ovalb16nEskqS1r
         GSyVFRxSsk8gmOdH+1voH4joVwABVNNEnD3lqsRIlDNvMG7T2wIMbqtec5MSaA8yiwq3
         o04g==
X-Forwarded-Encrypted: i=1; AL+hErEkiq0YJ6Fg0edJZCb9Y95avYRunuyzRng2YX2tAbYukW+ob8VlZZxmLAS/IlqShWnHIcXR/l5EYquHLN0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/B8c6qzvVK/ubPOfCp3ITetJ5w23R2DFJTz5tlVJSzW5qIW8hQ
	TGhYlqI8VtkpaQb54+1qAr+yDHD1ctynLcYZ1VwVw8YNrvvuVMp/D04e
X-Gm-Gg: AZFdTZe5kBs94wHXZ3BBjAB1DkYBf2tUmcAGxwFmF5OCy7w5YQmUmC3nQSC0PX/NUMs
	l9OYkl9WWgEhD6wn13b+6NEzUC1j0DyLjV6zXsWs3u88fJcdpBigg/Nfiu+5G9ML49XhL24y/FA
	BG8qavMER/tki01Ezxno6UtUbybxMygX1/4N88W7lfHsnjpa2uF/uYd+05zVujku48sr2GlPke1
	K4muljKOdKCwT1tM23tZxXWuLDe+8Y7yq34NDsxHIq59/NqN6ukbOgfJNh8/QhsG4WefeVN4HNK
	J6umJ19yJrRL7AOcVgsAY6mSjI08cXl9oB3SZIOkzDw5vfxYAYnE0RxIpvz2k1rmBPGpdVwQazF
	gxBGRB+KfVSPLCgl1ZDryms11NezuEim4LcJOKmEJzMSRHjDBDP4J/tEFK6JZucNRcD5cLZO2h1
	Dv3TQLJXP/LVZCBzPIZiQRXgLhfVTwBwPFFwLEOACOvGjsV8e3tEZGy+5/KBCgBZvMhK09lSg+B
	oLI0pMCFDiyNwr0jGChNhcPWdbr0pFdwv2b+ncKpaPXr2j1ateJggBN/CSmYU9ecwLyTo79BO+N
	TBkV0zQcOE7yNiSA4McnkUc6Jf4VFu8iqv0exbOm0BX5X1GiqeuoCXHrdoIiKqAYyPb3M4PfcOB
	Q
X-Received: by 2002:a17:903:230d:b0:2ef:f432:3fab with SMTP id d9443c01a7336-2f03f169933mr212665565ad.43.1795741294670;
        Thu, 26 Nov 2026 17:01:34 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm99260055ad.41.2026.11.26.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:01:33 -0800 (PST)
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
Subject: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 01:01:24 +0000
Message-Id: <20261127010124.848125-1-zhouzhouyi@gmail.com>
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
 drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..9840d0ebe6a3 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
+				tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2

