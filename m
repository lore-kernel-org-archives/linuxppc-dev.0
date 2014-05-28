Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468D31A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 09:18:56 +1000 (EST)
Message-ID: <1401319125.8262.34.camel@pasglop>
Subject: Re: [PATCH v7 3/3] drivers/vfio: EEH support for VFIO PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 29 May 2014 09:18:45 +1000
In-Reply-To: <53866747.50703@suse.de>
References: <1401180052-6060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401180052-6060-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401214527.3289.611.camel@ul30vt.home> <20140528005532.GA5528@shangw>
 <5385CB6F.50300@suse.de> <20140528124947.GA19346@shangw>
 <1401314311.8262.26.camel@pasglop> <53866747.50703@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-29 at 00:46 +0200, Alexander Graf wrote:
> I don't think so :). In QEMU the PHB emulation would have to notify the 
> "container" (IOMMU emulation layer -> PE) that a PE operation happened. 
> It's that emulation code's responsibility to broadcast operations across 
> its own emulated operations (recover config space access, reconfigure 
> BARs, etc) and the VFIO PE operations.
> 
> So from a kernel interface point of view, I think leaving out any 
> address information is the right way to go. Whether we managed to get 
> all QEMU internal interfaces modeled correctly yet has to be seen on the 
> next patch set revision :).

For a kernel interface I absolutely agree, all we care about is the group fd.

>From a qemu internal, I suppose it makes things easier to operate at the PHB
level for now and we can revisit later if the need arises.

Cheers,
Ben.
