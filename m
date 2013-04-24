Return-Path: <benh@kernel.crashing.org>
Message-ID: <1366766214.12131.27.camel@pasglop>
Subject: Re: [PATCH] powerpc/spufs: Initialise inode->i_ino in
 spufs_new_inode()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 24 Apr 2013 11:16:54 +1000
In-Reply-To: <1366765994-13486-1-git-send-email-michael@ellerman.id.au>
References: <1366765994-13486-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
 viro@zeniv.linux.org.uk, dchinner@redhat.com, Christoph Hellwig <hch@lst.de>,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-04-24 at 11:13 +1000, Michael Ellerman wrote:
> In commit 85fe402 (fs: do not assign default i_ino in new_inode), the
> initialisation of i_ino was removed from new_inode() and pushed down
> into the callers. However spufs_new_inode() was not updated.
> 
> This exhibits as no files appearing in /spu, because all our dirents
> have a zero inode, which readdir() seems to dislike.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Christoph/Al, can I have an Ack for this before I shoot it to Linus ?

Thanks !

Cheers,
Ben.

---
>  arch/powerpc/platforms/cell/spufs/inode.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/cell/spufs/inode.c
b/arch/powerpc/platforms/cell/spufs/inode.c
> index 3f3bb4c..35f77a4 100644
> --- a/arch/powerpc/platforms/cell/spufs/inode.c
> +++ b/arch/powerpc/platforms/cell/spufs/inode.c
> @@ -99,6 +99,7 @@ spufs_new_inode(struct super_block *sb, umode_t
mode)
>  	if (!inode)
>  		goto out;
>  
> +	inode->i_ino = get_next_ino();
>  	inode->i_mode = mode;
>  	inode->i_uid = current_fsuid();
>  	inode->i_gid = current_fsgid();
> 
