Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8gGH55CdzDvR9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 20:51:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
In-Reply-To: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 03 Nov 2016 20:51:18 +1100
Message-ID: <87zilgnb6x.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 2e4e7d8..9b7b302 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -91,7 +91,7 @@
>   */
>  #define LOAD_HANDLER(reg, label)					\
>  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> -	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> +	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);

That's weird. We explicitly added the @l there to make it work with
binutils 2.22. Is the Redhat "2.23" not really 2.23 ?

cheers
