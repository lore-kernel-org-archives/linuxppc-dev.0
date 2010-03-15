Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail9.fujitsu.co.jp (fgwmail9.fujitsu.co.jp [192.51.44.39])
	by ozlabs.org (Postfix) with ESMTP id D81C2B7D6D
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 12:31:17 +1100 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail9.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2F15iBV015300 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Mon, 15 Mar 2010 10:05:44 +0900
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2F15gbD015938 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Mon, 15 Mar 2010 10:05:42 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7855C45DE4F
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 10:05:42 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4DC0F45DE4E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 10:05:42 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 37EAA1DB8040
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 10:05:42 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DAE7D1DB803F
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 10:05:38 +0900 (JST)
Date: Mon, 15 Mar 2010 10:02:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: [BUGFIX][PATCH] memcg: avoid use cmpxchg in swap cgroup
	maintainance (Was Re: 34-rc1-git3 build failure with
	CGROUP_MEM_RES_CTLR_SWAP=y
Message-Id: <20100315100202.eb735f59.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4B9CBEE6.1090509@in.ibm.com>
References: <4B9CBEE6.1090509@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: nishimura@mxp.nes.nec.co.jp, lizf@cn.fujitsu.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 14 Mar 2010 16:18:06 +0530
Sachin Sant <sachinp@in.ibm.com> wrote:

> On a PowerPC box, latest 34-rc1 git(d89b218b8...) fails to build
> with CGROUPS_MEM_RES_CTRL_SWAP=y. 
> 
> LD      init/built-in.o
> LD      .tmp_vmlinux1
> mm/built-in.o: In function __xchg:
> arch/powerpc/include/asm/system.h:331: undefined reference to .__xchg_called_with_bad_pointer
> mm/built-in.o: In function __cmpxchg:
> arch/powerpc/include/asm/system.h:474: undefined reference to .__cmpxchg_called_with_bad_pointer
> make: *** [.tmp_vmlinux1] Error 1
> 
> The code in question was added via commit 024914477e...
> 
> memcg: move charges of anonymous swap
> 
Oh..ok, powerpc (and other archs?) can't do 2byte cmpxchg and xchg.
Then, we should use spinlock rather than that.

How about this ? Nishimura-san, could you consider something better ?
We need a quick fix.

==
swap_cgroup uses 2bytes data and uses cmpxchg in a new operation.
2byte cmpxchg/xchg is not available on some archs. This patch replaces
cmpxchg/xchg with operations under lock.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
---
 mm/page_cgroup.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: mmotm-2.6.34-Mar11/mm/page_cgroup.c
===================================================================
--- mmotm-2.6.34-Mar11.orig/mm/page_cgroup.c
+++ mmotm-2.6.34-Mar11/mm/page_cgroup.c
@@ -284,6 +284,7 @@ static DEFINE_MUTEX(swap_cgroup_mutex);
 struct swap_cgroup_ctrl {
 	struct page **map;
 	unsigned long length;
+	spinlock_t	lock;
 };
 
 struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
@@ -353,16 +354,22 @@ unsigned short swap_cgroup_cmpxchg(swp_e
 	struct swap_cgroup_ctrl *ctrl;
 	struct page *mappage;
 	struct swap_cgroup *sc;
+	unsigned long flags;
+	unsigned short retval;
 
 	ctrl = &swap_cgroup_ctrl[type];
 
 	mappage = ctrl->map[idx];
 	sc = page_address(mappage);
 	sc += pos;
-	if (cmpxchg(&sc->id, old, new) == old)
-		return old;
+	spin_lock_irqsave(&ctrl->lock, flags);
+	retval = sc->id;
+	if (retval == old)
+		sc->id = new;
 	else
-		return 0;
+		retval = 0;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	return retval;
 }
 
 /**
@@ -383,13 +390,17 @@ unsigned short swap_cgroup_record(swp_en
 	struct page *mappage;
 	struct swap_cgroup *sc;
 	unsigned short old;
+	unsigned long flags;
 
 	ctrl = &swap_cgroup_ctrl[type];
 
 	mappage = ctrl->map[idx];
 	sc = page_address(mappage);
 	sc += pos;
-	old = xchg(&sc->id, id);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	old = sc->id;
+	sc->id = id;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	return old;
 }
@@ -441,6 +452,7 @@ int swap_cgroup_swapon(int type, unsigne
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl->length = length;
 	ctrl->map = array;
+	spin_lock_init(&ctrl->lock);
 	if (swap_cgroup_prepare(type)) {
 		/* memory shortage */
 		ctrl->map = NULL;
