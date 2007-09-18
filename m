Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91896DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 05:13:20 +1000 (EST)
Date: Tue, 18 Sep 2007 12:16:30 -0700
From: Greg KH <greg@kroah.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.23-rc6-mm1
Message-ID: <20070918191630.GB11083@kroah.com>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<46EF96CC.1080807@linux.vnet.ibm.com>
	<20070918093444.GB973@shadowen.org>
	<1190109772.6403.79.camel@localhost.localdomain>
	<46EFBF9E.6060208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46EFBF9E.6060208@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 05:37:58PM +0530, Kamalesh Babulal wrote:
> Benjamin Herrenschmidt wrote:
>> On Tue, 2007-09-18 at 10:34 +0100, Andy Whitcroft wrote:
>>   
>>> On Tue, Sep 18, 2007 at 02:43:48PM +0530, Kamalesh Babulal wrote:
>>>     
>>>> Andrew Morton wrote:
>>>>       
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.23-rc6/2.6.23-rc6-mm1/
>>>>>
>>>>> 2.6.23-rc6-mm1 is a 29MB diff against 2.6.23-rc6.
>>>>>
>>>>>          
>>>> <snip>
>>>>
>>>> Hi Andrew,
>>>>
>>>> The 2.6.23-rc6-mm1build fails at
>>>>
>>>>  CC      drivers/pci/hotplug/rpadlpar_core.o
>>>>  CC      drivers/pci/hotplug/rpadlpar_sysfs.o
>>>> drivers/pci/hotplug/rpadlpar_sysfs.c:132: error: unknown field `name' 
>>>> specified in initializer
>>>> drivers/pci/hotplug/rpadlpar_sysfs.c: In function `dlpar_sysfs_init':
>>>> drivers/pci/hotplug/rpadlpar_sysfs.c:142: error: structure has no member 
>>>> named `name'
>>>> make[3]: *** [drivers/pci/hotplug/rpadlpar_sysfs.o] Error 1
>>>> make[2]: *** [drivers/pci/hotplug] Error 2
>>>> make[1]: *** [drivers/pci] Error 2
>>>> make: *** [drivers] Error 2
>>>>       
>>> This seems to be occuring across a number of the powerpc systems we test
>>> with.  That driver is a power dynamic lpar IO partitioning driver.
>>>
>>> Relevant Cc: added.
>>>     
>>
>> That's because somebody is breaking sysfs/kobject interfaces without
>> fixing all users :-) (Fair enough... it's just that we need to make sure
>> whoever takes care of that driver nowadays is aware of the breakage).
>>
>> Ben.
>>   
> Hi Andrew,
>
> Using the kobject_set_name function to set the kobject k_name.

Close, you should also use the kobject_name() function when referencing
it.

I'll fix this up in the patch, thanks.

Oh, and sorry for breaking this, I could only test all of the modules
build on x86 due to traveling while creating this patch.  I need to set
up some cross-compilers on my laptop to fix this issue :(

thanks,

greg k-h
