Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68906B6FD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 08:41:57 +1100 (EST)
Message-ID: <1329946909.20389.10.camel@pasglop>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 23 Feb 2012 08:41:49 +1100
In-Reply-To: <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
> We already use pci_flags, so this just sets pci_flags directly and removes
> the intermediate step of figuring out pci_probe_only, then using it to set
> pci_flags.

Ah yes, those flags are now common indeed.

> The PCI core provides a pci_flags definition (currently __weak), so drop
> the powerpc definitions in favor of that.  Note that we must set the ppc64
> default (PCI_PROBE_ONLY set) in the 64-bit setup_arch() before calling
> the platform .setup_arch() method, which may override the default.

Ah wait, I have a patch about to hit -next that flips the ppc64
default...

Maybe it's easier if you just pick it up and stick it in your series,
that will avoid integration clashes..

http://patchwork.ozlabs.org/patch/141225/

Cheers,
Ben.
