Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A70ADDE34
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Nov 2007 20:00:59 +1100 (EST)
Date: Mon, 19 Nov 2007 01:00:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
Message-Id: <20071119010002.9387d36b.akpm@linux-foundation.org>
In-Reply-To: <64bb37e0711182315s1d159c80h11811acb07566f03@mail.gmail.com>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117180946.GA14055@elte.hu>
	<20071117101957.7562639d.akpm@linux-foundation.org>
	<64bb37e0711171140w5f1451e0qea081a4fbc7a45f7@mail.gmail.com>
	<20071117230508.GB25905@dyad>
	<64bb37e0711181044s75fd1081sdf44dac2e060d49a@mail.gmail.com>
	<1195413486.7893.16.camel@heimdal.trondhjem.org>
	<64bb37e0711182315s1d159c80h11811acb07566f03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jan Blunck <jblunck@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	steved@redhat.com, LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Ingo Molnar <mingo@elte.hu>, Trond Myklebust <trond.myklebust@fys.uio.no>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2007 08:15:48 +0100 "Torsten Kaiser" <just.for.lkml@googlemail.com> wrote:

> On Nov 18, 2007 8:18 PM, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > On Sun, 2007-11-18 at 19:44 +0100, Torsten Kaiser wrote:
> > > NFSv2/3 and NFSv4 share the same dentry_iput and so share the same
> > > unlink and sillyrename logic.
> > > But they do not share nfs_init_server()!
> > >
> > > I wonder why this doesn't blow up more violently, but only hangs...
> > >
> > > But as I don't know if it is correct to add the workqueue
> > > initialization to nfs4_init_server() or remove the nfs_sb_active /
> > > nfs_sb_deactive for the NFSv4 case, I can't offer a patch to fix this.
> > >
> > > Torsten
> >
> > I had already fixed that one in my own stack. Attached are the 3 patches
> > that I've got. 1 from SteveD, 2 fixes.
> >
> 
> Moving the init_waitqueue_head() like patch
> linux-2.6.24-006-fix_to_fix_sillyrename_bug_on_umount.dif and applying
> linux-2.6.24-007-fix_nfs_free_unlinkdata.dif lets my testcase work.
> Also lockdep no longer complains about the non-static key.
> 

Thanks.

To avoid goofups, could you please send the full fix against 2.6.24-rc2-mm1?
