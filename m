Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C0B42C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:20:55 +1100 (EST)
Message-ID: <1381274440.7979.309.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v2] pci: fsl: derive the common PCI driver to
 drivers/pci/host
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 18:20:40 -0500
In-Reply-To: <CAErSpo76_w+wK76m73kkdYS1PouhYcGfZus_FYF5E2FHJTA6gQ@mail.gmail.com>
References: <1380531175-14836-1-git-send-email-Minghuan.Lian@freescale.com>
 <CAErSpo7LXqXmrw1gPwKHsJkKaAcDr2W_+tcC8b9T_5Mab1Arnw@mail.gmail.com>
 <1381272382.7979.292.camel@snotra.buserror.net>
 <CAErSpo76_w+wK76m73kkdYS1PouhYcGfZus_FYF5E2FHJTA6gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-08 at 17:09 -0600, Bjorn Helgaas wrote:
> On Tue, Oct 8, 2013 at 4:46 PM, Scott Wood <scottwood@freescale.com> wrote:
> > On Tue, 2013-10-08 at 13:13 -0600, Bjorn Helgaas wrote:
> >> [+cc Ben, Paul, linuxppc-dev]
> >>
> >> On Mon, Sep 30, 2013 at 04:52:54PM +0800, Minghuan Lian wrote:
> >> > The Freescale's Layerscape series processors will use ARM cores.
> >> > The LS1's PCIe controllers is the same as T4240's. So it's better
> >> > the PCIe controller driver can support PowerPC and ARM
> >> > simultaneously. This patch is for this purpose. It derives
> >> > the common functions from arch/powerpc/sysdev/fsl_pci.c to
> >> > drivers/pci/host/pci-fsl-common.c and leaves the architecture
> >> > specific functions which should be implemented in arch related files.
> >> >
> >> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >>
> >> I cc'd the powerpc maintainers so we can work out which tree this
> >> should go through.
> >>
> >> > ---
> >> > change log:
> >> > v1-v2:
> >> > 1. rename pci.h to pci-common.h
> >> > 2. rename pci-fsl.c to pci-fsl-common.c
> >> >
> >> > Based on upstream master.
> >> > Based on the discussion of RFC version here
> >> > http://patchwork.ozlabs.org/patch/274487/
> >> >
> >> >  arch/powerpc/sysdev/fsl_pci.c                      | 521 +-----------------
> >> >  arch/powerpc/sysdev/fsl_pci.h                      |  89 ----
> >> >  .../fsl_pci.c => drivers/pci/host/pci-fsl-common.c | 591 +--------------------
> >> >  .../fsl_pci.h => include/linux/fsl/pci-common.h    |  45 +-
> >>
> >> Is there any way to avoid putting this file in include/linux?  I know
> >> you want to share it beyond PowerPC, and I know there are similar
> >> examples there already, but this is all arch-specific or
> >> chipset-specific stuff that seems like it should be in some
> >> not-so-public place.  It doesn't seem scalable to add an include/linux
> >> subdirectory for every chipset that might be shared across
> >> architectures.
> >
> > What specifically is the problem with it, as long as it's properly
> > namespaced?
> 
> Well, as I said above, it doesn't seem scalable,

I'm not sure what scaling problems you're picturing, assuming proper
namespacing and organization within include/linux/.

>  and it doesn't seem to be the common existing practice. 
>
> Possibly this is just because sharing chipsets across arches isn't very common yet.
> 
> I hadn't noticed that include/linux/fsl exists already; I thought you
> were adding it.  Given that it *does* exist already, I guess I'm OK
> with putting more stuff in it.

I see other existing practice as well.  Besides plenty of
"include/linux/fsl*" that ought to be moved to "include/linux/fsl/", I
see things like include/linux/amba/, include/linux/scx200*,
include/linux/clksrc-dbx500-prcmu.h, include/linux/com202020.h, etc.
These are just a few random examples out of many.

> So I'll apply these given an ack from the powerpc folks.

ACK this patch.  The second one I'd like to see broken up into
digestible chunks so I can better review it.

-Scott
