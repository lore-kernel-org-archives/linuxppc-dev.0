Return-Path: <trond.myklebust@fys.uio.no>
Received: from pat.uio.no (pat.uio.no [129.240.10.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC98DDDEB
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 06:17:14 +1100 (EST)
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Torsten Kaiser <just.for.lkml@googlemail.com>
In-Reply-To: <64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-JB8J0Rnqj+uhc3kuo5ga"
Date: Sat, 17 Nov 2007 13:58:40 -0500
Message-Id: <1195325920.7484.1.camel@localhost.localdomain>
Mime-Version: 1.0
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


--=-JB8J0Rnqj+uhc3kuo5ga
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Sat, 2007-11-17 at 18:53 +0100, Torsten Kaiser wrote:
> On Nov 16, 2007 3:15 PM, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> > Hi Andrew,
> >
> > The kernel enters the xmon state while running the file system
> > stress on nfs v4 mounted partition.
> [snip]
> > 0:mon> t
> > [c0000000dbd4fb50] c000000000069768 .__wake_up+0x54/0x88
> > [c0000000dbd4fc00] d00000000086b890 .nfs_sb_deactive+0x44/0x58 [nfs]
> > [c0000000dbd4fc80] d000000000872658 .nfs_free_unlinkdata+0x2c/0x74 [nfs]
> > [c0000000dbd4fd10] d000000000598510 .rpc_release_calldata+0x50/0x74 [sunrpc]
> > [c0000000dbd4fda0] c00000000008d960 .run_workqueue+0x10c/0x1f4
> > [c0000000dbd4fe50] c00000000008ec70 .worker_thread+0x118/0x138
> > [c0000000dbd4ff00] c0000000000939f4 .kthread+0x78/0xc4
> > [c0000000dbd4ff90] c00000000002b060 .kernel_thread+0x4c/0x68

Could you try with the attached patch.

Cheers
  Trond

--=-JB8J0Rnqj+uhc3kuo5ga
Content-Disposition: inline; filename=linux-2.6.24-007-fix_nfs_free_unlinkdata.dif
Content-Type: message/rfc822; name=linux-2.6.24-007-fix_nfs_free_unlinkdata.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Sat, 17 Nov 2007 13:52:36 -0500
Subject: NFS: Fix nfs_free_unlinkdata()
Message-Id: <1195325920.7484.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

We should really only be calling nfs_sb_deactive() at the end of an RPC
call, to balance the nfs_sb_active() call in nfs_do_call_unlink(). OTOH,
nfs_free_unlinkdata() can be called from a variety of other situations.

Fix is to move the call to nfs_sb_deactive() into
nfs_async_unlink_release().

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/unlink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index b97d3bb..c90862a 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -31,7 +31,6 @@ struct nfs_unlinkdata {
 static void
 nfs_free_unlinkdata(struct nfs_unlinkdata *data)
 {
-	nfs_sb_deactive(NFS_SERVER(data->dir));
 	iput(data->dir);
 	put_rpccred(data->cred);
 	kfree(data->args.name.name);
@@ -116,6 +115,7 @@ static void nfs_async_unlink_release(void *calldata)
 	struct nfs_unlinkdata	*data = calldata;
 
 	nfs_dec_sillycount(data->dir);
+	nfs_sb_deactive(NFS_SERVER(data->dir));
 	nfs_free_unlinkdata(data);
 }
 

--=-JB8J0Rnqj+uhc3kuo5ga--
