Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB3402C016F
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jul 2013 15:37:01 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 2 Jul 2013 15:27:22 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9C1852CE8053
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jul 2013 15:36:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r625amFg7406044
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Jul 2013 15:36:48 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r625audB010045
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Jul 2013 15:36:57 +1000
Subject: [PATCH] Add hsize argument in write_buf call of pstore_ftrace_call
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Tue, 02 Jul 2013 11:06:54 +0530
Message-ID: <20130702053611.11466.71343.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: fengguang.wu@intel.com, kbuild-all@01.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Incorporate the addition of hsize argument in write_buf callback
of pstore.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---

 fs/pstore/ftrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index 43b1280..76a4eeb 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -44,7 +44,7 @@ static void notrace pstore_ftrace_call(unsigned long ip,
 	rec.parent_ip = parent_ip;
 	pstore_ftrace_encode_cpu(&rec, raw_smp_processor_id());
 	psinfo->write_buf(PSTORE_TYPE_FTRACE, 0, NULL, 0, (void *)&rec,
-			  sizeof(rec), psinfo);
+			  0, sizeof(rec), psinfo);
 
 	local_irq_restore(flags);
 }
