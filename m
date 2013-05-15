Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE64A2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 07:32:53 +1000 (EST)
Message-ID: <1368653557.9603.21.camel@pasglop>
Subject: Re: [PATCH v2, part 1 3/9] PCI: Convert alloc_pci_dev(void) to
 pci_alloc_dev(bus) instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 16 May 2013 07:32:37 +1000
In-Reply-To: <CAE9FiQVCSm14S0A1sVWewc7UX-dyOmu9aq1UwqdPZK6qSmbFxQ@mail.gmail.com>
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com>
 <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQVKKKmZRQ8CcKCzU8Gqzwb5SjWYagVB2OZiRqbSWXVpiw@mail.gmail.com>
 <5191F53E.4000305@cn.fujitsu.com> <51925136.5050302@gmail.com>
 <CAE9FiQWO-jR5y35kKiW0m6gVR54ZyRsBsdhP4BmFLSsDzCS3rA@mail.gmail.com>
 <51926CF6.1050706@gmail.com>
 <CAE9FiQWXN_ETRFPb5oFx-6LXyuHviX3h3NXCQKjcxtv2Uma-JA@mail.gmail.com>
 <51939E16.9090105@gmail.com>
 <CAE9FiQUXrOmN0rkvOwE1G_acEGY3-gouzaXjBMT7EE6uAqvuZA@mail.gmail.com>
 <51939FB1.20203@gmail.com>
 <CAE9FiQVCSm14S0A1sVWewc7UX-dyOmu9aq1UwqdPZK6qSmbFxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, Myron Stowe <myron.stowe@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Gu Zheng <guz.fnst@cn.fujitsu.com>,
 Paul Mackerras <paulus@samba.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Liu Jiang <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-15 at 07:58 -0700, Yinghai Lu wrote:

> Ben,
> 
> in drivers/pci/probe.c::pci_scan_device() there is
> 
>         pci_set_of_node(dev);
> 
>         if (pci_setup_device(dev)) {
>                 kfree(dev);
>                 return NULL;
>         }
> 
> so if pci_setup_device fails, there is one dev reference is not release.
> 
> please check you can just move down pci_set_of_node down after that
> failing path, like
> 
> 
>         if (pci_setup_device(dev)) {
>                 kfree(dev);
>                 return NULL;
>         }
> 
>         pci_set_of_node(dev);

No, we want the OF node set when we run the quirks, we intentionally do
that early, the right thing to do is to to call pci_release_of_node()
in the error path (it's safe to call even if the node is NULL).

Cheers,
Ben.
