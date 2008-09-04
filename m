Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EC91DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 13:06:27 +1000 (EST)
Subject: Re: [PATCH v2 1/4] powerpc: Introduce local (non-broadcast) forms
	of tlb invalidates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 13:06:15 +1000
Message-Id: <1220497575.4879.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-29 at 08:56 -0500, Kumar Gala wrote:

>  #if defined(CONFIG_40x) || defined(CONFIG_8xx)
>  #define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
> @@ -38,31 +41,31 @@ extern void _tlbia(void);
>  
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	_tlbia();
> +	_tlbil_all();
>  }
>  

Why not _tlbil_pid() ?

I think those flush_tlb_* should be implemented once for
all SW loaded TLB processors. The low level tlbil_pid
can just alias to tlbil_all() on CPUs that don't support
it (either that, or you do a read/test/write loop over
the TLB, might be worth experimenting with both).

Cheers,
Ben.
