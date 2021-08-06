Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD14C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 03:02:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC9960E97
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 03:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9AC9960E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgqyV4BbDz3dCN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Aug 2021 13:02:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130;
 helo=out30-130.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ggqy66tDkz301P
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Aug 2021 13:01:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0Ui5askT_1628218900; 
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0Ui5askT_1628218900) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 06 Aug 2021 11:01:40 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
 arnd@arndb.de, osandov@fb.com
Subject: [PATCH v4 0/2] make hvc pass dma capable memory to its backend
Date: Fri,  6 Aug 2021 11:01:36 +0800
Message-Id: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>, guoren@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear all,

This patch series make hvc framework pass DMA capable memory to
put_chars() of hvc backend(eg, virtio-console), and revert commit
c4baad5029 ("virtio-console: avoid DMA from stack”)

V1
virtio-console: avoid DMA from vmalloc area
https://lkml.org/lkml/2021/7/27/494

For v1 patch, Arnd Bergmann suggests to fix the issue in the first
place:
Make hvc pass DMA capable memory to put_chars()
The fix suggestion is included in v2.

V2
[PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/1/8
[PATCH 2/2] virtio-console: remove unnecessary kmemdup()
https://lkml.org/lkml/2021/8/1/9

For v2 patch, Arnd Bergmann suggests to make new buf part of the
hvc_struct structure, and fix the compile issue.
The fix suggestion is included in v3.

V3
[PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/3/1347
[PATCH v3 2/2] virtio-console: remove unnecessary kmemdup()
https://lkml.org/lkml/2021/8/3/1348

For v3 patch, Jiri Slaby suggests to make 'char c[N_OUTBUF]' part of
hvc_struct, and make 'hp->outbuf' aligned and use struct_size() to
calculate the size of hvc_struct. The fix suggestion is included in
v4.

drivers/char/virtio_console.c | 12 ++----------
drivers/tty/hvc/hvc_console.c | 33 ++++++++++++++++++---------------
drivers/tty/hvc/hvc_console.h | 16 ++++++++++++++--
3 file changed
