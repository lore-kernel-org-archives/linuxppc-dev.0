Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4351B2C0086
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2012 18:37:22 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 21 Sep 2012 14:07:18 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8L8bGaW37814274
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2012 14:07:16 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8LE6rMp025998
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2012 19:36:53 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Set paca->data_offset = 0 for boot cpu
In-Reply-To: <1348214878-32319-1-git-send-email-michael@ellerman.id.au>
References: <1348214878-32319-1-git-send-email-michael@ellerman.id.au>
Date: Fri, 21 Sep 2012 14:07:15 +0530
Message-ID: <87pq5f3h6s.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <michael@ellerman.id.au> writes:

> In commit 407821a we assigned a poison value to the paca->data_offset.
>
> Unfortunately with CONFIG_LOCK_STAT=y lockdep will read & write to percpu
> data very early in boot, prior to us initialising the percpu areas,
> leading to a crash.
>
> We have been getting away with this because the data_offset was previously
> set to zero. This causes lockdep to read & write to the initial copy of
> the percpu variables, which are discarded later in boot.
>
> Although that is "fishy", it does work, and for lock statistics it is no
> big deal to discard the counts from early boot.
>
> So set the paca->data_offset = 0 for the boot cpu paca only.
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/setup_64.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 389bd4f..efb6a41 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -208,6 +208,8 @@ void __init early_setup(unsigned long dt_ptr)
>
>  	/* Fix up paca fields required for the boot cpu */
>  	get_paca()->cpu_start = 1;
> +	/* Allow percpu accesses to "work" until we setup percpu data */
> +	get_paca()->data_offset = 0;
>
>  	/* Probe the machine type */
>  	probe_machine();
> -- 
> 1.7.9.5
