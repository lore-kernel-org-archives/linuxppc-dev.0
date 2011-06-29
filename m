Return-Path: <yong.zhang0@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 967C8B6F6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 16:23:33 +1000 (EST)
Received: by yxm34 with SMTP id 34so422899yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 23:23:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110627100104.GA24705@in.ibm.com>
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
	<4E074671.7060100@hitachi.com> <20110627100104.GA24705@in.ibm.com>
Date: Wed, 29 Jun 2011 14:23:28 +0800
Message-ID: <BANLkTimYej4_dmBqvPBCLej=JA5atLrZVA@mail.gmail.com>
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
From: Yong Zhang <yong.zhang0@gmail.com>
To: ananth@in.ibm.com
Content-Type: text/plain; charset=UTF-8
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, paulus@samba.org,
	yrl.pp-manager.tt@hitachi.com,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2011 at 6:01 PM, Ananth N Mavinakayanahalli
<ananth@in.ibm.com> wrote:
> On Sun, Jun 26, 2011 at 11:47:13PM +0900, Masami Hiramatsu wrote:
>> (2011/06/24 19:29), Steven Rostedt wrote:
>> > On Fri, 2011-06-24 at 17:21 +0800, Yong Zhang wrote:
>> >> Hi,
>> >>
>> >> When I use kprobe to do something, I found some wired thing.
>> >>
>> >> When CONFIG_FUNCTION_TRACER is disabled:
>> >> (gdb) disassemble do_fork
>> >> Dump of assembler code for function do_fork:
>> >> =C2=A0 =C2=A00xc0037390 <+0>: =C2=A0 =C2=A0 =C2=A0 =C2=A0mflr =C2=A0 =
=C2=A0r0
>> >> =C2=A0 =C2=A00xc0037394 <+4>: =C2=A0 =C2=A0 =C2=A0 =C2=A0stwu =C2=A0 =
=C2=A0r1,-64(r1)
>> >> =C2=A0 =C2=A00xc0037398 <+8>: =C2=A0 =C2=A0 =C2=A0 =C2=A0mfcr =C2=A0 =
=C2=A0r12
>> >> =C2=A0 =C2=A00xc003739c <+12>: =C2=A0 =C2=A0 =C2=A0 stmw =C2=A0 =C2=
=A0r27,44(r1)
>> >>
>> >> Then I:
>> >> modprobe kprobe_example func=3Ddo_fork offset=3D4
>> >> ls
>> >> Things works well.
>> >>
>> >> But when CONFIG_FUNCTION_TRACER is enabled:
>> >> (gdb) disassemble do_fork
>> >> Dump of assembler code for function do_fork:
>> >> =C2=A0 =C2=A00xc0040334 <+0>: =C2=A0 =C2=A0 =C2=A0 =C2=A0mflr =C2=A0 =
=C2=A0r0
>> >> =C2=A0 =C2=A00xc0040338 <+4>: =C2=A0 =C2=A0 =C2=A0 =C2=A0stw =C2=A0 =
=C2=A0 r0,4(r1)
>> >> =C2=A0 =C2=A00xc004033c <+8>: =C2=A0 =C2=A0 =C2=A0 =C2=A0bl =C2=A0 =
=C2=A0 =C2=A00xc00109d4 <mcount>
>> >> =C2=A0 =C2=A00xc0040340 <+12>: =C2=A0 =C2=A0 =C2=A0 stwu =C2=A0 =C2=
=A0r1,-80(r1)
>> >> =C2=A0 =C2=A00xc0040344 <+16>: =C2=A0 =C2=A0 =C2=A0 mflr =C2=A0 =C2=
=A0r0
>> >> =C2=A0 =C2=A00xc0040348 <+20>: =C2=A0 =C2=A0 =C2=A0 stw =C2=A0 =C2=A0=
 r0,84(r1)
>> >> =C2=A0 =C2=A00xc004034c <+24>: =C2=A0 =C2=A0 =C2=A0 mfcr =C2=A0 =C2=
=A0r12
>> >> Then I:
>> >> modprobe kprobe_example func=3Ddo_fork offset=3D12
>> >> ls
>> >> 'ls' will never retrun. system freeze.
>> >
>> > I'm not sure if x86 had a similar issue.
>> >
>> > Masami, have any ideas to why this happened?
>>
>> No, I don't familiar with ppc implementation. I guess
>> that single-step resume code failed to emulate the
>> instruction, but it strongly depends on ppc arch.
>> Maybe IBM people may know what happened.
>>
>> Ananth, Jim, would you have any ideas?
>
> On powerpc, we emulate sstep whenever possible. Only recently support to
> emulate loads and stores got added. I don't have access to a powerpc box
> today... but will try to recreate the problem ASAP and see what could be
> happening in the presence of mcount.

After taking more testing on it, it looks like the issue doesn't
depend on mcount
(AKA. CONFIG_FUNCTION_TRACER)

As I said in the first email, with eldk-5.0 CONFIG_FUNCTION_TRACER=3Dn
will work well.

But when I'm using eldk-4.2[1], both will fail. But the funny thing is when=
 I
set kprobe at several functions some works fine but some will fail. For exa=
mple,
at this time do_fork() works well, but show_interrupt() will crash.

root@unknown:/root> insmod kprobe_example.ko func=3Dshow_interrupts
Planted kprobe at c009be18
root@unknown:/root> cat /proc/interrupts
pre_handler: p->addr =3D 0xc009be18, nip =3D 0xc009be18, msr =3D 0x29000
post_handler: p->addr =3D 0xc009be18, msr =3D 0x29000,boostable =3D 1
Oops: Exception in kernel mode, sig: 11 [#1]
PREEMPT MPC8536 DS
Modules linked in: kprobe_example
NIP: df159e74 LR: c0106f40 CTR: c009be18
REGS: df159d90 TRAP: 0700   Not tainted  (3.0.0-rc4-00001-ge8ffcca-dirty)
MSR: 00029000 <EE,ME,CE>  CR: 20202688  XER: 00000000
TASK =3D dfaa5340[613] 'cat' THREAD: df158000
GPR00: fffff000 df159e40 dfaa5340 df024a00 df159e78 00000000 df159f20 00000=
001
GPR08: c10060d0 c009be18 00029000 df159e70 00000000 1001ca74 1ffb5f00 100a0=
1cc
GPR16: 00000000 00000000 00000000 00000000 df024a28 df159f20 00000000 dfbff=
080
GPR24: 10016000 00001000 df159f20 df159e78 dfbff080 df159e78 df024a00 df159=
e70
NIP [df159e74] 0xdf159e74
LR [c0106f40] seq_read+0x2a4/0x568
Call Trace:
[df159e40] [00029000] 0x29000 (unreliable)
[df159e74] [00000000]   (null)
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 60026bfc1fe79aed ]---
Segmentation fault

Thanks,
Yong

[1]: http://ftp.denx.de/pub/eldk/4.2/

--=20
Only stand for myself
