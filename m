Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406t7K06fdzF225
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 16:55:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mauricfo@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/mm: Fixup tlbie vs store ordering issue on
 POWER9
In-Reply-To: <20180323045627.16800-3-aneesh.kumar@linux.vnet.ibm.com>
References: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180323045627.16800-3-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 23 Mar 2018 16:55:37 +1100
Message-ID: <874ll7fi92.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index a2c5c95882cf..6c151d2e9bd9 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -465,7 +466,7 @@ static inline void cpu_feature_keys_init(void) { }
>  	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
>  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
>  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
> -	    CPU_FTR_PKEY)
> +	    CPU_FTR_PKEY | CPU_FTR_TLBIE_BUG)

We also need to enable this when we're using DT_CPU_FTRS.

We're still working out the best way to handle that sort of thing long
term, for now I'll just fold in a quirk that turns this feature on for
all Power9 revisions. We can do a follow-up patch to make that
conditional later.

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 0bcfb0f256e1..553514cd6c27 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -709,6 +709,9 @@ static __init void cpufeatures_cpu_quirks(void)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
 	else if ((version & 0xffffefff) == 0x004e0201)
 		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD2_1;
+
+	if ((version & 0xffff0000) == 0x004e0000)
+		cur_cpu_spec->cpu_features |= CPU_FTR_TLBIE_BUG;
 }
 

cheers
