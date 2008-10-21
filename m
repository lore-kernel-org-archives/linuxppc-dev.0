Return-Path: <mail4mz@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id BFB9ADDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 02:51:10 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1862629fga.39
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 08:51:08 -0700 (PDT)
Message-ID: <5c9cd53b0810210851j67f9f24fy8a0ae3531aa5c43b@mail.gmail.com>
Date: Tue, 21 Oct 2008 11:51:08 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Kim Phillips" <kim.phillips@freescale.com>
Subject: Re: Kernel Oops when run ifconfig on MPC8360MDS board
In-Reply-To: <5c9cd53b0810202126if1e16b1m89b9f85b4d0074dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0810201500j1c86dfffxdbfc6f5c5ab9728c@mail.gmail.com>
	<20081020195009.6bf54d5a.kim.phillips@freescale.com>
	<5c9cd53b0810202123x32488ba7vb3c70daa8d09aef@mail.gmail.com>
	<5c9cd53b0810202126if1e16b1m89b9f85b4d0074dd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable the debug flag on ucc_geth.c: there is the dmesg:

ucc_geth_open: IN
ucc_geth_startup: IN
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C0126910 XER: 20000000 LR: C01268D0 SP: CFD0DD80 REGS: cfd0dcd0
TRAP: 0200    Not tainted
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cfd0c000[398] 'ifconfig' Last syscall: 54
last math cfd0c000 last altivec 00000000
GPR00: 00000000 CFD0DD80 CFD0C000 00000000 00001032 CC10E000 C0247264 C04D1F74
GPR08: BA2E8BA3 D1000010 C01EE55C 00000000 48022228 100235F8 00000000 00000000
GPR16: 00000000 00000000 10020000 10020000 00009032 CFD0DE78 00000000 00000000
GPR24: FFFF8914 0000C000 C01D0000 CFD0DDB8 D1000000 C0586D20 C0269C20 00000000
Call backtrace:
C0126890 C00D59D0 C00D761C C012F400 C0130DD4 C01746B4 C017712C
C0127770 C004D8B0 C0005ABC 00000000 10001214 100023C4 0FEC4E00
00000000


On Tue, Oct 21, 2008 at 12:26 AM, mike zheng <mail4mz@gmail.com> wrote:
> Oh, I forgot to metion just now. The linux is based on a custom built
> kernel 2.4.22, not from Freescale.
>
> On 10/20/08, mike zheng <mail4mz@gmail.com> wrote:
>> On 10/20/08, Kim Phillips <kim.phillips@freescale.com> wrote:
>> > On Mon, 20 Oct 2008 15:00:33 -0700
>> > "mike zheng" <mail4mz@gmail.com> wrote:
>> >
>> > > I have following kernel Oops when I run ifconfig to setup the UEC0 of
>> > > MPC8360MDS board. There is no hardware problem, the UEC0 runs well
>> > > under Uboot.
>> >
>> > does this occur on vanilla u-boot and kernel versions?  if so, which
>> > ones, and on what board revision?
>> >
>> The kernel Oops happened under Linux when I try to use "ifconfig" to
>> setup the eth0. Under Uboot, the UEC0 works fine. I am able to do
>> ping, tftp via the ethernet port.
>>
>>
>> > > Call backtrace:
>> > > C0126890 C00D59D0 C00D761C C012F400 C0130DD4 C01746B4 C017712C
>> > > C0127770 C004D8B0 C0005ABC 00000000 10001214 100023C4 0FEC4E00
>> > > 00000000
>> >
>> > might want to turn on verbose debugging while you're at it.
>>
>> Which flag shall I turned on? I am not formaliar to the network driver. Thanks!
>> >
>> > Kim
>> >
>>
>
