Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yQSpR5Z3tzDqmt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 19:49:35 +1100 (AEDT)
Date: Mon, 30 Oct 2017 09:49:23 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, sjitindarsingh@gmail.com
Subject: Re: [PATCH v4 01/10] mtd: powernv_flash: Use WARN_ON_ONCE() rather
 than BUG_ON()
Message-ID: <20171030094923.42f8aa20@bbrezillon>
In-Reply-To: <20171010033302.20854-2-cyrilbur@gmail.com>
References: <20171010033302.20854-1-cyrilbur@gmail.com>
 <20171010033302.20854-2-cyrilbur@gmail.com>
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

On Tue, 10 Oct 2017 14:32:53 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

> BUG_ON() should be reserved in situations where we can not longer
> guarantee the integrity of the system. In the case where
> powernv_flash_async_op() receives an impossible op, we can still
> guarantee the integrity of the system.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/mtd/devices/powernv_flash.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index f5396f26ddb4..f9ec38281ff2 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -78,7 +78,9 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  		rc = opal_flash_erase(info->id, offset, len, token);
>  		break;
>  	default:
> -		BUG_ON(1);
> +		WARN_ON_ONCE(1);
> +		opal_async_release_token(token);
> +		return -EIO;
>  	}
>  
>  	if (rc != OPAL_ASYNC_COMPLETION) {
