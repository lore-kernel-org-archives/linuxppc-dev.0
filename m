Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B52CE1A006C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2016 12:33:12 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id yy13so4460042pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 17:33:12 -0800 (PST)
Message-ID: <1455327180.16012.14.camel@gmail.com>
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
From: Balbir Singh <bsingharora@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>, Jiri
 Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Jessica Yu
 <jeyu@redhat.com>,  Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Sat, 13 Feb 2016 12:33:00 +1100
In-Reply-To: <20160212164517.GO12548@pathway.suse.cz>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com>
 <20160212164517.GO12548@pathway.suse.cz>
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

On Fri, 2016-02-12 at 17:45 +0100, Petr Mladek wrote:
> On Sat 2016-02-13 03:13:29, Balbir Singh wrote:
> > On Thu, 2016-01-28 at 16:32 +0100, Torsten Duwe wrote:
> > > From: Petr Mladek <pmladek@suse.com>
> > > 
> > > Livepatch works on x86_64 and s390 only when the ftrace call
> > > is at the very beginning of the function. But PPC is different.
> > > We need to handle TOC and save LR there before calling the
> > > global ftrace handler.
> > > 
> > > Now, the problem is that the extra operations have different
> > > length on PPC depending on the used gcc version. It is
> > > 4 instructions (16 bytes) before gcc-6 and only 3 instructions
> > > (12 bytes) with gcc-6.
> > > 
> > > This patch tries to detect the offset a generic way during
> > > build. It assumes that the offset of the ftrace location
> > > is the same for all functions. It modifies the existing
> > > recordmcount tool that is able to find read mcount locations
> > > directly from the object files. It adds an option -p
> > > to print the first found offset.
> > > 
> > > The recordmcount tool is then used in the kernel/livepatch
> > > subdirectory to generate a header file. It defines
> > > a constant that is used to compute the ftrace location
> > > from the function address.
> > > 
> > > Finally, we have to enable the C implementation of the
> > > recordmcount tool to be used on PPC and S390. It seems
> > > to work fine there. It should be more reliable because
> > > it reads the standardized elf structures. The old perl
> > > implementation uses rather complex regular expressions
> > > to parse objdump output and is therefore much more tricky.
> > 
> > I'm still missing something, I'm getting offset as 8
> > 
> > When I run, I get
> > 
> > scripts/recordmcount -p kernel/livepatch/core.o 
> > #define KLP_FTRACE_LOCATION 8
> > 
> > scripts/recordmcount -p kernel/livepatch/ftrace-test.o 
> > #define KLP_FTRACE_LOCATION 8
> > 
> > My sample fails as well, since the expected offset is 16.
> > I guess the script is being run against a not so good
> > test.
> 
> I guess that you used a broken gcc and cheated the check
> to pass the compilation. Did you, please?
> 
> The test used to detect the offset is using a minimalistic
> function is is afftected by the gcc bug.
> 
> The patch below might be used to cheat the offset check as well.
> 
> Torsten, please mention this somewhere if you, just by chance,
> send a new version of the patchset.
> 
> From f6a438a3f2f60cc1acc859b41d0cc9259c9a331e Mon Sep 17 00:00:00 2001
> From: root <root@c79.arch.suse.de>
> Date: Tue, 2 Feb 2016 15:35:06 +0100
> Subject: [PATCH 2/2] livepatch: Make sure the TOC is handled when detecting
>  ftrace location
> 
> There seems to be a bug in gcc on PPC. It does not handle TOC
> if the function does not access global variables or functions
> by default. But it should when profiling is enabled.
> 

Yep.. Please see see http://marc.info/?l=linux-kernel&m=145518015816435&w=2
and my question at http://marc.info/?l=linuxppc-embedded&m=145518330317496&w=2

> This patch works around this problem by adding a call
> to a global function.
> 
> This patch is for testing only!
> ---
>  kernel/livepatch/ftrace-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/livepatch/ftrace-test.c b/kernel/livepatch/ftrace-test.c
> index 22f0c54bf7b3..a3b7aabb67e5 100644
> --- a/kernel/livepatch/ftrace-test.c
> +++ b/kernel/livepatch/ftrace-test.c
> @@ -1,6 +1,9 @@
>  /* Sample code to figure out mcount location offset */
> +#include 
> +
>  
>  int test(int a)
>  {
> +	printk("%d\n", a);
>  	return ++a;
>  }

This is much better, I see the offset of 16.

Balbir Singh
