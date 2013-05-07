Return-Path: <andrew.murray@arm.com>
Date: Tue, 7 May 2013 09:01:42 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
Message-ID: <20130507080142.GA8808@arm.com>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
 <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
 <1367721709.11982.37.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1367721709.11982.37.camel@pasglop>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, "juhosg@openwrt.org" <juhosg@openwrt.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
 "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 Rob Herring <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 05, 2013 at 03:41:49AM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-22 at 11:41 +0100, Andrew Murray wrote:
> > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> > property of a PCI host device, is found in both Microblaze and PowerPC
> > architectures. These implementations are nearly identical. This patch
> > moves this common code to a common place.
> 
> What's happening with this ? I'd like to avoid that patch for now
> as I'm doing some changes to pci_process_bridge_OF_ranges
> which are fairly urgent (I might even stick them in the current
> merge window) to deal with memory windows having separate offsets.

There were no objections to this latest revision until now and it is
currently sitting with Jason Cooper (mvebu-next/pcie). [1]

> 
> There's also a few hacks in there that are really ppc specific...
> 
> I think the right long term approach is to change the way powerpc
> (and microblaze ?) initializes PCI host bridges. Move it away from
> setup_arch() (which is a PITA anyway since it's way too early) to
> an early init call of some sort, and encapsulate the new struct
> pci_host_bridge.
> 
> We can then directly configure the host bridge windows rather
> than having this "intermediary" set of resources in our pci_controller
> and in fact move most of the fields from pci_controller to
> pci_host_bridge to the point where the former can remain as a
> simple platform specific wrapper if needed.

This is a view that was also shared by Bjorn [2] when I attempted to
submit a patchset which moves struct pci_controller to asm-generic.

> 
> So for new stuff (hint: DT based ARM PCI) or stuff that has to deal with
> a lot less archaic platforms (hint: Microblaze), I'd recommend going
> straight for that approach rather than perpetuating the PowerPC code
> which I'll try to deal with in the next few monthes.

The motativation for my patchsets were to give a way for ARM PCI host
bridge drivers to parse the DT ranges property, but this snow-balled into
unifying pci_process_bridge_OF_ranges.

My v8 patchset provides a of_pci_range_parser which is used directly by a
few ARM PCI DT host bridge drivers, this has been generally accepted and
tested. I don't see why this can't remain and so I'd really like to keep this
around. 

Grant, Benjamin would you be happy for me to resubmit this series which provides
the of_pci_range_parser which will be used by the separate implementations of
pci_process_bridge_OF_ranges in PowerPC/Microblaze?

Benjamin are you able to still use of_pci_range_parser in your
'Support per-aperture memory offset' patch?

Thanks,

Andrew Murray

[1] https://lkml.org/lkml/2013/4/22/505
[2] https://patchwork.kernel.org/patch/2487671

> 
> Cheers,
> Ben.
>  
> 
> 
