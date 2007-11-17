Return-Path: <just.for.lkml@googlemail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 9B53CDDDE6
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 06:18:51 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so5906168pyi
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 11:18:50 -0800 (PST)
Message-ID: <64bb37e0711171118t73a7c619p1117a5b150f369b7@mail.gmail.com>
Date: Sat, 17 Nov 2007 20:18:49 +0100
From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
In-Reply-To: <1195325920.7484.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<1195325920.7484.1.camel@localhost.localdomain>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, Jan Blunck <jblunck@suse.de>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 17, 2007 7:58 PM, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Sat, 2007-11-17 at 18:53 +0100, Torsten Kaiser wrote:
> > On Nov 16, 2007 3:15 PM, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> > > Hi Andrew,
> > >
> > > The kernel enters the xmon state while running the file system
> > > stress on nfs v4 mounted partition.
> > [snip]
> > > 0:mon> t
> > > [c0000000dbd4fb50] c000000000069768 .__wake_up+0x54/0x88
> > > [c0000000dbd4fc00] d00000000086b890 .nfs_sb_deactive+0x44/0x58 [nfs]
> > > [c0000000dbd4fc80] d000000000872658 .nfs_free_unlinkdata+0x2c/0x74 [nfs]
> > > [c0000000dbd4fd10] d000000000598510 .rpc_release_calldata+0x50/0x74 [sunrpc]
> > > [c0000000dbd4fda0] c00000000008d960 .run_workqueue+0x10c/0x1f4
> > > [c0000000dbd4fe50] c00000000008ec70 .worker_thread+0x118/0x138
> > > [c0000000dbd4ff00] c0000000000939f4 .kthread+0x78/0xc4
> > > [c0000000dbd4ff90] c00000000002b060 .kernel_thread+0x4c/0x68
>
> Could you try with the attached patch.
[snip]
> Fix is to move the call to nfs_sb_deactive() into
> nfs_async_unlink_release().

I realley doubt that will fix it.

My stacktrace was like:
run_workqueue
called: rpc_async_schedule
  that called: rpc_release_calldata
    which points to: nfs_async_unlink_release
       that called: nfs_free_unlinkdata

So it does not matter for me if nfs_sb_deactive is called one step earlier.

Currently building with SLAB instead SLUB to see if lockdep tells something...

Torsten
