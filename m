Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (unknown [IPv6:2001:720:418:ca01::132])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD7492C0335
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2012 17:06:48 +1000 (EST)
Date: Fri, 13 Jul 2012 08:46:05 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] power: Define PV_POWER7P
Message-ID: <20120713064605.GA11030@visitor2.iram.es>
References: <20120712235912.GA19909@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120712235912.GA19909@us.ibm.com>
Cc: michaele@au1.ibm.com, Anton Blanchard <anton@au1.ibm.com>,
 sukadev@us.ibm.com, linuxppc-dev@ozlabs.org, cel@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 12, 2012 at 04:59:12PM -0700, Sukadev Bhattiprolu wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 3 Jul 2012 13:32:46 -0700
> Subject: [PATCH 1/2] power: Define PV_POWER7P
> 
> This change is based on the patch that Carl Love posted to LKML
> 
> 	https://lkml.org/lkml/2012/6/22/309
> 
> It is included here for completeness and to enable building. When
> the above patch is merged, this patch can be ignored.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index f0cb7f4..b3fc2c1 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1014,6 +1014,7 @@
>  #define PV_970FX	0x003C
>  #define PV_POWER6	0x003E
>  #define PV_POWER7	0x003F
> +#define PV_POWER7P	0x004A
>  #define PV_630		0x0040
>  #define PV_630p	0x0041
>  #define PV_970MP	0x0044

Hmm, before this patch the PVR definitions were sorted in ascending
numerical order, at least for the list of 64 bit processors. Your
patch breaks this, which is not a good idea IMHO. 

For example, the 970* processors are already interspersed with other
processors to maintain numerical order, therefore I don't see why the 
POWER7P could not be between 970GX and BE.

Another inconsistency is that all other "plus" variants seem to 
use a lower case "p" suffix. So it would be better to use POWER7p.

	Regards,
	Gabriel
