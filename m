Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ia0-x22b.google.com (mail-ia0-x22b.google.com
 [IPv6:2607:f8b0:4001:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CA2B2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 03:23:33 +1000 (EST)
Received: by mail-ia0-f171.google.com with SMTP id r13so7865729iar.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 10:23:30 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com>
 <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
Date: Mon, 13 May 2013 10:23:29 -0700
Message-ID: <CAE9FiQVKKKmZRQ8CcKCzU8Gqzwb5SjWYagVB2OZiRqbSWXVpiw@mail.gmail.com>
Subject: Re: [PATCH v2, part 1 3/9] PCI: Convert alloc_pci_dev(void) to
 pci_alloc_dev(bus) instead
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Linux-Scsi <linux-scsi@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Gu Zheng <guz.fnst@cn.fujitsu.com>,
 Yijing Wang <wangyijing@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Myron Stowe <myron.stowe@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 9:08 AM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f0bc0a..bc075a3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1131,6 +1131,7 @@ static void pci_release_dev(struct device *dev)
>         struct pci_dev *pci_dev;
>
>         pci_dev = to_pci_dev(dev);
> +       pci_bus_put(pci_dev->bus);
>         pci_release_capabilities(pci_dev);
>         pci_release_of_node(pci_dev);
>         kfree(pci_dev);
> @@ -1269,11 +1270,10 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>         if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>                 return NULL;
>
> -       dev = alloc_pci_dev();
> +       dev = pci_alloc_dev(bus);
>         if (!dev)
>                 return NULL;
>
> -       dev->bus = bus;
>         dev->devfn = devfn;
>         dev->vendor = l & 0xffff;
>         dev->device = (l >> 16) & 0xffff;

in pci_setup_device() fail path, it release the ref to that bus.

Yinghai
