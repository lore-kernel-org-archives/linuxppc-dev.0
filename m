Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A1AE2C008F
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 21:02:45 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 16:23:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B7FEF125805B
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 16:31:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RB2uh432702656
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 16:32:56 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RB2baj014094
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 21:02:38 +1000
Message-ID: <51CC1BA3.5000801@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 16:31:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 4/8] powerpc/perf: Use existing out label in
 power_pmu_enable()
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-4-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> In power_pmu_enable() we can use the existing out label to reduce the
> number of return paths.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

> ---
>  arch/powerpc/perf/core-book3s.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 3d566ee..af4b4b1 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -919,12 +919,13 @@ static void power_pmu_enable(struct pmu *pmu)
> 
>  	if (!ppmu)
>  		return;
> +
>  	local_irq_save(flags);
> +
>  	cpuhw = &__get_cpu_var(cpu_hw_events);
> -	if (!cpuhw->disabled) {
> -		local_irq_restore(flags);
> -		return;
> -	}
> +	if (!cpuhw->disabled)
> +		goto out;
> +
>  	cpuhw->disabled = 0;
> 
>  	/*
> 
