Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A63B2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 01:04:19 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <will_schmidt@vnet.ibm.com>;
 Mon, 20 May 2013 11:04:16 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C204BC90045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 11:04:12 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4KF4DUl39715014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 11:04:13 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4KF4CwU002553
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 11:04:12 -0400
Message-ID: <1369062258.18289.3.camel@brimstone>
Subject: Re: [PATCH v2 2/4] powerpc/cputable: advertise DSCR support on P7/P7+
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Mon, 20 May 2013 10:04:18 -0500
In-Reply-To: <20130504004838.GB3532@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <2889.1367625894@ale.ozlabs.ibm.com>
 <20130504004756.GA3532@linux.vnet.ibm.com>
 <20130504004838.GB3532@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Michael R Meissner <mrmeissn@us.ibm.com>, Steve Munroe <sjmunroe@us.ibm.com>,
 Peter Bergner <bergner@us.ibm.com>, Ryan Arnold <ryanarn@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 17:48 -0700, Nishanth Aravamudan wrote:
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index ae9f433..a792157 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -98,6 +98,7 @@ extern void __restore_cpu_e6500(void);
>  				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
>  				 PPC_FEATURE_TRUE_LE | \
>  				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
> +#define COMMON_USER2_POWER7	(PPC_FEATURE2_DSCR)
>  #define COMMON_USER_POWER8	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
>  				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
>  				 PPC_FEATURE_TRUE_LE | \
> @@ -428,6 +429,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_name		= "POWER7 (architected)",
>  		.cpu_features		= CPU_FTRS_POWER7,
>  		.cpu_user_features	= COMMON_USER_POWER7,
> +		.cpu_user_features2	= COMMON_USER2_POWER7,
>  		.mmu_features		= MMU_FTRS_POWER7,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
> @@ -458,6 +460,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_name		= "POWER7 (raw)",
>  		.cpu_features		= CPU_FTRS_POWER7,
>  		.cpu_user_features	= COMMON_USER_POWER7,
> +		.cpu_user_features2	= COMMON_USER2_POWER7,
>  		.mmu_features		= MMU_FTRS_POWER7,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
> @@ -475,6 +478,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_name		= "POWER7+ (raw)",
>  		.cpu_features		= CPU_FTRS_POWER7,
>  		.cpu_user_features	= COMMON_USER_POWER7,
> +		.cpu_user_features	= COMMON_USER2_POWER7,

^ Oops here, I think.    Please consider applying this on top.
Untested, but seems obvious.

Fix a typo in setting COMMON_USER2_POWER7 bits to .cpu_user_features2
cpu specs table.

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>


diff --git a/arch/powerpc/kernel/cputable.c
b/arch/powerpc/kernel/cputable.c
index c60bbec..51eecb5 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -482,7 +482,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
                .cpu_name               = "POWER7+ (raw)",
                .cpu_features           = CPU_FTRS_POWER7,
                .cpu_user_features      = COMMON_USER_POWER7,
-               .cpu_user_features      = COMMON_USER2_POWER7,
+               .cpu_user_features2     = COMMON_USER2_POWER7,
                .mmu_features           = MMU_FTRS_POWER7,
                .icache_bsize           = 128,
                .dcache_bsize           = 128,

















>  		.mmu_features		= MMU_FTRS_POWER7,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
