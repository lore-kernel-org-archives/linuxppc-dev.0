Return-Path: <anton@samba.org>
Date: Tue, 20 Aug 2013 20:30:07 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Never handle VSX alignment exceptions from kernel
Message-ID: <20130820203007.4e0803f6@kryten>
In-Reply-To: <CAEjGV6x6fMPMunzfcm7O0RYHdxEyhnUoH1FcZno2AQRHtqkMVw@mail.gmail.com>
References: <20130820160516.596a85a4@kryten>
 <CAEjGV6x6fMPMunzfcm7O0RYHdxEyhnUoH1FcZno2AQRHtqkMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> Can you say what will happen when you apply this patch.  ie It
> produces one oops rather than megabytes of crap making it easier
> to debug.

Good point, updated.

> Also, can you give a clue as to how you can hit this since it should
> never happen in the first place.  I assume it's some LE corner case...

While it was found on LE, after reading the POWER7 docs I think we can
hit it pretty easily on BE. All it takes is a 4 byte aligned VSX load
or store. Misaligning the FPR array in the thread struct would be
enough to do it and we'd end up scribbling over memory until we self
destruct.

Anton
--

The VSX alignment handler needs to write out the existing VSX
state to memory before operating on it (flush_vsx_to_thread()).
If we take a VSX alignment exception in the kernel bad things
will happen. It looks like we could write the kernel state out
to the user process, or we could handle the kernel exception
using data from the user process (depending if MSR_VSX is set
or not).

Worse still, if the code to read or write the VSX state causes an
alignment exception, we will recurse forever. I ended up with
hundreds of megabytes of kernel stack to look through as a result.

Floating point and SPE code have similar issues but already include
a user check. Add the same check to emulate_vsx().

With this patch any unaligned VSX loads and stores in the kernel
will show up as a clear oops rather than silent corruption of
kernel or userspace VSX state, or worse, corruption of a potentially
unlimited amount of kernel memory.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/align.c
===================================================================
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -651,6 +651,10 @@ static int emulate_vsx(unsigned char __u
 	int sw = 0;
 	int i, j;
 
+	/* userland only */
+	if (unlikely(!user_mode(regs)))
+		return 0;
+
 	flush_vsx_to_thread(current);
 
 	if (reg < 32)
