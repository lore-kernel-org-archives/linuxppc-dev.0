Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wT01f74lrzDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 15:22:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/jprobes: Save and restore the parameter save
 area
In-Reply-To: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 15:22:30 +1000
Message-ID: <87d1b6lox5.fsf@concordia.ellerman.id.au>
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

> As pointed out in x86 setjmp_pre_handler(), we need to save and restore
> the parameter save area since the jprobe hook might overwrite it. Since
> there is no easy way to identify the size of the parameter save area,
> we choose to save/restore a fixed 16 [double]word-sized area including
> the stack frame header.
>
> We introduce STACK_FRAME_PARM_SAVE to encode the offset of the parameter
> save area from the stack frame pointer. Remove the similarly named
> PARAMETER_SAVE_AREA_OFFSET in ptrace.c as those are currently not used
> anywhere.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Michael,
> I've set the limit to 16 parameters as being a "reasonable" number, but
> we could very well make this 24 or 32 if we want to be sure. Let me
> know what you prefer.

That sounds incredibly fragile. Are we really just guessing at the size
required? What happens if we under estimate, do we crash, silently
corrupt data .. ?

cheers
