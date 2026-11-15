Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A41606A887
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=WTzVxPjO
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS9Rj1cwVz2xKv;
	Sun, 15 Nov 2026 23:34:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794746081;
	cv=none; b=l6GRA41kMAGthjXq0OE+VLSqpvo5R5P1SAu4wdpT+razAJwjS/z8AbsBhVrKv6unuN6yv5m3J7xToVbpckz45TdAw334Ozu4AFXwkf+aTIz+5NJh9nEFM9X7BCdzY7jz8BzumvH5k0GjM6A/3Wg5xkNYGGwq8VvHldalW3hQc6GP7Z32thA9iSb7UzPtkIBWTkP4/t0fJWXa5mXj5t2EQu3RaXBRNjoaIv6EMoN0iq6Hx8nDB5HC/RuQLGZt+mudF+bLDreVRxfsdEGRSKh/TjpLIGZOYTZQRPGv+6V8PNudmnjLwHcY4knAOfjWvNhATWNDVfsXcUYuaMO4fqvulA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794746081; c=relaxed/relaxed;
	bh=Q4/6Xcl3pbihX/qIA1idwhc1KCNY/vwDyWaXFbCkrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dgo1aufpw8AuqZlHvM0bNP1+mU+jHEPn09fBwlbnXYemPMWBviVolzWPVMCf4EAwO9DGasMXt5MS54njzQpIJUnesukl8VAlvSf0cqzzM3L4A9YefI5B4UEO5oCFJYHNo8VZMBRJsrlp2Ncockr8kHHCGDaKv18J5IAEJTLJB/k1VOUeZRMwXt8X8/XYgH28X5mByM5742QL/7BoTIIhE7Pm44GNQdujr3kpGbJbEDmSZjQuiXb2hhkF9IlBmV1FVE+pYEQe76wxVmP/F27ojFzkfPhMP2OIFhm7VGJSSuvjZdMKYtsGHU4D/OvgSU61mE1TuZkQN3hPF7GcC7tE0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=WTzVxPjO; dkim-atps=neutral; spf=pass (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=WTzVxPjO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=getshell@seu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 2759 seconds by postgrey-1.37 at boromir; Sun, 15 Nov 2026 23:34:31 AEDT
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS9RW3Tsdz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 23:34:27 +1100 (AEDT)
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04e1;
	Sun, 15 Nov 2026 19:47:55 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2] misc: ocxl: cancel XSL fault work before freeing SPA
Date: Sun, 15 Nov 2026 19:47:53 +0800
Message-ID: <179474327320.103840.10310873812308403660@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-HM-Tid: 0aa1df0910fb03a1kunmbac61c98bf790
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkkYVh0aHh0YTR5IQh4YH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=WTzVxPjOukEntrKyGnNEP5kw+C4eOilmbsX9cYjzRUgcSDLriAxcTpo54l4uCdAbclkX5nLsW4+jhrFF4yI9dd+Ox0rAhserv1jFZsSmSt0kLrmAL7KrVfuVS0TA136t1ZsaeiV+ewlbKro9D8DB7hEFuBDiHIiw+GT1SnE+RQ0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Q4/6Xcl3pbihX/qIA1idwhc1KCNY/vwDyWaXFbCkrtY=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The XSL fault interrupt takes an mm reference and queues fault_work
embedded in the SPA. free_irq() stops new interrupt handlers but does
not drain an already queued worker, allowing free_spa() to release its
container first.

Cancel the work after freeing the interrupt. When cancellation removes a
pending instance, also drop the mm reference that the worker would have
released.

Changes in v2: cancel the work after free_irq() and drop the mm
reference when a pending instance was removed, and refresh the comment
that explains the ordering.

Found by the author's in-house static analysis tool.

Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260928134110.227-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/misc/ocxl/link.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 7749dcd..a0220af 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -252,7 +252,11 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 			spa->xsl_fault.dsisr = dsisr;
 			spa->xsl_fault.pe_data = *pe_data;
 			schedule = true;
-			/* mm_users count released by bottom half */
+			/*
+			 * The bottom half drops the mm_users reference, or
+			 * release_xsl_irq() does when the work is still pending
+			 * and gets canceled during teardown.
+			 */
 	}
 	rcu_read_unlock();
 	if (schedule)
@@ -335,6 +339,8 @@ static void release_xsl_irq(struct ocxl_link *link)
 
 	if (spa->virq) {
 		free_irq(spa->virq, link);
+		if (cancel_work_sync(&spa->xsl_fault.fault_work))
+			mmput(spa->xsl_fault.pe_data.mm);
 		irq_dispose_mapping(spa->virq);
 	}
 	kfree(spa->irq_name);
-- 
2.50.1.windows.1

