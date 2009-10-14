Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 14275B7088
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 14:01:32 +1100 (EST)
Subject: Re: [PATCH] Ftrace : fix function_graph tracer OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4ACDFC83.4080205@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop> <1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
	<4ACC57C4.5010002@in.ibm.com> <1254906621.2409.1.camel@pasglop>
	<4ACDFC83.4080205@in.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Oct 2009 23:01:24 -0400
Message-Id: <1255489284.7113.3121.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 20:21 +0530, Sachin Sant wrote:
> Switch to LOAD_REG_ADDR().
> 
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---
> diff -Naurp old/arch/powerpc/kernel/entry_64.S
> new/arch/powerpc/kernel/entry_64.S
> --- old/arch/powerpc/kernel/entry_64.S  2009-10-08 18:37:44.000000000
> +0530
> +++ new/arch/powerpc/kernel/entry_64.S  2009-10-08 18:34:33.000000000
> +0530
> @@ -1038,8 +1038,8 @@ _GLOBAL(mod_return_to_handler)
>          * We are in a module using the module's TOC.
>          * Switch to our TOC to run inside the core kernel.
>          */
> -       LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
> -       ld      r2, 8(r4)
> +       ld      r2, PACATOC(r13)
> +       LOAD_REG_ADDR(r4,ftrace_return_to_handler)

Actually, the loading of this register is not needed. The original used
the loading to get the r2.

I actually wrote a fix for this a month ago. I never sent it out because
I was distracted by other issues.

I'll send out the two patches I had now.

Could yo test them?

Thanks!

-- Steve

>  
>         bl      .ftrace_return_to_handler
>         nop
> 
