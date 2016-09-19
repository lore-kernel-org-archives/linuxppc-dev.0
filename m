Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sd9DV2sz2zDsd9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 01:44:25 +1000 (AEST)
Date: Mon, 19 Sep 2016 12:44:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 rmk+kernel@arm.linux.org.uk, jolsa@kernel.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, namhyung@kernel.org
Subject: Re: [PATCH v6 4/7] perf annotate: Do not ignore call instruction
 with indirect target
Message-ID: <20160919154413.GA14725@kernel.org>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471611578-11255-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1471611578-11255-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Aug 19, 2016 at 06:29:35PM +0530, Ravi Bangoria escreveu:
> Do not ignore call instruction with indirect target when its already
> identified as a call. This is an extension of commit e8ea1561952b
> ("perf annotate: Use raw form for register indirect call instructions")
> to generalize annotation for all instructions with indirect calls.
> 
> This is needed for certain powerpc call instructions that use address
> in a register (such as bctrl, btarl, ...).
> 
> Apart from that, when kcore is used to disassemble function, all call
> instructions were ignored. This patch will fix it as a side effect by
> not ignoring them. For example,
> 
> Before (with kcore):
>        mov    %r13,%rdi
>        callq  0xffffffff811a7e70
>      ^ jmpq   64
>        mov    %gs:0x7ef41a6e(%rip),%al
> 
> After (with kcore):
>        mov    %r13,%rdi
>      > callq  0xffffffff811a7e70
>      ^ jmpq   64
>        mov    %gs:0x7ef41a6e(%rip),%al

Ok, makes sense, but then now I have the -> and can't press enter to go
to that function, in fact for the case I'm using as a test, the
vsnprintf kernel function, I get:

       │ 56:   test   %al,%al                                                                                                                                ▒
       │     ↓ je     81                                                                                                                                     ▒
       │       lea    -0x38(%rbp),%rsi                                                                                                                       ▒
       │       mov    %r15,%rdi                                                                                                                              ▒
       │     → callq  0xffffffff993e3230 

That 0xffffffff993e3230 should've been resolved to:

[root@jouet ~]# grep ffffffff993e3230 /proc/kallsyms 
ffffffff993e3230 t format_decode

Trying to investigate why it doesn't...

- Arnaldo

> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> [Suggested about 'bctrl' instruction]
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v6:
>   - No change
> 
>  tools/perf/util/annotate.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ea07588..a05423b 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -81,16 +81,12 @@ static int call__parse(struct ins_operands *ops, const char *norm_arch)
>  	return ops->target.name == NULL ? -1 : 0;
>  
>  indirect_call:
> -	tok = strchr(endptr, '(');
> -	if (tok != NULL) {
> +	tok = strchr(endptr, '*');
> +	if (tok == NULL) {
>  		ops->target.addr = 0;
>  		return 0;
>  	}
>  
> -	tok = strchr(endptr, '*');
> -	if (tok == NULL)
> -		return -1;
> -
>  	ops->target.addr = strtoull(tok + 1, NULL, 16);
>  	return 0;
>  }
> -- 
> 2.5.5
