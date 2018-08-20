Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vBNF0q5GzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:26:52 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so25155978oie.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 04:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180817102645.3839621-9-arnd@arndb.de>
 <CAJZ5v0jjZx3xCbPK5vfx-OCRNtMt59WQOxCYkWNj33Js_2Xi=A@mail.gmail.com>
 <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
In-Reply-To: <CAK8P3a1KWn0=xwrqZ+sF27O-WE6paDxQPg6PPZFcgCrgXGaX2A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Aug 2018 13:26:39 +0200
Message-ID: <CAJZ5v0htQ0KZ8M1BpE7H7weRS89jJWPtA0xvgAUmN53jx5DSYg@mail.gmail.com>
Subject: Re: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2018 at 1:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 20, 2018 at 10:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 17, 2018 at 12:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > -static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
> > > -               struct pci_ops *ops, void *sysdata, struct list_head *resources)
> > > +void pcibios_scan_root(int busnum)
> > >  {
> > > +       struct pci_sysdata *sd;
> > >         struct pci_host_bridge *bridge;
> > >         int error;
> > >
> > > -       bridge = pci_alloc_host_bridge(0);
> > > -       if (!bridge)
> > > -               return NULL;
> > > +       bridge = pci_alloc_host_bridge(sizeof(sd));
> > > +       if (!bridge) {
> > > +               printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
> > > +               return;
> > > +       }
> > > +       sd = pci_host_bridge_priv(bridge);
> >
> > This looks fishy, as bridge->private is not set at this point AFAICS,
> > unless one of the previous patches changes that.
>
> bridge->private what comes after the bridge structure, and it's allocated
> by pci_alloc_host_bridge() passing the size of the structure we want
> for this private area.

I see, sorry for the noise.
