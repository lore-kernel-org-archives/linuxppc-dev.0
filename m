Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DAF4DDDE4
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 05:20:48 +1100 (EST)
Date: Sat, 17 Nov 2007 10:19:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
Message-Id: <20071117101957.7562639d.akpm@linux-foundation.org>
In-Reply-To: <20071117180946.GA14055@elte.hu>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117180946.GA14055@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Peter,
	Zijlstra <a.p.zijlstra@chello.nl>, LKML <linux-kernel@vger.kernel.org>,
	Torsten Kaiser <just.for.lkml@googlemail.com>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Jan Blunck <jblunck@suse.de>, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 17 Nov 2007 19:09:46 +0100 Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Torsten Kaiser <just.for.lkml@googlemail.com> wrote:
> 
> > Sadly lockdep does not work for me, as it gets turned off early:
> > [   39.851594] ---------------------------------
> > [   39.855963] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
> > [   39.861981] swapper/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
> > [   39.866963]  (&n->list_lock){-+..}, at: [<ffffffff802935c1>]
> 
> hey, that means it found a bug - which is not sad at all :-)
> 

mutter.

Torsten, you could try CONFIG_SLAB=y, CONFIG_SLUB=n to see if you can make
some progress on the NFS problem.
