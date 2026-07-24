Return-Path: <linuxppc-dev+bounces-24762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4961C531CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 02:30:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5sRK3L6Zz2ygp;
	Fri, 24 Jul 2026 12:30:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784860237;
	cv=none; b=fFlWDGcRM1puMwNDK9FInrrhX4mJj4/UmVyXDY4MVYI2SPlC2/viLYMYNHZxsQwvfxT6AyiJL7GPkCdtJH/4p+h9NC4kbdJneMe4dqElOg43OpKfKITtini6D6xIRh69uWDGBzV94LMmh67CvBmlEii1/75Vr3D/lizMYJDLz0UOJIMzp7czAULUoXLyNPfMmGbgNXY7oo17bakzn52rKrR7u7wkeMT1uUOk6l3PXOWjz+2aSy0WunqgTp0xLGcN2EU7sAEP9lRjYRvvjiD2u+E4LTqmifrrkMQRpqVas8p1hdTVGg8IwyyShqIXGiMq+mxec7lYmxOKt9Nn1G1o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784860237; c=relaxed/relaxed;
	bh=Yn0Gyoe5DqjP71R2buJi41mG3iZ0k1ZX3eDGImr8Sq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=emtuVwTHyjWlHxMAsWzQuOANk7nVd3CRTlumvyEuFNKiGrJFHSzUlT7cj5hhNvVrVqebKqmexHKYdcugKwWsHwSZtgAXOM6ivOg0Vf6OKcUX36pSZ78bzP5dpNDYZgDCNVzVrd1MOjTIRR5v4K86kDMHtHw+5cBzkbLnX5qQY6gTBPJgh1z6OJw31oorphNlZ89Hz0Pd9YkCW+hj9+TxRUY9Hx206QRM5p7YpD3BxcWW5lulQL2Uic4KKzfp3rHCiP5yXX8iO1CdSSqk3/EGZVWZ5ytiarHDxICcV37QW5B9wa0lXIeUw+wDhchX56ggDhsd9M1b2QB5EYQI6OpDmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=JfRBL6vG; dkim-atps=neutral; spf=pass (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=JfRBL6vG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.243.244.52; helo=smtpbguseast3.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5sRH6rqNz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 12:30:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784860173;
	bh=Yn0Gyoe5DqjP71R2buJi41mG3iZ0k1ZX3eDGImr8Sq0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JfRBL6vGX+km3YMzXlEy7HJjnZqr5bN52rjPOVAQnKRIbluO+xg2UR2JNwgYqwD0z
	 SXyUg4OftBJTjKaq6Dj2Mo8/uGJrhggOebDVx6pkjdosAv8MRFez9vbIMWQeQE8m6Q
	 WIIski7wchHE/k3u849ZwaM0Ku3cvTGxYk+Yhn7A=
X-QQ-mid: zesmtpip4t1784860167t2acc5bb8
X-QQ-Originating-IP: qIXv24m5LF8xLoOUC1kXo/DM9tGPxEiRVtvDS4LSMeI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 24 Jul 2026 10:29:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 530311859156334886
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	gouhao@uniontech.com,
	namcao@linutronix.de,
	ynorov@nvidia.com,
	sshegde@linux.ibm.com,
	nilay@linux.ibm.com,
	clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v2 6/6] RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations
Date: Fri, 24 Jul 2026 10:28:51 +0800
Message-Id: <20260724022851.466017-7-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MNU5/P5d/Qy9RNPRk664Q0Xw109pxpzpMGKL379ZUzcshP83H9MiEsd1
	IyV+Onok3MeRQ1T+ngmr1xzbcU1xx+vFpwEVY+wuxNIJ201zV+NLvRFmflO7umpKgp1BOqJ
	z96wlYlqfUeBqPpOrRu4Laygf+MwqB4o3eF9GDKsAqt1h1VQsiKHgtTL078FspqslJclih/
	LSAdIRnaQcF3IsZ1FJYVJGUgcyRdHm3VLF50Ti6RUr0HwtqBlNFPHlKZMXhexrgtrw+Cphc
	JxY4JP/I25QaZKybpvkHDPy08pNjAmBdVxjk0nf/6T5JalR1ahtqR1+/MMoONxBhdS2CsHv
	xV2HJAgpiNZDWaaU5uNCEb8xAmJQqQRbeOo4oMDIYKkBIknl1Y2SKe2EtrMIhYHgYrLnR1p
	gpvduyt1R9gOS9tB9ky8rDkPS8a93XY/5/nFLCw526fv+nxxOpLAPFA2QeC33sEk5hEOIoj
	jxlWS3gKZXLrPbp7sz3IgyUWYT0KgMJmS2eU/TrQmKHZqCf+A6FEOh7ojp1+ZCsflDc0So3
	hDt8vEmZCr4JboY7d0ioM7Ik1oPszFjKauAqy9I/eMTzw4T6SC74qx+BWS6DHBgdpmK4EgZ
	+oSX/7H/vhqwP6G+ZcKjg9apZetYQghWsY00AzS6acYNqzs6N+6O1s28hNCPtwTflFQ29Hc
	j4Wm8jlXEFJwQ8dF/uge/PUGtom7egTNBopX5QYvI6AqFuNpql4a4YCGllUNzkHD+EB6hTY
	1sXdeMhMu5RMuOmHNYdgvRq90t2lH+BpCB45/yhvHe8d+b4mo8a61E5Tmr3FyYtwYzQ2C1k
	g50UjxEbNb63M5p5MDZjalDvYBmhXZVavsT52GOJIoelTYVS57GN9n+2LsZuRhmYg3901xe
	TZUqUqMPxqlw9dxzw1uzo5NR/JK0hfLbc5BRBqhys6pO/TYlWDrDUomU5GAa6KikVlW1Emx
	7zRhVMRn6Gw+Kpk4/7xPqX4HtdKoLinAtIJM709TwoMwB1MvH1A2AobZFepeMpyuEHBmEsD
	YCa4gwXfwzozIlgRG18qaCcxyGCN5lPeUDTUEgeScH5/oFd5PlvpxkI5HE4sGUDT4K5RUPf
	PQAKWbWwxwx2FrvruhkVRaqZqEn1ylT8XAY5Ly8DqJqJwep8AItIZU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

alloc_skb() with the __GFP_NOFAIL flag will never return NULL,
so the subsequent NULL checks and error handling are unreachable
dead code. Remove them.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 drivers/infiniband/hw/cxgb4/mem.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index cd1b010141984..08631de17c0a3 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -74,11 +74,8 @@ static int _c4iw_write_mem_dma_aligned(struct c4iw_rdev *rdev, u32 addr,
 		c4iw_init_wr_wait(wr_waitp);
 	wr_len = roundup(sizeof(*req) + sizeof(*sgl), 16);
 
-	if (!skb) {
+	if (!skb)
 		skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
-		if (!skb)
-			return -ENOMEM;
-	}
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 	req = __skb_put_zero(skb, wr_len);
@@ -134,11 +131,8 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
 					 roundup(copy_len, T4_ULPTX_MIN_IO),
 				 16);
 
-		if (!skb) {
+		if (!skb)
 			skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
-			if (!skb)
-				return -ENOMEM;
-		}
 		set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
 
 		req = __skb_put_zero(skb, wr_len);
-- 
2.20.1


