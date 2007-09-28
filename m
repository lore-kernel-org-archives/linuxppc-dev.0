Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8C0DDDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 01:30:04 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
References: <46F7F0B7.2090205@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7F0D5001-BDDC-48A3-A414-2D3C1CE1574B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Fwd: [PATCH#2 3/4] [PPC] Compile fix for 8xx CPM Ehernet driver
Date: Fri, 28 Sep 2007 10:30:07 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev <netdev@vger.kernel.org>,
	"linux-ppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Begin forwarded message:

> From: Jochen Friedrich <jochen@scram.de>
> Date: September 24, 2007 12:15:35 PM CDT
> To: linuxppc-embedded@ozlabs.org
> Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>
> Subject: [PATCH#2 3/4] [PPC] Compile fix for 8xx CPM Ehernet driver

Jeff,

Please pick up for 2.6.23 if you don't mind.

- k

>
>
> Add #include <asm/cacheflush.h> for flush_dcache_range
> to make the driver compile again.
>
>  CC      arch/ppc/8xx_io/enet.o
> arch/ppc/8xx_io/enet.c: In function 'scc_enet_start_xmit':
> arch/ppc/8xx_io/enet.c:240: error: implicit declaration of function
> 'flush_dcache_range'
> make[1]: *** [arch/ppc/8xx_io/enet.o] Error 1
> make: *** [arch/ppc/8xx_io] Error 2
>
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
> arch/ppc/8xx_io/enet.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
> diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
> index 703d47e..eace3bc 100644
> --- a/arch/ppc/8xx_io/enet.c
> +++ b/arch/ppc/8xx_io/enet.c
> @@ -44,6 +44,7 @@
>  #include <asm/mpc8xx.h>
>  #include <asm/uaccess.h>
>  #include <asm/commproc.h>
> +#include <asm/cacheflush.h>
>
>  /*
>   *				Theory of Operation
>
