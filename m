Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr3874tcHzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 22:49:43 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-pci@vger.kernel.org
Date: Mon, 04 Dec 2017 11:40:11 +0000 (GMT)
Message-ID: <4b18f51024d.45f899c9@auth.smtp.1and1.co.uk>
In-Reply-To: <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
References: <f3513294-6da0-456f-0f98-1f8c3bac90c9@xenosoft.de>
 <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: SB600 for the Nemo board has non-zero devices on non-root bus
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Bjorn

Firstly sorry for not being=A0able to join in this discussion, I have been
moving house and only got my X1000 set up again yesterday..

On 30/11/2017, Bjorn Helgaas wrote:
> I *think* something like the patch below should make this work if you
> use the "pci=3Dpcie_scan_all" parameter.  We have some x86 DMI quirks
> that set PCI_SCAN_ALL_PCIE_DEVS automatically.  I don't know how to do
> something similar on powerpc, but maybe you do?

Actually the root ports on the Nemo's PA6T processor don't respond to the
SB600 unless we turn on a special 'relax pci-e' bit in one of its control
registers. We use a small out of tree init routine to do this, and there
would be the ideal place to put a call to
pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS).

This patch fixes the last major hurdle to getting the X1000 fully supporte=
d in
the linux kernel, so thanks very much for that.

Regards
Darren
