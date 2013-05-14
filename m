Return-Path: <liuj97@gmail.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B1152C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 00:59:12 +1000 (EST)
Received: by mail-pd0-f172.google.com with SMTP id 6so503319pdd.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 07:59:11 -0700 (PDT)
Message-ID: <51925136.5050302@gmail.com>
Date: Tue, 14 May 2013 22:59:02 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2,
 part 1 3/9] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
 instead
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com>
 <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQVKKKmZRQ8CcKCzU8Gqzwb5SjWYagVB2OZiRqbSWXVpiw@mail.gmail.com>
 <5191F53E.4000305@cn.fujitsu.com>
In-Reply-To: <5191F53E.4000305@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Linux-Scsi <linux-scsi@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Myron Stowe <myron.stowe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Yijing Wang <wangyijing@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2013 04:26 PM, Gu Zheng wrote:
> On 05/14/2013 01:23 AM, Yinghai Lu wrote:
>
>> On Mon, May 13, 2013 at 9:08 AM, Jiang Liu <liuj97@gmail.com> wrote:
>>> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 4f0bc0a..bc075a3 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1131,6 +1131,7 @@ static void pci_release_dev(struct device *dev)
>>>          struct pci_dev *pci_dev;
>>>
>>>          pci_dev = to_pci_dev(dev);
>>> +       pci_bus_put(pci_dev->bus);
>>>          pci_release_capabilities(pci_dev);
>>>          pci_release_of_node(pci_dev);
>>>          kfree(pci_dev);
>>> @@ -1269,11 +1270,10 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>>>          if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>>>                  return NULL;
>>>
>>> -       dev = alloc_pci_dev();
>>> +       dev = pci_alloc_dev(bus);
>>>          if (!dev)
>>>                  return NULL;
>>>
>>> -       dev->bus = bus;
>>>          dev->devfn = devfn;
>>>          dev->vendor = l & 0xffff;
>>>          dev->device = (l >> 16) & 0xffff;
>> in pci_setup_device() fail path, it release the ref to that bus.
> Yes, you're right, we need to release the bus' ref if pci_setup_device() failed.
Hi Zheng,
     I suggest to use pci_release_dev() instead because it also needs to 
release OF related resources.
I will update it in next version.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bc075a3..2ac6338 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1281,7 +1281,7 @@ static struct pci_dev *pci_scan_device(struct 
pci_bus *bus
         pci_set_of_node(dev);

         if (pci_setup_device(dev)) {
-               kfree(dev);
+               pci_release_dev(&dev->dev);
                 return NULL;
         }


> hanks for your correction.:)
>
> Best regards,
> Gu
>
>> Yinghai
>>
>
