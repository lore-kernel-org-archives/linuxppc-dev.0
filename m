Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0kjw532czDvXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 22:59:16 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9LBwom4034077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:14 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 267e514khh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 07:59:14 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Fri, 21 Oct 2016 12:59:08 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B7C1E1B0807B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:01:10 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9LBx6lR15925510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 11:59:06 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9LBx4wg008607
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 05:59:05 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/5] stop_machine: yield CPU during stop machine
Date: Fri, 21 Oct 2016 13:58:55 +0200
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

stop_machine can take a very long time if the hypervisor does
overcommitment for guest CPUs. When waiting for "the one", lets
give up our CPU by using the new cpu_relax_yield.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index ec9ab2f..1eb8266 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -194,7 +194,7 @@ static int multi_cpu_stop(void *data)
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax();
+		cpu_relax_yield();
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.5.5
