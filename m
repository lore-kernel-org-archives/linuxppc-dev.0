Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311AEC63797
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Jan 2023 09:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nx32G58ngz3fH6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Jan 2023 20:07:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Missing IP4: 74.116.198.153) smtp.mailfrom=zte.com.cn (client-ip=183.62.165.209; helo=mxct.zte.com.cn; envelope-from=ye.xingchen@zte.com.cn; receiver=<UNKNOWN>)
X-Greylist: delayed 3925 seconds by postgrey-1.36 at boromir; Tue, 17 Jan 2023 20:06:46 AEDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nx31275Rrz3c9Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2023 20:06:44 +1100 (AEDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Nx30q2PFbz501St;
	Tue, 17 Jan 2023 17:06:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 30H96Rre076903;
	Tue, 17 Jan 2023 17:06:27 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Tue, 17 Jan 2023 17:06:30 +0800 (CST)
Date: Tue, 17 Jan 2023 17:06:30 +0800 (CST)
X-Zmail-TransId: 2af963c66516fffffffffd6dec0a
X-Mailer: Zmail v1.0
Message-ID: <202301171706300144532@zte.com.cn>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <arnd@arndb.de>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VycGMvY2VsbC9heG9uX21zaTogVXNlIGRtYV96YWxsb2NfY29oZXJlbnQoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30H96Rre076903
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C6651B.003/4Nx30q2PFbz501St
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: ye xingchen <ye.xingchen@zte.com.cn>

Instead of using dma_alloc_coherent() and memset() directly use
dma_zalloc_coherent().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/powerpc/platforms/cell/axon_msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 0c11aad896c7..8a4c522c8e67 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -358,8 +358,8 @@ static int axon_msi_probe(struct platform_device *device)
 		goto out_free_msic;
 	}

-	msic->fifo_virt = dma_alloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
-					     &msic->fifo_phys, GFP_KERNEL);
+	msic->fifo_virt = dma_zalloc_coherent(&device->dev, MSIC_FIFO_SIZE_BYTES,
+					      &msic->fifo_phys, GFP_KERNEL);
 	if (!msic->fifo_virt) {
 		printk(KERN_ERR "axon_msi: couldn't allocate fifo for %pOF\n",
 		       dn);
@@ -372,7 +372,6 @@ static int axon_msi_probe(struct platform_device *device)
 		       dn);
 		goto out_free_fifo;
 	}
-	memset(msic->fifo_virt, 0xff, MSIC_FIFO_SIZE_BYTES);

 	/* We rely on being able to stash a virq in a u16, so limit irqs to < 65536 */
 	msic->irq_domain = irq_domain_add_nomap(dn, 65536, &msic_host_ops, msic);
-- 
2.25.1
