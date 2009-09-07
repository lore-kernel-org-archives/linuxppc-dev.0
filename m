Return-Path: <tklauser@distanz.ch>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4C265B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 17:35:19 +1000 (EST)
Received: from mx2.zhaw.ch (mx2.zhaw.ch [160.85.104.51])
	by ozlabs.org (Postfix) with ESMTP id D776CDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 17:35:18 +1000 (EST)
From: Tobias Klauser <tklauser@distanz.ch>
To: Paul Mackerras <paulus@au.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Declare hcall_inst_seq_ops const
Date: Mon,  7 Sep 2009 09:28:20 +0200
Message-Id: <1252308500-31240-1-git-send-email-tklauser@distanz.ch>
Cc: linuxppc-dev@ozlabs.org, Tobias Klauser <tklauser@distanz.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marking it const moves it to the .rodata section, which avoids false
sharing with potential dirty data. In addition it'll catch accidental
writes at compile time to these shared resources.

(description taken from commit 5dfe4c964a0dd7bb3a1d64a4166835a153146207)

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index eae51ef..3631a4f 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -71,7 +71,7 @@ static int hc_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static struct seq_operations hcall_inst_seq_ops = {
+static const struct seq_operations hcall_inst_seq_ops = {
         .start = hc_start,
         .next  = hc_next,
         .stop  = hc_stop,
-- 
1.6.0.4
