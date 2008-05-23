Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02900DE0BC
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 00:14:29 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4NEELMD001775
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 10:14:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4NEE631034162
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 08:14:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4NEE5Zx019882
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 08:14:05 -0600
Date: Fri, 23 May 2008 07:14:03 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcupreempt: remove export of rcu_batches_completed_bh
Message-ID: <20080523141403.GA8798@linux.vnet.ibm.com>
References: <Pine.LNX.4.58.0805221415330.14724@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0805221415330.14724@gandalf.stny.rr.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 02:18:17PM -0400, Steven Rostedt wrote:
> 
> In rcupreempt, rcu_batches_completed_bh is defined as a static inline in
> the header file. This does not need to be exported, and not only that,
> this breaks my PPC build.

Good catch!!!

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Steven Rostedt <srostedt@redhat.com>
> ---
>  kernel/rcupreempt.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: linux-tip.git/kernel/rcupreempt.c
> ===================================================================
> --- linux-tip.git.orig/kernel/rcupreempt.c	2008-05-22 11:12:30.000000000 -0700
> +++ linux-tip.git/kernel/rcupreempt.c	2008-05-22 11:12:33.000000000 -0700
> @@ -217,8 +217,6 @@ long rcu_batches_completed(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_batches_completed);
> 
> -EXPORT_SYMBOL_GPL(rcu_batches_completed_bh);
> -
>  void __rcu_read_lock(void)
>  {
>  	int idx;
> 
