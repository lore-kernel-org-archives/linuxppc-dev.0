Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skq909zvzF1s5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:25 +1000 (AEST)
In-Reply-To: <20180325090648.1029-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] xmon: Use __printf markup to silence compiler
Message-Id: <40skq861hKz9s3c@ozlabs.org>
Date: Fri, 25 May 2018 21:41:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-03-25 at 09:06:47 UTC, Mathieu Malaterre wrote:
> Update the other prototype declarations in asm/xmon.h.
> 
> Silence warnings (triggered at W=1) by adding relevant __printf attribute.
> Move #define at bottom of the file to prevent conflict with gcc attribute.
> 
> Solve the original warning:
> 
>   arch/powerpc/xmon/nonstdio.c:178:2: error: function might be possible candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> In turn this uncovered the following (partial list) warnings (treated as
> errors with W=1):
> 
>   arch/powerpc/xmon/xmon.c:2866:17: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘unsigned char *’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1607:31: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘struct pt_regs *’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1611:9: error: too many arguments for format [-Werror=format-extra-args]
>   arch/powerpc/xmon/xmon.c:1623:26: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘struct task_struct *’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:630:36: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1392:15: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:2570:16: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1629:25: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘pid_t {aka int}’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1168:18: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:3016:24: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘pgd_t * {aka struct <anonymous> *}’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:2339:9: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:3827:10: error: format ‘%p’ expects argument of type ‘void *’, but argument 4 has type ‘long long unsigned int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:3896:50: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/xmon/spu-dis.c:137:18: error: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:3827:10: error: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘u64 {aka long long unsigned int}’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:1665:17: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘int’ [-Werror=format=]
>   arch/powerpc/xmon/xmon.c:2339:9: error: '#' flag used with ‘%p’ gnu_printf format [-Werror=format=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e70d8f55268ba95f00c61857df2bab

cheers
