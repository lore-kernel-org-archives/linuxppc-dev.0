Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwqcc4xyhzDrW6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 01:27:10 +1000 (AEST)
Date: Mon, 18 Sep 2017 17:27:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 chandan <chandan@linux.vnet.ibm.com>
Subject: Re: [linux-next][XFS][trinity] WARNING: CPU: 32 PID: 31369 at
 fs/iomap.c:993
Message-ID: <20170918152706.GA11482@lst.de>
References: <1505746565.6990.18.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505746565.6990.18.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 18, 2017 at 08:26:05PM +0530, Abdul Haleem wrote:
> Hi,
> 
> A warning is triggered from:
> 
> file fs/iomap.c in function iomap_dio_rw
> 
>     if (ret)
>         goto out_free_dio;
> 
>     ret = invalidate_inode_pages2_range(mapping,
>             start >> PAGE_SHIFT, end >> PAGE_SHIFT);
> >>  WARN_ON_ONCE(ret);
>     ret = 0;
> 
>     inode_dio_begin(inode);

This is expected and an indication of a problematic workload - which
may be triggered by a fuzzer.
