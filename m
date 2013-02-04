Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by ozlabs.org (Postfix) with ESMTP id DAA472C0089
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 14:22:57 +1100 (EST)
Date: Sun, 3 Feb 2013 19:24:47 -0600
From: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH?] Move ACPI device nodes under /sys/firmware/acpi (was:
 Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework)
Message-ID: <20130204012447.GB6433@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <20130202145801.GB1434@kroah.com>
 <1810611.i6Sc4oLaux@vostro.rjw.lan>
 <2806030.VWUMy6F7lm@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2806030.VWUMy6F7lm@vostro.rjw.lan>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 02, 2013 at 11:18:20PM +0100, Rafael J. Wysocki wrote:
> On Saturday, February 02, 2013 09:15:37 PM Rafael J. Wysocki wrote:
> > On Saturday, February 02, 2013 03:58:01 PM Greg KH wrote:
> [...]
> > 
> > > I know it's more complicated with these types of devices, and I think we
> > > are getting closer to the correct solution, I just don't want to ever
> > > see duplicate devices in the driver model for the same physical device.
> > 
> > Do you mean two things based on struct device for the same hardware component?
> > That's been happening already pretty much forever for every PCI device known
> > to the ACPI layer, for PNP and many others.  However, those ACPI things are (or
> > rather should be, but we're going to clean that up) only for convenience (to be
> > able to see the namespace structure and related things in sysfs).  So the stuff
> > under /sys/devices/LNXSYSTM\:00/ is not "real".  In my view it shouldn't even
> > be under /sys/devices/ (/sys/firmware/acpi/ seems to be a better place for it),
> > but that may be difficult to change without breaking user space (maybe we can
> > just symlink it from /sys/devices/ or something).  And the ACPI bus type
> > shouldn't even exist in my opinion.
> 
> Well, well.
> 
> In fact, the appended patch moves the whole ACPI device nodes tree under
> /sys/firmware/acpi/ and I'm not seeing any negative consequences of that on my
> test box (events work and so on).  User space is quite new on it, though, and
> the patch is hackish.

Try booting a RHEL 5 image on this type of kernel, or some old Fedora
releases, they were sensitive to changes in sysfs.

greg k-h
