Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC79FDDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:34:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8IC8eKg008104
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:08:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8ICC6P2290522
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:12:06 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8ID8F3f030770
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 23:08:15 +1000
Message-ID: <46EFBF9E.6060208@linux.vnet.ibm.com>
Date: Tue, 18 Sep 2007 17:37:58 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-rc6-mm1
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<46EF96CC.1080807@linux.vnet.ibm.com>
	<20070918093444.GB973@shadowen.org>
	<1190109772.6403.79.camel@localhost.localdomain>
In-Reply-To: <1190109772.6403.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2007-09-18 at 10:34 +0100, Andy Whitcroft wrote:
>   
>> On Tue, Sep 18, 2007 at 02:43:48PM +0530, Kamalesh Babulal wrote:
>>     
>>> Andrew Morton wrote:
>>>       
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc6/2.6.23-rc6-mm1/
>>>>
>>>> 2.6.23-rc6-mm1 is a 29MB diff against 2.6.23-rc6.
>>>>
>>>>  
>>>>         
>>> <snip>
>>>
>>> Hi Andrew,
>>>
>>> The 2.6.23-rc6-mm1build fails at
>>>
>>>  CC      drivers/pci/hotplug/rpadlpar_core.o
>>>  CC      drivers/pci/hotplug/rpadlpar_sysfs.o
>>> drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `name' 
>>> specified in initializer
>>> drivers/pci/hotplug/rpadlpar_sysfs.c: In function `dlpar_sysfs_init':
>>> drivers/pci/hotplug/rpadlpar_sysfs.c:142: error: structure has no member 
>>> named `name'
>>> make[3]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
>>> make[2]: *** [drivers/pci/hotplug] Error 2
>>> make[1]: *** [drivers/pci] Error 2
>>> make: *** [drivers] Error 2
>>>       
>> This seems to be occuring across a number of the powerpc systems we test
>> with.  That driver is a power dynamic lpar IO partitioning driver.
>>
>> Relevant Cc: added.
>>     
>
> That's because somebody is breaking sysfs/kobject interfaces without
> fixing all users :-) (Fair enough... it's just that we need to make sure
> whoever takes care of that driver nowadays is aware of the breakage).
>
> Ben.
>   
Hi Andrew,

Using the kobject_set_name function to set the kobject k_name.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
--- linux-2.6.23-rc6/drivers/pci/hotplug/rpadlpar_sysfs.c       
2007-09-18 14:56:05.000000000 +0530
+++ linux-2.6.23-rc6/drivers/pci/hotplug/~rpadlpar_sysfs.c      
2007-09-18 16:51:55.000000000 +0530
@@ -129,17 +129,17 @@ struct kobj_type ktype_dlpar_io = {
 };
 
 struct kset dlpar_io_kset = {
-       .kobj = {.name = DLPAR_KOBJ_NAME,
-                .ktype = &ktype_dlpar_io,
-                .parent = &pci_hotplug_slots_subsys.kobj},
+        .kobj = {.ktype = &ktype_dlpar_io,
+                 .parent = &pci_hotplug_slots_subsys.kobj},
        .ktype = &ktype_dlpar_io,
 };
 
 int dlpar_sysfs_init(void)
 {
+       kobject_set_name(&dlpar_io_kset.kobj, DLPAR_KOBJ_NAME);
        if (kset_register(&dlpar_io_kset)) {
                printk(KERN_ERR "rpadlpar_io: cannot register kset for 
%s\n",
-                               dlpar_io_kset.kobj.name);
+                               dlpar_io_kset.kobj.k_name);
                return -EINVAL;
        }

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
