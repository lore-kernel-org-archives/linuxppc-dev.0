Message-ID: <40F5E435.60503@cyberone.com.au>
Date: Thu, 15 Jul 2004 11:56:05 +1000
From: Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev@lists.linuxppc.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Fw: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32
References: <20040714161503.2b0ce4d9.akpm@osdl.org>
In-Reply-To: <20040714161503.2b0ce4d9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Morton wrote:

>Nick , Ingo: could you please appropriately berate the ppc developers
>over this?  They're ignoring me ;)
>
>Or, if we don't really think the risk is very high, maybe I should just drop
>the debug patch?
>
>

sched-clean-init-idle has the following hunk to schedule() which
should catch all unsafe calls to it, I think.

+	/*
+	 * The idle thread is not allowed to schedule!
+	 * Remove this check after it has been exercised a bit.
+	 */
+	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
+		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
+		dump_stack();
+	}
+

Probably the patch can go.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
