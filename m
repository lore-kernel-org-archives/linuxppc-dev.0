Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQSsR1VHlzDrd4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 19:52:11 +1100 (AEDT)
Date: Mon, 30 Oct 2017 09:51:59 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH v4 04/10] mtd: powernv_flash: Don't return -ERESTARTSYS
 on interrupted token acquisition
Message-ID: <20171030095159.143fecaa@bbrezillon>
In-Reply-To: <20171010033302.20854-5-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171010033302.20854-5-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2017 14:32:56 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> Because the MTD core might split up a read() or write() from userspace
> into several calls to the driver, we may fail to get a token but already
> have done some work, best to return -EINTR back to userspace and have
> them decide what to do.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mtd/devices/powernv_flash.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 4dd3b5d2feb2..3343d4f5c4f3 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -47,6 +47,11 @@ enum flash_op {
>  	FLASH_OP_ERASE,
>  };
>  
> +/*
> + * Don't return -ERESTARTSYS if we can't get a token, the MTD core
> + * might have split up the call from userspace and called into the
> + * driver more than once, we'll already have done some amount of work.
> + */
>  static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		loff_t offset, size_t len, size_t *retlen, u_char *buf)
>  {
> @@ -63,6 +68,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  	if (token < 0) {
>  		if (token != -ERESTARTSYS)
>  			dev_err(dev, "Failed to get an async token\n");
> +		else
> +			token = -EINTR;
>  		return token;
>  	}
>  
