Return-Path: <dan.j.williams@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by ozlabs.org (Postfix) with ESMTP id 2959DB70F6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:48:14 +1000 (EST)
Message-ID: <4C9BD6DC.3070707@intel.com>
Date: Thu, 23 Sep 2010 15:38:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: "tmarri@apm.com" <tmarri@apm.com>
Subject: Re: [PATCH v1 1/4] PPC4xx: Generalizing ADMA driver modifications
References: <1285279839-16588-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1285279839-16588-1-git-send-email-tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"yur@emcraft.com" <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/23/2010 3:10 PM, tmarri@apm.com wrote:
> From: Tirumala Marri<tmarri@apm.com>
>
> This patch generalizes the existing drver/dma/ppc4xx/adma.c, so that
> common code can be shared between different similar DMA engine
> drivers in other SoCs. Also Makefile and Kconfig changed to accommodate
> PPC4XX.
>
> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> ---
> V1:
>    * No change.
> ---
>   arch/powerpc/include/asm/async_tx.h |    4 +-
>   drivers/dma/Kconfig                 |    6 +-
>   drivers/dma/Makefile                |    2 +-
>   drivers/dma/ppc4xx/Makefile         |    2 +-
>   drivers/dma/ppc4xx/adma.c           | 4437 +++--------------------------------
>   drivers/dma/ppc4xx/adma.h           |   92 +-
>   6 files changed, 354 insertions(+), 4189 deletions(-)

Did you look at this changelog before sending?  It just deletes 4000 
lines of code??

Moving and renaming code in one patch makes it very difficult to verify 
the result.  When generalizing code the first thing I want to see with a 
very quick glance at the patch(es) is that the existing implementation 
is not harmed.  One way to go about this is to first identify the 
portions of existing code that you want to reuse in your driver and the 
pieces that are truly ppc440spe specific.  Move the ppc440spe pieces to 
their own file (get this reviewed and approved by the ppc440spe 
authors).  The remaining code in adma.c will be assumed generic.  You 
can then have another patch to do a simple s/ppc440spe/ppc4xx/ in adma.c 
(no other logic changes or code movement).  Then you can introduce your 
ppc460ex unique implementation that calls into adma.c.

I don't want to see patches along the lines of "rename 
drivers/dma/ppc4xx/adma.c to drivers/dma/ppc4xx/ppc4xx-adma.c" because 
that is just redundant.  Assume that the existing generic file names are 
where the common code will lie and then add hw-implementation specific 
files to call into that base.

Another rule is that the conversion should be bisectable at every step, 
I should be able to apply each patch in the series and still have a 
functional/runnable result.

--
Dan
