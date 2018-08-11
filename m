Return-Path: <srs0=ok2+=k2=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nTdd6x6gzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 14:33:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41nTdd5y48z8tPq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 14:33:41 +1000 (AEST)
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41nTdd0QXjz9s8f
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2018 14:33:40 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id e11-v6so4816954plb.3
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 21:33:40 -0700 (PDT)
Date: Sat, 11 Aug 2018 14:33:27 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 7/9] powerpc/pseries: Dump the SLB contents on SLB
 MCE errors.
Message-ID: <20180811143327.12255ffb@roar.ozlabs.ibm.com>
In-Reply-To: <153365145460.14256.11932687379471923123.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365145460.14256.11932687379471923123.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 07 Aug 2018 19:47:39 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> If we get a machine check exceptions due to SLB errors then dump the
> current SLB contents which will be very much helpful in debugging the
> root cause of SLB errors. Introduce an exclusive buffer per cpu to hold
> faulty SLB entries. In real mode mce handler saves the old SLB contents
> into this buffer accessible through paca and print it out later in virtual
> mode.
> 
> With this patch the console will log SLB contents like below on SLB MCE
> errors:
> 
> [  507.297236] SLB contents of cpu 0x1
> [  507.297237] Last SLB entry inserted at slot 16
> [  507.297238] 00 c000000008000000 400ea1b217000500
> [  507.297239]   1T  ESID=   c00000  VSID=      ea1b217 LLP:100
> [  507.297240] 01 d000000008000000 400d43642f000510
> [  507.297242]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297243] 11 f000000008000000 400a86c85f000500
> [  507.297244]   1T  ESID=   f00000  VSID=      a86c85f LLP:100
> [  507.297245] 12 00007f0008000000 4008119624000d90
> [  507.297246]   1T  ESID=       7f  VSID=      8119624 LLP:110
> [  507.297247] 13 0000000018000000 00092885f5150d90
> [  507.297247]  256M ESID=        1  VSID=   92885f5150 LLP:110
> [  507.297248] 14 0000010008000000 4009e7cb50000d90
> [  507.297249]   1T  ESID=        1  VSID=      9e7cb50 LLP:110
> [  507.297250] 15 d000000008000000 400d43642f000510
> [  507.297251]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297252] 16 d000000008000000 400d43642f000510
> [  507.297253]   1T  ESID=   d00000  VSID=      d43642f LLP:110
> [  507.297253] ----------------------------------
> [  507.297254] SLB cache ptr value = 3
> [  507.297254] Valid SLB cache entries:
> [  507.297255] 00 EA[0-35]=    7f000
> [  507.297256] 01 EA[0-35]=        1
> [  507.297257] 02 EA[0-35]=     1000
> [  507.297257] Rest of SLB cache entries:
> [  507.297258] 03 EA[0-35]=    7f000
> [  507.297258] 04 EA[0-35]=        1
> [  507.297259] 05 EA[0-35]=     1000
> [  507.297260] 06 EA[0-35]=       12
> [  507.297260] 07 EA[0-35]=    7f000
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> 
> Changes in V7:
> - Print slb cache ptr value and slb cache data
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    7 ++
>  arch/powerpc/include/asm/paca.h               |    4 +
>  arch/powerpc/mm/slb.c                         |   73 +++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/ras.c          |   10 +++
>  arch/powerpc/platforms/pseries/setup.c        |   10 +++
>  5 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index cc00a7088cf3..5a3fe282076d 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -485,9 +485,16 @@ static inline void hpte_init_pseries(void) { }
>  
>  extern void hpte_init_native(void);
>  
> +struct slb_entry {
> +	u64	esid;
> +	u64	vsid;
> +};
> +
>  extern void slb_initialize(void);
>  extern void slb_flush_and_rebolt(void);
>  extern void slb_flush_and_rebolt_realmode(void);
> +extern void slb_save_contents(struct slb_entry *slb_ptr);
> +extern void slb_dump_contents(struct slb_entry *slb_ptr);
>  
>  extern void slb_vmalloc_update(void);
>  extern void slb_set_size(u16 size);
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
>  } ____cacheline_aligned;
>  
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

What's the point of saving this?

> +
> +	if (!slb_ptr)
> +		return;

Can this ever happen?

> +
> +	for (i = 0; i < mmu_slb_size; i++) {
> +		asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
> +		asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));

Does the UM say these instructions can cause machine checks if the SLB
is corrupted? It talks about mfslb instruction causing MCE, but there
seems to be no such instruction so I wonder if that's a typo for slbmf?

Seems like a parity error in the SLB should cause a MCE, at least,
because it can't guarantee valid data for the instruction in that case
(multi-hit may be different because you aren't searching by EA).

You could limit slb saving to a single level of recursion to avoid
the problem.

Thanks,
Nick
