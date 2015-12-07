Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1F941A0E61
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 01:42:45 +1100 (AEDT)
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF2C91401DA
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2015 01:42:44 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so196237144ykd.0
 for <linuxppc-dev@ozlabs.org>; Mon, 07 Dec 2015 06:42:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
References: <1448389419-5296-1-git-send-email-kda@linux-powerpc.org>
Date: Mon, 7 Dec 2015 17:42:42 +0300
Message-ID: <CAOJe8K3wP_KT9XAOhduw35dD=QVaDUVBMi-jSeRDLGD+Zs-a-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: introduce TRACE_EVENT_FN_COND macro
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> TRACE_EVENT_FN can't be used in some circumstances
> like invoking trace functions from offlined CPU due
> to RCU usage.
>
> This patch adds the TRACE_EVENT_FN_COND macro
> to make such trace points conditional.
>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Hi Steven,
are you going to take this series through your tree?

Thanks!

> ---
>  include/linux/tracepoint.h   | 4 ++++
>  include/trace/define_trace.h | 6 ++++++
>  include/trace/trace_events.h | 6 ++++++
>  3 files changed, 16 insertions(+)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 696a339c..45b3fcf 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -493,6 +493,10 @@ extern void syscall_unregfunc(void);
>  #define TRACE_EVENT_FN(name, proto, args, struct,		\
>  		assign, print, reg, unreg)			\
>  	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
> +#define TRACE_EVENT_FN_COND(name, proto, args, cond, struct,		\
> +		assign, print, reg, unreg)			\
> +	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
> +			PARAMS(args), PARAMS(cond))
>  #define TRACE_EVENT_CONDITION(name, proto, args, cond,		\
>  			      struct, assign, print)		\
>  	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 2d8639e..6e3945f 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -40,6 +40,11 @@
>  		assign, print, reg, unreg)			\
>  	DEFINE_TRACE_FN(name, reg, unreg)
>
> +#undef TRACE_EVENT_FN_COND
> +#define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,		\
> +		assign, print, reg, unreg)			\
> +	DEFINE_TRACE_FN(name, reg, unreg)
> +
>  #undef DEFINE_EVENT
>  #define DEFINE_EVENT(template, name, proto, args) \
>  	DEFINE_TRACE(name)
> @@ -93,6 +98,7 @@
>
>  #undef TRACE_EVENT
>  #undef TRACE_EVENT_FN
> +#undef TRACE_EVENT_FN_COND
>  #undef TRACE_EVENT_CONDITION
>  #undef DECLARE_EVENT_CLASS
>  #undef DEFINE_EVENT
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index de996cf..170c93b 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -123,6 +123,12 @@ TRACE_MAKE_SYSTEM_STR();
>  	TRACE_EVENT(name, PARAMS(proto), PARAMS(args),			\
>  		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
>
> +#undef TRACE_EVENT_FN_COND
> +#define TRACE_EVENT_FN_COND(name, proto, args, cond, tstruct,	\
> +		assign, print, reg, unreg)				\
> +	TRACE_EVENT_CONDITION(name, PARAMS(proto), PARAMS(args), PARAMS(cond),		\
> +		PARAMS(tstruct), PARAMS(assign), PARAMS(print))		\
> +
>  #undef TRACE_EVENT_FLAGS
>  #define TRACE_EVENT_FLAGS(name, value)					\
>  	__TRACE_EVENT_FLAGS(name, value)
> --
> 2.4.0
>
>
