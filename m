Return-Path: <axboe@kernel.dk>
Received: from mail-pg0-x22c.google.com (mail-pg0-x22c.google.com
 [IPv6:2607:f8b0:400e:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txzgc2lCczDqRH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 02:32:58 +1100 (AEDT)
Received: by mail-pg0-x22c.google.com with SMTP id f188so275870133pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 07:32:58 -0800 (PST)
Subject: Re: [PATCH] do_direct_IO: Use inode->i_blkbits to compute block count
 to be cleaned
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>, jack@suse.cz
References: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <25f09398-7750-19ce-8fa9-15e229aad498@kernel.dk>
Date: Mon, 9 Jan 2017 08:32:55 -0700
MIME-Version: 1.0
In-Reply-To: <1483886830-23878-1-git-send-email-chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2017 07:47 AM, Chandan Rajendra wrote:
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

Thanks, added for 4.10.

-- 
Jens Axboe
