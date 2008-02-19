Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail9.fujitsu.co.jp (fgwmail9.fujitsu.co.jp [192.51.44.39])
	by ozlabs.org (Postfix) with ESMTP id CD493DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 19:31:02 +1100 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m1J88Pe8024914 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Tue, 19 Feb 2008 17:08:25 +0900
Date: Tue, 19 Feb 2008 17:04:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1
	softlockup  while bootup on powerpc
Message-Id: <20080219170432.9c04376f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20080217192913.GO23197@kernel.dk>
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
	<47B67E5E.4010001@linux.vnet.ibm.com>
	<20080217192913.GO23197@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Dhaval Giani <dhaval@linux.vnet.ibm.com>,
	Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 17 Feb 2008 20:29:13 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:

> It's odd stuff. Could you perhaps try and add some printks to
> block/cfq-iosched.c:call_for_each_cic(), like dumping the 'nr' return
> from radix_tree_gang_lookup() and the pointer value of cics[i] in the
> for() loop after the lookup?
> 
I met the same issue on ia64/NUMA box.
seems cisc[]->key is NULL and index for radix_tree_gang_lookup() was always '1'.

Attached patch works well for me, 
but I don't know much about cfq. please confirm. 

Regards,
-Kame

==
cics[]->key can be NULL.
In that case, cics[]->dead_key has key value.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.25-rc2/block/cfq-iosched.c
===================================================================
--- linux-2.6.25-rc2.orig/block/cfq-iosched.c
+++ linux-2.6.25-rc2/block/cfq-iosched.c
@@ -1171,7 +1171,11 @@ call_for_each_cic(struct io_context *ioc
 			break;
 
 		called += nr;
-		index = 1 + (unsigned long) cics[nr - 1]->key;
+
+		if (!cics[nr - 1]->key)
+			index = 1 + (unsigned long) cics[nr - 1]->dead_key;
+		else
+			index = 1 + (unsigned long) cics[nr - 1]->key;
 
 		for (i = 0; i < nr; i++)
 			func(ioc, cics[i]);
