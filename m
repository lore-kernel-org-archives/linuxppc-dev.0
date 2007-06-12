Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A44F4DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 01:19:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5CEGXqP030667
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 10:16:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5CFJJa2301714
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 11:19:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5CFJJ5I003655
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 11:19:19 -0400
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH 3/3] i386: During VM oom condition,
	kill all threads in process group
To: linuxppc-dev@ozlabs.org, anton@samba.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Jun 2007 10:19:13 -0500
Message-ID: <20070612151912.2869.43167.stgit@farscape.rchland.ibm.com>
In-Reply-To: <20070612151901.2869.59390.stgit@farscape.rchland.ibm.com>
References: <20070612151901.2869.59390.stgit@farscape.rchland.ibm.com>
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
allow for the application to restart, or otherwise handled, and makes it very
obvious that something has gone wrong.

This change allows the entire process group to be taken down, rather than
just the one thread.

tested lightly on i386.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/i386/mm/fault.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index b8c4e25..a47e712 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -568,7 +568,7 @@ out_of_memory:
 	}
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
-		do_exit(SIGKILL);
+		do_group_exit(SIGKILL);
 	goto no_context;
 
 do_sigbus:
