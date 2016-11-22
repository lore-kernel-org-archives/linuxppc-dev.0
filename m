Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60p0JXlzDvHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:18 +1100 (AEDT)
In-Reply-To: <1479305373-20539-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: Re: cxl: Do adapter fence check before handling afu interrupt
Message-Id: <3tN60n2c0Hz9t2D@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 14:09:33 UTC, Vaibhav Jain wrote:
> If an afu interrupt is in flight when an eeh error is triggered the
> control still reaches the function native_irq_multiplexed and the
> PE-Handle read from the CXL_PSL_PEHandle_An register is 0xffff. The
> function then erroneously assumes that the interrupt belonged to a
> detached context and generates a warning with full stack dump in the
> kernel log complaining:
> 
> "Unable to demultiplex CXL PSL IRQ for PE 65535 DSISR ffffffff DAR
> ffffffff. (Possible AFU HW issue - was a term/remove acked with
> outstanding transactions"
> 
> To fix this the patch adds new code to the function
> native_irq_multiplexed function to compares the read value of register
> CXL_PSL_PEHandle_An to ~0ULL. If true then logs a warning message
> saying that the interrupt is being ignored and returns IRQ_HANDLED from
> the irq handler.
> 
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/abf051be684be768c1ee079514f4d0

cheers
