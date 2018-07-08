Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NwtM0lVKzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 03:48:25 +1000 (AEST)
Received: by mail-vk0-x242.google.com with SMTP id y9-v6so9290274vky.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jul 2018 10:48:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180708025946.GI3047@MiWiFi-R3L-srv>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Jul 2018 20:48:22 +0300
Message-ID: <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
To: Baoquan He <bhe@redhat.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>, Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>, Borislav Petkov <bp@suse.de>,
 brijesh.singh@amd.com,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org,
 richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>,
 Max Filippov <jcmvbkbc@gmail.com>, baiyaowei@cmss.chinamobile.com,
 Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 linux-input <linux-input@vger.kernel.org>,
 Gustavo Padovan <gustavo@padovan.org>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Sean Paul <seanpaul@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>,
 Jon Derrick <jonathan.derrick@intel.com>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
 devel@linuxdriverproject.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 8, 2018 at 5:59 AM, Baoquan He <bhe@redhat.com> wrote:
> On 07/05/18 at 01:00am, kbuild test robot wrote:

> However, I didn't find below branch. And tried to open it in web
> broswer, also failed.

While this is kinda valid point...

> Could you help have a look at this?

...isn't obvious that you didn't change the file mentioned in a report?
Just take latest linux-next and you will see.


>> All error/warnings (new ones prefixed by >>):
>>
>> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
>>      .child = &rc32434_res_pci_mem2
>>               ^
>>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
>> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem1 = {
>>                                                   ^
>>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
>>     static struct resource rc32434_res_pci_mem2 = {
>>                                                   ^
>>    cc1: some warnings being treated as errors
>>
>> vim +57 arch/mips/pci/pci-rc32434.c
>>
>> 73b4390f Ralf Baechle 2008-07-16  50
>> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
>> 73b4390f Ralf Baechle 2008-07-16  52          .name = "PCI MEM1",
>> 73b4390f Ralf Baechle 2008-07-16  53          .start = 0x50000000,
>> 73b4390f Ralf Baechle 2008-07-16  54          .end = 0x5FFFFFFF,
>> 73b4390f Ralf Baechle 2008-07-16  55          .flags = IORESOURCE_MEM,
>> 73b4390f Ralf Baechle 2008-07-16  56          .sibling = NULL,
>> 73b4390f Ralf Baechle 2008-07-16 @57          .child = &rc32434_res_pci_mem2
>> 73b4390f Ralf Baechle 2008-07-16  58  };
>> 73b4390f Ralf Baechle 2008-07-16  59
>>
>> :::::: The code at line 57 was first introduced by commit
>> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
>>
>> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
>> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>



-- 
With Best Regards,
Andy Shevchenko
