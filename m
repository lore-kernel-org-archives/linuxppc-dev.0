Return-Path: <hch@lst.de>
Date: Tue, 22 Jul 2008 11:49:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: arnd@arndb.de
Subject: Re: [Cbe-oss-dev] [patch 7/9] azfs: initial submit of azfs,
	a non-buffered filesystem
Message-ID: <20080722094950.GA3234@lst.de>
References: <20080715195139.316677337@arndb.de>
	<20080715195739.820365109@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080715195739.820365109@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 09:51:46PM +0200, arnd@arndb.de wrote:
> From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
> 
> AZFS is a file system which keeps all files on memory mapped random
> access storage. It was designed to work on the axonram device driver
> for IBM QS2x blade servers, but can operate on any block device
> that exports a direct_access method.

I don't thinks it's quite ready yet.  I've had another look through the
code and here's some issues I came up with:

 - first thing is that it's not sparse clean, which is a bit of a red
   flag.  The __iomem and __user annotations are there for a reason.
 - then even with annotations we still have the issue of
   copy_{from,to}_user into mmio regions.  According to benh that's
   still an open issue, but it at least needs very good explanations in
   comments.
 - the aio_read and aio_write methods don't handle actually vectored
   writes.  They need to iterate over all iovecs.  Or just implement
   plain read/write given that it's not actually asynchronous.
 - the persistent superblock hack needs to go away.  Just clean up
   everything in ->put_super.  If we want a fully persistant fs
   we should just be using ext2 + xip
 - azfs_open looks very fishy.  there's never a need to do seeks
   inside open.  if O_APPEND is set the VFS makes sure the read and
   write methods get the right ppos pointer passed.
   And truncation is done by the VFS for O_TRUNC opens through
   ->setattr
 - azfs_znode should not have a size field of it's own, but the
   filesystem should only use the inode one
 - the lists and inode_init_once should be called from the slab
   constructor as in other filesystems
 - I don't think there is any point of having a slab cache
   for the azfs_block structures
 - disk->driverfs_dev is not writeable to the filesystem, but for
   driver use.  The information azfs stores in there is not used
   anyway, so it could easily be removed.
 - lots of duplicated field in azfs_super where the superblock
   ones should be used:

	media_size	-> sb->s_maxbytes
	sector_size	-> not needed at all
	blkdev		-> sb->s_bdev
	root		-> sb->s_root
