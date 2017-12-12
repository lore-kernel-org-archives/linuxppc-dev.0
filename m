Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yx1md33tnzDrWW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 01:05:05 +1100 (AEDT)
Date: Tue, 12 Dec 2017 08:05:01 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171212140501.44vf4xcz6jhbqofd@treble>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171212113912.GA1907@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2017 at 12:39:12PM +0100, Torsten Duwe wrote:
> Hi all,
> 
> The "Power Architecture 64-Bit ELF V2 ABI" says in section 2.3.2.3:
> 
> [...] There are several rules that must be adhered to in order to ensure
> reliable and consistent call chain backtracing:
> 
> * Before a function calls any other function, it shall establish its
>   own stack frame, whose size shall be a multiple of 16 bytes.

What about leaf functions?  If a leaf function doesn't establish a stack
frame, and it has inline asm which contains a blr to another function,
this ABI is broken.

Also, even for non-leaf functions, is it possible for GCC to insert the
inline asm before it sets up the stack frame?  (This is an occasional
problem on x86.)

Also, what about hand-coded asm?

> To me this sounds like the equivalent of HAVE_RELIABLE_STACKTRACE.
> This patch may be unneccessarily limited to ppc64le, but OTOH the only
> user of this flag so far is livepatching, which is only implemented on
> PPCs with 64-LE, a.k.a. ELF ABI v2.

In addition to fixing the above issues, the unwinder also needs to
detect interrupts (i.e., preemption) and page faults on the stack of a
blocked task.  If a function were preempted before it created a stack
frame, or if a leaf function blocked on a page fault, the stack trace
will skip the function's caller, so such a trace will need to be
reported to livepatch as unreliable.

Furthermore, the "reliable" unwinder needs to have a way to report an
error if it doesn't reach the end.  This probably just means ensuring
that it reaches the user mode registers on the stack.

And as Miroslav mentioned, once that's all done, implement
save_stack_trace_tsk_reliable().

I don't think the above is documented anywhere, it would be good to put
it in the livepatch doc.

-- 
Josh
