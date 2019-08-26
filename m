Return-Path: <SRS0=H2FS=WW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A21C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 15:06:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B8720874
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCskg3zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B8720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HFgz00r8zDqMC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 01:06:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HFbH3HhszDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 01:02:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rCskg3zW"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46HFbF0XfDz8swq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 01:02:01 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46HFbD3znPz9sN4; Tue, 27 Aug 2019 01:02:00 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rCskg3zW"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46HFbC6bbgz9sMr;
 Tue, 27 Aug 2019 01:01:58 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 845CD23407;
 Mon, 26 Aug 2019 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566831716;
 bh=I6e2z6xG6NNp+2Wpt9kGj+eQ5xIpFiafpE0oAydyqz4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rCskg3zWYS8sUfIN6SpZQxIOcvVswWxnixVypxSGkkK4sWFtFSIsWK8y001UJ3VVq
 YwDsf8c4gc4K/d7W/i03gofw7+kYrrB1Yv+9KAveARF2SiykU7hsc4ZC9ryTJQzK8K
 kzHLkzUW39HoCAGUes5rLeWxtjERSq0yjP8ranhY=
Date: Mon, 26 Aug 2019 17:01:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nayna <nayna@linux.vnet.ibm.com>
Subject: [PATCH] sysfs: add BIN_ATTR_WO() macro
Message-ID: <20190826150153.GD18418@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826140131.GA15270@kroah.com>
 <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 Elaine Palmer <erpalmer@us.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 linux-integrity@vger.kernel.org, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This variant was missing from sysfs.h, I guess no one noticed it before.

Turns out the powerpc secure variable code can use it, so add it to the
tree for it, and potentially others to take advantage of, instead of
open-coding it.

Reported-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

I'll queue this up to my tree for 5.4-rc1, but if you want to take this
in your tree earlier, feel free to do so.

 include/linux/sysfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 965236795750..5420817ed317 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -196,6 +196,12 @@ struct bin_attribute {
 	.size	= _size,						\
 }
 
+#define __BIN_ATTR_WO(_name) {						\
+	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.store	= _name##_store,					\
+	.size	= _size,						\
+}
+
 #define __BIN_ATTR_RW(_name, _size)					\
 	__BIN_ATTR(_name, 0644, _name##_read, _name##_write, _size)
 
@@ -208,6 +214,9 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR(_name, _mode, _read,	\
 #define BIN_ATTR_RO(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RO(_name, _size)
 
+#define BIN_ATTR_WO(_name, _size)					\
+struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
+
 #define BIN_ATTR_RW(_name, _size)					\
 struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
 
-- 
2.23.0

