Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vmZl4ZKlzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:07:59 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id r37-v6so12207016qtc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 03:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180821061451.GB481@infradead.org>
In-Reply-To: <20180821061451.GB481@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 21 Aug 2018 12:07:40 +0200
Message-ID: <CAK8P3a1_VbhLteRiJe2WDk2FgcPFMLTXv_t5oi2zZ1ywh63cZg@mail.gmail.com>
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Aug 21, 2018 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> > Hi Bjorn and others,
> >
> > Triggered by Christoph's patches, I had another go at converting
> > all of the remaining pci host bridge implementations to be based
> > on pci_alloc_host_bridge and a separate registration function.
>
> I really like the idea behind this series.
>
> > I'm adding a bit of duplication into the less maintained code
> > here, but it makes everything more consistent, and gives an
> > easy place to hook up callback functions etc.
>
> I wonder if there is a way to avoid some of that by adding a few
> more helpers, but even without the helpers that approach looks
> ok to me.

Ok, thanks for taking a first look.

One core part that gets duplicated a lot (also in existing drivers)
is the chunk that could be handled by this:

int pci_host_bridge_init(struct pci_host_bridge *bridge,
                   struct device *parent, int bus,
                   struct pci_ops *ops, void *sysdata,
                   struct list_head *resource_list)
{
       if (resources)
              list_splice_init(resources, &bridge->windows);
       bridge->dev.parent = parent;
       bridge->sysdata = sysdata;
       bridge->busnr = bus;
       bridge->ops = ops;
}

That would probably help, but we should think carefully about
the set of fields that we want pass here, specifically because the
idea of splitting the probing into two parts was to avoid having
to come up with a new interface every time that list changes
due to some rework.

For instance, the numa node is something that might get passed
here, and if we decide to split out the operations into a separate
pci_host_bridge_ops structure, the pointer to that would also
be something we'd want to pass this way.

> Do you have a git tree somewhere to play around with the changes?

I now uploaded it (with fixes incorporated) to

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
pci-probe-rework

       arnd
