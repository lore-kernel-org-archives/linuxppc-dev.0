Return-Path: <toshi.kani@hp.com>
Received: from g5t0006.atlanta.hp.com (g5t0006.atlanta.hp.com [15.192.0.43])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5F722C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 03:56:29 +1100 (EST)
Message-ID: <1359996378.23410.130.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 04 Feb 2013 09:46:18 -0700
In-Reply-To: <20130204124612.GA22096@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <20130130045830.GH30002@kroah.com>
 <1359601065.15120.156.camel@misato.fc.hp.com>
 <9860755.q4y3PrCFZx@vostro.rjw.lan>
 <1359682338.15120.209.camel@misato.fc.hp.com>
 <20130201073010.GC1180@kroah.com>
 <1359751210.15120.278.camel@misato.fc.hp.com>
 <20130202150154.GC1434@kroah.com>
 <1359937689.23410.82.camel@misato.fc.hp.com>
 <20130204124612.GA22096@kroah.com>
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

On Mon, 2013-02-04 at 04:46 -0800, Greg KH wrote:
> On Sun, Feb 03, 2013 at 05:28:09PM -0700, Toshi Kani wrote:
> > On Sat, 2013-02-02 at 16:01 +0100, Greg KH wrote:
> > > On Fri, Feb 01, 2013 at 01:40:10PM -0700, Toshi Kani wrote:
> > > > On Fri, 2013-02-01 at 07:30 +0000, Greg KH wrote:
> > > > > On Thu, Jan 31, 2013 at 06:32:18PM -0700, Toshi Kani wrote:
> > > > >  > This is already done for PCI host bridges and platform devices and I don't
> > > > > > > see why we can't do that for the other types of devices too.
> > > > > > > 
> > > > > > > The only missing piece I see is a way to handle the "eject" problem, i.e.
> > > > > > > when we try do eject a device at the top of a subtree and need to tear down
> > > > > > > the entire subtree below it, but if that's going to lead to a system crash,
> > > > > > > for example, we want to cancel the eject.  It seems to me that we'll need some
> > > > > > > help from the driver core here.
> > > > > > 
> > > > > > There are three different approaches suggested for system device
> > > > > > hot-plug:
> > > > > >  A. Proceed within system device bus scan.
> > > > > >  B. Proceed within ACPI bus scan.
> > > > > >  C. Proceed with a sequence (as a mini-boot).
> > > > > > 
> > > > > > Option A uses system devices as tokens, option B uses acpi devices as
> > > > > > tokens, and option C uses resource tables as tokens, for their handlers.
> > > > > > 
> > > > > > Here is summary of key questions & answers so far.  I hope this
> > > > > > clarifies why I am suggesting option 3.
> > > > > > 
> > > > > > 1. What are the system devices?
> > > > > > System devices provide system-wide core computing resources, which are
> > > > > > essential to compose a computer system.  System devices are not
> > > > > > connected to any particular standard buses.
> > > > > 
> > > > > Not a problem, lots of devices are not connected to any "particular
> > > > > standard busses".  All this means is that system devices are connected
> > > > > to the "system" bus, nothing more.
> > > > 
> > > > Can you give me a few examples of other devices that support hotplug and
> > > > are not connected to any particular buses?  I will investigate them to
> > > > see how they are managed to support hotplug.
> > > 
> > > Any device that is attached to any bus in the driver model can be
> > > hotunplugged from userspace by telling it to be "unbound" from the
> > > driver controlling it.  Try it for any platform device in your system to
> > > see how it happens.
> > 
> > The unbind operation, as I understand from you, is to detach a driver
> > from a device.  Yes, unbinding can be done for any devices.  It is
> > however different from hot-plug operation, which unplugs a device.
> 
> Physically, yes, but to the driver involved, and the driver core, there
> is no difference.  That was one of the primary goals of the driver core
> creation so many years ago.
> 
> > Today, the unbind operation to an ACPI cpu/memory devices causes
> > hot-unplug (offline) operation to them, which is one of the major issues
> > for us since unbind cannot fail.  This patchset addresses this issue by
> > making the unbind operation of ACPI cpu/memory devices to do the
> > unbinding only.  ACPI drivers no longer control cpu and memory as they
> > are supposed to be controlled by their drivers, cpu and memory modules.
> 
> I think that's the problem right there, solve that, please.

We cannot eliminate the ACPI drivers since we have to scan ACPI.  But we
can limit the ACPI drivers to do the scanning stuff only.   This is
precisely the intend of this patchset.  The real stuff, removing actual
devices, is done by the system device drivers/modules.


> > > > > > 2. Why are the system devices special?
> > > > > > The system devices are initialized during early boot-time, by multiple
> > > > > > subsystems, from the boot-up sequence, in pre-defined order.  They
> > > > > > provide low-level services to enable other subsystems to come up.
> > > > > 
> > > > > Sorry, no, that doesn't mean they are special, nothing here is unique
> > > > > for the point of view of the driver model from any other device or bus.
> > > > 
> > > > I think system devices are unique in a sense that they are initialized
> > > > before drivers run.
> > > 
> > > No, most all devices are "initialized" before a driver runs on it, USB
> > > is one such example, PCI another, and I'm pretty sure that there are
> > > others.
> > 
> > USB devices can be initialized after the USB bus driver is initialized.
> > Similarly, PCI devices can be initialized after the PCI bus driver is
> > initialized.  However, CPU and memory are initialized without any
> > dependency to their bus driver since there is no such thing.
> 
> You can create such a thing if you want :)

Well, a pseudo driver could be created for it, but it does not make any
difference.  Access to CPU and memory does not go thru any bus
controller visible to the OS.  CPU and memory are connected with links
(which are up at begging) and do not have bus structure any more.


> > In addition, CPU and memory have two drivers -- their actual
> > drivers/subsystems and their ACPI drivers.
> 
> Again, I feel that is the root of the problem.  Rafael seems to be
> working on solving this, which I think is essencial to your work as
> well.

Yes, Rafael is doing excellent work to turn ACPI drivers into ACPI
"scan" drivers, removing device driver portion, and keeping them as
attach / detach operation to ACPI device object.  My patchset is very
much aligned with this direction. :)


Thanks,
-Toshi
