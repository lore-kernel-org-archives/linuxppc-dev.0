Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 02:48:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232D36058D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 02:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 232D36058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVrKs4CDdz3cFv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 13:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVrK1228fz2yMg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Oct 2021 13:47:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R641e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0Us1cFSh_1634266020; 
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0Us1cFSh_1634266020) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 15 Oct 2021 10:47:01 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
 arnd@arndb.de, osandov@fb.com
Subject: [PATCH v11 0/3] make hvc pass dma capable memory to its backend
Date: Fri, 15 Oct 2021 10:46:55 +0800
Message-Id: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
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
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
 shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

V4
[PATCH v4 0/2] make hvc pass dma capable memory to its backend
https://lkml.org/lkml/2021/8/5/1350
[PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
https://lkml.org/lkml/2021/8/5/1351
[PATCH v4 2/2] virtio-console: remove unnecessary kmemdup()
https://lkml.org/lkml/2021/8/5/1352

For v4 patch, Arnd Bergmann suggests to introduce another
array(cons_outbuf[]) for the buffer pointers next to the cons_ops[]
and vtermnos[] arrays. This fix included in this v5 patch.

V5
Arnd Bergmann suggests to use "L1_CACHE_BYTES" as dma alignment,
use 'sizeof(long)' as dma alignment is wrong. fix it in v6.

V6
It contains coding error, fix it in v7 and it worked normally
according to test result.

V7
Greg KH suggests to add test and code review developer,
Jiri Slaby suggests to use lockless buffer and fix dma alignment
in separate patch.
fix above things in v8. 

V8
This contains coding error when switch to use new buffer. fix it in v9.

V9
It didn't make things much clearer, it needs add more comments for new added buf.
Add use lock to protect new added buffer. fix in v10.

V10
Remove 'char outchar' and its lock from hvc_struct, adjust hvc_struct and use
pahole to display the struct layout.
fix it in v11.

********TEST STEPS*********
1, config guest console=hvc0
2, start guest
3, login guest
    Welcome to Buildroot
    buildroot login: root
    # 
    # cat /proc/cmdline 
    console=hvc0 root=/dev/vda rw init=/sbin/init
    #

drivers/tty/hvc/hvc_console.c | 36 ++++++++++++++++++++---------------
drivers/tty/hvc/hvc_console.h | 21 +++++++++++++++++++-
drivers/char/virtio_console.c | 12 ++----------
3 file changed
