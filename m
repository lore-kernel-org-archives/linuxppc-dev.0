Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D78EC6FD19
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Mar 2023 23:31:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PYMlD3xNpz2x9L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Mar 2023 10:31:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ICn+4H1G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=mcgrof@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ICn+4H1G;
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PYMh96LhCz30NN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2023 10:29:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vxh+5loJXr3QOkEBXraKRrSEsoLxyjcuI0B+WEdhvrc=; b=ICn+4H1Gid6ISIQtmA0dRRbsb8
	TA5WsB7AvOCX+EZG9pAFvNij/xCRcRVffQ8DW1eKISqZhVdSweKez4Ce4x6bNBbtzrxAb3g/QEuQY
	Tgr2QdR77Rqua6uRpaqyFTZqzSdIsVTrMeEb8BmWcxEHuLzpriCVgZUTuzips3XFyZibgMPeH/JJG
	7AHXtJJ84yqwS7cGnh2ZAZre7hmo0fkKTYShqUS1WzB3bJkjmaooFmGGSreXLsWcb5IK6592fhuCN
	NLUCBWdbzyfO99+sFR9jKYhNMMC+dlHEnIFt5rF3WEDeMKkGshOoxh1DZjxsHRCEEpSrV6uM7y73S
	ls83Dbxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pamAN-00GcM6-0Y; Fri, 10 Mar 2023 23:28:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu
Subject: [PATCH 0/2] ppc: simplify sysctl registration
Date: Fri, 10 Mar 2023 15:28:48 -0800
Message-Id: <20230310232850.3960676-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
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
Cc: j.granados@samsung.com, keescook@chromium.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, yzaikin@google.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can simplify the way we do sysctl registration both by
reducing the number of lines and also avoiding calllers which
could do recursion. The docs are being updated to help reflect
this better [0].

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

Luis Chamberlain (2):
  ppc: simplify one-level sysctl registration for
    powersave_nap_ctl_table
  ppc: simplify one-level sysctl registration for
    nmi_wd_lpm_factor_ctl_table

 arch/powerpc/kernel/idle.c                | 10 +---------
 arch/powerpc/platforms/pseries/mobility.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

-- 
2.39.1

