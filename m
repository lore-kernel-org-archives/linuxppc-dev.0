Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9420DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:19:21 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5CFJG0i013733
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 11:19:16 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5CFJFim252842
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:19:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5CFJF0P027794
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:19:15 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH 1/3] powerpc: during VM oom condition,
	kill all threads in process group
To: linuxppc-dev@ozlabs.org, anton@samba.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Jun 2007 10:19:01 -0500
Message-ID: <20070612151901.2869.59390.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


During a VM oom condition, kill all threads in the process group.

We have had complaints where a threaded application is left in a bad state
after one of it's threads is killed when we hit a VM: out_of_memory
condition.

Killing just one of the process threads can leave the application in a
bad state, whereas killing the entire process group would
allow for the application to restart, or otherwise handled, and makes it
very obvious that something has gone wrong.

This change allows the entire process group to be taken down, rather than
just the one thread.

lightly tested on powerpc

Signed-off-by: Will <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/mm/fault.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 03aeb3a..de1dcee 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -393,7 +393,7 @@ out_of_memory:
 	}
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
-		do_exit(SIGKILL);
+		do_group_exit(SIGKILL);
 	return SIGKILL;
 
 do_sigbus:
