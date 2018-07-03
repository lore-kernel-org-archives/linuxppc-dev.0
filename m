Return-Path: <kernelfans@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kdzj4stMzF1RC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 19:26:41 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id q9-v6so1101238ioj.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
 <20180703075106.GA21136@wunner.de>
In-Reply-To: <20180703075106.GA21136@wunner.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 3 Jul 2018 17:26:27 +0800
Message-ID: <CAFgQCTt0M=+AQKXFXcOkxppjnDK9EAyNxHN=2F+n_NvyN=rQqg@mail.gmail.com>
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

On Tue, Jul 3, 2018 at 3:51 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Jul 03, 2018 at 02:50:40PM +0800, Pingfan Liu wrote:
> > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > places an assumption of supplier<-consumer order on the process of probe.
> > But it turns out to break down the parent <- child order in some scene.
> > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > have been probed. Then comes the bridge's module, which enables extra
> > feature(such as hotplug) on this bridge. This will break the
> > parent<-children order and cause failure when "kexec -e" in some scenario.
> >
> > The detailed description of the scenario:
> > An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> > match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> > to some issue. For this case, the bridge is moved after its children in
> > devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> > write back buffer in flight due to the former shutdown of the bridge which
> > clears the BusMaster bit.
>
> If you revert commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
> during shutdown"), does the issue go away?

Yes, it is gone.
