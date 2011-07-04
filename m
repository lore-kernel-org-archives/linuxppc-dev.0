Return-Path: <yong.zhang0@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF570B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Jul 2011 12:23:29 +1000 (EST)
Received: by gwj17 with SMTP id 17so2056088gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 03 Jul 2011 19:23:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E0D9B5E.3010901@windriver.com>
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
	<4E074671.7060100@hitachi.com> <20110627100104.GA24705@in.ibm.com>
	<BANLkTimYej4_dmBqvPBCLej=JA5atLrZVA@mail.gmail.com>
	<4E0D9B5E.3010901@windriver.com>
Date: Mon, 4 Jul 2011 10:23:25 +0800
Message-ID: <CAM2zO=AO2bxvBgZopZAkhhr++VNby9MvvLv-dae8t=QUu8_C0w@mail.gmail.com>
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
From: Yong Zhang <yong.zhang0@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
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

On Fri, Jul 1, 2011 at 6:03 PM, tiejun.chen <tiejun.chen@windriver.com> wro=
te:
>> root@unknown:/root> insmod kprobe_example.ko func=3Dshow_interrupts
>> Planted kprobe at c009be18
>> root@unknown:/root> cat /proc/interrupts
>> pre_handler: p->addr =3D 0xc009be18, nip =3D 0xc009be18, msr =3D 0x29000
>> post_handler: p->addr =3D 0xc009be18, msr =3D 0x29000,boostable =3D 1
>> Oops: Exception in kernel mode, sig: 11 [#1]
>> PREEMPT MPC8536 DS
>> Modules linked in: kprobe_example
>> NIP: df159e74 LR: c0106f40 CTR: c009be18
>> REGS: df159d90 TRAP: 0700 =C2=A0 Not tainted =C2=A0(3.0.0-rc4-00001-ge8f=
fcca-dirty)
>> MSR: 00029000 <EE,ME,CE> =C2=A0CR: 20202688 =C2=A0XER: 00000000
>> TASK =3D dfaa5340[613] 'cat' THREAD: df158000
>> GPR00: fffff000 df159e40 dfaa5340 df024a00 df159e78 00000000 df159f20 00=
000001
>> GPR08: c10060d0 c009be18 00029000 df159e70 00000000 1001ca74 1ffb5f00 10=
0a01cc
>> GPR16: 00000000 00000000 00000000 00000000 df024a28 df159f20 00000000 df=
bff080
>> GPR24: 10016000 00001000 df159f20 df159e78 dfbff080 df159e78 df024a00 df=
159e70
>> NIP [df159e74] 0xdf159e74
>> LR [c0106f40] seq_read+0x2a4/0x568
>> Call Trace:
>> [df159e40] [00029000] 0x29000 (unreliable)
>> [df159e74] [00000000] =C2=A0 (null)
>> Instruction dump:
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> ---[ end trace 60026bfc1fe79aed ]---
>> Segmentation fault
>
> Maybe I can understand this problem.
>
> When we kprobe these operations such as store-and-update-word for SP(r1),
>
> stwu r1, -A(r1)
>
> The program exception is triggered then PPC always allocate an exception =
frame
> as shown as the follows:
>
> old r1 --------
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 nip
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpr[2]~gpr[31]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpr[1] <--------- old r1 is stored here.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpr[0]
> =C2=A0 =C2=A0 =C2=A0 -------- <-- pr_regs @offset 16 bytes
> =C2=A0 =C2=A0 =C2=A0 padding
> =C2=A0 =C2=A0 =C2=A0 STACK_FRAME_REGS_MARKER
> =C2=A0 =C2=A0 =C2=A0 LR
> =C2=A0 =C2=A0 =C2=A0 back chain
> new r1 --------
>
> Here emulate_step() is called to emulate 'stwu'. Actually this is equival=
ent to
> 1> update pr_regs->gpr[1] =3D mem(old r1 + (-A))
> 2> 'stw <old r1>, mem<(old r1 + (-A)) >
>
> You should notice the stack based on new r1 would be covered with mem<old=
 r1
> +(-A)>. So after this, the kernel exit from post_krpobe, something would =
be
> broken. This should depend on sizeof(-A).
>
> For kprobe show_interrupts, you can see pregs->nip is re-written violentl=
y so
> kernel issued.

Yeah, my debug also show this, so this is the root cause.
Thanks for your explanation.

>
> But sometimes we may only re-write some violate registers the kernel stil=
l
> alive. And so this is just why the kernel works well for some kprobed poi=
nt
> after you change some kernel options/toolchains.
>
> If I'm correct its difficult to kprobe these stwu sp operation since the
> sizeof(-A) is undermined for the kernel. So we have to implement in-depen=
d
> interrupt stack like PPC64.

Hmmm, a dedicated exception stack will smooth the concern IMHO,
Ben, Kuma?

Thanks,
Yong


--=20
Only stand for myself
