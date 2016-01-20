Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56A7D1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 20:48:35 +1100 (AEDT)
Date: Wed, 20 Jan 2016 10:48:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160120094830.GA3178@pathway.suse.cz>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453269803.14751.10.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 2016-01-20 17:03:23, Michael Ellerman wrote:
> On Wed, 2016-01-06 at 15:17 +0100, Petr Mladek wrote:
> > On Fri 2015-12-04 15:45:29, Torsten Duwe wrote:
> > > Changes since v4:
> > >   * change comment style in entry_64.S to C89
> > >     (nobody is using assembler syntax comments there).
> > >   * the bool function restore_r2 shouldn't return 2,
> > >     that's a little confusing.
> > >   * Test whether the compiler supports -mprofile-kernel
> > >     and only then define CC_USING_MPROFILE_KERNEL
> > >   * also make the return value of klp_check_compiler_support
> > >     depend on that.
> >
> > Note that there is still needed the extra patch from
> > http://thread.gmane.org/gmane.linux.kernel/2093867/focus=2099603
> > to get the livepatching working.
> 
> Sorry which extra patch?

It was in an older reply and can be found at
http://thread.gmane.org/gmane.linux.kernel/2093867/focus=2099603


> > Both ftrace with regs and live patching works for me with this patch
> > set and the extra patch. So. for the whole patchset:
> >
> > Tested-by: Petr Mladek <pmladek@suse.com>
> 
> Can you give me some more info on how you're testing it? What config options,
> toolchain etc.?

You need to fulfill all dependencies for CONFIG_LIVEPATCH, see
kernel/livepatch/Kconfig. Please, find attached the config that
that I used.

I did the testing on PPC64LE with a kernel based on 4.4.0-rc8
using the attached config. I used the following stuff:

$> gcc --version
gcc (SUSE Linux) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$> rpm -q binutils
binutils-2.25.0-13.1.ppc64le


I tested it the following way:

# booted the compiled kernel and printed the default cmdline
$> cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-rc3-11-default+ root=UUID=...

# tried function_graph tracer to check ftrace with regs
echo function_graph >/sys/kernel/debug/tracing/current_tracer ; \
echo 1 >/sys/kernel/debug/tracing/tracing_on ; \
sleep 1 ; \
/usr/bin/ls /proc ; \
echo 0 >/sys/kernel/debug/tracing/tracing_on ; \
less /sys/kernel/debug/tracing/trace

# loaded the patch and printed the patch cmdline
$> modprobe livepatch-sample
$> cat /proc/cmdline
this has been live patched

# tried to disable and enable the patch
$> echo 0 > /sys/kernel/livepatch/livepatch_sample/enabled
$> cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-rc3-11-default+ root=UUID=...
$> echo 1 > /sys/kernel/livepatch/livepatch_sample/enabled
$> cat /proc/cmdline
this has been live patched

# also checked messages
$> dmesg | tail -n 4
[   33.673057] livepatch: tainting kernel with TAINT_LIVEPATCH
[   33.673068] livepatch: enabling patch 'livepatch_sample'
[ 1997.098257] livepatch: disabling patch 'livepatch_sample'
[ 2079.696277] livepatch: enabling patch 'livepatch_sample'


> For me the series doesn't even boot, even with livepatching disabled.

I wonder if you have enabled CONFIG_FTRACE_STARTUP_TEST and if
the ftrace with regs fails on your setup.

Best Regards,
Petr
