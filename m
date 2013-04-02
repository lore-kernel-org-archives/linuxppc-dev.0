Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 422CD2C0256
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 02:10:40 +1100 (EST)
Message-ID: <1364915422.16520.8.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: fix PCI-e devices rescan issue on powerpc
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuanquan Chen <Yuanquan.Chen@freescale.com>
Date: Tue, 02 Apr 2013 17:10:22 +0200
In-Reply-To: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
References: <1364902014-943-1-git-send-email-Yuanquan.Chen@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-02 at 19:26 +0800, Yuanquan Chen wrote:
> So we move the DMA & IRQ initialization code from pcibios_setup_devices() and
> construct a new function pcibios_enable_device. We call this function in
> pcibios_enable_device, which will be called by PCI-e rescan code. At the
> meanwhile, we avoid the the impact on cardbus. I also validate this patch with
> silicon's PCIe-sata which encounters the IRQ issue.

My worry is that this delays the setup of the IRQ and DMA to very late in
the process, possibly after the quirks have been run, which can be
problematic. We have platform hooks that might try to "fixup" specific
IRQ issues on some platforms (especially macs) which I worry might fail
if delayed that way (I may be wrong, I don't have a specific case in mind,
but I would feel better if we kept setting up these things earlier).

Cheers,
Ben.
