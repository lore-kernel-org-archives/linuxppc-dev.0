Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 51250DDEC5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 19:59:36 +1100 (EST)
Date: Tue, 19 Feb 2008 18:02:42 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [BUG] Linux 2.6.25-rc2 - Regression from 2.6.24-rc1-git1
	softlockup  while bootup on powerpc
Message-Id: <20080219180242.0bbec245.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20080219083633.GN23197@kernel.dk>
References: <alpine.LFD.1.00.0802151302210.9496@woody.linux-foundation.org>
	<47B67E5E.4010001@linux.vnet.ibm.com>
	<20080217192913.GO23197@kernel.dk>
	<20080219170432.9c04376f.kamezawa.hiroyu@jp.fujitsu.com>
	<20080219083633.GN23197@kernel.dk>
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

On Tue, 19 Feb 2008 09:36:34 +0100
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Tue, Feb 19 2008, KAMEZAWA Hiroyuki wrote:
> > On Sun, 17 Feb 2008 20:29:13 +0100
> > Jens Axboe <jens.axboe@oracle.com> wrote:
> > 
> > > It's odd stuff. Could you perhaps try and add some printks to
> > > block/cfq-iosched.c:call_for_each_cic(), like dumping the 'nr' return
> > > from radix_tree_gang_lookup() and the pointer value of cics[i] in the
> > > for() loop after the lookup?
> > > 
> > I met the same issue on ia64/NUMA box.
> > seems cisc[]->key is NULL and index for radix_tree_gang_lookup() was
> > always '1'.
> 
> Why does it keep repeating then? If ->key is NULL, the next lookup index
> should be 1UL.
> 
> But I think the radix 'scan over entire tree' is a bit fragile. This
> patch adds a parallel hlist for ease of properly browsing the members,
> does that work for you? It compiles, but I haven't booted it here yet...
> 
Works well for me and my box booted !

Thanks,
-Kame
