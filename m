Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 271DCDDF12
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 22:25:32 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1962988rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Sep 2008 05:25:30 -0700 (PDT)
Message-ID: <319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>
Date: Mon, 1 Sep 2008 14:25:29 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Trace
In-Reply-To: <929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11231_5142318.1220271930348"
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_11231_5142318.1220271930348
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I found where is the failure with your advices
In init_dev (tty_io.c), init_dev calls "tty =3D driver->ttys[idx]"
after this call, tty value is : tty =3D 0x57555541

Have I to initialize driver->ttys in my driver. If yes, how have I to
Initialize this ?

The driver tty is used in order to have a console on my serial port.
Thanks for your help


2008/9/1, Jenkins, Clive <Clive.Jenkins@xerox.com>:
>
> The instruction that caused the fault is at this address:
>
> > NIP [c0110ddc] init_dev+0x2bc/0x584
>
>
> The hex value of the instruction is also highlighted between <> here:
>
> > Instruction dump:
> > 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062 2f800001
> > 409efd98 83ff00d0 2c1f0000 4182fd90 <801f00b8> 70090080 408201b0 801e00=
60
>
>
> Disassemble your kernel and look at offset 0x2BC relative to the label
> init_dev
>
> ________________________________
>
> From: linuxppc-dev-bounces+clive.jenkins=3Dxerox.com@ozlabs.org [mailto:
> linuxppc-dev-bounces+clive.jenkins <linuxppc-dev-bounces%2Bclive.jenkins>=
=3D
> xerox.com@ozlabs.org] On Behalf Of S=E9bastien Chr=E9tien
> Sent: 01 September 2008 10:16
> To: linuxppc-dev@ozlabs.org
> Subject: Trace
>
>
>
> Hello,
>
> I am triying to write a tty_driver under ppc. And I get a kernel panic.
> Can somebody explain me how finding the source of the error with a kernel
> panic trace :
> thanks
>
> Unable to handle kernel paging request for data at address 0x575555f9
> Faulting instruction address: 0xc0110ddc
> Oops: Kernel access of bad area, sig: 11 [#1]
> Modules linked in:
> NIP: c0110ddc LR: c011118c CTR: 00000000
> REGS: cf01bcb0 TRAP: 0300   Not tainted  (2.6.26)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 44002022  XER: 20000000
> DAR: 575555f9, DSISR: 40000000
> TASK =3D cf01c000[1] 'swapper' THREAD: cf01a000
> GPR00: 0000000c cf01bd60 cf01c000 cf04c300 ffffffff cf01bdbc 00000000
> c01d0000
> GPR08: 00001249 fffffffc 00000000 cf000420 84002022 00000000 10000b00
> 007fff00
> GPR16: 0fffa1d0 00000000 00000004 cf01bdbc 007ffec0 00000000 00000000
> 00800000
> GPR24: 00000000 c01b7650 00000002 c01d0000 ffffffff ce4a6700 cf04c300
> 57555541
> NIP [c0110ddc] init_dev+0x2bc/0x584
> LR [c011118c] tty_open+0xe8/0x3e0
> Call Trace:
> [cf01bd60] [cf01bd78] 0xcf01bd78 (unreliable)
> [cf01bdb0] [c011118c] tty_open+0xe8/0x3e0
> [cf01bde0] [c00742c8] chrdev_open+0x114/0x1b0
> [cf01be10] [c006fb5c] __dentry_open+0x190/0x2e8
> [cf01be40] [c006fdac] nameidata_to_filp+0x38/0x70
> [cf01be60] [c007bc60] do_filp_open+0x200/0x7d0
> [cf01bf10] [c00700b4] do_sys_open+0x74/0x114
> [cf01bf40] [c0003c94] init_post+0x34/0x258
> [cf01bf60] [c019ca64] kernel_init+0x258/0x270
> [cf01bff0] [c0011b3c] kernel_thread+0x44/0x60
> Instruction dump:
> 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062 2f800001
> 409efd98 83ff00d0 2c1f0000 4182fd90 <801f00b8> 70090080 408201b0 801e0060
> ---[ end trace b7795a387aeb7786 ]---
> Kernel panic - not syncing: Attempted to kill init!
> allocation failed: out of vmalloc space - use vmalloc=3D<size> to increas=
e
> size.
>
>

------=_Part_11231_5142318.1220271930348
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I found where is the failure with your advices <br>

In init_dev (tty_io.c), init_dev calls &quot;tty =3D driver-&gt;ttys[idx]&q=
uot;<br>

after this call, tty value is : tty =3D 0x57555541<br>

<br>

Have I to initialize driver-&gt;ttys in my driver. If yes, how have I to In=
itialize this ?<br>

<br>

The driver tty is used in order to have a console on my serial port.<br>

Thanks for your help<br>
<br><br><div><span class=3D"gmail_quote">2008/9/1, Jenkins, Clive &lt;<a hr=
ef=3D"mailto:Clive.Jenkins@xerox.com">Clive.Jenkins@xerox.com</a>&gt;:</spa=
n><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
The instruction that caused the fault is at this address:<br> <br>&gt; NIP =
[c0110ddc] init_dev+0x2bc/0x584<br> <br> <br>The hex value of the instructi=
on is also highlighted between &lt;&gt; here:<br> <br>&gt; Instruction dump=
:<br>
 &gt; 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f0 a81e0062 2f8000=
01<br> &gt; 409efd98 83ff00d0 2c1f0000 4182fd90 &lt;801f00b8&gt; 70090080 4=
08201b0 801e0060<br> <br> <br>Disassemble your kernel and look at offset 0x=
2BC relative to the label init_dev<br>
 <br> ________________________________<br> <br> From: linuxppc-dev-bounces+=
clive.jenkins=3D<a href=3D"http://xerox.com">xerox.com</a>@<a href=3D"http:=
//ozlabs.org">ozlabs.org</a> [mailto:<a href=3D"mailto:linuxppc-dev-bounces=
%2Bclive.jenkins">linuxppc-dev-bounces+clive.jenkins</a>=3D<a href=3D"http:=
//xerox.com">xerox.com</a>@<a href=3D"http://ozlabs.org">ozlabs.org</a>] On=
 Behalf Of S=E9bastien Chr=E9tien<br>
 Sent: 01 September 2008 10:16<br> To: <a href=3D"mailto:linuxppc-dev@ozlab=
s.org">linuxppc-dev@ozlabs.org</a><br> Subject: Trace<br> <br><br> <br> Hel=
lo,<br> <br> I am triying to write a tty_driver under ppc. And I get a kern=
el panic.<br>
 Can somebody explain me how finding the source of the error with a kernel =
panic trace :<br> thanks<br> <br> Unable to handle kernel paging request fo=
r data at address 0x575555f9<br> Faulting instruction address: 0xc0110ddc<b=
r>
 Oops: Kernel access of bad area, sig: 11 [#1]<br> Modules linked in:<br> N=
IP: c0110ddc LR: c011118c CTR: 00000000<br> REGS: cf01bcb0 TRAP: 0300&nbsp;=
&nbsp; Not tainted&nbsp;&nbsp;(2.6.26)<br> MSR: 00009032 &lt;EE,ME,IR,DR&gt=
;&nbsp;&nbsp;CR: 44002022&nbsp;&nbsp;XER: 20000000<br>
 DAR: 575555f9, DSISR: 40000000<br> TASK =3D cf01c000[1] &#39;swapper&#39; =
THREAD: cf01a000<br> GPR00: 0000000c cf01bd60 cf01c000 cf04c300 ffffffff cf=
01bdbc 00000000 c01d0000<br> GPR08: 00001249 fffffffc 00000000 cf000420 840=
02022 00000000 10000b00 007fff00<br>
 GPR16: 0fffa1d0 00000000 00000004 cf01bdbc 007ffec0 00000000 00000000 0080=
0000<br> GPR24: 00000000 c01b7650 00000002 c01d0000 ffffffff ce4a6700 cf04c=
300 57555541<br> NIP [c0110ddc] init_dev+0x2bc/0x584<br> LR [c011118c] tty_=
open+0xe8/0x3e0<br>
 Call Trace:<br> [cf01bd60] [cf01bd78] 0xcf01bd78 (unreliable)<br> [cf01bdb=
0] [c011118c] tty_open+0xe8/0x3e0<br> [cf01bde0] [c00742c8] chrdev_open+0x1=
14/0x1b0<br> [cf01be10] [c006fb5c] __dentry_open+0x190/0x2e8<br> [cf01be40]=
 [c006fdac] nameidata_to_filp+0x38/0x70<br>
 [cf01be60] [c007bc60] do_filp_open+0x200/0x7d0<br> [cf01bf10] [c00700b4] d=
o_sys_open+0x74/0x114<br> [cf01bf40] [c0003c94] init_post+0x34/0x258<br> [c=
f01bf60] [c019ca64] kernel_init+0x258/0x270<br> [cf01bff0] [c0011b3c] kerne=
l_thread+0x44/0x60<br>
 Instruction dump:<br> 7d808120 4e800020 7c832378 4bfa9ea9 7c7f1b79 418201f=
0 a81e0062 2f800001<br> 409efd98 83ff00d0 2c1f0000 4182fd90 &lt;801f00b8&gt=
; 70090080 408201b0 801e0060<br> ---[ end trace b7795a387aeb7786 ]---<br>
 Kernel panic - not syncing: Attempted to kill init!<br> allocation failed:=
 out of vmalloc space - use vmalloc=3D&lt;size&gt; to increase size.<br> <b=
r> </blockquote></div><br>

------=_Part_11231_5142318.1220271930348--
