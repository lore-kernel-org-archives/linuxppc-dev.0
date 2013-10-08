Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B41FF2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 10:10:21 +1100 (EST)
Received: by mail-ie0-f173.google.com with SMTP id ar20so11677iec.32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Oct 2013 16:10:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381272382.7979.292.camel@snotra.buserror.net>
References: <1380531175-14836-1-git-send-email-Minghuan.Lian@freescale.com>
 <CAErSpo7LXqXmrw1gPwKHsJkKaAcDr2W_+tcC8b9T_5Mab1Arnw@mail.gmail.com>
 <1381272382.7979.292.camel@snotra.buserror.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 17:09:56 -0600
Message-ID: <CAErSpo76_w+wK76m73kkdYS1PouhYcGfZus_FYF5E2FHJTA6gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] pci: fsl: derive the common PCI driver to
 drivers/pci/host
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Oct 8, 2013 at 4:46 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 2013-10-08 at 13:13 -0600, Bjorn Helgaas wrote:
>> [+cc Ben, Paul, linuxppc-dev]
>>
>> On Mon, Sep 30, 2013 at 04:52:54PM +0800, Minghuan Lian wrote:
>> > The Freescale's Layerscape series processors will use ARM cores.
>> > The LS1's PCIe controllers is the same as T4240's. So it's better
>> > the PCIe controller driver can support PowerPC and ARM
>> > simultaneously. This patch is for this purpose. It derives
>> > the common functions from arch/powerpc/sysdev/fsl_pci.c to
>> > drivers/pci/host/pci-fsl-common.c and leaves the architecture
>> > specific functions which should be implemented in arch related files.
>> >
>> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>>
>> I cc'd the powerpc maintainers so we can work out which tree this
>> should go through.
>>
>> > ---
>> > change log:
>> > v1-v2:
>> > 1. rename pci.h to pci-common.h
>> > 2. rename pci-fsl.c to pci-fsl-common.c
>> >
>> > Based on upstream master.
>> > Based on the discussion of RFC version here
>> > http://patchwork.ozlabs.org/patch/274487/
>> >
>> >  arch/powerpc/sysdev/fsl_pci.c                      | 521 +-----------------
>> >  arch/powerpc/sysdev/fsl_pci.h                      |  89 ----
>> >  .../fsl_pci.c => drivers/pci/host/pci-fsl-common.c | 591 +--------------------
>> >  .../fsl_pci.h => include/linux/fsl/pci-common.h    |  45 +-
>>
>> Is there any way to avoid putting this file in include/linux?  I know
>> you want to share it beyond PowerPC, and I know there are similar
>> examples there already, but this is all arch-specific or
>> chipset-specific stuff that seems like it should be in some
>> not-so-public place.  It doesn't seem scalable to add an include/linux
>> subdirectory for every chipset that might be shared across
>> architectures.
>
> What specifically is the problem with it, as long as it's properly
> namespaced?

Well, as I said above, it doesn't seem scalable, and it doesn't seem
to be the common existing practice.  Possibly this is just because
sharing chipsets across arches isn't very common yet.

I hadn't noticed that include/linux/fsl exists already; I thought you
were adding it.  Given that it *does* exist already, I guess I'm OK
with putting more stuff in it.

So I'll apply these given an ack from the powerpc folks.

Bjorn
