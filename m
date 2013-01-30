Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by ozlabs.org (Postfix) with ESMTP id 95C4B2C0111
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 19:09:35 +1100 (EST)
Date: Tue, 29 Jan 2013 23:54:37 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH v2 03/12] drivers/base: Add system device hotplug
 framework
Message-ID: <20130130045437.GG30002@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <1357861230-29549-4-git-send-email-toshi.kani@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357861230-29549-4-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com,
 linux-mm@kvack.org, yinghai@kernel.org, linux-kernel@vger.kernel.org,
 rjw@sisk.pl, linux-acpi@vger.kernel.org, isimatu.yasuaki@jp.fujitsu.com,
 srivatsa.bhat@linux.vnet.ibm.com, guohanjun@huawei.com, bhelgaas@google.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 10, 2013 at 04:40:21PM -0700, Toshi Kani wrote:
> Added sys_hotplug.c, which is the system device hotplug framework code.
> 
> shp_register_handler() allows modules to register their hotplug handlers
> to the framework.  shp_submit_req() provides the interface to submit
> a hotplug or online/offline request of system devices.  The request is
> then put into hp_workqueue.  shp_start_req() calls all registered handlers
> in ascending order for each phase.  If any handler failed in validate or
> execute phase, shp_start_req() initiates its rollback procedure.
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---
>  drivers/base/Makefile      |    1 
>  drivers/base/sys_hotplug.c |  313 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 314 insertions(+)
>  create mode 100644 drivers/base/sys_hotplug.c
> 
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 5aa2d70..2e9b2f1 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -21,6 +21,7 @@ endif
>  obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
>  obj-$(CONFIG_REGMAP)	+= regmap/
>  obj-$(CONFIG_SOC_BUS) += soc.o
> +obj-y			+= sys_hotplug.o

No option to select this for systems that don't need it?  If not, then
put it up higher with all of the other code for the core.

thanks,

greg k-h
