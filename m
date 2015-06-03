Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B22B1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 23:15:26 +1000 (AEST)
Date: Wed, 3 Jun 2015 15:15:22 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Jiri Kosina <jkosina@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] ppc64 ftrace: spare early boot and low level code
Message-ID: <20150603131522.GD19424@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
 <20150516080534.GA27059@lst.de>
 <alpine.LRH.2.00.1505181428360.2306@twin.jikos.cz>
 <1432006027.8339.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1505191150420.8186@pobox.suse.cz>
 <20150603130257.GA19424@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603130257.GA19424@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Using -mprofile-kernel on early boot code not only confuses the checker
but is also useless, as the infrastructure is not yet in place. Proceed
like with -pg, equally with time.o and ftrace itself.

Signed-off-by: Torsten Duwe <duwe@suse.de>

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 502cf69..fb33fc5 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -17,14 +17,14 @@ endif
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code
-CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
-CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog -mprofile-kernel
+CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog -mprofile-kernel
 # do not trace tracer code
-CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog -mprofile-kernel
 # timers used by tracing
-CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
+CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog -mprofile-kernel
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
