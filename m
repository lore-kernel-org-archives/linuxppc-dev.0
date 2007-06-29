Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A682DDFB4
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 06:40:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TKeFH8016683
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 16:40:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TKeFU3217670
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 14:40:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TKeFUn017902
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 14:40:15 -0600
Subject: Re: [PATCH v2] Fix VDSO gettimeofday() when called with NULL
	struct timeval.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Tony Breeds <tony@bakeyournoodle.com>,
	will_schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20070625235032.GH9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 15:39:44 -0500
Message-Id: <1183149584.22547.51.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-26 at 09:50 +1000, Tony Breeds wrote:
> Updated to include feedback from Ben and Segher, also reposition the
> compare in the 64bit VDSO to catch all the references to tv.


> --- working.orig/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ working/arch/powerpc/kernel/vdso64/gettimeofday.S

<snippage>
> @@ -32,6 +31,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  	mr	r11,r3			/* r11 holds tv */
>  	mr	r10,r4			/* r10 holds tz */
>  	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
> +	cmpldi	r10,0			/* check if tv is NULL */

Whoops!    r10 holds tz value, not tv.   This should be r11.  

As is, a (64-bit) userspace app calling gettimeofday(&tv,NULL); will
"silently fail", and the application is left using whatever old data
happens to be in the tv structure.

This affected my G5 (gentoo), most noticable when apps like 'ping' and
nfs-mounts quit working properly.  :-) 

patch follows momentarily... 

> +	beq	2f
>  	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
>  	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
>  	ori     r7,r7,16960
> @@ -43,8 +44,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
>  					 * XSEC_PER_SEC
>  					 */
>  	rldicl  r0,r0,44,20
> -	cmpldi	cr0,r10,0		/* check if tz is NULL */
>  	std	r0,TVAL64_TV_USEC(r11)	/* store usec in tv */
> +2:	cmpldi	r10,0			/* check if tz is NULL */
>  	beq	1f
>  	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
>  	lwz	r5,CFG_TZ_DSTTIME(r3)
> 
> Yours Tony
> 
>   linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
>   Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
