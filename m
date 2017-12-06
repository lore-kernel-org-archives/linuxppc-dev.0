Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysWPs4ZHVzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 08:06:41 +1100 (AEDT)
Date: Wed, 6 Dec 2017 15:06:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on
 non-root bus
Message-ID: <20171206210637.GO23510@bhelgaas-glaptop.roam.corp.google.com>
References: <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de>
 <20171202230052.34y2ivxgpgr3osct@localhost>
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
 <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
 <1d5276c3-1d29-114a-c868-6f022eee58e7@xenosoft.de>
 <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
 <87fu8odnfk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87fu8odnfk.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 06, 2017 at 11:57:03PM +1100, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
> ...
> >
> > Hi Olof,
> >
> > Many thanks for your patch! :-) The RC2 of kernel 4.15 boots without any 
> > problems on my P.A. Semi Nemo board (A-EON AmigaOne X1000). I don’t need 
> > the additional boot argument 'pci=pcie_scan_all' anymore.
> >
> > Is it possible to merge it via the powerpc tree?
> 
> Yes.
> 
> It would be good to confirm that the change is harmless on other pasemi
> boards. I'll try and get mine booted tomorrow, unless someone beats me
> to it.

Theoretically, it should not do any harm since it only turns off an
enumeration optimization.  Boot will be slightly slower but should
still work fine.

Darren's idea of doing it at the same time you tweak the SB600 "relax
pci-e" bit is ideal because then the two pieces are obviously
connected and it wouldn't affect any other systems at all.

Bjorn
