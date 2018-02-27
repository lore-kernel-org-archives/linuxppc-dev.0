Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr4jP47qwzF19R
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 15:00:24 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1R3x819142801
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:00:22 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gcwfdvp71-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 23:00:22 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 04:00:20 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2] powerpc: Don't do runtime futex_cmpxchg test
In-Reply-To: <CANashXPc952+httE=Vhx=wGrkN3Ycva7j+a+WE6jXQaw38p=YQ@mail.gmail.com>
References: <20180226140950.12111-1-aneesh.kumar@linux.vnet.ibm.com>
 <CANashXPc952+httE=Vhx=wGrkN3Ycva7j+a+WE6jXQaw38p=YQ@mail.gmail.com>
Date: Tue, 27 Feb 2018 09:30:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a7vv9j5c.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <nicholas.piggin@gmail.com> writes:

> On 27 Feb. 2018 00:34, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> wrote:
>
> futex_detect_cmpxchg() does a cmpxchg_futex_value_locked on a NULL user
> addr to
> runtime detect whether architecture implements atomic cmpxchg for futex.
> POWER
> do implement the feature and hence we can enable the config instead of
> depending
> on runtime detection.
>
> We could possible enable this on everything. For now limitted to book3s_64
>
>
> I think everything implements it? Might as well do it all at once.
>
> I wouldn't mind putting in an explicit null dereference test if we take
> this out.

If the config is not selected we do that with futex_detect_cmpxchg()
right? Or are you suggesting something else?

>
> Thanks,
> Nick
>
>
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype
> index a429d859f15d..31bc2bd5dfd1 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -75,6 +75,7 @@ config PPC_BOOK3S_64
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select IRQ_WORK
>         select HAVE_KERNEL_XZ
> +       select HAVE_FUTEX_CMPXCHG if FUTEX
>
>  config PPC_BOOK3E_64
>         bool "Embedded processors"
> --
> 2.14.3
