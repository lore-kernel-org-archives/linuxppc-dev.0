Return-Path: <linuxppc-dev+bounces-24877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4967FC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:43:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wDj608Yz2yjx;
	Mon, 27 Jul 2026 20:43:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.124.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149013;
	cv=none; b=j7wr0E/Q96eSxUSBd5GeigWmfR2PDoTctTl4SoawuXTFblStIaIUs7M/cIs3tvcYuZRQuR2cyEUYgNIFucPekX4gM33H7OyiR958JWtHQF/i/KF4XNHX0w7f9p1avt3Gkr/Bjxq3wKrLj/ct+9XBVWfArTRudGtIJBj/E0L9PdR4XKaV+PwoGtCQl5RADtVD9z7fAt73rJsbANh2DkL7Aqhf5dqx0uJYOD7DEHyPbF85eLLdLHohfkIuXixDWf7x/ej7CYIEI8vU51L/b4BUCpmcYYnsTHGQwDlpohwCJ5inYh+MZe8Ke0f9eUwYOHYp2YQkpbVibMd+09yO1cX9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149013; c=relaxed/relaxed;
	bh=ivoAljloOvAb8QMpRzM/ZymLdYHI6z1Q7H435Lx28TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bt/h2ZUM0VTNZuN+ZyydKISzXFX+gpMGRk5nfKckN2wVRJ3CKvr6A2E6enGq84hvWnE2XT8BKMiE+67i8ldNCxwmHlp/1TQxKbzTOYTlzoQeazj7T/HAwayQ5uRfcwvfWr5/oWXbsVy6d/kHBRLqIHO/LK27cb7o+7WVczwHH0e6QphTzQYNNJ88d5gxmoaxD3+OJpWjZODi/GZUgpLIlyCXzFpKZwtoPabex3b5Dp8coDP6PuzujEODZmq+owx3T60aqMAeDiGDGPtR0+XVqwa6H3m3Uv/h+rBoDUZP0oHPS/JHDp9p1J6+N2AUKo+P7dzdSOEMb5MYCa+G8spbWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=HTenXkyW; dkim-atps=neutral; spf=pass (client-ip=114.132.124.171; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=HTenXkyW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.124.171; helo=bg1.exmail.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 27022 seconds by postgrey-1.37 at boromir; Mon, 27 Jul 2026 20:43:32 AEST
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wDh19K7z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:43:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785148954;
	bh=ivoAljloOvAb8QMpRzM/ZymLdYHI6z1Q7H435Lx28TY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HTenXkyWZsGjg8j0WvVyM/oaPdyRUMtlGHuKL2gtN+o59dQVHr2C+HCRu9j6Nruk2
	 Uuqqi3e5OPMDV9kZVBpxrb86TzFPeddUmKyupbBfSVgTVwMw+l83c2dIS3KdclofFF
	 PsjYU9pTAnRsjJxy3SuWPnAzFJNyHdZ91jHoJ4VE=
X-QQ-mid: zesmtpip2t1785148939t8c74e3a2
X-QQ-Originating-IP: rzAA9TqFOLBYfdxsYDpmvcJtB7XPvL+WcxRh3OZXpgU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2473966333756403746
EX-QQ-RecipientCnt: 21
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	namcao@linutronix.de,
	peterz@infradead.org,
	sshegde@linux.ibm.com,
	kees@kernel.org,
	lgs201920130244@gmail.com,
	srikar@linux.ibm.com,
	ynorov@nvidia.com,
	nilay@linux.ibm.com,
	clg@kaod.org,
	benh@kernel.crashing.org,
	miltonm@bga.com,
	mkchauras@gmail.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v3 0/5] powerpc/xive: remove __GFP_NOFAIL and fix IPI error handling
Date: Mon, 27 Jul 2026 18:42:10 +0800
Message-Id: <20260727104215.184786-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MKbpLBOB35np3H9KmPzUfVtEnPfWPzEQylbsu715kooClnQu0ahDYP2/
	zUwiV5DOOMiSjD5xuJYnXMz7PH2cq8ENxEGODjX4qzYu8cngVaYUwUj/MwuI9YYkuZkYdkQ
	VJ0VYrNqltox8Jtn5wWQbLNHRWgavPZ8XDgAudrvXEWvHXPhxXqLlR3uK4+sdTnPelAdxnV
	wnsyRPu66UFbkSWYUAK6sroQ/m3iJomyEaiS7+1ZsKu/WpSD+OjCw8kKfb+slh8rEu9DEsd
	J26Wlz9O444RGr3Fc9/1W/m85Xain4lyz5KVoTHTQY9fCQcnBi+0XuP5C57XWsbUDiu9zWU
	hElNYjFjdBR2lVM0YXVnvOo+FxebbkLORPkuOvtfkA7wFQMlbpRfzWh4+tyA2Nd1ReuddnR
	PAVo4rjqjDCj6yvbk8CE5qhsn2jTUUY4EVaOXtKD2u8BW1/3h1Lv5ECz529HKjVLluLS5xn
	+GNAeNbObzpZllYYfgpoXuT8sXozYi0M4KpUxy9VpHsrX/VQXhSiMNLz3lkON1lQVLWnRaZ
	1nYtiCL0/VVgkyh6srNCPw5Zh0AKXzzfqQXXcfmDlM8z+Te3SbAq8B8RJzFyHNd5gRBv7Nx
	uHenstbM5fzRrGFXVFkXpzgl6jPqnR7tpkdeRTD3D9fBgHi1zXBd8jSUdOyeJ2Ww35I/IzR
	RG/5YS6MmvrmTGhemEZcuQoGFkQjEej8YsXOXR5hA9TbbNks7ixTis2Yd+CLJcH7IQeLWFs
	h2r6OYbyXq1DRaGcEPX/7j7LTLGyV5BUqyJq9mVx6Hq5/9gNL1umXdET60LQzDqc4jlpSUO
	Qo+uuuT0lWUzIzhoefiHxIx2ErSJYoTQTMxtUvozAsFxNov/96eUEoID+cDnnKurhdbzYsY
	j5OnW9LNOj/7CQZbYPRqHt4Rfhu0J88GiIJvQgoRs0VDMgwiGqD1SMVjUt6653bCOH1+0f0
	1UWiNYnK2wTAvXxpwpwqiTkxg7b8OPbkbAf2mYLTJrUc94SWN+dX9hogMlwPgtKhsXaPhfs
	oBtvSz12nwVfKbjt4k+v/qsqm88OLT3RjsGmgrfjmBImPMgZ7hdvBeATncMGQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Changes in v3:
- Split into a separate xive-only series; the drm, test_hmm
  and cxgb4 patches are unchanged since v1 and will no longer be updated here.
- Rework the first patch: instead of simply removing the unreachable
  NULL check, remove __GFP_NOFAIL from the IPI allocation and make
  all xive_ipis access paths NULL-safe (suggested by Andrew Morton [1]
  and Cédric Le Goater).
- Add a patch to defer setting cause_ipi until IPI init succeeds,
  so that smp_muxed_ipi_message_pass() does not call into a
  half-initialized IPI path.
- Add a defensive NULL guard for cause_ipi in
  smp_muxed_ipi_message_pass() as a safety net.

[1] https://lore.kernel.org/all/20260725202632.dcb325658896a470df91cf57@linux-foundation.org/

Changes in v2:
- Remove the now-unused out_free_domain error label in the xive
  patch after deleting the unreachable NULL check goto.
- Fix a use-after-free of xive_ipis: when xive_init_ipis() fails,
  the error path frees xive_ipis but xive_smp_probe() ignores the
  error and proceeds to dereference it in xive_setup_cpu_ipi().
  Propagate the error return through xive_smp_probe() and check
  it in both pnv_smp_probe() and pSeries_smp_probe().

This is a code cleanup series that removes unreachable
NULL checks (and associated error handling) that follow allocations
using __GFP_NOFAIL, which guarantees non-NULL return.

v2: https://lore.kernel.org/all/20260724022851.466017-1-gouhao@uniontech.com/
v1: https://lore.kernel.org/all/20260723081813.176792-1-gouhao@uniontech.com/

Gou Hao (5):
  powerpc/xive: make xive IPI allocation NULL-safe
  powerpc/xive: add error return value to xive_smp_probe()
  powerpc/xive: propagate IPI init errors to prevent use-after-free
  powerpc/xive: defer setting cause_ipi until IPI init succeeds
  powerpc/smp: add NULL guard for cause_ipi in
    smp_muxed_ipi_message_pass

 arch/powerpc/include/asm/xive.h      |  4 ++--
 arch/powerpc/kernel/smp.c            |  3 +++
 arch/powerpc/platforms/powernv/smp.c |  8 +++++---
 arch/powerpc/platforms/pseries/smp.c |  8 +++++---
 arch/powerpc/sysdev/xive/common.c    | 28 ++++++++++++++++----------
 5 files changed, 37 insertions(+), 14 deletions(-)

-- 
2.20.1

