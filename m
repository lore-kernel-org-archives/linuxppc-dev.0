Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 123C8B7D65
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 13:14:27 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2F2CGxq015358
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 13:12:16 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2F28QJ71523862
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 13:08:30 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2F2EIF9012698
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 13:14:19 +1100
Date: Mon, 15 Mar 2010 07:44:14 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] memcg: avoid use cmpxchg in swap cgroup
	maintainance (Was Re: 34-rc1-git3 build failure with
	CGROUP_MEM_RES_CTLR_SWAP=y
Message-ID: <20100315021414.GH17643@balbir.in.ibm.com>
References: <4B9CBEE6.1090509@in.ibm.com>
	<20100315100202.eb735f59.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100315100202.eb735f59.kamezawa.hiroyu@jp.fujitsu.com>
Cc: nishimura@mxp.nes.nec.co.jp, lizf@cn.fujitsu.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> [2010-03-15 10:02:02]:

> On Sun, 14 Mar 2010 16:18:06 +0530
> Sachin Sant <sachinp@in.ibm.com> wrote:
> 
> > On a PowerPC box, latest 34-rc1 git(d89b218b8...) fails to build
> > with CGROUPS_MEM_RES_CTRL_SWAP=y. 
> > 
> > LD      init/built-in.o
> > LD      .tmp_vmlinux1
> > mm/built-in.o: In function __xchg:
> > arch/powerpc/include/asm/system.h:331: undefined reference to .__xchg_called_with_bad_pointer
> > mm/built-in.o: In function __cmpxchg:
> > arch/powerpc/include/asm/system.h:474: undefined reference to .__cmpxchg_called_with_bad_pointer
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > The code in question was added via commit 024914477e...
> > 
> > memcg: move charges of anonymous swap
> > 
> Oh..ok, powerpc (and other archs?) can't do 2byte cmpxchg and xchg.
> Then, we should use spinlock rather than that.
> 
> How about this ? Nishimura-san, could you consider something better ?
> We need a quick fix.
>

Looks good to me

 
Acked-by: Balbir Singh <balbir@linux.vnet.ibm.com>
 

-- 
	Three Cheers,
	Balbir
