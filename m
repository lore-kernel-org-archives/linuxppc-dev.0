Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30B606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a5d6+J37
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLSLx6rGXz2xHG;
	Fri, 06 Nov 2026 16:25:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793929802;
	cv=none; b=Ll2Ear9V+lxvxibAEPcoywMzXAGICuLMDZLsMMcqaOMadSQKjnLsjEO4HcSGhcCRyTLVH9IPDrNPMuplk9dDPe83d6na9PgCyypv0unDecXXPIOZhfc+l+yATpgN82j0tt+trLaJp9hlfLaDgXD1ZQwzk5y6qrhlZ629/CpwAerqi6Uqmjy66alLqRGAGn9wzFdLesIem6/x1Lq0ZaiUGw41T/IHJzjHd53EN4w1XLmcvgEq2h4MEXSrK0KOnolmoh2ixirbfFEzhGfBl5lv3+i5SwJb6yUA0tctWF7wljASZ/2577htaedw0tA/+hhJnzwHMCbs0x7PaGu/+3IhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793929802; c=relaxed/relaxed;
	bh=FDEdvRW2qMYa9xxlAN0aPEzctXRxc4Lt0+J1Enj5sqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMnEHKX/0rQyk7MbbS2mM8GuapFGnjDa6hiiIZFNMn7UiVEp7IhQXdcPjEdZw3X6fHM8ySX+yXugcGHFF65uQrxI53vB7+ZXXwkOiZXWj22kf65Gmi2JuKIj1urSS4eo5IU2sPrV/fae3ZpwLbSCxWhSO6Nxie6clRQMWXwmvNvJzoBepszqtDqO9AwqFPjhAAKQQO7cIc7Rcov2YJdp7EUzmkXUdGs8Td0EklS4+/I6a01J9jAdqMYUhrZ6a0zcxREJm8ROOSusX825JzSXwOcQsHxBdcRCnlhURxf2zfcjgTJYDPeack+tXzFMl2bZ0fi/BRVa8+/NbiyCS4P3EQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a5d6+J37; dkim-atps=neutral; spf=pass (client-ip=115.124.28.49; helo=out28-49.mail.aliyun.com; envelope-from=guozh23@xiaopeng.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaopeng.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=a5d6+J37;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaopeng.com (client-ip=115.124.28.49; helo=out28-49.mail.aliyun.com; envelope-from=guozh23@xiaopeng.com; receiver=lists.ozlabs.org)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLMYz28jXz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 12:49:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929789; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FDEdvRW2qMYa9xxlAN0aPEzctXRxc4Lt0+J1Enj5sqc=;
	b=a5d6+J37WFd47eQ5x2Z9YzkUtunrk4ZM7RCqcl0nr7l97GwJB1mQjH1apHUAGhA3KcyXJN9uCQ/Hd/PNgNpErSRQ+V8znW2IHUGKN5+oqpFrjOieJKSeuOJmpgXg0OwwUlDFuY+QQfnOxAPWAN+D1ZvTXhqvxw6VMHAtZ2qNv/Q=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07680749|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00595435-0.00433875-0.989707;FP=13129445745589044890|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065030;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jxsQSWC_1793929786;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxsQSWC_1793929786 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:47 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tpm: ibmvtpm: check the response size against the buffer size
Date: Fri,  6 Nov 2026 09:49:46 +0800
Message-ID: <20261106014946.4128696-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The send path validates the transfer size against the size of the
RTCE buffer:

	if (count > ibmvtpm->rtce_size) {
		dev_err(ibmvtpm->dev,
			"Invalid size in send: count=%zd, rtce_size=%d\n",
			count, ibmvtpm->rtce_size);
		return -EIO;
	}

The receive path has no such check: the response length is whatever
the hypervisor reported in the completion CRQ, and it is only
compared against the size the caller asked for before being used to
copy and clear the RTCE buffer:

	len = ibmvtpm->res_len;

	if (count < len) {
		...
		return -EIO;
	}

	spin_lock(&ibmvtpm->rtce_lock);
	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
	memset(ibmvtpm->rtce_buf, 0, len);

A response length larger than the RTCE buffer makes the memcpy read
past the buffer and the memset clear past it.

Reject a response that does not fit in the RTCE buffer, mirroring
the check the send path already performs.

Fixes: 132f76294744 ("drivers/char/tpm: Add new device driver to support IBM vTPM")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb..bfef4bc14 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -121,6 +121,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
+	if (len > ibmvtpm->rtce_size) {
+		dev_err(ibmvtpm->dev,
+			"Invalid size in recv: res_len=%d, rtce_size=%d\n",
+			len, ibmvtpm->rtce_size);
+		return -EIO;
+	}
+
 	spin_lock(&ibmvtpm->rtce_lock);
 	memcpy((void *)buf, (void *)ibmvtpm->rtce_buf, len);
 	memset(ibmvtpm->rtce_buf, 0, len);
-- 
2.50.1


