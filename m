Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KmqC3MWzzF1MY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 00:34:46 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pingfan Liu <kernelfans@gmail.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of
 devices_kset_move_last()
Date: Tue, 03 Jul 2018 16:26:40 +0200
Message-ID: <3375966.ydPZj5TMVj@aspire.rjw.lan>
In-Reply-To: <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> correct device's shutdown order"). So later we can revert it safely.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 684b994..db3deb8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  {
>  	struct device_link *link;
>  
> -	/*
> -	 * Devices that have not been registered yet will be put to the ends
> -	 * of the lists during the registration, so skip them here.
> -	 */
> -	if (device_is_registered(dev))
> -		devices_kset_move_last(dev);
> -
>  	if (device_pm_initialized(dev))
>  		device_pm_move_last(dev);

You can't do this.

If you do it, that will break power management in some situations.

Thanks,
Rafael
