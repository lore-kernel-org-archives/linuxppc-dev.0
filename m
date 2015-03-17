Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96D871A020A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 01:27:32 +1100 (AEDT)
Message-ID: <1426601130.18247.238.camel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v6 07/30] PCI: Pass PCI domain number
 combined with root bus number
From: Ian Campbell <ian.campbell@citrix.com>
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Date: Tue, 17 Mar 2015 14:05:30 +0000
In-Reply-To: <5507B88D.1020300@caviumnetworks.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
 <1425868467-9667-8-git-send-email-wangyijing@huawei.com>
 <5507B88D.1020300@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
 Yijing Wang <wangyijing@huawei.com>, Chris Metcalf <cmetcalf@ezchip.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, xen-devel@lists.xenproject.org,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Rusty Russell <rusty@rustcorp.com.au>, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yinghai Lu <yinghai@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Liviu Dudau <liviu@dudau.co.uk>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Jiang Liu <jiang.liu@linux.intel.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-17 at 10:45 +0530, Manish Jaggi wrote:
> On Monday 09 March 2015 08:04 AM, Yijing Wang wrote:
> > Now we could pass PCI domain combined with bus number
> > in u32 argu. Because in arm/arm64, PCI domain number
> > is assigned by pci_bus_assign_domain_nr(). So we leave
> > pci_scan_root_bus() and pci_create_root_bus() in arm/arm64
> > unchanged. A new function pci_host_assign_domain_nr()
> > will be introduced for arm/arm64 to assign domain number
> > in later patch.
> Hi,
> I think these changes might not be required. We have made very few 
> changes in the xen-pcifront to support PCI passthrough in arm64.
> As per xen architecture for a domU only a single pci virtual bus is 
> created and all passthrough devices are attached to it.

I guess you are only talking about the changes to xen-pcifront.c?
Otherwise you are ignoring the dom0 case which is exposed to the real
set of PCI root complexes and anyway I'm not sure how "not needed for
Xen domU" translates into not required, since it is clearly required for
other systems.

Strictly speaking the Xen pciif protocol does support multiple buses,
it's just that the tools, and perhaps kernels, have not yet felt any
need to actually make use of that.

There doesn't seem to be any harm in updating pcifront to follow this
generic API change.

Ian.
