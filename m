Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by lists.ozlabs.org (Postfix) with ESMTP id E28FF1A0072
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 12:21:57 +1000 (AEST)
Message-ID: <55AB09BE.5040506@hitachi.com>
Date: Sun, 19 Jul 2015 11:21:50 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kprobes: Mark OPTPROBES n/a for powerpc
References: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
In-Reply-To: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/07/16 19:56, Ananth N Mavinakayanahalli wrote:
> Kprobes uses a breakpoint instruction to trap into execution flow
> and the probed instruction is single-stepped from an alternate location.
> 
> On some architectures like x86, under certain conditions, the OPTPROBES
> feature enables replacing the probed instruction with a jump instead,
> resulting in a significant perfomance boost (one single-step exception
> is bypassed for each kprobe).

The OPTPROBE is not only for bypassing the single-step exception, but also
the breakpoint exception.
Please see commit 0dc016dbd820260b (ARM: kprobes: enable OPTPROBES for ARM 32) too,
which shows how it is done on RISC processor.

> Powerpc has an in-kernel instruction emulator. Kprobes on powerpc uses
> this emulator already and bypasses the single-step exception, with a
> lot less complexity.

So, this might miss the point. Since it is impossible to do on some RISC
processor, I agree with this change, but it should be committed with
correct comments.

Thank you,

> 
> Hence, mark OPTPROBES n/a for powerpc.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> ---
>  .../features/debug/optprobes/arch-support.txt      |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
> index b8999d8..0a3ca33 100644
> --- a/Documentation/features/debug/optprobes/arch-support.txt
> +++ b/Documentation/features/debug/optprobes/arch-support.txt
> @@ -27,7 +27,7 @@
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: | n/a  |
>      |        s390: | TODO |
>      |       score: | TODO |
>      |          sh: | TODO |
> 
> 


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
