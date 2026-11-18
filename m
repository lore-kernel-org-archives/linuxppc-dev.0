Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE4606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=VXQmyBa5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV4TJ5wWcz2xdX;
	Thu, 19 Nov 2026 01:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795011574;
	cv=none; b=C8c/rpBcrc1ngoGGCSOWBJi6tVbIzbS7H0x8g9iD6d0e0deYMOL/D+j24iKYHH6+BWTL3D6XTYUthO8gbV1kRedIcycaddnluHX2h4n3IVvMhFcxfyqO37v9swqGvW5IuJK0cgMW1FwkUD/9alAo2W7d6L3pK2aMaURH67FsUHvMcjyywXBnf428aJrZJEf1N1W4bAK5L5jfEmdDd0P1DBlRNRjDxncQS55p/wq+ocBkvkkQI1wUCptqBhqqkpaHnI8RD34a+4vAA6tjIxqTBsRf0WAvfJIy6bcret2xFpDLTeWVoRqJ709og5QHudNlPx6+uTDzaEmGzBrO3V6lBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795011574; c=relaxed/relaxed;
	bh=B1Nddc/qGpNwrjS9IUI4dl8xbOE1/6p/3UcD8cYz1MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nwx56IhAoOUxBxCmUkQtCIRwWOp9bqlp+csyO/PmhDxlPVFVBDNwEkGY+MNhixjS/nWMNfcx1/M5OKVy07RBZAkFjphxW0UP7DDcN4pZiMbO5nFmOtavfhc1xZwuHb+tg4/nuckeO1ZOnXpLJbFpZw1oc9KAxfeE/Lx471Dk+Ka2g0K8k+yHU7C8Yl/dmSP+8LNnPTglp5pTgNBS1ODdvKe81Edw9Md4njc3WnwvzVqU72HwFJL4sRuFmim160HugbCHX65ovak6szgcS806LcX1uhaYmruhfmHerN+Ltgmiut0d/VUuLP9my5fcTRYYwlRYUsAsYlz+Sm5NeMd67g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=VXQmyBa5; dkim-atps=neutral; spf=pass (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=VXQmyBa5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 311 seconds by postgrey-1.37 at boromir; Thu, 19 Nov 2026 01:19:32 AEDT
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV3dJ1Fh1z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 01:19:31 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d7856;
	Wed, 18 Nov 2026 22:13:48 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] usb: gadget: nokia: Fix potential use-after-free on bind failure
Date: Wed, 18 Nov 2026 22:13:47 +0800
Message-ID: <20261118-324f82bd41-usb-gadget-2@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1ef01b41203a1kunmc2b9e01c1a0cb1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0oYVksYSU9KSkJNSUJOQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=VXQmyBa5PnagJhd92DXUJT2yMP5JiCZxAG0wXuLb9BY2msdXMRjQdntpALcmXvWjHP/ctIjWN65JNS5gJFKMNRvERkq2GvbnUg63PYaig/UWQPLhCaKAPJ5yFe7afQGE4cszfabGF6ZpGmD+igV1qWUchWieQcsI9pkJEM1/gZ4=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=B1Nddc/qGpNwrjS9IUI4dl8xbOE1/6p/3UcD8cYz1MQ=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the second configuration fails to bind, nokia_bind() frees the
functions in the first configuration while they remain on its function
list. Composite cleanup then accesses the freed functions.

Remove those functions before putting them, and also put the mass-storage
function acquired for the first configuration.

This issue was found by our static analysis tool under development.

Fixes: 15761826eecd ("usb: gadget: nokia: use function framework for ACM")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/usb/gadget/legacy/nokia.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/legacy/nokia.c
index 396605a84cd1..87d496e9b2eb 100644
--- a/drivers/usb/gadget/legacy/nokia.c
+++ b/drivers/usb/gadget/legacy/nokia.c
@@ -267,6 +267,7 @@ static int nokia_bind_config(struct usb_configuration *c)
 static int nokia_bind(struct usb_composite_dev *cdev)
 {
 	struct usb_gadget	*gadget = cdev->gadget;
+	struct usb_function	*f, *tmp;
 	struct fsg_opts		*fsg_opts;
 	struct fsg_config	fsg_config;
 	int			status;
@@ -357,6 +358,9 @@ static int nokia_bind(struct usb_composite_dev *cdev)
 	return 0;
 
 err_put_cfg1:
+	list_for_each_entry_safe(f, tmp, &nokia_config_500ma_driver.functions, list)
+		usb_remove_function(&nokia_config_500ma_driver, f);
+	usb_put_function(f_msg_cfg1);
 	usb_put_function(f_acm_cfg1);
 	if (!IS_ERR_OR_NULL(f_obex1_cfg1))
 		usb_put_function(f_obex1_cfg1);
-- 
2.43.0


