Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DF3A1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 20:29:59 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 15:59:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 71E91E0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 16:00:45 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56AUaFa8257924
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 16:00:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56ATnAN003033
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 15:59:50 +0530
Message-ID: <539197C6.8090203@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 15:58:22 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/powernv : Disable subcore for UP configs
References: <1402050065-18007-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1402050171-18270-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1402050171-18270-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2014 03:52 PM, Shreyas B. Prabhu wrote:
> Build throws following errors when CONFIG_SMP=n
> arch/powerpc/platforms/powernv/subcore.c: In function ‘cpu_update_split_mode’:
> arch/powerpc/platforms/powernv/subcore.c:274:15: error: ‘setup_max_cpus’ undeclared (first use in this function)
> arch/powerpc/platforms/powernv/subcore.c:285:5: error: lvalue required as left operand of assignment
> 
> 'setup_max_cpus' variable is relevant only on SMP, so there is no point
> working around it for UP. Furthermore, subcore itself is relevant only
> on SMP and hence the better solution is to exclude subcore.o and
> subcore-asm.o for UP builds.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
> Changes in v2:
> Excluding subcore-asm.o which is part of the subcore feature for UP configs.
> 
>  arch/powerpc/platforms/powernv/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 4ad0d34..d55891f 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,9 +1,9 @@
>  obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> -obj-y			+= opal-msglog.o subcore.o subcore-asm.o
> +obj-y			+= opal-msglog.o
> 
> -obj-$(CONFIG_SMP)	+= smp.o
> +obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
>  obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
>  obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
> 
