Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EB606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpKN4xwd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV4R31Lb2z2xSl;
	Thu, 19 Nov 2026 01:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795010265;
	cv=pass; b=SHimWN9/3ZWZo782SZYStXP6Azn5yXGv8NyEARS/gCWD8FfeVQOniVRpp0sMMK2x3UmW4EkxcuoRzrYW8ARdruQNSLrdKTZ7HM0I28OKU+C9Fqin9KxN68B5zd+x6ux1LOnhYkDv0k5P5kUK7HHbtxwJqcAoWPIB5yk2GHO4G0e9aEq8tjkYgOqWa6wx9IBDKKYS9qCrOJNLG5Lt1eCu1Dsmo35UKznwxuSh4cWYBMHcTgS/VNkuedffFws61cQMyr8RVsbu9ogEVnu1+OyQuPsb+8jOXVjYEzYwciAM2SJa35YFfJZdoLUZxkxPhRsQs7NaH25oTaCMukFuN1HAZw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795010265; c=relaxed/relaxed;
	bh=9k6xkSgoU4/ycdA73IPAUpz2zxduvWOoGVm9HO78QCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RP4dRP96+C4/Z+TmCV9Hyx4s1TTU+4ZaWHLP9MSFW5gPN6WfXzpJfzXzbBqpR2nEBxVssGpgFf4KipDrZBnFkkxazG7RXizAcKRXgYh2iT9ATA6soVwSNifqfoFjos4Xn2em+rEfLVVZGDvmKCBsHsztAsiU04RmDLe6ZadsFXdPpZR6XHb2hTOqAk3wvQN+Q0vy9VUW4zbYNC3c1v8bGHD1+eW6eRIak3aYTAAK+IQaZrs+J0y2Wnrp5OBHQKV5BNXfNv9F4lJv2jRT78Op5kNp28BbYm77qXPT8bggxUkEWRUjKrMAryPy8gMu6tJ+MWDO7AJqcTayQ5WAV3hXEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpKN4xwd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+shyckless.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpKN4xwd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+shyckless.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV3883JDPz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 00:57:44 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 86E5543724;
	Wed, 18 Nov 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795010262;
	b=wC3Eumy5vUzYEP/VaAEcCYXT3+aXje/fyymTBdOWstG3ZU8qqZODVcmYwQ7mr+5Rtd//
	 Yhqmx6qe0tt3n+4UyS0ugI3z8vlOmZC0xjLmmUxhBjkiPo5DVrazBejVhyfk25pP6PvPh
	 m0qJTUVId0QbnlMTi/bKGN9KaZjJWfnKRGgWfPcUZFhCvaBgqd5db6VNP1vRehPINVKmj
	 n/LOAuJ6TxqCSAGUoElsVGyiQxOlYA+rBVFgh2agAwD5iXpTEHxGPmzSM53QP5oIsNF2o
	 91actz0Rd8OEYvr8TPjlrXgciq4G72LAS163PszzW+SwuTjtdtMEb7wCuZIFIGWapTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010262;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9k6xkSgoU4/ycdA73IPAUpz2zxduvWOoGVm9HO78QCk=;
	b=NfAUb8JHhzha+q4ZbEzKmEFIKEcIwC62iPAS/ca6o1cxQwf9TXulJmNbHDQ/9YgFCekm
	 BvwjykVJmS64rl6qBFV6LjIz2kcsDyzmNGGU/626J+OtfUNSiPl6pQbza+VurK1KtJj4v
	 ekbecQU0i8VSX4kb3SDRCKnKxYpoWpbvxzAqSjsPuY3CiKahDwjs2Gq9RFMqbToRnPxeu
	 S6fG3hkqssLEx0kWOgRUK+LerHeTTHF3a6Qi5YuKYClXBb8+TU1QOBjib+gpsfJTG28r8
	 NKBMJWotSqTDUXrt53DbYvE0QZLy3cvTF08M/w9hBx8AGYyjQOqpNVgNh4QSTvZsaCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED4121F000C5;
	Wed, 18 Nov 2026 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010262;
	bh=9k6xkSgoU4/ycdA73IPAUpz2zxduvWOoGVm9HO78QCk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FpKN4xwdcjqxMJpZCwWr5aPFqtlgYWe8ZwIpl8mL7/d6S1cJWgxdzw0jTsiNEvYnc
	 Ix5HJV7le25bBF1NAoP7yOqaJdQ/R9psBslIyZ0HUQDJbREnQ8fL/vpdkPmhqcoJKH
	 Hnmnpt3D1nyRet7AdjbRZrEfxHaO+daYTDEcq91nOKCAhOX91FOLcsJZGk+EHaZY0d
	 lFUMNPowM/XeaxW6lELexH0ek3RRuQXHI/asThfxrweuodNGzWKUe3XKirO2Z05pIo
	 84dQa1VkDdGT658EqVWUq3gs/Ot9CeaAgiCCkcPUFw2Iyoyd7XjW+8CMyhqgHQ/txt
	 lBbW08DGUikww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B4D44ADC0;
	Wed, 18 Nov 2026 13:57:41 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 13:57:41 +0000
Subject: [PATCH] scsi: ibmvfc: Unmap scatterlists before completing BSG
 jobs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-ibmvfc-v1-1-3115f5901130@gmail.com>
X-B4-Tracking: v=1; b=H4sIANSu/WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0ML3cyk3LK0ZF1TU9OkRItk4+Sk5DQloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0Ax0wl/2oAAAA=
X-Change-ID: 20261118-ibmvfc-555ba8c3cbcf
To: tyreld@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795010260; l=2020;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=N0Tx4tKvk+IGw2iXqqTkUq8ZEOCSQRNuciGKIswz/Gg=;
 b=gfulJ5sTCNkCHuEG89KYs141VHVOJihg1jGg25SYidOMf4HKeizUjAnBk4ijAwqXuQBi+EnWy
 EG8irAzLWPhAgwj5bHaoFp5FuwKcgOpmAAtUB5Qtne6wavXO8KaJRNI
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suyuan Wang <stevewong@hust.edu.cn>

ibmvfc_bsg_request() calls bsg_job_done() before unmapping the request
and reply scatterlists.

bsg_job_done() starts block request completion, which can run
bsg_teardown_job() and free both scatterlists before the following
dma_unmap_sg() calls. The unmaps can then read freed memory.

Complete the job after the common DMA cleanup instead. The completion
path has already saved the operation result in bsg_reply and set rc to
zero; paths that return an error keep their existing cleanup and leave
completion to the FC transport. passthru_mutex stays held until after
the completion call.

Found with a static analysis tool and checked by hand.

Fixes: d31429e1517c ("[SCSI] ibmvfc: Add FC Passthru support")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested on powerpc with clang (W=1, no new warnings). I don't
have IBM Power virtual FC hardware.
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index aa7ae81df41b..6dce72cb80b5 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -2392,14 +2392,15 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 	ibmvfc_free_event(evt);
 	spin_unlock_irqrestore(&vhost->host->host_lock, flags);
 	bsg_reply->result = rc;
-	bsg_job_done(job, bsg_reply->result,
-		       bsg_reply->reply_payload_rcv_len);
 	rc = 0;
 out:
 	dma_unmap_sg(vhost->dev, job->request_payload.sg_list,
 		     job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	dma_unmap_sg(vhost->dev, job->reply_payload.sg_list,
 		     job->reply_payload.sg_cnt, DMA_FROM_DEVICE);
+	if (!rc)
+		bsg_job_done(job, bsg_reply->result,
+			     bsg_reply->reply_payload_rcv_len);
 	mutex_unlock(&vhost->passthru_mutex);
 	LEAVE;
 	return rc;





