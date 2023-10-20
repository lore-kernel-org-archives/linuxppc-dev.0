Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B863FCDB474
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Oct 2023 16:16:42 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g6XL6KrL;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SBqTj2cvnz3vYv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:16:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=g6XL6KrL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+5f4592396010e9e3c002+7362+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SBqSl6fBPz3c5c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2023 03:15:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=I4hMGAn3CCXbvIhFniLsRuw1X84vM7LzNgk6oVf6hDo=; b=g6XL6KrLFvXCVI21u1A5KeupFv
	+QFnHNBtXPSX2WGx/qzbR8hAv15UjjS3G7GeUcRbT6Gzod96JethLXROgfY3uc2SU169IvhiZdRGh
	PQGKjDFv0/nWu/OIs7h5I+YdQjcKmWPq6iD07vRG6QQQEc9KMRwcxd9MEFfDm+JhqgzS/494qQBHg
	cmRRbbr+caoCft14R2moMfBDrzAlzzoBVVkfYfN3hN7MnKJVzuTCxV7GKaf92411iUcMwW41EdBZu
	LzyJ/6kNrv4xSgCoDDiOqDloTvQ2En//Zuw6p8kbzieBn/ZS50xuBKNEiKD53bPkfqRtyRa8Wwy2S
	MoYvVmXQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qts9u-00E44C-84; Fri, 20 Oct 2023 16:15:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qts9s-001UOZ-13;
	Fri, 20 Oct 2023 17:15:32 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Juergen Gross <jgross@suse.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 2/3] hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
Date: Fri, 20 Oct 2023 17:15:28 +0100
Message-Id: <20231020161529.355083-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020161529.355083-1-dwmw2@infradead.org>
References: <20231020161529.355083-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>, Jiri Slaby <jirislaby@kernel.org>, Roger Pau Monne <roger.pau@citrix.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: David Woodhouse <dwmw@amazon.co.uk>

The xen_hvc_init() function should always register the frontend driver,
even when there's no primary console — as there may be secondary consoles.
(Qemu can always add secondary consoles, but only the toolstack can add
the primary because it's special.)

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/hvc/hvc_xen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index f24e285b6441..4a768b504263 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -588,7 +588,7 @@ static int __init xen_hvc_init(void)
 		ops = &dom0_hvc_ops;
 		r = xen_initial_domain_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 		info = vtermno_to_xencons(HVC_COOKIE);
 	} else {
 		ops = &domU_hvc_ops;
@@ -597,7 +597,7 @@ static int __init xen_hvc_init(void)
 		else
 			r = xen_pv_console_init();
 		if (r < 0)
-			return r;
+			goto register_fe;
 
 		info = vtermno_to_xencons(HVC_COOKIE);
 		info->irq = bind_evtchn_to_irq_lateeoi(info->evtchn);
@@ -622,6 +622,7 @@ static int __init xen_hvc_init(void)
 	}
 
 	r = 0;
+ register_fe:
 #ifdef CONFIG_HVC_XEN_FRONTEND
 	r = xenbus_register_frontend(&xencons_driver);
 #endif
-- 
2.40.1

