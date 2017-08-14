Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWG146JZgzDqn6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:00:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Dump ftrace buffers for the current
 CPU only
In-Reply-To: <1501704846-22625-1-git-send-email-leitao@debian.org>
References: <1501704846-22625-1-git-send-email-leitao@debian.org>
Date: Mon, 14 Aug 2017 23:00:07 +1000
Message-ID: <87efseqp7s.fsf@concordia.ellerman.id.au>
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

Breno Leitao <leitao@debian.org> writes:
> @@ -2231,6 +2232,19 @@ static void xmon_rawdump (unsigned long adrs, long ndump)
>  	printf("\n");
>  }
>  
> +static void dump_tracing(void)
> +{
> +	int c;
> +
> +	c = inchar();
> +	if (c == 'c')
> +		ftrace_dump(DUMP_ORIG);
> +	else
> +		ftrace_dump(DUMP_ALL);
> +
> +	tracing_on();
> +}

Thinking about this some more, two things that would make this *really*
useful.

Firstly, it would be great if we could dump the buffer for *another*
CPU. Currently ftrace_dump() doesn't support that, and maybe it can't
because of the ring buffer design (?), but it would be really great if
you could dump another CPU's buffer.

That would be great eg. when a CPU is stuck and doesn't come into xmon,
you could use the trace buffer to work out where it is. You can do it
now, by dumping the whole trace buffer, but it's quite tricky to spot
that one CPU amongst all the others.


The second thing that would be good is if dumping the trace buffer from
xmon didn't consume the trace. Currently if you do 'dt' to dump the
trace buffer, and then realise actually you should have just dumped it
for one CPU then you're out of luck.

So it'd be nice if we could dump but leave the trace intact. That would
also be good from an "xmon doesn't perturb the system" (too much) point
of view, ie. if you drop to xmon and dump the trace then currently the
trace is no longer available.

cheers
