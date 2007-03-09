Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16059DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 00:07:10 +1100 (EST)
Subject: Re: [PATCH] Fix atomicity of TIF update in flush_thread() for powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20070309024525.GB9462@Krystal>
References: <20070309024525.GB9462@Krystal>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 14:06:39 +0100
Message-Id: <1173445599.24454.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, mbligh@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 .../...

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Nice catch !

> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -476,8 +476,13 @@ void flush_thread(void)
>  #ifdef CONFIG_PPC64
>  	struct thread_info *t = current_thread_info();
>  
> -	if (t->flags & _TIF_ABI_PENDING)
> -		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
> +	if (test_tsk_thread_flag(tsk, TIF_ABI_PENDING)) {
> +		clear_tsk_thread_flag(tsk, TIF_ABI_PENDING);
> +		if (test_tsk_thread_flag(tsk, TIF_32BIT))
> +			clear_tsk_thread_flag(tsk, TIF_32BIT);
> +		else
> +			set_tsk_thread_flag(tsk, TIF_32BIT);
> +	}
>  #endif
>  
>  	discard_lazy_cpu_state();
