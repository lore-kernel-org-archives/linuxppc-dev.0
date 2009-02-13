Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45F06DDF6F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 15:15:30 +1100 (EST)
Subject: Re: [PATCH 3/7][RFC] powerpc64, tracing: add function graph tracer
	with dynamic tracing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20090212011343.074329920@goodmis.org>
References: <20090212011051.265346435@goodmis.org>
	<20090212011343.074329920@goodmis.org>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 15:15:09 +1100
Message-Id: <1234498509.26036.35.camel@pasglop>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> @@ -55,8 +56,9 @@ static unsigned char *ftrace_call_replace(unsigned
> long ip, unsigned long addr)
>  	 */
>  	addr = GET_ADDR(addr);
>  
> -	/* Set to "bl addr" */
> -	op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);
> +	/* if (link) set op to 'bl' else 'b' */
> +	op = 0x48000000 | (link ? 1 : 0);
> +	op |= (ftrace_calc_offset(ip, addr) & 0x03fffffc);

Any reason why you aren't using the code in
arch/powerpc/lib/code-patching.c here ?

> 	new = ftrace_call_replace(ip, stub, 0);
> +	memcpy(old, new, MCOUNT_INSN_SIZE);
> +	new = ftrace_call_replace(ip, addr, 0);
> +
> +	return ftrace_modify_code(ip, old, new);
> +}

Heh, memcpy of 4 bytes :-) I hope gcc is smart enough to turn that into
a simple load/store ..

Cheers,
Ben.
