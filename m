Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WyYB6nY2zDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 14:27:58 +1000 (AEST)
Message-ID: <f3ff14198333daac599adb64344d66a09e88acb7.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] PCI: Data corruption happening due to race condition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>, Hari Vyas <hari.vyas@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Ray Jui
 <ray.jui@broadcom.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 20 Jul 2018 14:27:41 +1000
In-Reply-To: <20180719185538.GA7731@wunner.de>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <1530608741-30664-2-git-send-email-hari.vyas@broadcom.com>
 <20180718232904.GJ128988@bhelgaas-glaptop.roam.corp.google.com>
 <65dd986d0b8b2ebe5132b365dabb2dbaaed9177f.camel@kernel.crashing.org>
 <CAM5rFu8b1mdim8uA15TzpJtcxH5jXN3C53rBGZcyXG2h7bRoyA@mail.gmail.com>
 <20180719185538.GA7731@wunner.de>
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

On Thu, 2018-07-19 at 20:55 +0200, Lukas Wunner wrote:
> On Thu, Jul 19, 2018 at 9:48 AM, Benjamin Herrenschmidt <benh@kernel.crashing.org wrote:
> > Indeed. However I'm not fan of the solution. Shouldn't we instead have
> > some locking for the content of pci_dev? I've always been wary of us
> > having other similar races in there.
> 
> The solution presented is perfectly fine as it uses atomic bitops which
> obviate the need for locking.  Why do you want to add unnecessary locking
> on top?

Atomic bitops tend to be *more* expensive than a lock.

My concern is that the PCIe code historically had no locking and I
worry we may have other fields in there with similar issues. But maybe
I'm wrong.

> Certain other parts of struct pci_dev use their own locking, e.g.
> pci_bus_sem to protect bus_list.  Most elements can and should
> be accessed lockless for performance.
> 
> 
> > > The powerpc PCI code contains a lot of cruft coming from the depth of
> > > history, including rather nasty assumptions. We want to progressively
> > > clean it up, starting with EEH, but it will take time.
> 
> Then I suggest using the #include "../../../drivers/pci/pci.h" for now
> until the powerpc arch code has been consolidated.

There's also the need both in powerpc and sparc to access the guts of
pci_dev because those archs will "fabricate" as pci_dev from the
device-tree rather than probing it under some circumstances.

Cheers,
Ben.
