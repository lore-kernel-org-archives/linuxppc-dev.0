Return-Path: <liuj97@gmail.com>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8033A2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 02:16:54 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id md4so3448736pbc.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jun 2013 09:16:51 -0700 (PDT)
Message-ID: <51B0B5EB.2070807@gmail.com>
Date: Fri, 07 Jun 2013 00:16:43 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3,
 part1 03/10] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus)
 instead
References: <1369489718-25869-1-git-send-email-jiang.liu@huawei.com>
 <1369489718-25869-4-git-send-email-jiang.liu@huawei.com>
 <CAErSpo6C-QMFCbMMivBE5TN4sEOFR_EyPmtN=OUNo8eN-+t=GQ@mail.gmail.com>
In-Reply-To: <CAErSpo6C-QMFCbMMivBE5TN4sEOFR_EyPmtN=OUNo8eN-+t=GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>, sparclinux@vger.kernel.org,
 Toshi Kani <toshi.kani@hp.com>, Jiang Liu <jiang.liu@huawei.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Myron Stowe <myron.stowe@redhat.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <jbottomley@parallels.com>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Yijing Wang <wangyijing@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gu Zheng <guz.fnst@cn.fujitsu.com>, Paul Mackerras <paulus@samba.org>,
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

On Thu 06 Jun 2013 04:07:18 AM CST, Bjorn Helgaas wrote:
> On Sat, May 25, 2013 at 7:48 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
>>
>> Use the new pci_alloc_dev(bus) to replace the existing using of
>> alloc_pci_dev(void).
>> ...
>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 26df9c8..d5d18a0 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1130,6 +1130,7 @@ static void pci_release_dev(struct device *dev)
>>         struct pci_dev *pci_dev;
>>
>>         pci_dev = to_pci_dev(dev);
>> +       pci_bus_put(pci_dev->bus);
>>         pci_release_capabilities(pci_dev);
>>         pci_release_of_node(pci_dev);
>>         kfree(pci_dev);
>
> I think we should drop the pci_bus reference *last* (before the
> kfree).  Otherwise, we have to audit pci_release_capabilities() and
> pci_release_of_node() to make sure they don't use pci_dev->bus.
>
> I made this change on my branch already; just let me know if you object.
Hi Bjorn,
       You are right, thanks for fixing it.

>
> Bjorn
