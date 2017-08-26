Return-Path: <srs0=m4b2=74=gate.crashing.org=segher@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xfh2K0wCCzDrCw
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 00:56:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xfh2J6rMTz8t26
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 00:56:56 +1000 (AEST)
Date: Sat, 26 Aug 2017 09:56:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 01/10] powerpc: Handle most loads and stores in
 instruction emulation code
Message-ID: <20170826145649.GF13471@gate.crashing.org>
References: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
 <1503639722-19121-2-git-send-email-paulus@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503639722-19121-2-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Fri, Aug 25, 2017 at 03:41:53PM +1000, Paul Mackerras wrote:
> diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
> index a58777c..6840911 100644
> --- a/arch/powerpc/lib/ldstfp.S
> +++ b/arch/powerpc/lib/ldstfp.S
> @@ -178,10 +178,10 @@ _GLOBAL(do_stfd)
>  	EX_TABLE(2b,3b)
>  
>  #ifdef CONFIG_ALTIVEC
> -/* Get the contents of vrN into v0; N is in r3. */
> +/* Get the contents of vrN into v0; N is in r3. Doesn't touch r3 or r4. */
>  _GLOBAL(get_vr)
>  	mflr	r0
> -	rlwinm	r3,r3,3,0xf8
> +	rlwinm	r6,r3,3,0xf8
>  	bcl	20,31,1f
>  	blr			/* v0 is already in v0 */
>  	nop

Not new in your patch, but that bcl disturbs the link stack (only $+4
branches do not).


> +/* Convert single-precision to double, without disturbing FPRs. */
> +/* conv_sp_to_dp(double *dp, float *sp) */

That should be

+/* Convert double-precision to single, without disturbing FPRs. */
+/* conv_dp_to_sp(double *dp, float *sp) */

> +_GLOBAL(conv_dp_to_sp)


Segher
