Return-Path: <JAxboe@fusionio.com>
Received: from mx2.fusionio.com (mx2.fusionio.com [64.244.102.31])
	by ozlabs.org (Postfix) with ESMTP id B3F38B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 07:00:58 +1100 (EST)
Message-ID: <4CB3689F.1050601@fusionio.com>
Date: Mon, 11 Oct 2010 21:42:23 +0200
From: Jens Axboe <jaxboe@fusionio.com>
MIME-Version: 1.0
To: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ps3disk: passing wrong variable to bvec_kunmap_irq()
References: <20101011191335.GH5851@bicker>
In-Reply-To: <20101011191335.GH5851@bicker>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Geoff Levand <geoff@infradead.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2010-10-11 21:13, Dan Carpenter wrote:
> This should pass "buf" to bvec_kunmap_irq() instead of "bv".  The api is
> like kmap_atomic() instead of kmap().
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
> index e9da874..03688c2 100644
> --- a/drivers/block/ps3disk.c
> +++ b/drivers/block/ps3disk.c
> @@ -113,7 +113,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
>  			memcpy(buf, dev->bounce_buf+offset, size);
>  		offset += size;
>  		flush_kernel_dcache_page(bvec->bv_page);
> -		bvec_kunmap_irq(bvec, &flags);
> +		bvec_kunmap_irq(buf, &flags);
>  		i++;
>  	}
>  }

Thanks applied, that bug is all too common.

-- 
Jens Axboe
