Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sJ8GF0M1LzDr5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 09:01:56 +1000 (AEST)
Date: Mon, 22 Aug 2016 18:01:51 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <alexander.shishkin@linux.intel.com>, <treeze.taeung@gmail.com>,
 <naveen.n.rao@linux.vnet.ibm.com>, <markus@trippelsdorf.de>,
 <chris.ryder@arm.com>, <pawel.moll@arm.com>, <mhiramat@kernel.org>,
 <rmk+kernel@arm.linux.org.uk>, <jolsa@kernel.org>, <mpe@ellerman.id.au>,
 <hemant@linux.vnet.ibm.com>, <namhyung@kernel.org>
Subject: Re: [PATCH v6 2/7] perf annotate: Add cross arch annotate support
Message-Id: <20160822180151.241ad87ad1befd72bd46c2ec@arm.com>
In-Reply-To: <1471611578-11255-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471611578-11255-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 19 Aug 2016 18:29:33 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Changes in v6:
>   - Instead of adding only those instructions defined in #ifdef __arm__,
>     add all instructions from default table to arm table.
..
> +static struct ins instructions_arm[] = {
>  	{ .name = "add",   .ops  = &mov_ops, },
>  	{ .name = "addl",  .ops  = &mov_ops, },
>  	{ .name = "addq",  .ops  = &mov_ops, },
>  	{ .name = "addw",  .ops  = &mov_ops, },
>  	{ .name = "and",   .ops  = &mov_ops, },
> -#ifdef __arm__
> -	{ .name = "b",     .ops  = &jump_ops, }, // might also be a call
> +	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
>  	{ .name = "bcc",   .ops  = &jump_ops, },
>  	{ .name = "bcs",   .ops  = &jump_ops, },
>  	{ .name = "beq",   .ops  = &jump_ops, },
> @@ -382,7 +462,6 @@ static struct ins instructions[] = {
>  	{ .name = "blt",   .ops  = &jump_ops, },
>  	{ .name = "blx",   .ops  = &call_ops, },
>  	{ .name = "bne",   .ops  = &jump_ops, },
> -#endif
>  	{ .name = "bts",   .ops  = &mov_ops, },
>  	{ .name = "call",  .ops  = &call_ops, },
>  	{ .name = "callq", .ops  = &call_ops, },
> @@ -471,24 +550,48 @@ static int ins__cmp(const void *a, const void *b)
>  	return strcmp(ia->name, ib->name);
>  }

Thanks, I've gone through the list and removed all not-ARM
instructions, and added some missing ARM branch instructions:

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b2c6cf3..9d686504 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -451,9 +451,6 @@ static struct ins instructions_x86[] = {
 
 static struct ins instructions_arm[] = {
 	{ .name = "add",   .ops  = &mov_ops, },
-	{ .name = "addl",  .ops  = &mov_ops, },
-	{ .name = "addq",  .ops  = &mov_ops, },
-	{ .name = "addw",  .ops  = &mov_ops, },
 	{ .name = "and",   .ops  = &mov_ops, },
 	{ .name = "b",     .ops  = &jump_ops, }, /* might also be a call */
 	{ .name = "bcc",   .ops  = &jump_ops, },
@@ -463,81 +460,20 @@ static struct ins instructions_arm[] = {
 	{ .name = "bgt",   .ops  = &jump_ops, },
 	{ .name = "bhi",   .ops  = &jump_ops, },
 	{ .name = "bl",    .ops  = &call_ops, },
+	{ .name = "ble",   .ops  = &jump_ops, },
+	{ .name = "bleq",  .ops  = &call_ops, },
+	{ .name = "blne",  .ops  = &call_ops, },
 	{ .name = "bls",   .ops  = &jump_ops, },
 	{ .name = "blt",   .ops  = &jump_ops, },
 	{ .name = "blx",   .ops  = &call_ops, },
+	{ .name = "blxne", .ops  = &call_ops, },
+	{ .name = "bmi",   .ops  = &jump_ops, },
 	{ .name = "bne",   .ops  = &jump_ops, },
-	{ .name = "bts",   .ops  = &mov_ops, },
-	{ .name = "call",  .ops  = &call_ops, },
-	{ .name = "callq", .ops  = &call_ops, },
+	{ .name = "bpl",   .ops  = &jump_ops, },
 	{ .name = "cmp",   .ops  = &mov_ops, },
-	{ .name = "cmpb",  .ops  = &mov_ops, },
-	{ .name = "cmpl",  .ops  = &mov_ops, },
-	{ .name = "cmpq",  .ops  = &mov_ops, },
-	{ .name = "cmpw",  .ops  = &mov_ops, },
-	{ .name = "cmpxch", .ops  = &mov_ops, },
-	{ .name = "dec",   .ops  = &dec_ops, },
-	{ .name = "decl",  .ops  = &dec_ops, },
-	{ .name = "imul",  .ops  = &mov_ops, },
-	{ .name = "inc",   .ops  = &dec_ops, },
-	{ .name = "incl",  .ops  = &dec_ops, },
-	{ .name = "ja",	   .ops  = &jump_ops, },
-	{ .name = "jae",   .ops  = &jump_ops, },
-	{ .name = "jb",	   .ops  = &jump_ops, },
-	{ .name = "jbe",   .ops  = &jump_ops, },
-	{ .name = "jc",	   .ops  = &jump_ops, },
-	{ .name = "jcxz",  .ops  = &jump_ops, },
-	{ .name = "je",	   .ops  = &jump_ops, },
-	{ .name = "jecxz", .ops  = &jump_ops, },
-	{ .name = "jg",	   .ops  = &jump_ops, },
-	{ .name = "jge",   .ops  = &jump_ops, },
-	{ .name = "jl",    .ops  = &jump_ops, },
-	{ .name = "jle",   .ops  = &jump_ops, },
-	{ .name = "jmp",   .ops  = &jump_ops, },
-	{ .name = "jmpq",  .ops  = &jump_ops, },
-	{ .name = "jna",   .ops  = &jump_ops, },
-	{ .name = "jnae",  .ops  = &jump_ops, },
-	{ .name = "jnb",   .ops  = &jump_ops, },
-	{ .name = "jnbe",  .ops  = &jump_ops, },
-	{ .name = "jnc",   .ops  = &jump_ops, },
-	{ .name = "jne",   .ops  = &jump_ops, },
-	{ .name = "jng",   .ops  = &jump_ops, },
-	{ .name = "jnge",  .ops  = &jump_ops, },
-	{ .name = "jnl",   .ops  = &jump_ops, },
-	{ .name = "jnle",  .ops  = &jump_ops, },
-	{ .name = "jno",   .ops  = &jump_ops, },
-	{ .name = "jnp",   .ops  = &jump_ops, },
-	{ .name = "jns",   .ops  = &jump_ops, },
-	{ .name = "jnz",   .ops  = &jump_ops, },
-	{ .name = "jo",	   .ops  = &jump_ops, },
-	{ .name = "jp",	   .ops  = &jump_ops, },
-	{ .name = "jpe",   .ops  = &jump_ops, },
-	{ .name = "jpo",   .ops  = &jump_ops, },
-	{ .name = "jrcxz", .ops  = &jump_ops, },
-	{ .name = "js",	   .ops  = &jump_ops, },
-	{ .name = "jz",	   .ops  = &jump_ops, },
-	{ .name = "lea",   .ops  = &mov_ops, },
-	{ .name = "lock",  .ops  = &lock_ops, },
 	{ .name = "mov",   .ops  = &mov_ops, },
-	{ .name = "movb",  .ops  = &mov_ops, },
-	{ .name = "movdqa",.ops  = &mov_ops, },
-	{ .name = "movl",  .ops  = &mov_ops, },
-	{ .name = "movq",  .ops  = &mov_ops, },
-	{ .name = "movslq", .ops  = &mov_ops, },
-	{ .name = "movzbl", .ops  = &mov_ops, },
-	{ .name = "movzwl", .ops  = &mov_ops, },
 	{ .name = "nop",   .ops  = &nop_ops, },
-	{ .name = "nopl",  .ops  = &nop_ops, },
-	{ .name = "nopw",  .ops  = &nop_ops, },
 	{ .name = "or",    .ops  = &mov_ops, },
-	{ .name = "orl",   .ops  = &mov_ops, },
-	{ .name = "test",  .ops  = &mov_ops, },
-	{ .name = "testb", .ops  = &mov_ops, },
-	{ .name = "testl", .ops  = &mov_ops, },
-	{ .name = "xadd",  .ops  = &mov_ops, },
-	{ .name = "xbeginl", .ops  = &jump_ops, },
-	{ .name = "xbeginq", .ops  = &jump_ops, },
-	{ .name = "retq",  .ops  = &ret_ops, },
 };
 
 struct instructions_powerpc {

Ideally ARM would - like this powerpc implementation - add a
ins__find_arm() to handle its condition codes, but, for now, is
it possible to merge this change into this series?  I can post a
follow-up patch if not.

Thanks,

Kim
