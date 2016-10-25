Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t36dD0tpgzDvgk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 20:03:27 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9P8wgCT116595
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:03:26 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269xbpgawf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 05:03:25 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 25 Oct 2016 10:03:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5715B2190069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 10:02:36 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9P93KNX17170574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 09:03:20 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9P93IjL017389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 03:03:20 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Noam Camus <noamc@ezchip.com>, sparclinux@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL v2 2/5] stop_machine: yield CPU during stop machine
Date: Tue, 25 Oct 2016 11:03:12 +0200
In-Reply-To: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
References: <1477386195-32736-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1477386195-32736-3-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some time ago commit 57f2ffe14fd125c2  ("s390: remove diag 44 calls
from cpu_relax()") did stop cpu_relax on s390 yielding to the
hypervisor.

As it turns out this made stop_machine run really slow on virtualized
overcommited systems. For example the kprobes test during bootup took
several seconds instead of just running unnoticed with large guests.

Therefore, the yielding was reintroduced with commit 4d92f50249eb
("s390: reintroduce diag 44 calls for cpu_relax()"), but in fact the
stop machine code seems to be the only place where this yielding
was really necessary. This place is probably the most important one
as it makes all but one guest CPUs wait for one guest CPU.

As we now have cpu_relax_yield, we can use this in multi_cpu_stop.
For now lets only add it here. We can add it later in other places
when necessary.

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
