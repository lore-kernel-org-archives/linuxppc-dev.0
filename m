Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L5bS5Y0pzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 13:10:43 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id o5-v6so5928052itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 20:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
 <20180703075106.GA21136@wunner.de>
 <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
In-Reply-To: <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 4 Jul 2018 11:10:30 +0800
Message-ID: <CAFgQCTtY3=F5O6ibzS=7B1cDbzwn=OCnooHRP4HSEtoAO-eY6w@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown
 devices
To: lukas@wunner.de
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 3, 2018 at 5:26 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Tue, Jul 3, 2018 at 3:51 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Tue, Jul 03, 2018 at 02:50:40PM +0800, Pingfan Liu wrote:
> > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > places an assumption of supplier<-consumer order on the process of probe.
> > > But it turns out to break down the parent <- child order in some scene.
> > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > have been probed. Then comes the bridge's module, which enables extra
> > > feature(such as hotplug) on this bridge. This will break the
> > > parent<-children order and cause failure when "kexec -e" in some scenario.
> > >
> > > The detailed description of the scenario:
> > > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > > to some issue. For this case, the bridge is moved after its children in
> > > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > > write back buffer in flight due to the former shutdown of the bridge which
> > > clears the BusMaster bit.
> >
> > If you revert commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> > during shutdown"), does the issue go away?
>
> Yes, it is gone.

Have not figured out why the issue was gone. But I think it just cover
some fault.

re-fetch the boot log of mainline kernel without any patch, and filter
out the pci domain 0004
grep "devices_kset: Moving 0004:" newlog.txt
[    2.114986] devices_kset: Moving 0004:00:00.0 to end of list   <---
pcie port drive's probe, but it failed
[    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
[    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
[    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
[    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
[    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
[    3.181860] devices_kset: Moving 0004:03:00.0 to end of list  <---
the ata disk controller which sits behind the bridge
[   10.267081] devices_kset: Moving 0004:00:00.0 to end of list  <---
shpc_probe() on this bridge, failed too.

Hence we have the bridge (parent) after the child in devices_kset.

Thanks,
Pingfan
