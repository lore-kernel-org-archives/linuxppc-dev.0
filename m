Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4123XB01TGzF349
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 10:42:17 +1000 (AEST)
Date: Fri, 8 Jun 2018 09:42:11 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
Message-Id: <20180608094211.0d225831bb7acc100b7c2436@kernel.org>
In-Reply-To: <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812783350.10068.4690566636762511152.stgit@devbox>
 <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
 <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
 <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
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

On Thu, 07 Jun 2018 22:07:26 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Thu, 07 Jun 2018 17:07:00 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >> > Don't call the ->break_handler() from the arm kprobes code,
> >> 					    ^^^ powerpc
> >> 
> >> > because it was only used by jprobes which got removed.
> >> > 
> >> > This also makes skip_singlestep() a static function since
> >> > only ftrace-kprobe.c is using this function.
> >> > 
> >> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> > Cc: Paul Mackerras <paulus@samba.org>
> >> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> >> > Cc: linuxppc-dev@lists.ozlabs.org
> >> > ---
> >> >  arch/powerpc/include/asm/kprobes.h   |   10 ----------
> >> >  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
> >> >  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
> >> >  3 files changed, 14 insertions(+), 43 deletions(-)
> >> 
> >> With 2 small comments...
> > 
> > 2 ? or 1 ?
> 
> Two, with one in the commit log above :)

Oops, sorry I missed it. yeah, the comment above is my mistake. I'll fix it.

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
