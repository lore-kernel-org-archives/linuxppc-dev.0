Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 585921A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 18:41:33 +1000 (EST)
Message-ID: <1409301692.30345.1.camel@concordia>
Subject: Re: [PATCH 1/2] PCI/MSI/PPC: Remove arch_msi_check_device()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Gordeev <agordeev@redhat.com>
Date: Fri, 29 Aug 2014 18:41:32 +1000
In-Reply-To: <18276ae8c0b212b8d40dfd186e1c84b8ae949525.1405160163.git.agordeev@redhat.com>
References: <cover.1405160163.git.agordeev@redhat.com>
 <18276ae8c0b212b8d40dfd186e1c84b8ae949525.1405160163.git.agordeev@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-07-12 at 13:21 +0200, Alexander Gordeev wrote:
> PowerPC is the only architecture that makes use of hook
> arch_msi_check_device() and does perform some checks to
> figure out if MSI/MSI-X could be enabled for a device.
> However, there are no reasons why those checks could not
> be done within arch_setup_msi_irqs() hook.
> 
> Moving MSI checks into arch_setup_msi_irqs() makes code
> more readable and allows getting rid of unnecessary hook
> arch_msi_check_device().

The intention was that this hook allowed a platform to reject the request
early, ie. before all the setup had been done. But if no one except us is using
it then fine, get rid of it.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
