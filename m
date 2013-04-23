Return-Path: <michael@ellerman.id.au>
Date: Tue, 23 Apr 2013 23:24:36 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Dennis Schridde <devurandom@gmx.net>
Subject: Re: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no
 threads shown in spufs
Message-ID: <20130423132436.GB1078@concordia>
References: <1470334.YUWOQ37ijW@ernie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470334.YUWOQ37ijW@ernie>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 06:44:13PM +0200, Dennis Schridde wrote:
> Hello!
> 
> 
> [1.] One line summary of the problem:
> .. no threads shown in spufs

So I think I've got this one fixed, this works for me, can you test it
please?

I'll send a proper patch in the morning.

cheers

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 3f3bb4c..35f77a4 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -99,6 +99,7 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 	if (!inode)
 		goto out;
 
+	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
