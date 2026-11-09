Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944A606A334
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rswHMVZS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNCQn3J7Tz2xfK;
	Mon, 09 Nov 2026 12:50:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794189009;
	cv=none; b=h81BCPEzspJwJfzT8ADeQB0iNSY2nGeX9xf1Y2NOxRp1MQVgEDhPTIgXo6JY045YQJC/zgqvhHBcuh2gRj62HQndgX5CN1N80nZDLUdIXe+mNT53nBt0pbv7MI2EjnCS0FLnkTMZDg/bQ3cHV0uynoy4d/ywhyC5PCP6FCodIQwGKdsEEHihK8+6y6npQ5LqYLWrXvrxE29ZeSv8IV8M2H/N94eogPFlkc8m8DwXk7o3+EDsysbEYWT7fqe5GPXAzlMc2RbQT6YqUo3V+d9HhEepyUGUj/MOscNycr99XhzS2E/I91fedSvqVNs4PpYza85LteuiLLudLspKhJopJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794189009; c=relaxed/relaxed;
	bh=V38T8aAeXJ9M+jcD3MoRT7yJtF10TXOXINWjQCRAFE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da5f/JnEfYyTPSd8h+DHoy3CBwVwshKifkSADq5fWTPkb82W8SWbk0LWk26+R4eUBaUizY576Ff/W9G1HunXPGwXwXMjCXRkumHXE9QS+cteGcts/ND3ePPI55mJzjpbGRxy8BnI2GvOOWge1Lm3ZkR6SAuh9zNJoYKr6iZrQxkswMU0BmZAk9HjFiojGl7j+xp6dCN27SmA18wa1340Zu9q9pBHv4FQyVHu+rBcls+p0+fgAqiwT6/ASOvVrcykfo8MUZktyIGk0SyXXL9Bjg1z3IcHcEM4yOJc4KB6CkPp3u1de5jrke2ZzKS49Otkkm74je+HEjtSiiW5AIfSeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rswHMVZS; dkim-atps=neutral; spf=pass (client-ip=115.124.28.3; helo=out28-3.mail.aliyun.com; envelope-from=guozh23@xiaopeng.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaopeng.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=rswHMVZS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaopeng.com (client-ip=115.124.28.3; helo=out28-3.mail.aliyun.com; envelope-from=guozh23@xiaopeng.com; receiver=lists.ozlabs.org)
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNCQk73w1z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 12:50:04 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794188999; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=V38T8aAeXJ9M+jcD3MoRT7yJtF10TXOXINWjQCRAFE8=;
	b=rswHMVZSeoF3uG3iqJSWruna1hSjO0DDR6+p/KJQoSOx5pRbMpgVzmVwUPtOIOtEReRXcDbXIAnIQKXMlK8QC7QkpbWcyUxrCKvRx/gfVtWIrbWu5Sqn63h90UvTlDq4U0Fu42tk/DSX/irdoyVMjjTZPh1D5kOtesf5DluKiYU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07461259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00469702-0.00473385-0.990569;FP=10823690688715638298|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jzgjJbI_1794188997;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jzgjJbI_1794188997 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 09:49:58 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ashley Lai <adlai@linux.vnet.ibm.com>,
	Kent Yoder <key@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: ibmvtpm: check the response size against the buffer size
Date: Mon,  9 Nov 2026 09:49:57 +0800
Message-ID: <20261109014957.2777790-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <au3w4NDX1Uqz-iqd@kernel.org>
References: <au3w4NDX1Uqz-iqd@kernel.org>
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

Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Drop the Fixes and Cc: stable tags, as suggested by Jarkko
Sakkinen: a hypervisor reporting an oversized response is not
known to violate the architecture, so this is hardening rather
than a bug fix. No code changes.

 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 6fb4d30eb6f6..bfef4bc14767 100644
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


