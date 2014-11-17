Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9603C1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 13:53:33 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 02:53:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CADDB17D8043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 02:53:37 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAH2rQ2516646482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 02:53:26 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAH2rPkk016289
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Nov 2014 19:53:25 -0700
Message-ID: <1416192750.3375.7.camel@TP420>
Subject: [PATCH powerpc] init nvram_pstore_info's buf_lock
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 17 Nov 2014 10:52:30 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It seems nvram_pstore_info's buf_lock is not initialized before
registering, which causes some strange behavior when trying to obtain
the lock during kdump process.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/nvram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 11a3b61..054a0ed 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -715,6 +715,8 @@ static int nvram_pstore_init(void)
 	nvram_pstore_info.buf = oops_data;
 	nvram_pstore_info.bufsize = oops_data_sz;
 
+	spin_lock_init(&nvram_pstore_info.buf_lock);
+
 	rc = pstore_register(&nvram_pstore_info);
 	if (rc != 0)
 		pr_err("nvram: pstore_register() failed, defaults to "
