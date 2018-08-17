Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sK9D6gPjzDr5p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 20:25:52 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HANZX2096033
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 06:25:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kwufnth2n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 06:25:48 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 17 Aug 2018 11:25:47 +0100
Date: Fri, 17 Aug 2018 15:55:40 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc64/ftrace: Include ftrace.h needed for
 enable/disable calls
To: Luke Dashjr <luke@dashjr.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>
References: <201808162136.27788.luke@dashjr.org>
In-Reply-To: <201808162136.27788.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1534501411.hvsbp9w9ur.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Luke Dashjr wrote:
> this_cpu_disable_ftrace and this_cpu_enable_ftrace are inlines in ftrace.=
h
> Without it included, the build fails.

I'm unable to reproduce this. Can you share your .config and the build=20
environment?

>=20
> Fixes: a4bc64d305af ("powerpc64/ftrace: Disable ftrace during kvm entry/e=
xit")
> Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/kvm/book3s_hv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index ee4a8854985e..15c2c64291f4 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -46,6 +46,7 @@
>  #include <linux/compiler.h>
>  #include <linux/of.h>
>=20
> +#include <asm/ftrace.h>
>  #include <asm/reg.h>
>  #include <asm/ppc-opcode.h>
>  #include <asm/asm-prototypes.h>

In any case, this change itself looks alright to me. So:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks,
Naveen

=
