Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F19CB2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 03:16:14 +1000 (EST)
Message-ID: <5033C250.2000904@freescale.com>
Date: Tue, 21 Aug 2012 12:16:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
 <5032B455.3080607@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A56A61@039-SN1MPN1-002.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F093BD870@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F093BD870@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Bradley Hughes <bhughes@silicontkx.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2012 01:49 AM, Li Yang-R58472 wrote:
> If there is i8259 node in the device tree, it should be suggesting
> that there is a PCI to ISA bridge but not explicitly described in the
> device tree.  Then we need to fix the device tree to add the ISA
> nodes.

No, we need to work with existing device trees.  Just because they're
hosted in the kernel tree doesn't mean they can be treated as an
internal kernel implementation detail.  They are stable API with
external entities such as bootloaders and hypervisors, get forked for
custom boards, etc.

Boards with this problem should set fsl_pci_primary in platform code
based on whatever criteria is relevant.

-Scott
