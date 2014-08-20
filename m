Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D1E81A0367
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 09:21:46 +1000 (EST)
Message-ID: <1408576886.4058.73.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] fsl_ifc: Support all 8 IFC chip selects
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Wed, 20 Aug 2014 18:21:26 -0500
In-Reply-To: <53F4179F.1010803@freescale.com>
References: <1234993482.57039.1408136876321.JavaMail.zimbra@xes-inc.com>
 <1408493285.4058.55.camel@snotra.buserror.net>
 <53F4179F.1010803@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Aaron Sierra <asierra@xes-inc.com>,
 linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-20 at 09:05 +0530, Prabhakar Kushwaha wrote:
> On 8/20/2014 5:38 AM, Scott Wood wrote:
> > On Fri, 2014-08-15 at 16:07 -0500, Aaron Sierra wrote:
> >> Freescale's QorIQ T Series processors support 8 IFC chip selects
> >> within a memory map backward compatible with previous P Series
> >> processors which supported only 4 chip selects.
> >>
> >> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> >> ---
> >>   include/linux/fsl_ifc.h | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/fsl_ifc.h b/include/linux/fsl_ifc.h
> >> index 84d60cb..62762ff 100644
> >> --- a/include/linux/fsl_ifc.h
> >> +++ b/include/linux/fsl_ifc.h
> >> @@ -29,7 +29,7 @@
> >>   #include <linux/of_platform.h>
> >>   #include <linux/interrupt.h>
> >>   
> >> -#define FSL_IFC_BANK_COUNT 4
> >> +#define FSL_IFC_BANK_COUNT 8
> > First please modify fsl_ifc_nand.c to limit itself to the number of
> > banks it dynamically determines are present based on the IFC version.
> >
> >
> 
> Number of available bank/chip select are defined by SoC and it is 
> independent of SoC.

Do you mean defined by the SoC and independent of the IFC version?

> It should be fix in following way
> 
> Option 1:
> u-boot:  fix device tree with number of available chip select. It may 
> require IFC binding change
> Linux: Read device tree and determine the Chip Selects

If we do this then it will need to be an optional property that defaults
to the current assumption being made (4).

In the future we really ought to check whether there are integration
parameters when coming up with the initial binding for a hardware
block...

> Option 2:
> Make it static because any way IFC NAND driver polls to 
> FSL_IFC_BANK_COUNT to know NAND flash chip select. This patch is doing same.

I don't understand what you're saying here.  The driver does not know at
compile time how many there are.  What this patch does is assume it's OK
to access non-existent registers in the rare case that there's no match
in the registers that exist.

Aaron tested this on P1010 and it seemed to work, though I'm not
generally fond of relying on such things.

-Scott
