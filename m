Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2BA0DDE29
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 02:58:35 +1000 (EST)
Date: Tue, 18 Sep 2007 09:53:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.23-rc6-mm1
Message-Id: <20070918095323.bae6c278.akpm@linux-foundation.org>
In-Reply-To: <46EFBF9E.6060208@linux.vnet.ibm.com>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<46EF96CC.1080807@linux.vnet.ibm.com>
	<20070918093444.GB973@shadowen.org>
	<1190109772.6403.79.camel@localhost.localdomain>
	<46EFBF9E.6060208@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Sep 2007 17:37:58 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> Benjamin Herrenschmidt wrote:
> > On Tue, 2007-09-18 at 10:34 +0100, Andy Whitcroft wrote:
> >   
> >> On Tue, Sep 18, 2007 at 02:43:48PM +0530, Kamalesh Babulal wrote:
> >>     
> >>> Andrew Morton wrote:
> >>>       
> >>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc6/2.6.23-rc6-mm1/
> >>>>
> >>>> 2.6.23-rc6-mm1 is a 29MB diff against 2.6.23-rc6.
> >>>>
> >>>>  
> >>>>         
> >>> <snip>
> >>>
> >>> Hi Andrew,
> >>>
> >>> The 2.6.23-rc6-mm1build fails at
> >>>
> >>>  CC      drivers/pci/hotplug/rpadlpar_core.o
> >>>  CC      drivers/pci/hotplug/rpadlpar_sysfs.o
> >>> drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `name' 
> >>> specified in initializer
> >>> drivers/pci/hotplug/rpadlpar_sysfs.c: In function `dlpar_sysfs_init':
> >>> drivers/pci/hotplug/rpadlpar_sysfs.c:142: error: structure has no member 
> >>> named `name'
> >>> make[3]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
> >>> make[2]: *** [drivers/pci/hotplug] Error 2
> >>> make[1]: *** [drivers/pci] Error 2
> >>> make: *** [drivers] Error 2
> >>>       
> >> This seems to be occuring across a number of the powerpc systems we test
> >> with.  That driver is a power dynamic lpar IO partitioning driver.
> >>
> >> Relevant Cc: added.
> >>     
> >
> > That's because somebody is breaking sysfs/kobject interfaces without
> > fixing all users :-) (Fair enough... it's just that we need to make sure
> > whoever takes care of that driver nowadays is aware of the breakage).
> >
> > Ben.
> >   
> Hi Andrew,
> 
> Using the kobject_set_name function to set the kobject k_name.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
> --- linux-2.6.23-rc6/drivers/pci/hotplug/rpadlpar_sysfs.c       
> 2007-09-18 14:56:05.000000000 +0530
> +++ linux-2.6.23-rc6/drivers/pci/hotplug/~rpadlpar_sysfs.c      
> 2007-09-18 16:51:55.000000000 +0530
> @@ -129,17 +129,17 @@ struct kobj_type ktype_dlpar_io = {
>  };
>  
>  struct kset dlpar_io_kset = {
> -       .kobj = {.name = DLPAR_KOBJ_NAME,
> -                .ktype = &ktype_dlpar_io,
> -                .parent = &pci_hotplug_slots_subsys.kobj},
> +        .kobj = {.ktype = &ktype_dlpar_io,
> +                 .parent = &pci_hotplug_slots_subsys.kobj},
>         .ktype = &ktype_dlpar_io,
>  };
>  
>  int dlpar_sysfs_init(void)
>  {
> +       kobject_set_name(&dlpar_io_kset.kobj, DLPAR_KOBJ_NAME);
>         if (kset_register(&dlpar_io_kset)) {
>                 printk(KERN_ERR "rpadlpar_io: cannot register kset for 
> %s\n",
> -                               dlpar_io_kset.kobj.name);
> +                               dlpar_io_kset.kobj.k_name);
>                 return -EINVAL;
>         }
> 

Thanks.

Your email client replaces tabs with spaces, and is performing wordwrapping.
