Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailx.hitachi.co.jp (mailx.hitachi.co.jp [133.145.228.49])
	by ozlabs.org (Postfix) with ESMTP id 4916FB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 01:00:32 +1000 (EST)
Message-ID: <4E074671.7060100@hitachi.com>
Date: Sun, 26 Jun 2011 23:47:13 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>,
	Jim Keniston <jkenisto@linux.vnet.ibm.com>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
In-Reply-To: <1308911347.531.56.camel@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Yong Zhang <yong.zhang0@gmail.com>, paulus@samba.org,
	yrl.pp-manager.tt@hitachi.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2011/06/24 19:29), Steven Rostedt wrote:
> On Fri, 2011-06-24 at 17:21 +0800, Yong Zhang wrote:
>> Hi,
>>
>> When I use kprobe to do something, I found some wired thing.
>>
>> When CONFIG_FUNCTION_TRACER is disabled:
>> (gdb) disassemble do_fork
>> Dump of assembler code for function do_fork:
>>    0xc0037390 <+0>:	mflr    r0
>>    0xc0037394 <+4>:	stwu    r1,-64(r1)
>>    0xc0037398 <+8>:	mfcr    r12
>>    0xc003739c <+12>:	stmw    r27,44(r1)
>>
>> Then I:
>> modprobe kprobe_example func=do_fork offset=4
>> ls
>> Things works well.
>>
>> But when CONFIG_FUNCTION_TRACER is enabled:
>> (gdb) disassemble do_fork
>> Dump of assembler code for function do_fork:
>>    0xc0040334 <+0>:	mflr    r0
>>    0xc0040338 <+4>:	stw     r0,4(r1)
>>    0xc004033c <+8>:	bl      0xc00109d4 <mcount>
>>    0xc0040340 <+12>:	stwu    r1,-80(r1)
>>    0xc0040344 <+16>:	mflr    r0
>>    0xc0040348 <+20>:	stw     r0,84(r1)
>>    0xc004034c <+24>:	mfcr    r12
>> Then I:
>> modprobe kprobe_example func=do_fork offset=12
>> ls
>> 'ls' will never retrun. system freeze.
> 
> I'm not sure if x86 had a similar issue.
> 
> Masami, have any ideas to why this happened?

No, I don't familiar with ppc implementation. I guess
that single-step resume code failed to emulate the
instruction, but it strongly depends on ppc arch.
Maybe IBM people may know what happened.

Ananth, Jim, would you have any ideas?

Thank you,

> 
> I don't have a PPC32 to test on, but I can try it out on my PPC64.
> 
> -- Steve
> 
>>
>> I'm using toolchain from:http://www.denx.de/wiki/ELDK-5/WebHome
>> powerpc-linux-gcc -v
>> Using built-in specs.
>> COLLECT_GCC=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/bin/powerpc-linux/powerpc-linux-gcc
>> COLLECT_LTO_WRAPPER=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/libexec/powerpc-linux/gcc/powerpc-linux/4.5.1/lto-wrapper
>> Target: powerpc-linux
>> Configured with:
>> /opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/work/i686-nativesdk-oesdk-linux/gcc-cross-canadian-powerpc-4.5.1-r4/gcc-4.5.1/configure
>> --build=x86_64-linux --host=i686-oesdk-linux --target=powerpc-linux
>> --prefix=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr
>> --exec_prefix=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr
>> --bindir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/bin/powerpc-linux
>> --sbindir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/bin/powerpc-linux
>> --libexecdir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/libexec/powerpc-linux
>> --datadir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/share
>> --sysconfdir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/etc
>> --sharedstatedir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/com
>> --localstatedir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/var
>> --libdir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/lib/powerpc-linux
>> --includedir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/include
>> --oldincludedir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/include
>> --infodir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/share/info
>> --mandir=/opt/eldk-5.0/powerpc/sysroots/i686-oesdk-linux/usr/share/man
>> --with-libtool-sysroot=/opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/sysroots/i686-oesdk-linux-nativesdk
>> --with-gnu-ld --enable-shared --enable-languages=c,c++
>> --enable-threads=posix --disable-multilib --enable-c99
>> --enable-long-long --enable-symvers=gnu --enable-libstdcxx-pch
>> --program-prefix=powerpc-linux- --enable-lto --enable-libssp
>> --disable-bootstrap --disable-libgomp --disable-libmudflap
>> --enable-cheaders=c_global
>> --with-local-prefix=/opt/eldk-5.0/powerpc/sysroots/powerpc-linux/usr
>> --with-gxx-include-dir=/usr/include/c++
>> --with-build-time-tools=/opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/sysroots/x86_64-linux/usr/powerpc-linux/bin
>> --with-sysroot=/opt/eldk-5.0/powerpc/sysroots/powerpc-linux
>> --with-build-sysroot=/opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/sysroots/powerpc
>> --disable-libunwind-exceptions --disable-libssp --disable-libgomp
>> --disable-libmudflap
>> --with-mpfr=/opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/sysroots/i686-oesdk-linux-nativesdk
>> --with-mpc=/opt/poky/build/eldk-2011-05-20-5cde06e-powerpc/tmp/sysroots/i686-oesdk-linux-nativesdk
>> --enable-__cxa_atexit
>> Thread model: posix
>> gcc version 4.5.1 (GCC)
>>
>>
>> And kernel config is attached.
>>
>> BTW, I have made a patch to make kprobe_example set breakpoint easily,
>> attached too.
>>
>> Thanks,
>> Yong
>>

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
