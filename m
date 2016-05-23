Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCrR910jJzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 17:54:29 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id eu11so2333pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 00:54:29 -0700 (PDT)
Date: Mon, 23 May 2016 17:54:17 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Improve comment explaining why we modify VRSAVE
Message-ID: <20160523175417.2d96049b@camb691>
In-Reply-To: <20160520044134.62712b79@kryten>
References: <20160520044134.62712b79@kryten>
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

On Fri, 20 May 2016 04:41:34 +1000
Anton Blanchard via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org> wrote:

> The comment explaining why we modify VRSAVE is misleading, glibc
> does rely on the behaviour. Update the comment.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> index 1c2e7a3..3907fcf 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -70,10 +70,11 @@ _GLOBAL(load_up_altivec)
>  	MTMSRD(r5)			/* enable use of AltiVec now */
>  	isync
>  
> -	/* Hack: if we get an altivec unavailable trap with VRSAVE
> -	 * set to all zeros, we assume this is a broken application
> -	 * that fails to set it properly, and thus we switch it to
> -	 * all 1's
> +	/*
> +	 * While userspace in general ignores VRSAVE, glibc uses it as a
> +	 * boolean to optimise userspace context save/restore. Whenever we
> +	 * take an altivec unavailable exception we must set VRSAVE to
> +	 * something non zero. Set it to all 1s.

I always assumed this was a little more complicated and that it revolved
around trying to adhere to the programming note in 5.3.3 of the ISA:

"The VRSAVE register can be used to indicate which VRs are currently being used
by a program. If this is done, the operating system could save only those VRs
when an 'interrupt' occurs, and could restore only those VRs when resuming the
interrupted program."

In this scenario we don't trust userspace to do anything sane (IE the old
comment saying 'broken application' because zero here can't be correct) and
we're loading all 1's because we're now switching all (32) altivec registers.
Obviously we're still going to switch all 32 even if userspace adheres to the
note, doing so doesn't violate the note.

Admittedly the note really does imply that it's userspaces responsibility to
set it, however, if we're going to change it to something other than zero, it
might be worth noting that all 1's is 'best' in case anyone does ever follow
that note.

Perhaps ending with "... Set it to all 1s as a best effort to adhere to the
programming note in '5.3.3 VR Save Register' of the ISA"

Having said all that, a reminder that glibc does look at it is very welcome
here!

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

>  	 */
>  	mfspr	r4,SPRN_VRSAVE
>  	cmpwi	0,r4,0
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
