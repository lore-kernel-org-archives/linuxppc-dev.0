Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70E361A0748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:58:35 +1000 (AEST)
In-Reply-To: <20150719172352.GA14386@vaishali-Ideapad-Z570>
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: cxl: Remove use of macro DEFINE_PCI_DEVICE_TABLE
Message-Id: <20150827215835.309C31401CD@ozlabs.org>
Date: Fri, 28 Aug 2015 07:58:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-19-07 at 17:23:52 UTC, Vaishali Thakkar wrote:
> Macro DEFINE_PCI_DEVICE_TABLE is deprecated. So, here use
> struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE with
> the goal of getting rid of this macro completely.
> 
> The Coccinelle semantic patch that performs this transformation
> is as follows:
> 
> @@
> identifier a;
> declarer name DEFINE_PCI_DEVICE_TABLE;
> initializer i;
> @@
> - DEFINE_PCI_DEVICE_TABLE(a)
> + const struct pci_device_id a[]
> = i;
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> Acked-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f47f966fbe0aaff4ebbdb83d

cheers
