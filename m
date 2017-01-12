Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzcwX3yBmzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 18:34:51 +1100 (AEDT)
Date: Thu, 12 Jan 2017 08:35:11 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
 "mulix@mulix.org" <mulix@mulix.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "geoff@infradead.org" <geoff@infradead.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "a-jacquiot@ti.com" <a-jacquiot@ti.com>,
 "dalias@libc.org" <dalias@libc.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "shorne@gmail.com" <shorne@gmail.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "lftan@altera.com" <lftan@altera.com>, "deller@gmx.de" <deller@gmx.de>,
 "jdmason@kudzu.us" <jdmason@kudzu.us>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "chris@zankel.net" <chris@zankel.net>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
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
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
 "dhowells@redhat.com" <dhowells@redhat.com>,
 "starvik@axis.com" <starvik@axis.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "uclinux-h8-devel@lists.sourceforge.jp"
 <uclinux-h8-devel@lists.sourceforge.jp>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stefan.kristiansson@saunalahti.fi" <stefan.kristiansson@saunalahti.fi>,
 "jonas@southpole.se" <jonas@southpole.se>,
 "egtvedt@samfundet.no" <egtvedt@samfundet.no>
Subject: Re: [PATCH 2/9] Move dma_ops from archdata into struct device
Message-ID: <20170112073511.GA23347@kroah.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-3-bart.vanassche@sandisk.com>
 <20170111064803.GB26893@kroah.com>
 <1484158589.2619.14.camel@sandisk.com>
 <20170111203100.GB17895@kroah.com>
 <1484173670.2619.28.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484173670.2619.28.camel@sandisk.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2017 at 10:28:05PM +0000, Bart Van Assche wrote:
> On Wed, 2017-01-11 at 21:31 +0100, gregkh@linuxfoundation.org wrote:
> > That's a big sign that your patch series needs work.  Break it up into
> > smaller pieces, it should be possible, which will make merges easier
> > (well, different in a way.)
> 
> Hello Greg,
> 
> Can you have a look at the attached patches? These three patches are a
> splitup of the single patch at the start of this e-mail thread.

Please send them in the proper format (i.e. one patch per email), and I
will be glad to review them.  Otherwise it's really hard to do so, would
you want to review attachments?

thanks,

greg k-h
