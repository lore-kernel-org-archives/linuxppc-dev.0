Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.231])
 by lists.ozlabs.org (Postfix) with ESMTP id 37EB31A0FEE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 22:48:12 +1000 (AEST)
Date: Fri, 19 Jun 2015 08:41:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] ppc64 LE ABI v2 ftrace-with-regs implementation
Message-ID: <20150619084149.1c625bf8@grimm.local.home>
In-Reply-To: <20150619121703.GC3805@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <CAOJe8K3B4fEfSpMO3L6WNYxvPfj_rE87dpWZSLY-3EFLOrPyTQ@mail.gmail.com>
 <20150619121703.GC3805@lst.de>
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

On Fri, 19 Jun 2015 14:17:03 +0200
Torsten Duwe <duwe@lst.de> wrote:

> On Fri, Jun 19, 2015 at 10:15:44AM +0300, Denis Kirjanov wrote:
> > 
> > Hi Torsten,
> > 
> > could you provide a description how you did test that.
> 
> Vanilla kernel, those patches on top, built as described to
> Steven in the previous mail (.config attached there, built
> natively on ppc64le ABIv2, mentioned tool versions)
> 

Great that you got it working on your machine. But you need to do it in
a way that you don't break builds of existing machines, with existing
(still supported) compilers.

-- Steve

> make vmlinux, make modules, build initrd
> qemu-system-ppc64 -no-reboot -enable-kvm -m 20480 -kernel vmlinux
>   -initrd initrd.gz -append console=hvc0 -nographic -vga none
> inside:
> cd /sys/kernel/debug/tracing
> mkdir instances/Foo
> cd instances/Foo
> echo function > current_tracer
> 
> current_tracer holds "nop" or "function"; the transition is accompanied 
> by heavy binary patching. When the function tracer is active, almost all
> calls go through ftrace_caller. This should be enough for a start; the
> proper stack frame layout details for the tracer functions still remain
> to be checked...
> 
> 	Torsten
