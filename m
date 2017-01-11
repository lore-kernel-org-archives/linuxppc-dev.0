Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzLJk3lkVzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 07:36:22 +1100 (AEDT)
Date: Wed, 11 Jan 2017 21:31:00 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
 "mulix@mulix.org" <mulix@mulix.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "geoff@infradead.org" <geoff@infradead.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
 "dalias@libc.org" <dalias@libc.org>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "shorne@gmail.com" <shorne@gmail.com>,
 "lftan@altera.com" <lftan@altera.com>, "deller@gmx.de" <deller@gmx.de>,
 "jdmason@kudzu.us" <jdmason@kudzu.us>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "chris@zankel.net" <chris@zankel.net>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "starvik@axis.com" <starvik@axis.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "stefan.kristiansson@saunalahti.fi" <stefan.kristiansson@saunalahti.fi>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jonas@southpole.se" <jonas@southpole.se>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 2/9] Move dma_ops from archdata into struct device
Message-ID: <20170111203100.GB17895@kroah.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064803.GB26893@kroah.com>
 <1484158589.2619.14.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1484158589.2619.14.camel@sandisk.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2017 at 06:17:03PM +0000, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 07:48 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 10, 2017 at 04:56:41PM -0800, Bart Van Assche wrote:
> > > Several RDMA drivers, e.g. drivers/infiniband/hw/qib, use the CPU to
> > > transfer data between memory and PCIe adapter. Because of performance
> > > reasons it is important that the CPU cache is not flushed when such
> > > drivers transfer data. Make this possible by allowing these drivers to
> > > override the dma_map_ops pointer. Additionally, introduce the function
> > > set_dma_ops() that will be used by a later patch in this series.
> > 
> > When you say things like "additionally", that's a huge flag that this
> > needs to be split up into multiple patches.  No need to add
> > set_dma_ops() here in this patch.
> 
> Hello Greg,
> 
> Some architectures already define a set_dma_ops() function. So what this
> patch does is to move both the dma_ops pointer and the set_dma_ops()
> function from architecture-specific to architecture independent code. I
> don't think that it is possible to separate these two changes. But I
> understand that how I formulated the patch description caused confusion. I
> will rewrite the patch description to make it more clear before I repost
> this patch series.

I think you should separate it out into multiple patches, this is a
mess, as you say below:

> > And I'd argue that it should be dma_ops_set(), and dma_ops_get(), just
> > to keep the namespace sane, but that's probably a different set of
> > patches...
> 
> Every time I rebase and retest this patch series on top of a new kernel
> version I have to modify some of the patches to compensate for changes in
> the architecture code. So I expect that once Linus merges these patches that
> he will have to resolve one or more merge conflicts. Including a rename of
> the functions that query and set the dma_ops pointer in this patch series
> would increase the number of merge conflicts triggered by this patch series
> and would make Linus' job harder. So I hope that you will allow me to
> postpone that rename until a later time ...

That's a big sign that your patch series needs work.  Break it up into
smaller pieces, it should be possible, which will make merges easier
(well, different in a way.)

Good luck, tree-wide changes are not simple.

greg k-h
