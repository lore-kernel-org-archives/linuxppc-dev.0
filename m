Return-Path: <amodra@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPtvw5VFJzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 00:21:32 +1100 (AEDT)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vPtvw1Kjlz9s8B
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2017 00:21:32 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id y6so3862812pgy.2
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2017 05:21:32 -0800 (PST)
Date: Fri, 17 Feb 2017 23:51:25 +1030
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Subject: Re: [RFC PATCH] powerpc: Fix dubious r0 usage
Message-ID: <20170217132125.GV3731@bubble.grove.modra.org>
References: <1487333333-17221-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487333333-17221-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2017 at 11:08:53PM +1100, Michael Ellerman wrote:
> Bleeding edge binutils no longer accepts r0 in places where the CPU
> interprets the value as a literal 0.

Wow!  That was quite some cleanup.  I think I'd better turn the error
into a warning..

> --- a/arch/powerpc/purgatory/trampoline.S
> +++ b/arch/powerpc/purgatory/trampoline.S
> @@ -67,7 +67,7 @@ master:
>  	mr	%r16,%r3	/* save dt address in reg16 */
>  	li	%r4,20
>  	LWZX_BE	%r6,%r3,%r4	/* fetch __be32 version number at byte 20 */
> -	cmpwi	%r0,%r6,2	/* v2 or later? */
> +	cmpwi	0,%r6,2		/* v2 or later? */
>  	blt	1f
>  	li	%r4,28
>  	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */

With this one, it would probably be better to omit the zero (BF
field).

-- 
Alan Modra
Australia Development Lab, IBM
