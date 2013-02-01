Return-Path: <toshi.kani@hp.com>
Received: from g4t0014.houston.hp.com (g4t0014.houston.hp.com [15.201.24.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42B482C029B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 07:50:21 +1100 (EST)
Message-ID: <1359751210.15120.278.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 01 Feb 2013 13:40:10 -0700
In-Reply-To: <20130201073010.GC1180@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <20130130045830.GH30002@kroah.com>
 <1359601065.15120.156.camel@misato.fc.hp.com>
 <9860755.q4y3PrCFZx@vostro.rjw.lan>
 <1359682338.15120.209.camel@misato.fc.hp.com>
 <20130201073010.GC1180@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "jiang.liu@huawei.com" <jiang.liu@huawei.com>,
 "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yinghai@kernel.org" <yinghai@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lenb@kernel.org" <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-02-01 at 07:30 +0000, Greg KH wrote:
> On Thu, Jan 31, 2013 at 06:32:18PM -0700, Toshi Kani wrote:
>  > This is already done for PCI host bridges and platform devices and I don't
> > > see why we can't do that for the other types of devices too.
> > > 
> > > The only missing piece I see is a way to handle the "eject" problem, i.e.
> > > when we try do eject a device at the top of a subtree and need to tear down
> > > the entire subtree below it, but if that's going to lead to a system crash,
> > > for example, we want to cancel the eject.  It seems to me that we'll need some
> > > help from the driver core here.
> > 
> > There are three different approaches suggested for system device
> > hot-plug:
> >  A. Proceed within system device bus scan.
> >  B. Proceed within ACPI bus scan.
> >  C. Proceed with a sequence (as a mini-boot).
> > 
> > Option A uses system devices as tokens, option B uses acpi devices as
> > tokens, and option C uses resource tables as tokens, for their handlers.
> > 
> > Here is summary of key questions & answers so far.  I hope this
> > clarifies why I am suggesting option 3.
> > 
> > 1. What are the system devices?
> > System devices provide system-wide core computing resources, which are
> > essential to compose a computer system.  System devices are not
> > connected to any particular standard buses.
> 
> Not a problem, lots of devices are not connected to any "particular
> standard busses".  All this means is that system devices are connected
> to the "system" bus, nothing more.

Can you give me a few examples of other devices that support hotplug and
are not connected to any particular buses?  I will investigate them to
see how they are managed to support hotplug.

> > 2. Why are the system devices special?
> > The system devices are initialized during early boot-time, by multiple
> > subsystems, from the boot-up sequence, in pre-defined order.  They
> > provide low-level services to enable other subsystems to come up.
> 
> Sorry, no, that doesn't mean they are special, nothing here is unique
> for the point of view of the driver model from any other device or bus.

I think system devices are unique in a sense that they are initialized
before drivers run.

> > 3. Why can't initialize the system devices from the driver structure at
> > boot?
> > The driver structure is initialized at the end of the boot sequence and
> > requires the low-level services from the system devices initialized
> > beforehand.
> 
> Wait, what "driver structure"?  

Sorry it was not clear.  cpu_dev_init() and memory_dev_init() are called
from driver_init() at the end of the boot sequence, and initialize
system/cpu and system/memory devices.  I assume they are the system bus
you are referring with option A.

> If you need to initialize the driver
> core earlier, then do so.  Or, even better, just wait until enough of
> the system has come up and then go initialize all of the devices you
> have found so far as part of your boot process.

They are pseudo drivers that provide sysfs entry points of cpu and
memory.  They do not actually initialize cpu and memory.  I do not think
initializing cpu and memory fits into the driver model either, since
drivers should run after cpu and memory are initialized.

> None of the above things you have stated seem to have anything to do
> with your proposed patch, so I don't understand why you have mentioned
> them...

You suggested option A before, which uses system bus scan to initialize
all system devices at boot time as well as hot-plug.  I tried to say
that this option would not be doable.

> > 4. Why do we need a new common framework?
> > Sysfs CPU and memory on-lining/off-lining are performed within the CPU
> > and memory modules.  They are common code and do not depend on ACPI.
> > Therefore, a new common framework is necessary to integrate both
> > on-lining/off-lining operation and hot-plugging operation of system
> > devices into a single framework.
> 
> {sigh}
> 
> Removing and adding devices and handling hotplug operations is what the
> driver core was written for, almost 10 years ago.  To somehow think that
> your devices are "special" just because they don't use ACPI is odd,
> because the driver core itself has nothing to do with ACPI.  Don't get
> the current mix of x86 system code tied into ACPI confused with an
> driver core issues here please.

CPU online/offline operation is performed within the CPU module.  Memory
online/offline operation is performed within the memory module.  CPU and
memory hotplug operations are performed within ACPI.  While they deal
with the same set of devices, they operate independently and are not
managed under a same framework.

I agree with you that not using ACPI is perfectly fine.  My point is
that ACPI framework won't be able to manage operations that do not use
ACPI.

> > 5. Why can't do everything with ACPI bus scan?
> > Software dependency among system devices may not be dictated by the ACPI
> > hierarchy.  For instance, memory should be initialized before CPUs (i.e.
> > a new cpu may need its local memory), but such ordering cannot be
> > guaranteed by the ACPI hierarchy.  Also, as described in 4,
> > online/offline operations are independent from ACPI.  
> 
> That's fine, the driver core is independant from ACPI.  I don't care how
> you do the scaning of your devices, but I do care about you creating new
> driver core pieces that duplicate the existing functionality of what we
> have today.
>
> In short, I like Rafael's proposal better, and I fail to see how
> anything you have stated here would matter in how this is implemented. :)

Doing everything within ACPI means we can only manage ACPI hotplug
operations, not online/offline operations.  But I understand that you
concern about adding a new framework with option C.  It is good to know
that you are fine with option B. :)  So, I will step back, and think
about what we can do within ACPI.

Thanks,
-Toshi
