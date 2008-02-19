Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 9C4DADDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 20:07:36 +1100 (EST)
Date: Tue, 19 Feb 2008 18:07:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1  
	softlockup  while bootup on powerpc
Message-Id: <20080219180723.e742a582.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20080219085838.GP23197@kernel.dk>
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
	<47B67E5E.4010001@linux.vnet.ibm.com>
	<20080217192913.GO23197@kernel.dk>
	<20080219170432.9c04376f.kamezawa.hiroyu@jp.fujitsu.com>
	<20080219083633.GN23197@kernel.dk>
	<20080219174743.202b64f8.kamezawa.hiroyu@jp.fujitsu.com>
	<20080219085838.GP23197@kernel.dk>
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

On Tue, 19 Feb 2008 09:58:38 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:
> > when I inserted printk here
> > ==
> > 	for (i = 0; i < nr; i++)
> > 		func(ioc, cics[i]);
> > 	printk("%d %lx\n", nr, index);
> > ==
> > index was always "1" and  nr was always 32.
> > 
> > So, cics[31]->key was always NULL when index=1 is passed to
> > radix_tree_gang_lookup().
> 
> Hang on, it returned 32? It should not return more than 16, since that
> is what we have room for and asked for. 
sorry. Of course, it was 16 ;(

your patch works well. thank you.

-Kame
