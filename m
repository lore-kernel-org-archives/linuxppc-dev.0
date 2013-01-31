Return-Path: <toshi.kani@hp.com>
Received: from g1t0028.austin.hp.com (g1t0028.austin.hp.com [15.216.28.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78B442C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 12:59:01 +1100 (EST)
Message-ID: <1359596935.15120.110.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 03/12] drivers/base: Add system device hotplug
 framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 30 Jan 2013 18:48:55 -0700
In-Reply-To: <20130130045437.GG30002@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <1357861230-29549-4-git-send-email-toshi.kani@hp.com>
 <20130130045437.GG30002@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Tue, 2013-01-29 at 23:54 -0500, Greg KH wrote:
> On Thu, Jan 10, 2013 at 04:40:21PM -0700, Toshi Kani wrote:
> > Added sys_hotplug.c, which is the system device hotplug framework code.
> > 
> > shp_register_handler() allows modules to register their hotplug handlers
> > to the framework.  shp_submit_req() provides the interface to submit
> > a hotplug or online/offline request of system devices.  The request is
> > then put into hp_workqueue.  shp_start_req() calls all registered handlers
> > in ascending order for each phase.  If any handler failed in validate or
> > execute phase, shp_start_req() initiates its rollback procedure.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> > ---
> >  drivers/base/Makefile      |    1 
> >  drivers/base/sys_hotplug.c |  313 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 314 insertions(+)
> >  create mode 100644 drivers/base/sys_hotplug.c
> > 
> > diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> > index 5aa2d70..2e9b2f1 100644
> > --- a/drivers/base/Makefile
> > +++ b/drivers/base/Makefile
> > @@ -21,6 +21,7 @@ endif
> >  obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
> >  obj-$(CONFIG_REGMAP)	+= regmap/
> >  obj-$(CONFIG_SOC_BUS) += soc.o
> > +obj-y			+= sys_hotplug.o
> 
> No option to select this for systems that don't need it?  If not, then
> put it up higher with all of the other code for the core.

It used to have CONFIG_HOTPLUG, but I removed it as you suggested.  Yes,
I will put it up higher.  

Thanks,
-Toshi
