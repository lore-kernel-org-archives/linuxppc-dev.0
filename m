Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMVXD6dhKzDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 23:57:00 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id n14so22151601pfh.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 05:57:00 -0700 (PDT)
Date: Wed, 25 Oct 2017 23:56:48 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, Vipin K Parashar <vipin@linux.vnet.ibm.com>, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv: Avoid checkstop on HMI and MCE
Message-ID: <20171025235648.1152bff3@MiWiFi-R3-srv>
In-Reply-To: <20171024092005.3861-1-mikey@neuling.org>
References: <20171024092005.3861-1-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 24 Oct 2017 20:20:05 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On an unrecoverable HMI or MCE only generate an checkstop (via
> PLATFORM ERROR opal reboot call) when panic_on_oops is set.
> 
> We currently generate an checkstop as an attempt for the FSP to grab a
> dump and then reboot us. Unfortunately this never works and no one
> I've talked to has ever seen a resulting dump, let alone got useful
> information from it.
> 
> Even worse, the checkstop gets in the way of debugging real
> problems. If we hit a software bug that results in this, we get no
> opportunity to debug it live. Similarly if the bug is due to hardware
> that is not in the dump (say PCI or NVLINK GPU), we get no information
> in the dump about that hardware.
> 
> So let's remove it unless someone sets panic_on_oops.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/platforms/powernv/opal-hmi.c | 6 ++++++
>  arch/powerpc/platforms/powernv/opal.c     | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
> index c9e1a4ff29..23780970d0 100644
> --- a/arch/powerpc/platforms/powernv/opal-hmi.c
> +++ b/arch/powerpc/platforms/powernv/opal-hmi.c
> @@ -29,6 +29,7 @@
>  #include <asm/opal.h>
>  #include <asm/cputable.h>
>  #include <asm/machdep.h>
> +#include <asm/bug.h>
>  
>  #include "powernv.h"
>  
> @@ -284,6 +285,11 @@ static void hmi_event_handler(struct work_struct *work)
>  			print_hmi_event_info(hmi_evt);
>  		}
>  
> +		if (!panic_on_oops) {
> +			die("Unrecoverable HMI exception", NULL, SIGBUS);
> +			return;
> +		}
> +

If panic_on_oops is set, we checkstop, not panic! Passing NULL to die, will
cause arch_uprobe_exception_notify() to complain.

We could respin this a bit and I can send an updated patch if there is interest


Balbir Singh.
