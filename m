Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m96x31d1zDr5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 11:06:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 7/9] powerpc/pseries: Dump the SLB contents on SLB MCE
 errors.
In-Reply-To: <153365145460.14256.11932687379471923123.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365145460.14256.11932687379471923123.stgit@jupiter.in.ibm.com>
Date: Thu, 09 Aug 2018 11:05:58 +1000
Message-ID: <87lg9g9wnd.fsf@concordia.ellerman.id.au>
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

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 7f22929ce915..233d25ff6f64 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -254,6 +254,10 @@ struct paca_struct {
>  #endif
>  #ifdef CONFIG_PPC_PSERIES
>  	u8 *mce_data_buf;		/* buffer to hold per cpu rtas errlog */
> +
> +	/* Capture SLB related old contents in MCE handler. */
> +	struct slb_entry *mce_faulty_slbs;
> +	u16 slb_save_cache_ptr;
>  #endif /* CONFIG_PPC_PSERIES */

             ^^^^^^^^^^^^^^^^^

> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index e89f675f1b5e..16a53689ffd4 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -151,6 +151,79 @@ void slb_flush_and_rebolt_realmode(void)
>  	get_paca()->slb_cache_ptr = 0;
>  }
>  
> +void slb_save_contents(struct slb_entry *slb_ptr)
> +{
> +	int i;
> +	unsigned long e, v;
> +
> +	/* Save slb_cache_ptr value. */
> +	get_paca()->slb_save_cache_ptr = get_paca()->slb_cache_ptr;

This isn't inside CONFIG_PPC_PSERIES which breaks lots of configs, eg
powernv.

  arch/powerpc/mm/slb.c:160:12: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'
  arch/powerpc/mm/slb.c:218:27: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'
  arch/powerpc/mm/slb.c:216:49: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'

http://kisskb.ozlabs.ibm.com/kisskb/head/219f20e490add009194d94fdeb480da2e385f1c6/

cheers
