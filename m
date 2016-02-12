Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DC71A004B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 03:13:42 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id y7so788688paa.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 08:13:42 -0800 (PST)
Message-ID: <1455293609.16012.9.camel@gmail.com>
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Sat, 13 Feb 2016 03:13:29 +1100
In-Reply-To: <20160210174517.8347D692C8@newverein.lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-28 at 16:32 +0100, Torsten Duwe wrote:
> From: Petr Mladek <pmladek@suse.com>
> 
> Livepatch works on x86_64 and s390 only when the ftrace call
> is at the very beginning of the function. But PPC is different.
> We need to handle TOC and save LR there before calling the
> global ftrace handler.
> 
> Now, the problem is that the extra operations have different
> length on PPC depending on the used gcc version. It is
> 4 instructions (16 bytes) before gcc-6 and only 3 instructions
> (12 bytes) with gcc-6.
> 
> This patch tries to detect the offset a generic way during
> build. It assumes that the offset of the ftrace location
> is the same for all functions. It modifies the existing
> recordmcount tool that is able to find read mcount locations
> directly from the object files. It adds an option -p
> to print the first found offset.
> 
> The recordmcount tool is then used in the kernel/livepatch
> subdirectory to generate a header file. It defines
> a constant that is used to compute the ftrace location
> from the function address.
> 
> Finally, we have to enable the C implementation of the
> recordmcount tool to be used on PPC and S390. It seems
> to work fine there. It should be more reliable because
> it reads the standardized elf structures. The old perl
> implementation uses rather complex regular expressions
> to parse objdump output and is therefore much more tricky.

I'm still missing something, I'm getting offset as 8

When I run, I get

scripts/recordmcount -p kernel/livepatch/core.o 
#define KLP_FTRACE_LOCATION 8

scripts/recordmcount -p kernel/livepatch/ftrace-test.o 
#define KLP_FTRACE_LOCATION 8

My sample fails as well, since the expected offset is 16.
I guess the script is being run against a not so good
test.

A quick hack (no signoff below, its just an experiment),
seems to do the trick for the provided sample-livepatch.
It is hacky because it uses the sample object and due to
lack of a better description of srctree, it uses 
srctree/../..

I suspect the usage of recordmcount needs to be revisited

diff --git a/kernel/livepatch/Makefile b/kernel/livepatch/Makefile
index 65a44b68..10b5f38 100644
--- a/kernel/livepatch/Makefile
+++ b/kernel/livepatch/Makefile
@@ -2,7 +2,7 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 
 livepatch-objs := core.o
 
-always		:= $(hostprogs-y) ftrace-test.o
+always		:= $(hostprogs-y) $(srctree)/../../samples/livepatch/livepatch-sample.o
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/core.o: $(obj)/livepatch-ftrace.h
@@ -10,7 +10,7 @@ $(obj)/core.o: $(obj)/livepatch-ftrace.h
 quiet_cmd_livepatch-rmcount = RMCOUNT $@
       cmd_livepatch-rmcount = $(objtree)/scripts/recordmcount -p $< > $@
 
-$(obj)/livepatch-ftrace.h: $(obj)/ftrace-test.o $(objtree)/scripts/recordmcount
+$(obj)/livepatch-ftrace.h: $(obj)/../../samples/livepatch/livepatch-sample.o $(objtree)/scripts/recordmcount
 	$(call if_changed,livepatch-rmcount)
 
 targets += livepatch-ftrace.h
