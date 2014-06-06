Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A71A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 15:54:11 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 11:24:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 53B7C1258054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 11:23:24 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s565sGsg40304888
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 11:24:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s565s4cQ003101
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 11:24:04 +0530
Message-ID: <5391570B.1050402@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 11:22:11 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/powernv : Disable subcore for UP configs
References: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1401981868-4108-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1401981868-4108-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2014 08:54 PM, Shreyas B. Prabhu wrote:
> Build throws following errors when CONFIG_SMP=n
> arch/powerpc/platforms/powernv/subcore.c: In function ‘cpu_update_split_mode’:
> arch/powerpc/platforms/powernv/subcore.c:274:15: error: ‘setup_max_cpus’ undeclared (first use in this function)
> arch/powerpc/platforms/powernv/subcore.c:285:5: error: lvalue required as left operand of assignment
> 
> 'setup_max_cpus' variable is relevant only on SMP, so there is no point
> working around it for UP. Furthermore, subcore.c itself is relevant only
> on SMP and hence the better solution is to exclude subcore.c for UP builds.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> This patch applies on top of ben/powerpc.git/next branch
> 
>  arch/powerpc/platforms/powernv/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
> index 4ad0d34..636d206 100644
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -1,9 +1,9 @@
>  obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
>  obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
>  obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
> -obj-y			+= opal-msglog.o subcore.o subcore-asm.o
> +obj-y			+= opal-msglog.o subcore-asm.o
> 

subcore-asm.o can also move down here as well ?

> -obj-$(CONFIG_SMP)	+= smp.o
> +obj-$(CONFIG_SMP)	+= smp.o subcore.o
