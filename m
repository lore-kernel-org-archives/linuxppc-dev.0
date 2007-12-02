Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from yergi.telenet-ops.be (yergi.telenet-ops.be [195.130.132.36])
	by ozlabs.org (Postfix) with ESMTP id EBA3EDDDF9
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 20:35:08 +1100 (EST)
Received: from agave.telenet-ops.be (unknown [195.130.137.77])
	by yergi.telenet-ops.be (Postfix) with ESMTP id B4D6C5C8AB9
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 10:35:06 +0100 (CET)
Date: Sun, 2 Dec 2007 10:34:56 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@linux-m68k.org
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: Re: [PATCH 09/28] blk_end_request: changing ps3disk (take 3)
In-Reply-To: <20071130.182810.98558485.k-ueda@ct.jp.nec.com>
Message-ID: <Pine.LNX.4.64.0712021032490.29349@anakin>
References: <20071130.182810.98558485.k-ueda@ct.jp.nec.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463808512-250639608-1196588096=:29349"
Cc: linux-scsi@vger.kernel.org, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	jens.axboe@oracle.com,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-ide@vger.kernel.org, dm-devel@redhat.com,
	bharrosh@panasas.com, j-nomura@ce.jp.nec.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463808512-250639608-1196588096=:29349
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 30 Nov 2007, Kiyoshi Ueda wrote:
> This patch converts ps3disk to use blk_end_request().
                                     ^^^^^^^^^^^^^^^
Patch subject and description are inconsistent with actual change.

> Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> ---
>  drivers/block/ps3disk.c |    6 +-----
>  1 files changed, 1 insertion(+), 5 deletions(-)
> 
> Index: 2.6.24-rc3-mm2/drivers/block/ps3disk.c
> ===================================================================
> --- 2.6.24-rc3-mm2.orig/drivers/block/ps3disk.c
> +++ 2.6.24-rc3-mm2/drivers/block/ps3disk.c
> @@ -280,11 +280,7 @@ static irqreturn_t ps3disk_interrupt(int
>  	}
>  
>  	spin_lock(&priv->lock);
> -	if (!end_that_request_first(req, uptodate, num_sectors)) {
> -		add_disk_randomness(req->rq_disk);
> -		blkdev_dequeue_request(req);
> -		end_that_request_last(req, uptodate);
> -	}
> +	__blk_end_request(req, uptodate, num_sectors << 9);
        ^^^^^^^^^^^^^^^^^

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---1463808512-250639608-1196588096=:29349--
