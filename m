Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Nw43RXfzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 00:01:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/mm: Implement CONFIG_DEBUG_RODATA on PPC32
In-Reply-To: <eabf767c896a023e5670adfa07398f1008756c13.1492596044.git.christophe.leroy@c-s.fr>
References: <cover.1492596044.git.christophe.leroy@c-s.fr>
 <eabf767c896a023e5670adfa07398f1008756c13.1492596044.git.christophe.leroy@c-s.fr>
Date: Thu, 20 Apr 2017 00:01:39 +1000
Message-ID: <87inm05we4.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 32509de6ce4c..4af81fb23653 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -526,7 +526,9 @@ void ftrace_replace_code(int enable)
>   */
>  void arch_ftrace_update_code(int command)
>  {
> +	set_kernel_text_rw();
>  	ftrace_modify_all_code(command);
> +	set_kernel_text_ro();
>  }
  
I'm not sure that's the right place for that.

If you look at other arches they hook into ftrace_modify_code(), where
you have the address that's being modified.

cheers
