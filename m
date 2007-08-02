Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD2B6DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:41:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KfP99025537
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:41:25 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KfPgZ215458
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:41:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KfPtu011179
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:41:25 -0600
Subject: Re: [PATCH] Use 1TB segments
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
References: <18095.59959.698141.565343@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Aug 2007 15:41:23 -0500
Message-Id: <1186087283.22717.80.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul, 
   just a few questions.  

On Wed, 2007-08-01 at 12:04 +1000, Paul Mackerras wrote:
> This makes the kernel use 1TB segments for all kernel mappings and for
> user addresses of 1TB and above, on machines which support them
> (currently POWER5+ and POWER6).  We don't currently use 1TB segments
> for user addresses < 1T, since that would effectively prevent 32-bit
> processes from using huge pages unless we also had a way to revert to
> using 256MB segments.

I think I have a question about "user address < 1T"..  once I think on
it a bit more it'll either click, or I'll have a question
articulated. :-)


> -static inline void __tlbiel(unsigned long va, unsigned int psize)
> +static inline void __tlbiel(unsigned long va, int psize, int ssize)

> -static inline void tlbie(unsigned long va, int psize, int local)
> +static inline void tlbie(unsigned long va, int psize, int ssize, int local)

>  static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
>  			unsigned long pa, unsigned long rflags,
> -			unsigned long vflags, int psize)
> +			unsigned long vflags, int psize, int ssize)

>  static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
> -				 unsigned long va, int psize, int local)
> +				 unsigned long va, int psize, int ssize,
> +				 int local)

Is there technical reason why the 'local' variable remains at the end of
the parm list for these?   In other cases 'ssize' simply gets added to
the end of the parm list. 

> +static int __init htab_dt_scan_seg_sizes(unsigned long node,
> +					 const char *uname, int depth,
> +					 void *data)
> +{
> +	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +	u32 *prop;
> +	unsigned long size = 0;
> +
> +	/* We are scanning "cpu" nodes only */
> +	if (type == NULL || strcmp(type, "cpu") != 0)
> +		return 0;
> +
> +	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,processor-segment-sizes",
> +					  &size);
> +	if (prop != NULL && size >= 8) {
> +		if (prop[0] == 0x1c && prop[1] == 0x28) {

This is 0x1c indicating 2^28 for 256M; and 0x28 indicating 2^40 for 1TB
segments.

Will there ever be a segment size between the two?  Or will the
representation every vary from this?  i.e. wondering if prop[0] will
always be for 256M and prop[1] for 1TB.  

> +#define slb_vsid_shift(ssize)	\
> +	((ssize) == MMU_SEGSIZE_256M? SLB_VSID_SHIFT: SLB_VSID_SHIFT_1T)

> @@ -100,12 +106,13 @@ void slb_flush_and_rebolt(void)
>  	vflags = SLB_VSID_KERNEL | vmalloc_llp;
> 
>  	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
> -	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET)
> +	mask = (mmu_kernel_ssize == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T;

Is this one worthy of a #define like the slb_vsid_shift() above? 

> +#define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */

> +#define VSID_MULTIPLIER_1T	ASM_CONST(12538073)	/* 24-bit prime */

Anything special in how this 24-bit prime value was selected?   (same
question could be for the 28-bit prime, though I see that value was
updated at least once a few years back)

-Will
