Return-Path: <just.for.lkml@googlemail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id B2CEBDDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 10:44:14 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so6031815pyi
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 15:44:13 -0800 (PST)
Message-ID: <64bb37e0711171544j2150288atea842e4d597ed2d1@mail.gmail.com>
Date: Sun, 18 Nov 2007 00:44:12 +0100
From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
In-Reply-To: <20071117230508.GB25905@dyad>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
	<20071117180946.GA14055@elte.hu>
	<20071117101957.7562639d.akpm@linux-foundation.org>
	<64bb37e0711171140w5f1451e0qea081a4fbc7a45f7@mail.gmail.com>
	<20071117230508.GB25905@dyad>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, steved@redhat.com,
	LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Blunck <jblunck@suse.de>, Ingo Molnar <mingo@elte.hu>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 18, 2007 12:05 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> On Sat, Nov 17, 2007 at 08:40:22PM +0100, Torsten Kaiser wrote:
>
> > Lockdep triggers immedetly before the freeze, but the result is still
> > not helpful:
> >
> > [  221.565011] INFO: trying to register non-static key.
> > [  221.566999] the code is fine but needs lockdep annotation.
> > [  221.569206] turning off the locking correctness validator.
> > [  221.571404]
> > [  221.571405] Call Trace:
> > [  221.572996]  [<ffffffff8025a1b4>] __lock_acquire+0x4c4/0x1140
> > [  221.575298]  [<ffffffff8025ae85>] lock_acquire+0x55/0x70
> > [  221.577429]  [<ffffffff8022d6fd>] __wake_up+0x2d/0x70
> > [  221.579457]  [<ffffffff805c5f04>] _spin_lock_irqsave+0x34/0x50
> > [  221.581800]  [<ffffffff805c5e45>] _spin_unlock_irqrestore+0x55/0x70
> > [  221.584317]  [<ffffffff8022d6fd>] __wake_up+0x2d/0x70
> > [  221.586344]  [<ffffffff805a88b0>] rpc_async_schedule+0x0/0x10
> > [  221.588648]  [<ffffffff802fface>] nfs_free_unlinkdata+0x1e/0x50
> > [  221.591023]  [<ffffffff805a7e96>] rpc_release_calldata+0x26/0x50
> > [  221.593428]  [<ffffffff8024778f>] run_workqueue+0x16f/0x210
> > [  221.595662]  [<ffffffff80259731>] trace_hardirqs_on+0xc1/0x160
> > [  221.598004]  [<ffffffff802483d0>] worker_thread+0x0/0xb0
> > [  221.600130]  [<ffffffff802483d0>] worker_thread+0x0/0xb0
> > [  221.602265]  [<ffffffff8024843d>] worker_thread+0x6d/0xb0
> > [  221.604431]  [<ffffffff8024bfc0>] autoremove_wake_function+0x0/0x30
> > [  221.606939]  [<ffffffff802483d0>] worker_thread+0x0/0xb0
> > [  221.609067]  [<ffffffff802483d0>] worker_thread+0x0/0xb0
> > [  221.611199]  [<ffffffff8024bbeb>] kthread+0x4b/0x80
> > [  221.613156]  [<ffffffff8020cb98>] child_rip+0xa/0x12
> > [  221.615151]  [<ffffffff8020c2af>] restore_args+0x0/0x30
> > [  221.617247]  [<ffffffff8024bba0>] kthread+0x0/0x80
> > [  221.619162]  [<ffffffff8020cb8e>] child_rip+0x0/0x12
> > [  221.621147]
> > [  221.621749] INFO: lockdep is turned off.
>
> I've been staring at this NFS code for a while an can't make any sense
> out of it. It seems to correctly initialize the waitqueue. So this would
> indicate corruption of some sort.

Not sure if this is helpful, but after looking into the code, the
above stacktrace looks somewhat damaged.
Might be my fault: # CONFIG_FRAME_POINTER is not set
On the other hand the stacktrace from the run with the SLUB lockdep
fix shows the same function names.

That trace contains this line:
 [<ffffffff8030167e>] nfs_free_unlinkdata+0x1e/0x50
(gdb) list *0xffffffff8030167e
0xffffffff8030167e is in nfs_free_unlinkdata (fs/nfs/unlink.c:33).
28       */
29      static void
30      nfs_free_unlinkdata(struct nfs_unlinkdata *data)
31      {
32              nfs_sb_deactive(NFS_SERVER(data->dir));
33              iput(data->dir);
34              put_rpccred(data->cred);
35              kfree(data->args.name.name);
36              kfree(data);
37      }

Is some inode lock guilty?
Please ask, if you need more information.

Torsten
