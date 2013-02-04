Return-Path: <toshi.kani@hp.com>
Received: from g4t0014.houston.hp.com (g4t0014.houston.hp.com [15.201.24.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD2DC2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 11:38:22 +1100 (EST)
Message-ID: <1359937689.23410.82.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Sun, 03 Feb 2013 17:28:09 -0700
In-Reply-To: <20130202150154.GC1434@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <20130130045830.GH30002@kroah.com>
 <1359601065.15120.156.camel@misato.fc.hp.com>
 <9860755.q4y3PrCFZx@vostro.rjw.lan>
 <1359682338.15120.209.camel@misato.fc.hp.com>
 <20130201073010.GC1180@kroah.com>
 <1359751210.15120.278.camel@misato.fc.hp.com>
 <20130202150154.GC1434@kroah.com>
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

On Sat, 2013-02-02 at 16:01 +0100, Greg KH wrote:
> On Fri, Feb 01, 2013 at 01:40:10PM -0700, Toshi Kani wrote:
> > On Fri, 2013-02-01 at 07:30 +0000, Greg KH wrote:
> > > On Thu, Jan 31, 2013 at 06:32:18PM -0700, Toshi Kani wrote:
> > >  > This is already done for PCI host bridges and platform devices and I don't
> > > > > see why we can't do that for the other types of devices too.
> > > > > 
> > > > > The only missing piece I see is a way to handle the "eject" problem, i.e.
> > > > > when we try do eject a device at the top of a subtree and need to tear down
> > > > > the entire subtree below it, but if that's going to lead to a system crash,
> > > > > for example, we want to cancel the eject.  It seems to me that we'll need some
> > > > > help from the driver core here.
> > > > 
> > > > There are three different approaches suggested for system device
> > > > hot-plug:
> > > >  A. Proceed within system device bus scan.
> > > >  B. Proceed within ACPI bus scan.
> > > >  C. Proceed with a sequence (as a mini-boot).
> > > > 
> > > > Option A uses system devices as tokens, option B uses acpi devices as
> > > > tokens, and option C uses resource tables as tokens, for their handlers.
> > > > 
> > > > Here is summary of key questions & answers so far.  I hope this
> > > > clarifies why I am suggesting option 3.
> > > > 
> > > > 1. What are the system devices?
> > > > System devices provide system-wide core computing resources, which are
> > > > essential to compose a computer system.  System devices are not
> > > > connected to any particular standard buses.
> > > 
> > > Not a problem, lots of devices are not connected to any "particular
> > > standard busses".  All this means is that system devices are connected
> > > to the "system" bus, nothing more.
> > 
> > Can you give me a few examples of other devices that support hotplug and
> > are not connected to any particular buses?  I will investigate them to
> > see how they are managed to support hotplug.
> 
> Any device that is attached to any bus in the driver model can be
> hotunplugged from userspace by telling it to be "unbound" from the
> driver controlling it.  Try it for any platform device in your system to
> see how it happens.

The unbind operation, as I understand from you, is to detach a driver
from a device.  Yes, unbinding can be done for any devices.  It is
however different from hot-plug operation, which unplugs a device.

Today, the unbind operation to an ACPI cpu/memory devices causes
hot-unplug (offline) operation to them, which is one of the major issues
for us since unbind cannot fail.  This patchset addresses this issue by
making the unbind operation of ACPI cpu/memory devices to do the
unbinding only.  ACPI drivers no longer control cpu and memory as they
are supposed to be controlled by their drivers, cpu and memory modules.
The current hotplug code requires putting all device control stuff into
ACPI, which this patchset is trying to fix it.


> > > > 2. Why are the system devices special?
> > > > The system devices are initialized during early boot-time, by multiple
> > > > subsystems, from the boot-up sequence, in pre-defined order.  They
> > > > provide low-level services to enable other subsystems to come up.
> > > 
> > > Sorry, no, that doesn't mean they are special, nothing here is unique
> > > for the point of view of the driver model from any other device or bus.
> > 
> > I think system devices are unique in a sense that they are initialized
> > before drivers run.
> 
> No, most all devices are "initialized" before a driver runs on it, USB
> is one such example, PCI another, and I'm pretty sure that there are
> others.

USB devices can be initialized after the USB bus driver is initialized.
Similarly, PCI devices can be initialized after the PCI bus driver is
initialized.  However, CPU and memory are initialized without any
dependency to their bus driver since there is no such thing.

In addition, CPU and memory have two drivers -- their actual
drivers/subsystems and their ACPI drivers.  Their actual
drivers/subsystems initialize cpu and memory.  The ACPI drivers
initialize driver-specific data of their ACPI nodes.  During hot-plug
operation, however, the current code requires these ACPI drivers to do
their hot-plug operations.  This patchset keeps them separated during
hot-plug and let their actual drivers/subsystems to do the job.


> > > If you need to initialize the driver
> > > core earlier, then do so.  Or, even better, just wait until enough of
> > > the system has come up and then go initialize all of the devices you
> > > have found so far as part of your boot process.
> > 
> > They are pseudo drivers that provide sysfs entry points of cpu and
> > memory.  They do not actually initialize cpu and memory.  I do not think
> > initializing cpu and memory fits into the driver model either, since
> > drivers should run after cpu and memory are initialized.
> 
> We already represent CPUs in the sysfs tree, don't represent them in two
> different places with two different structures.  Use the existing ones
> please.

This patchset does not make any changes to sysfs.  It does however make
the system drivers to control the system devices, and ACPI to do the
ACPI stuff only.

The boot sequence calls the following steps to initialize memory and
cpu, as well as their acpi nodes.  These steps are independent, i.e. #1
and #2 run without ACPI.

 1. mm -> initialize memory -> create sysfs system/memory
 2. smp/cpu -> initialize cpu -> create sysfs system/cpu
 3. acpi core -> acpi scan -> create sysfs acpi nodes

While there are 3 separate steps at boot, the current hotplug code tries
to do everything in #3.  Therefore, this patchset provides a sequencer
(which is similar to the boot sequence) to run these steps during a
hot-plug operation as well.  Hence, we have consistent steps and role
mode between boot and hot-plug operations.


> > > None of the above things you have stated seem to have anything to do
> > > with your proposed patch, so I don't understand why you have mentioned
> > > them...
> > 
> > You suggested option A before, which uses system bus scan to initialize
> > all system devices at boot time as well as hot-plug.  I tried to say
> > that this option would not be doable.
> 
> I haven't yet been convinced otherwise, sorry.  Please prove me wrong :)

This patchset enables the system drivers (i.e. cpu and memory drivers)
to do the hot-plug operations, and ACPI core to do the ACPI stuff.

We should not go with the system driver only approach since we do need
to use ACPI stuff.  Also, we should not go with the ACPI only approach
since we do need to use the system (and other) drivers.  This patchset
provides a sequencer to manage these steps across multiple subsystems.


Thanks,
-Toshi
