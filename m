Return-Path: <liuj97@gmail.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B3A42C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 00:39:28 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id p11so1416770pdj.40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 07:39:25 -0700 (PDT)
Message-ID: <51939E16.9090105@gmail.com>
Date: Wed, 15 May 2013 22:39:18 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2,
 part 1 3/9] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
 instead
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com>
 <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQVKKKmZRQ8CcKCzU8Gqzwb5SjWYagVB2OZiRqbSWXVpiw@mail.gmail.com>
 <5191F53E.4000305@cn.fujitsu.com> <51925136.5050302@gmail.com>
 <CAE9FiQWO-jR5y35kKiW0m6gVR54ZyRsBsdhP4BmFLSsDzCS3rA@mail.gmail.com>
 <51926CF6.1050706@gmail.com>
 <CAE9FiQWXN_ETRFPb5oFx-6LXyuHviX3h3NXCQKjcxtv2Uma-JA@mail.gmail.com>
In-Reply-To: <CAE9FiQWXN_ETRFPb5oFx-6LXyuHviX3h3NXCQKjcxtv2Uma-JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 Linux-Scsi <linux-scsi@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <jbottomley@parallels.com>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gu Zheng <guz.fnst@cn.fujitsu.com>, Paul Mackerras <paulus@samba.org>,
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

On Wed 15 May 2013 02:52:51 AM CST, Yinghai Lu wrote:
> On Tue, May 14, 2013 at 9:57 AM, Liu Jiang <liuj97@gmail.com> wrote:
>> On Tue 14 May 2013 11:10:33 PM CST, Yinghai Lu wrote:
>>>
>>> On Tue, May 14, 2013 at 7:59 AM, Liu Jiang <liuj97@gmail.com> wrote:
>>>>
>>>> On 05/14/2013 04:26 PM, Gu Zheng wrote:
>>>>       I suggest to use pci_release_dev() instead because it also needs to
>>>> release OF related resources.
>>>> I will update it in next version.
>>>>
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index bc075a3..2ac6338 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -1281,7 +1281,7 @@ static struct pci_dev *pci_scan_device(struct
>>>> pci_bus
>>>> *bus
>>>>           pci_set_of_node(dev);
>>>>
>>>>           if (pci_setup_device(dev)) {
>>>> -               kfree(dev);
>>>> +               pci_release_dev(&dev->dev);
>>>>                   return NULL;
>>>
>>>
>>> no, should move pci_set_of_node calling into pci_setup_device.
>>>
>>> Yinghai
>>
>>
>> I'm not sure whether we should call pci_set_of_node() for SR-IOV devices
>> too,
>> any suggestions here?
>
> or just move down pci_set_of_node after pci_setup_device?
>
> anyway that is another bug.
>
> Yinghai
I'm not familiar with the OF logic and can't make sure whether 
pci_setup_device()
has dependency on dev->of_node. Feel it's more safe to call 
pci_release_of_node()
on failing path instead of tuning call-site of pci_set_of_node().
