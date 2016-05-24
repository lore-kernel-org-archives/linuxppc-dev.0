Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDXtd00YPzDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:17:12 +1000 (AEST)
Message-ID: <1464088614.3078.79.camel@kernel.crashing.org>
Subject: Re: PAGE_GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org,
 darren@stevens-zone.net
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman
 <michaele@au1.ibm.com>
Date: Tue, 24 May 2016 21:16:54 +1000
In-Reply-To: <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-24 at 12:48 +0200, Christian Zigotzky wrote:
> Ben,
> 
> Thanks for the hint. I'm sorry I don't know how pgprot_noncached()
> works.
> 
> I tried:
> 
> 1) range.size, pgprot_noncached()
> 
> 2) range.size, pgprot_val(pgprot_noncached(__pgprot(0))));

Hrm... The above is what is used elsewhere, I'm not sure what's wrong.

Aneesh, any idea ?

Michael, does it work on our PA-Semi board ? (DO we have that
southbridge on it ?)

Actually, can you try pgprot_noncached(PAGE_KERNEL) ? If that works,
then I wonder what that's going on in pci_64.c ...

Cheers,
Ben.

> 3) range.size, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
> 
> Unfortunately without any success.
> 
> I'd like to modify the following code for the ATi SB600 southbridge
> chipset:
> 
> /* Workaround for lack of device tree */
>                         if (primary) {
>                                 __ioremap_at(range.cpu_addr, (void 
> *)ISA_IO_BASE,
>                                 range.size,
> _PAGE_NO_CACHE|_PAGE_GUARDED);
>                                 hose->io_base_virt = (void
> *)_IO_BASE;
>                                 printk("Initialised io_base_virt
> 0x%lx 
> _IO_BASE 0x%llx\n", (unsigned long)hose->io_base_virt, (unsigned
> long 
> long)_IO_BASE);
>                      }
> 
> This workaround works with the kernel 4.6 final. After the commit 
> powerpc-4.7-1, the computer doesn't boot anymore.
> 
> Last message in the CFE firmware:
> 
> Booting Linux via __start()...
> 
> Cheers,
> 
> Christian
> 
> 
> On 23 May 2016 at 10:01 AM, Benjamin Herrenschmidt wrote:
> > 
> > On Mon, 2016-05-23 at 06:38 +0200, Christian Zigotzky wrote:
> > > 
> > > Hi All,
> > > 
> > > You removed PAGE_GUARDED in the commit
> > > 
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/c
> > > ommi
> > > t/?id=c04a5880299eab3da8c10547db96ea9cdffd44a6
> > > 
> > > We use
> > > 
> > > range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);
> > > 
> > > This doesn't work anymore. What can we use instead?
> > You should just use pgprot_noncached()
> > 
> > Cheers,
> > Ben.
> > 
> > 
