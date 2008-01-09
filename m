Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 54FC8DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 22:24:53 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so194613fgg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 03:24:51 -0800 (PST)
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Uartlite: Section type fixups
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-7-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080108193519.5282318F8069@mail8-blu.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 09 Jan 2008 12:24:48 +0100
In-Reply-To: <20080108193519.5282318F8069@mail8-blu.bigfish.com> (Stephen
	Neuendorffer's message of "Tue\, 8 Jan 2008 11\:35\:09 -0800")
Message-ID: <87ve63w8an.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Stephen" == Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> writes:

 Stephen> All the __devexit functions are now appropriately tagged.  This fixes
 Stephen> some ppc link warnings.

You forgot to add __devexit_p(ulite_remove) in ulite_platform_driver,
otherwise:

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

 Stephen> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
 Stephen> ---
 Stephen>  drivers/serial/uartlite.c |    4 ++--
 Stephen>  1 files changed, 2 insertions(+), 2 deletions(-)

 Stephen> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 Stephen> index 02c2d89..ecd5540 100644
 Stephen> --- a/drivers/serial/uartlite.c
 Stephen> +++ b/drivers/serial/uartlite.c
 Stephen> @@ -594,7 +594,7 @@ static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
 Stephen>   *
 Stephen>   * @dev: pointer to device structure
 Stephen>   */
 Stephen> -static int __devinit ulite_release(struct device *dev)
 Stephen> +static int __devexit ulite_release(struct device *dev)
 Stephen>  {
 Stephen>  	struct uart_port *port = dev_get_drvdata(dev);
 Stephen>  	int rc = 0;
 Stephen> @@ -627,7 +627,7 @@ static int __devinit ulite_probe(struct platform_device *pdev)
 Stephen>  	return ulite_assign(&pdev->dev, pdev->id, res->start, res2->start);
 Stephen>  }
 
 Stephen> -static int ulite_remove(struct platform_device *pdev)
 Stephen> +static int __devexit ulite_remove(struct platform_device *pdev)
 Stephen>  {
 Stephen>  	return ulite_release(&pdev->dev);
 Stephen>  }
 Stephen> -- 
 Stephen> 1.5.3.4-dirty



 Stephen> _______________________________________________
 Stephen> Linuxppc-dev mailing list
 Stephen> Linuxppc-dev@ozlabs.org
 Stephen> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Bye, Peter Korsgaard
