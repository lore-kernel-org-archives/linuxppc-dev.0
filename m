From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>,
	<cort@fsmlabs.com>
Subject: Re: Fwd: CPU features
Date: Sun, 1 Apr 2001 19:04:18 +0200
Message-Id: <20010401170418.2024@smtp.wanadoo.fr>
In-Reply-To: <20010402002232.Postino-025103@smtp01.highway.ne.jp>
References: <20010402002232.Postino-025103@smtp01.highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi
>Thanks your great kernel works.
>Recently kernel source has spin_lock problem.
>
>I  needed the patch for kernel-2.4.3.pre8-SMP on Dual G4.
>
>Kernel Guys, Please look the patch or
>Please Look this problem.

Hrm.. your patch isn't good. I think I found the problem (but didn't
yet test. My proposed fix is in my rsync, please test and report).

Basically, pte_alloc() is meant to be called with the page table lock
held. It may itself unlock & re-lock it.

There are places in arch/ppc/mm/init.c where we call it (via map_page())
without the lock. That mean that we can go out of mapin_ram and paging_init
with a dangling page table lock held init init_mm, causing further calls
to __ioremap (or other things) to lockup as soon as they try to grab that
lock.

The fix would be to enclose those calls to map_page() with a
spin_lock(&init_mm.page_table_lock);
and
spin_unlock(&init_mm.page_table_lock);

Tell me what result you get with that.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
