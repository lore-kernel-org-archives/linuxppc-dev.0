Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj5qn3LsVzDwH2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 03:25:25 +1100 (AEDT)
Date: Mon, 19 Dec 2016 17:25:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
In-Reply-To: <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.20.1612191712530.6638@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Dec 2016, Josh Poimboeuf wrote:

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 215612c..b4a6663 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -155,6 +155,7 @@ config X86
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> +	select HAVE_RELIABLE_STACKTRACE		if X86_64 && FRAME_POINTER && STACK_VALIDATION

Tests to measure possible performance penalty of frame pointers were done 
by Mel Gorman. The outcome was quite clear. There IS a measurable 
impact. The percentage depends on the workflow but I think it is safe to 
say that FP usually takes 5-10 percents.

If my understanding is correct there is no single culprit. Register 
pressure is definitely not a problem. We ran simple benchmarks while 
taking a register away from GCC (RBP or a common one). The impact is a 
combination of more cacheline pressure, more memory accesses and the fact 
that the kernel contains a lot of small functions.

Thus, I think that DWARF should be the way to go here.

Other than that the patch looks good to me.

Miroslav 
