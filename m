Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tn5JR49d2zDsyf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:15:33 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBQ4EAWu064276
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Dec 2016 23:15:30 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27jmnkuaa1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Dec 2016 23:15:30 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 26 Dec 2016 14:15:28 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 931312BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:15:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBQ4FPAE31129682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:15:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBQ4FPS4024913
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Dec 2016 15:15:25 +1100
Subject: Re: [PATCH] powerpc/perf: use is_kernel_addr macro in
 perf_get_misc_flags()
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1482559549-22273-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 26 Dec 2016 09:45:18 +0530
MIME-Version: 1.0
In-Reply-To: <1482559549-22273-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58609956.3040204@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2016 11:35 AM, Madhavan Srinivasan wrote:
> Cleanup to use is_kernel_addr macro.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 2cdf2647cdb0..d9c74fd1b37b 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -243,7 +243,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>  	 */
>  	if (ppmu->flags & PPMU_NO_SIPR) {
>  		unsigned long siar = mfspr(SPRN_SIAR);
> -		if (siar >= PAGE_OFFSET)
> +		if (is_kernel_addr(siar))
>  			return PERF_RECORD_MISC_KERNEL;
>  		return PERF_RECORD_MISC_USER;
>  	}

While you are at this, why not also clean up these in the xmon code
as well.

arch/powerpc/xmon/xmon.c:		if (sp < PAGE_OFFSET) {
arch/powerpc/xmon/xmon.c:				if (lr < PAGE_OFFSET
arch/powerpc/xmon/xmon.c:			} else if (lr >= PAGE_OFFSET
arch/powerpc/xmon/xmon.c:	if (addr < PAGE_OFFSET)
