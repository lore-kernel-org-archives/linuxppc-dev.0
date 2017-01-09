Return-Path: <BATV+346223d864736513bcc6+4887+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txxRt4gf4zDsYM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:52:42 +1100 (AEDT)
Date: Mon, 9 Jan 2017 05:52:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: axboe@kernel.dk, jack@suse.cz, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block
 count to be cleaned
Message-ID: <20170109135238.GA17003@infradead.org>
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 08, 2017 at 08:17:10PM +0530, Chandan Rajendra wrote:
> The code currently uses sdio->blkbits to compute the number of blocks to
> be cleaned. However sdio->blkbits is derived from the logical block size
> of the underlying block device (Refer to the definition of
> do_blockdev_direct_IO()). Due to this, generic/299 test would rarely
> fail when executed on an ext4 filesystem with 64k as the block size and
> when using a virtio based disk (having 512 byte as the logical block
> size) inside a kvm guest.
> 
> This commit fixes the bug by using inode->i_blkbits to compute the
> number of blocks to be cleaned.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
