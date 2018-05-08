Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g4MK0cc0zF1mb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 13:13:48 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4839JNG129626
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 23:13:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htx2xuma8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 23:13:46 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 8 May 2018 04:13:43 +0100
Subject: Re: [PATCH v2 1/7] powerpc: Add TIDR CPU feature for Power9
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, arnd@arndb.de, linux-doc@vger.kernel.org,
 malat@debian.org, gregkh@linuxfoundation.org, corbet@lwn.net,
 vaibhav@linux.vnet.ibm.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 pombredanne@nexb.com, felix@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com
Date: Tue, 08 May 2018 13:13:37 +1000
In-Reply-To: <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-2-alastair@au1.ibm.com>
 <2f95cc6f-9843-e2b9-6fca-2f4153317a5f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525749217.7796.48.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 19:17 +0200, Frederic Barrat wrote:
> 
> Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch adds a CPU feature bit to show whether the CPU has
> > the TIDR register available, enabling as_notify/wait in userspace.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/cputable.h | 3 ++-
> >   arch/powerpc/kernel/dt_cpu_ftrs.c   | 1 +
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/cputable.h
> > b/arch/powerpc/include/asm/cputable.h
> > index 4e332f3531c5..54c4cbbe57b4 100644
> > --- a/arch/powerpc/include/asm/cputable.h
> > +++ b/arch/powerpc/include/asm/cputable.h
> > @@ -215,6 +215,7 @@ static inline void cpu_feature_keys_init(void)
> > { }
> >   #define CPU_FTR_P9_TM_HV_ASSIST		LONG_ASM_CONST(0x0
> > 000100000000000)
> >   #define CPU_FTR_P9_TM_XER_SO_BUG	LONG_ASM_CONST(0x00002000
> > 00000000)
> >   #define CPU_FTR_P9_TLBIE_BUG		LONG_ASM_CONST(0x0000
> > 400000000000)
> > +#define CPU_FTR_P9_TIDR			LONG_ASM_CONST(0x00
> > 00800000000000)
> > 
> >   #ifndef __ASSEMBLY__
> > 
> > @@ -462,7 +463,7 @@ static inline void cpu_feature_keys_init(void)
> > { }
> >   	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
> >   	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_ARCH_207S |
> > \
> >   	    CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | CPU_FTR_PKEY | \
> > -	    CPU_FTR_P9_TLBIE_BUG)
> > +	    CPU_FTR_P9_TLBIE_BUG | CPU_FTR_P9_TIDR)
> >   #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 |
> > CPU_FTR_POWER9_DD1) & \
> >   			     (~CPU_FTR_SAO))
> >   #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index 11a3a4fed3fb..10f8b7f55637 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -722,6 +722,7 @@ static __init void cpufeatures_cpu_quirks(void)
> >   	if ((version & 0xffff0000) == 0x004e0000) {
> >   		cur_cpu_spec->cpu_features &= ~(CPU_FTR_DAWR);
> >   		cur_cpu_spec->cpu_features |=
> > CPU_FTR_P9_TLBIE_BUG; > +		cur_cpu_spec->cpu_features 
> > |= CPU_FTR_P9_TIDR;
> 
> 
> Isn't it redundant with adding the flag to CPU_FTRS_POWER9?
> 
>    Fred
> 

No, cpu_features is populated from device tree, not from
CPU_FTRS_POWER9. Since TIDR will not be explicitly requested in the
device tree, we need to handle it in quirks.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819
