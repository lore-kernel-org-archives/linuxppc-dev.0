Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x231.google.com (mail-ie0-x231.google.com
 [IPv6:2607:f8b0:4001:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA40D2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 07:52:27 +1000 (EST)
Received: by mail-ie0-f177.google.com with SMTP id 9so4893456iec.22
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 14:52:24 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1368653557.9603.21.camel@pasglop>
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
 <1368653557.9603.21.camel@pasglop>
Date: Wed, 15 May 2013 14:52:23 -0700
Message-ID: <CAE9FiQUrzCR4=9_=QyZipQZ584ucSpin6BOYD7t-9Y9Gq8tLFg@mail.gmail.com>
Subject: Re: [PATCH v2, part 1 3/9] PCI: Convert alloc_pci_dev(void) to
 pci_alloc_dev(bus) instead
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, May 15, 2013 at 2:32 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2013-05-15 at 07:58 -0700, Yinghai Lu wrote:
>
>> Ben,
>>
>> in drivers/pci/probe.c::pci_scan_device() there is
>>
>>         pci_set_of_node(dev);
>>
>>         if (pci_setup_device(dev)) {
>>                 kfree(dev);
>>                 return NULL;
>>         }
>>
>> so if pci_setup_device fails, there is one dev reference is not release.
>>
>> please check you can just move down pci_set_of_node down after that
>> failing path, like
>>
>>
>>         if (pci_setup_device(dev)) {
>>                 kfree(dev);
>>                 return NULL;
>>         }
>>
>>         pci_set_of_node(dev);
>
> No, we want the OF node set when we run the quirks, we intentionally do
> that early, the right thing to do is to to call pci_release_of_node()
> in the error path (it's safe to call even if the node is NULL).
>

Good.

We have two options.
1. can you please submit one complete patch, and get it merged into v3.10.
2. put it together with pci_alloc_dev patchset towards to v3.11?

Thanks

Yinghai
