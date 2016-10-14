Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swCj01Gq3zDt26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 14:27:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: link error on orphan sections
In-Reply-To: <20161012070020.30170-1-npiggin@gmail.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
Date: Fri, 14 Oct 2016 14:27:45 +1100
Message-ID: <87twcfd2z2.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 8295f51..9f4d85e 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -317,6 +319,16 @@ SECTIONS
>  	_end = . ;
>  	PROVIDE32 (end = .);
>  
> -	/* Sections to be discarded. */
> +	STABS_DEBUG
> +
> +	DWARF_DEBUG

With DEBUG_INFO=y I'm seeing:

  /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_addr' from `arch/powerpc/kernel/prom_init.o'.
  /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_gnu_pubnames' from `arch/powerpc/kernel/prom_init.o'.
  /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_gnu_pubtypes' from `arch/powerpc/kernel/prom_init.o'.

And many more for the same sections from other files.

cheers
