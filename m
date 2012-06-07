Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1FC49B6FC8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 19:30:40 +1000 (EST)
Message-ID: <1339061428.24838.24.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <ben.c@servergy.com>
Date: Thu, 07 Jun 2012 19:30:28 +1000
In-Reply-To: <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com>
 <16AB27C3-8709-4A7C-AFFE-42A0B658AC1D@servergy.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-06 at 19:35 -0400, Ben Collins wrote:
> 
> pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus
> address [0x100000000-0x10000ffff])
> 
> Without the fix that I sent, it ends up looking like:
> 
> pci_bus 0000:00: root bus resource [io  0xffbed000-0xffbfcfff] (bus
> address [0x0000-0xffff])
> 
> And that's when some devices fail to be assigned valid bar 0's and the
> kernel complains because of it.

Note that oddly, the second range of bus addresses looks -more- correct
than the first one...

Cheers,
Ben.
