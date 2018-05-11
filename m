Return-Path: <fbarrat@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j3c82wsfzF2Fy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 18:46:48 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4B8iTm9107227
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:46:45 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hw70a2e9m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 04:46:45 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Fri, 11 May 2018 09:46:43 +0100
Subject: Re: [PATCH v5 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 10:46:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180511061303.10728-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bde93f43-92b8-d3c8-a5c5-eb1a7495b765@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2018 à 08:12, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Switch the use of TIDR on it's CPU feature, rather than assuming it
> is available based on architecture.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   arch/powerpc/kernel/process.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 1237f13fed51..3b00da47699b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1154,7 +1154,7 @@ static inline void restore_sprs(struct thread_struct *old_thread,
>   			mtspr(SPRN_TAR, new_thread->tar);
>   	}
> 
> -	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> +	if (cpu_has_feature(CPU_FTR_P9_TIDR) &&
>   	    old_thread->tidr != new_thread->tidr)
>   		mtspr(SPRN_TIDR, new_thread->tidr);
>   #endif
> @@ -1570,7 +1570,7 @@ void clear_thread_tidr(struct task_struct *t)
>   	if (!t->thread.tidr)
>   		return;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR)) {
>   		WARN_ON_ONCE(1);
>   		return;
>   	}
> @@ -1593,7 +1593,7 @@ int set_thread_tidr(struct task_struct *t)
>   {
>   	int rc;
> 
> -	if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +	if (!cpu_has_feature(CPU_FTR_P9_TIDR))
>   		return -EINVAL;
> 
>   	if (t != current)
> 
