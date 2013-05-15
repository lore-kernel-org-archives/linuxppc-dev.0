Return-Path: <liuj97@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C5022C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 09:47:10 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bg2so1953204pad.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 16:47:07 -0700 (PDT)
Message-ID: <51941E71.8010309@gmail.com>
Date: Thu, 16 May 2013 07:46:57 +0800
From: Liu Jiang <liuj97@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
 <51939E16.9090105@gmail.com>
 <CAE9FiQUXrOmN0rkvOwE1G_acEGY3-gouzaXjBMT7EE6uAqvuZA@mail.gmail.com>
 <51939FB1.20203@gmail.com> <1368653371.9603.18.camel@pasglop>
In-Reply-To: <1368653371.9603.18.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Neela Syam Kolli <megaraidlinux@lsi.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Toshi Kani <toshi.kani@hp.com>, Linux-Scsi <linux-scsi@vger.kernel.org>,
 Myron Stowe <myron.stowe@redhat.com>, David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "James E.J. Bottomley" <jbottomley@parallels.com>,
 "Rafael J . Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>, Paul Mackerras <paulus@samba.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gu Zheng <guz.fnst@cn.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>,
 Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jiang Liu <jiang.liu@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 16 May 2013 05:29:31 AM CST, Benjamin Herrenschmidt wrote:
> On Wed, 2013-05-15 at 22:46 +0800, Liu Jiang wrote:
>>         I don't know any OF exports, could you please help to CC
>> some OF experts?
>
> I wrote that code I think. Sorry, I've missed the beginning of the
> thread, what is the problem ?
>
> Cheers,
> Ben.
>
>
Hi,
     Just found a little memory leak issue that we should call 
pci_release_of_node()
on error recovery path in function pci_scan_device().
        pci_set_of_node(dev);

        if (pci_setup_device(dev)) {
                kfree(dev);
                return NULL;
        }

Regards!
Gerry
