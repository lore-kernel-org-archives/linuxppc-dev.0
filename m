Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41P9Cf5T2dzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2018 13:04:13 +1000 (AEST)
Date: Mon, 9 Jul 2018 11:04:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Josh Triplett <josh@joshtriplett.org>,
 kbuild test robot <fengguang.wu@intel.com>,
 Borislav Petkov <bp@suse.de>, brijesh.singh@amd.com,
 devicetree <devicetree@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 richard.weiyang@gmail.com, Keith Busch <keith.busch@intel.com>,
 Max Filippov <jcmvbkbc@gmail.com>, baiyaowei@cmss.chinamobile.com,
 Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 linux-input <linux-input@vger.kernel.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Sean Paul <seanpaul@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>,
 Jon Derrick <jonathan.derrick@intel.com>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
 devel@linuxdriverproject.org,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 2/4] resource: Use list_head to link sibling resource
Message-ID: <20180709030403.GJ3047@MiWiFi-R3L-srv>
References: <20180704041038.8190-3-bhe@redhat.com>
 <201807042347.hfDcKxmG%fengguang.wu@intel.com>
 <20180708025946.GI3047@MiWiFi-R3L-srv>
 <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VcjGQutVtZ90C0huUGCY6yj8H0Wo0tMdrbLmLsRQ+x4XQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/18 at 08:48pm, Andy Shevchenko wrote:
> On Sun, Jul 8, 2018 at 5:59 AM, Baoquan He <bhe@redhat.com> wrote:
> > On 07/05/18 at 01:00am, kbuild test robot wrote:
> 
> > However, I didn't find below branch. And tried to open it in web
> > broswer, also failed.
> 
> While this is kinda valid point...
> 
> > Could you help have a look at this?
> 
> ...isn't obvious that you didn't change the file mentioned in a report?
> Just take latest linux-next and you will see.

Yes, it's clear to me. Just want to use the way to cross compile them on
ia64 and mips, hope I can find out all missed places on these ARCHes.
Now I think I can apply patches on linux-next, and use the config
attached to compile. Thanks.

> 
> 
> >> All error/warnings (new ones prefixed by >>):
> >>
> >> >> arch/mips/pci/pci-rc32434.c:57:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
> >>      .child = &rc32434_res_pci_mem2
> >>               ^
> >>    arch/mips/pci/pci-rc32434.c:57:11: note: (near initialization for 'rc32434_res_pci_mem1.child.next')
> >> >> arch/mips/pci/pci-rc32434.c:51:47: warning: missing braces around initializer [-Wmissing-braces]
> >>     static struct resource rc32434_res_pci_mem1 = {
> >>                                                   ^
> >>    arch/mips/pci/pci-rc32434.c:60:47: warning: missing braces around initializer [-Wmissing-braces]
> >>     static struct resource rc32434_res_pci_mem2 = {
> >>                                                   ^
> >>    cc1: some warnings being treated as errors
> >>
> >> vim +57 arch/mips/pci/pci-rc32434.c
> >>
> >> 73b4390f Ralf Baechle 2008-07-16  50
> >> 73b4390f Ralf Baechle 2008-07-16 @51  static struct resource rc32434_res_pci_mem1 = {
> >> 73b4390f Ralf Baechle 2008-07-16  52          .name = "PCI MEM1",
> >> 73b4390f Ralf Baechle 2008-07-16  53          .start = 0x50000000,
> >> 73b4390f Ralf Baechle 2008-07-16  54          .end = 0x5FFFFFFF,
> >> 73b4390f Ralf Baechle 2008-07-16  55          .flags = IORESOURCE_MEM,
> >> 73b4390f Ralf Baechle 2008-07-16  56          .sibling = NULL,
> >> 73b4390f Ralf Baechle 2008-07-16 @57          .child = &rc32434_res_pci_mem2
> >> 73b4390f Ralf Baechle 2008-07-16  58  };
> >> 73b4390f Ralf Baechle 2008-07-16  59
> >>
> >> :::::: The code at line 57 was first introduced by commit
> >> :::::: 73b4390fb23456964201abda79f1210fe337d01a [MIPS] Routerboard 532: Support for base system
> >>
> >> :::::: TO: Ralf Baechle <ralf@linux-mips.org>
> >> :::::: CC: Ralf Baechle <ralf@linux-mips.org>
> >>
> >> ---
> >> 0-DAY kernel test infrastructure                Open Source Technology Center
> >> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> >
> >
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
