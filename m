Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 14019DDF4A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 01:00:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
Subject: Re: AZFS file system proposal
Date: Tue, 1 Jul 2008 16:59:32 +0200
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807011659.33413.arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 June 2008, Maxim Shchetynin wrote:
> AZFS patch updated accordinly to comments of Christoph Hellwig and Dmitri Vorobiev.

Sorry for my not commenting earlier on this. I'm finally collecting my
2.6.27 patches and stumbled over it again. There are a few details
that I hope we can fix up quickly, other than that, it looks good now,
great work!

> Subject: azfs: initial submit of azfs, a non-buffered filesystem
 
Please make the patch subject the actual subject of your email next time,
and put the introductory text below the Signed-off-by: lines, separated
by a "---" line. That will make the standard tools work without extra
effort on my side. Also, please always Cc the person you want to merge
the patch, in this case probably me.

> diff -Nuar linux-2.6.26-rc6/fs/Makefile linux-2.6.26-rc6-azfs/fs/Makefile
> --- linux-2.6.26-rc6/fs/Makefile	2008-06-12 23:22:24.000000000 +0200
> +++ linux-2.6.26-rc6-azfs/fs/Makefile	2008-06-16 11:17:50.000000000 +0200
> @@ -119,3 +119,4 @@
>  obj-$(CONFIG_DEBUG_FS)		+= debugfs/
>  obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
>  obj-$(CONFIG_GFS2_FS)           += gfs2/
> +obj-$(CONFIG_AZ_FS)		+= azfs.o
> diff -Nuar linux-2.6.26-rc6/fs/azfs.c linux-2.6.26-rc6-azfs/fs/azfs.c
> --- linux-2.6.26-rc6/fs/azfs.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc6-azfs/fs/azfs.c	2008-06-18 15:56:13.252266896 +0200

All other file systems are in separate directories, so it would be better
to rename fs/azfs.c to fs/azfs/inode.c

> +#define AZFS_FILESYSTEM_NAME		"azfs"
> +#define AZFS_FILESYSTEM_FLAGS		FS_REQUIRES_DEV
> +
> +#define AZFS_SUPERBLOCK_MAGIC		0xABBA1972
> +#define AZFS_SUPERBLOCK_FLAGS		MS_NOEXEC | \
> +					MS_SYNCHRONOUS | \
> +					MS_DIRSYNC | \
> +					MS_ACTIVE

Why MS_NOEXEC? What happens on a remount if the user does not specifies
-o remount,exec?

> +/**
> + * azfs_block_find - get real address of a part of a file
> + * @inode: inode
> + * @direction: data direction
> + * @from: offset for read/write operation
> + * @size: pointer to a value of the amount of data to be read/written
> + */
> +static unsigned long
> +azfs_block_find(struct inode *inode, enum azfs_direction direction,
> +		unsigned long from, unsigned long *size)
> +{
> +	struct azfs_super *super;
> +	struct azfs_znode *znode;
> +	struct azfs_block *block;
> +	unsigned long block_id, west, east;
> +
> +	super = inode->i_sb->s_fs_info;
> +	znode = I2Z(inode);
> +
> +	if (from + *size > znode->size) {
> +		i_size_write(inode, from + *size);
> +		inode->i_op->truncate(inode);
> +	}
> +
> +	read_lock(&znode->lock);
> +
> +	if (list_empty(&znode->block_list)) {
> +		read_unlock(&znode->lock);
> +		return 0;
> +	}
> +
> +	block_id = from >> super->block_shift;
> +
> +	for_each_block(block, &znode->block_list) {
> +		if (block->count > block_id)
> +			break;
> +		block_id -= block->count;
> +	}
> +
> +	west = from % super->block_size;
> +	east = ((block->count - block_id) << super->block_shift) - west;
> +
> +	if (*size > east)
> +		*size = east;
> +
> +	block_id = ((block->id + block_id) << super->block_shift) + west;
> +
> +	read_unlock(&znode->lock);
> +
> +	block_id += direction == AZFS_MMAP ? super->ph_addr : super->io_addr;
> +
> +	return block_id;
> +}

This overloading of the return type to mean either a pointer or an offset
on the block device is rather confusing. Why not just return the raw block_id
before the last += and leave that part up to the caller?

static void __iomem *
azfs_block_addr(struct inode *inode, enum azfs_direction direction,
		unsigned long from, unsigned long *size)
{
	struct azfs_super *super;
	unsigned long offset;
	void __iomem *p;

	super = inode->i_sb->s_fs_info;
	offset = azfs_block_find(inode, super, 0, from, size);
	p = super->ph_addr + offset;

	return p;
}

> +	target = iov->iov_base;
> +	todo = min((loff_t) iov->iov_len, i_size_read(inode) - pos);
> +
> +	for (step = todo; step; step -= size) {
> +		size = step;
> +		pin = azfs_block_find(inode, AZFS_READ, pos, &size);
> +		if (!pin) {
> +			rc = -ENOSPC;
> +			goto out;
> +		}
> +		if (copy_to_user(target, (void*) pin, size)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}

Question to the powerpc folks: is copy_to_user safe for an __iomem source?
Should there be two copies (memcpy_fromio and copy_to_user) instead?

> +	page_prot = pgprot_val(vma->vm_page_prot);
> +	page_prot |= (_PAGE_NO_CACHE | _PAGE_RW);
> +	page_prot &= ~_PAGE_GUARDED;
> +	vma->vm_page_prot = __pgprot(page_prot);

The pgprot modifications rely on powerpc specific flags, but the
file system should not really need to be powerpc only.

The flags we want are more or less the same as PAGE_AGP, because
both are I/O mapped memory that needs to be uncached but should
not be guarded, for performance reasons.

Maybe we can introduce a new PAGE_IOMEM here that we can use
in all places that need something like this. In spufs we need
the same flags for the local store mappings.

I wouldn't hold up merging the file system for this problem, but
until it is solved, the Kconfig entry should probably have
a "depends on PPC".

	Arnd <><
