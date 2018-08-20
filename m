Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vBbV585nzF1R0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 21:36:38 +1000 (AEST)
Received: by mail-qk0-f195.google.com with SMTP id d131-v6so511389qke.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 04:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180817102645.3839621-8-arnd@arndb.de>
 <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
 <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com>
 <CAJZ5v0gu_agFQBS7UjTMY3FR7woPPN-riJ6frwk1QoetGoVjfA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gu_agFQBS7UjTMY3FR7woPPN-riJ6frwk1QoetGoVjfA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Aug 2018 13:36:19 +0200
Message-ID: <CAK8P3a2nHxGTo9ajAweQpoutLhUns8SK0c6NWf4nV=PZhf0j_A@mail.gmail.com>
Subject: Re: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
To: Rafael Wysocki <rafael@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

On Mon, Aug 20, 2018 at 1:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Aug 20, 2018 at 1:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Aug 20, 2018 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Fri, Aug 17, 2018 at 12:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > @@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> > > >         int ret, busnum = root->secondary.start;
> > > >         struct acpi_device *device = root->device;
> > > >         int node = acpi_get_node(device->handle);
> > > > -       struct pci_bus *bus;
> > > > -       struct pci_host_bridge *host_bridge;
> > > > +       struct pci_host_bridge *bridge;
> > >
> > > Why "bridge" and not "host" or even something to stand for "root complex"?
> > >
> > > Or maybe it can still be "host_bridge"?
> >
> > I did this for consistency with the naming in drivers/pci/probe.c,
> > which always declares the local variable as 'struct pci_host_bridge *bridge'.
> > It's easy to change here if you feel strongly about it (I don't).
>
> I would leave host_bridge here.  It would make the patch smaller too I think.

Ok, I've changed my local copy as you suggested now.

      Arnd
