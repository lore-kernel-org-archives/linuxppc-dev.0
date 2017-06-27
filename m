Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxlg646kFzDr27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 22:32:18 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Frederic Barrat' <fbarrat@linux.vnet.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mikey@neuling.org" <mikey@neuling.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
 "clsoto@linux.vnet.ibm.com" <clsoto@linux.vnet.ibm.com>
Subject: RE: [PATCH v2] powerpc/powernv: Enable PCI peer-to-peer
Date: Tue, 27 Jun 2017 12:32:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD002BE3A@AcuExch.aculab.com>
References: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Frederic Barrat
> Sent: 26 June 2017 19:09
> P9 has support for PCI peer-to-peer, enabling a device to write in the
> mmio space of another device directly, without interrupting the CPU.
>=20
> This patch adds support for it on powernv, by adding a new API to be
> called by drivers. The pnv_pci_set_p2p(...) call configures an
> 'initiator', i.e the device which will issue the mmio operation, and a
> 'target', i.e. the device on the receiving side.
...

Two questions:

1) How does the driver get the correct address to give to the 'initiator'
   in order to perform an access to the 'target'?

2) Surely the API call the driver makes should be architecture neutral,
   returning an error on other architectures.

At least some x86 cpus also support peer-to-peer writes,
I believe they can work between cpu chips.
PCIe bridges might support them (or be configurable to support them).

	David
