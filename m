Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C44D414027C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 16:35:37 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 May 2014 16:35:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1DFF62CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 16:35:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s476EPqc42467566
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 16:14:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s476ZYbx016725
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 16:35:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Emil Medve <Emilian.Medve@Freescale.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2 v2] powerpc: Enable NO_BOOTMEM
In-Reply-To: <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1399402084-6325-1-git-send-email-Emilian.Medve@Freescale.com>
 <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
Date: Wed, 07 May 2014 12:05:30 +0530
Message-ID: <87lhueumdp.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emil Medve <Emilian.Medve@Freescale.com> writes:

> Currently bootmem is just a wrapper around memblock. This gets rid of
> the wrapper code just as other ARHC(es) did: x86, arm, etc.
>
> For now only cover !NUMA systems/builds
>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>
> v2: Acknowledge that NUMA systems/builds are not covered by this patch
>
>  arch/powerpc/Kconfig  | 3 +++
>  arch/powerpc/mm/mem.c | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e099899..07b164b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -475,6 +475,9 @@ config SYS_SUPPORTS_HUGETLBFS
>  
>  source "mm/Kconfig"
>  
> +config NO_BOOTMEM
> +	def_bool !NUMA


There is actually one in  mm/Kconfig

So I guess you should make the platform that you are interested
/tested just do select No_BOOTMEM like we do in arch/arm/Kconfig etc ?

-aneesh
