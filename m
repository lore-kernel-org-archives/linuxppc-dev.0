Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0126C001DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Oct 2023 16:17:30 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=T0zKb6Qe;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SBqVd1QsCz3vck
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Oct 2023 03:17:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=T0zKb6Qe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=batv+5f4592396010e9e3c002+7362+infradead.org+dwmw2@casper.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SBqSp2L1Vz3c5c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2023 03:15:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+yckRkFG8qkJeHSM7gJpLJWXmYYcv8nGS7sjBbidu2o=; b=T0zKb6Qe+rPgKfDjqH/Yy6akUz
	iPqrhSFIqIkEL5Zx1lo+Xf8Ln6ZtkAldLanYm/TC+BiWcrLRUcQ7aYSs2pLWZ2YieCBlAIb/k7M/7
	t3T+lTc5eljToOU5aSM5pXsfSvxK9Kqe9iVLwwl353CI80nUZL3HYDGXD5o3LdUX5/eNgvAIVv7EA
	h8ATW3NHs8MGFwvwj64DIAwyJQi8A56iiBnF2Cp+Iyh66H0pPzt8sPBJ35utrpRCrdTMTH1lXlnPa
	PQqmwpaCOZlnPANH8XpVwHB5IUUFp0nTpjJIVqMv813nea7BnGnAGOxQKOJKJmeEKBsRlybO9JZKq
	ftfzAo2Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qts9u-00E44D-7G; Fri, 20 Oct 2023 16:15:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qts9s-001UOT-0R;
	Fri, 20 Oct 2023 17:15:32 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Juergen Gross <jgross@suse.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/3] hvc/xen: Xen console fixes.
Date: Fri, 20 Oct 2023 17:15:26 +0100
Message-Id: <20231020161529.355083-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
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

It started out relatively simple, fixing the fact that the secondary
consoles didn't work at *all* due to bugs in the IRQ setup. There were
one or two other simple fixes that I snuck into the same patch in v1.

But it's much more broken than that, so split the fixes out, especially
the last one for hot-unplug.

Preserving the Reviewed-by: from Jürgen on the first two seems fair;
the third patch is new and exciting but *does* fix the case of removing
the console while userspace is spamming it.

And all I really wanted to do this week was spin up a PV guest under KVM 
so I could play with its SMEP behaviour...

David Woodhouse (3):
      hvc/xen: fix event channel handling for secondary consoles
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
      hvc/xen: fix console unplug

 drivers/tty/hvc/hvc_xen.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)


