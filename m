Return-Path: <j.s.denova@gmail.com>
MIME-Version: 1.0
In-Reply-To: <871vp2eu09.fsf@macbook.be.48ers.dk>
References: <621779fd0906290825i6bdc1e99tf6be68e3de56e9a6@mail.gmail.com>
	<871vp2eu09.fsf@macbook.be.48ers.dk>
Date: Mon, 6 Jul 2009 14:38:28 +0200
Message-ID: <621779fd0907060538x705e5888ke55ff642abe254f@mail.gmail.com>
Subject: Re: Device tree for c67x00
From: =?ISO-8859-1?Q?Jorge_S=E1nchez_de_Nova?= <j.s.denova@gmail.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Content-Type: multipart/mixed; boundary=0015174c136e6f3b7c046e08c8f1
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174c136e6f3b7c046e08c8f1
Content-Type: multipart/alternative; boundary=0015174c136e6f3b6b046e08c8ef

--0015174c136e6f3b6b046e08c8ef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

 ok, so I have managed to give it some OF support in a preliminary way(see
patch). But now, I am facing serious problems which I am finding difficult
to tackle. I understand that maybe these problems have to do partially or
entirely to the Xilinx ML403. Let me explain myself: First of all, I don't
know of anyone else who has used it for the ML403 with the XPS_EPC , so
there might be some particularities I should specifically take care of.

 First of all, I see a resetting problem. When I load the kernel with my
board from a powered off state to a powered on state it behaves differently
that if I just to try to load the kernel again with the board powered on
(see ERROR 1 below). I have seen that the reset line in the c67300 is
connected to the fpga and for sure, to take care of it one would need to do
it through a third gpio line outside. This would be to make a hard reset.
Looking at this old specific driver that I have found for kernel 2.4.20 (
http://www.sysf.physto.se/~attila/ATLAS/Digitizer/Testbench/System_ISE_Soft=
MAC/linux/software/uClinux-2.4.x/drivers/usb/cy7c67300/<http://www.sysf.phy=
sto.se/%7Eattila/ATLAS/Digitizer/Testbench/System_ISE_SoftMAC/linux/softwar=
e/uClinux-2.4.x/drivers/usb/cy7c67300/>)
I see that the hard resets are common using the ugly gpio method.

 With the board on, if I reload the fpga programming and kernel image into
memory and set the PC to run properly, it gives different errors. Sometimes
ERROR2 and some other times ERROR3. When ERROR2, the processor halts when
calling WARN_ON(!res) and in the second, the interrupt handler keeps writin=
g
to the output endlessly.

 I have added some printks to trace the problem and the OF support is simpl=
y
a rewriting of the normal platform_driver registration. Any ideas?

Jorge

-- ERROR 1 (just after power on--
Generic platform RAM MTD, (c) 2004 Simtec Electronics
usbmon: debugfs is not available
C67X00_DBG:c67x00_of_probe() - Request memory region
C67X00_DBG:c67x00_of_probe() - Allocating data structs
C67X00_DBG:c67x00_of_probe() - Configuring c67x00 device
C67X00_DBG:c67x00_of_probe() - Configure platform data based on the
device-tree data
C67X00_DBG:c67x00_of_probe() - hpi.regstep: 2
C67X00_DBG:c67x00_of_probe() - SIE_config: 1
C67X00_DBG:c67x00_of_probe() - SIE_config: 21
C67X00_DBG:c67x00_of_probe() - Low-level initizalization
C67X00_DBG:c67x00_ll_hpi_reg_init(): Reg:324 written=3D0x00 ; read: 0
C67X00_DBG:c67x00_ll_hpi_reg_init(): Reg:328 written=3D0x00 ; read: 0
C67X00_DBG:c67x00_of_probe() - Registering IRQ
C67X00_DBG:c67x00_of_probe() - Trying to register IRQ:17 @ 17
C67X00_DBG:c67x00_irq() - Handling IRQ number 57005
=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=EF=BF=BD;=EF=BF=BDL=EF=BF=
=BD=3D?=EF=BF=BD : Not all interrupts handled! status =3D 0xdead
C67X00_DBG:c67x00_irq() - Handling IRQ number 57005
C67X00_DBG:c67x00_of_probe() - Low-level reset
C67X00_DBG:c67x00_ll_reset() - Send mbox
C67X00_DBG:c67x00_ll_reset() - recv_msg
C67X00_DBG:ll_recv_msg() -  calling wait_for_completion_timeout
C67X00_DBG:ll_recv_msg() res=3D5000
C67X00_DBG:c67x00_ll_reset() - done recv_msg
C67X00_DBG:c67x00_of_probe() - Configuring SIEs
C67X00_DBG:ll_recv_msg() -  calling wait_for_completion_timeout
C67X00_DBG:ll_recv_msg() res=3D5000
=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=C3=98=EF=BF=BD : SIE 0 not=
 set to host mode
=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=C3=98=EF=BF=BD : Cypress C=
67X00 Host Controller
Unable to handle kernel paging request for data at address 0x00000002
Faulting instruction address: 0xc0012654
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT Xilinx Virtex
Modules linked in:
NIP: c0012654 LR: c01c8ca0 CTR: c01fa0e4
REGS: c381db90 TRAP: 0300   Not tainted  (2.6.29.4)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 35039055  XER: a000004b
DEAR: 00000002, ESR: 00000000
TASK =3D c381a000[1] 'swapper' THREAD: c381c000
GPR00: 00000002 c381dc40 c381a000 00000002 00000001 00000000 fffffffe
ffffffff
GPR08: 00000000 00000008 00000003 c380a0b1 35039059 ffffffff ffffffff
ffffffff
GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff c398fee0 c035bdc4
c0360acc
GPR24: 00000000 00000000 c380a000 c03cac98 00000001 c385a84c 000000d0
c385a84c
NIP [c0012654] strlen+0x4/0x18
LR [c01c8ca0] kobject_get_path+0x34/0xe0
Call Trace:
[c381dc40] [c01c91fc] add_uevent_var+0x74/0xf4 (unreliable)
[c381dc60] [c01fa190] dev_uevent+0xac/0x210
[c381dc80] [c01c94a8] kobject_uevent_env+0x22c/0x454
[c381dcd0] [c01fb164] device_add+0x39c/0x594
[c381dd20] [c01fb418] device_create_vargs+0x8c/0xd0
[c381dd50] [c01fb49c] device_create+0x40/0x50
[c381dd80] [c0219fc0] usb_add_hcd+0x140/0x6d4
[c381ddb0] [c022daac] c67x00_hcd_probe+0x120/0x1f0
[c381ddd0] [c022c88c] c67x00_probe_sie+0xcc/0xe0
[c381dde0] [c02f43a4] c67x00_of_probe+0x3fc/0x458
[c381de50] [c0258a88] of_platform_device_probe+0x5c/0x84
[c381de70] [c01fdb8c] driver_probe_device+0xbc/0x1f4
[c381de90] [c01fdd68] __driver_attach+0xa4/0xa8
[c381deb0] [c01fce78] bus_for_each_dev+0x5c/0x98
[c381dee0] [c01fd990] driver_attach+0x24/0x34
[c381def0] [c01fd798] bus_add_driver+0x1d0/0x250
[c381df20] [c01fe0b4] driver_register+0x5c/0x150
[c381df40] [c0258950] of_register_driver+0x54/0x70
[c381df50] [c03aaa8c] c67x00_init+0x34/0x8c
[c381df60] [c000236c] do_one_initcall+0x34/0x1a4
[c381dfd0] [c0393170] kernel_init+0x90/0xfc
[c381dff0] [c000fa24] kernel_thread+0x4c/0x68
Instruction dump:
4d820020 7ca903a6 38a3ffff 3884ffff 8c650001 2c830000 8c040001 7c601851
4d860020 4102ffec 4e800020 3883ffff <8c040001> 2c000000 4082fff8 7c632050
---[ end trace f8500dd73d54b5fd ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

-- ERROR 2 (with the board already on, just reprogramming fpga, kernel and
booting again)--

Generic platform RAM MTD, (c) 2004 Simtec Electronics
usbmon: debugfs is not available
C67X00_DBG:c67x00_of_probe() - Request memory region
C67X00_DBG:c67x00_of_probe() - Allocating data structs
C67X00_DBG:c67x00_of_probe() - Configuring c67x00 device
C67X00_DBG:c67x00_of_probe() - Configure platform data based on the
device-tree data
C67X00_DBG:c67x00_of_probe() - hpi.regstep: 2
C67X00_DBG:c67x00_of_probe() - SIE_config: 1
C67X00_DBG:c67x00_of_probe() - SIE_config: 21
C67X00_DBG:c67x00_of_probe() - Low-level initizalization
C67X00_DBG:c67x00_ll_hpi_reg_init(): Reg:324 written=3D0x00 ; read: 0
C67X00_DBG:c67x00_ll_hpi_reg_init(): Reg:328 written=3D0x00 ; read: 0
C67X00_DBG:c67x00_of_probe() - Registering IRQ
C67X00_DBG:c67x00_of_probe() - Trying to register IRQ:17 @ 17
C67X00_DBG:c67x00_of_probe() - Low-level reset
C67X00_DBG:c67x00_ll_reset() - Send mbox
C67X00_DBG:c67x00_ll_reset() - recv_msg
C67X00_DBG:ll_recv_msg() -  calling wait_for_completion_timeout
C67X00_DBG:ll_recv_msg() res=3D0
--> Here the processor halts when in call to WARN_ON(!res);

-- ERROR 3: gets stuck in the interrupt handler --
=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=EF=BF=BD;=EF=BF=BDL=EF=BF=
=BD=3D?=EF=BF=BD : Not all interrupts handled! status =3D 0x0148
C67X00_DBG:c67x00_irq() - Handling IRQ number 328

2009/6/29 Peter Korsgaard <jacmet@sunsite.dk>

> >>>>> "Jorge" =3D=3D Jorge S=C3=A1nchez de Nova <j.s.denova@gmail.com> wr=
ites:
>
>  Jorge> Hi,
>
>  Jorge> It doesn't work at all since it doesn't load anything. I have
>  Jorge> looked at the driver and there is apparently no openfirmware
>  Jorge> support for it, so maybe the dts info won't work without
>  Jorge> it. Am I wrong? Does this means that the c67x00 needs OF
>  Jorge> support to work in this configuration? How can I make it
>  Jorge> otherwise?
>
> Yes, the c67x00 driver doesn't currently have any OF bindings. Either
> you can add it, or simply manually create the struct platform_device
> in your board file (or scan the DT in your board file and fill in the
> correct base address / interrupt number from it).
>
> Remember that arch/powerpc uses virtual interrupt numbers if you're
> going to fill in the platform_device by hand.
>
> --
> Bye, Peter Korsgaard
>

--0015174c136e6f3b6b046e08c8ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>=C2=A0ok, so I have managed to give it some OF support in a pre=
liminary way(see patch). But now, I am facing serious problems which I am f=
inding difficult to tackle. I understand that maybe these problems have to =
do partially or entirely to the Xilinx ML403. Let me explain myself: First =
of all, I don&#39;t know of anyone else who has used it for the ML403 with =
the XPS_EPC , so there might be some particularities I should specifically =
take care of. <br>


<br>=C2=A0First of all, I see a resetting problem. When I load the kernel w=
ith my board from a powered off state to a powered on state it behaves diff=
erently that if I just to try to load the kernel again with the board power=
ed on (see ERROR 1 below). I have seen that the reset line in the c67300 is=
 connected to the fpga and for sure, to take care of it one would need to d=
o it through a third gpio line outside. This would be to make a hard reset.=
 Looking at this old specific driver that I have found for kernel 2.4.20 ( =
<a href=3D"http://www.sysf.physto.se/%7Eattila/ATLAS/Digitizer/Testbench/Sy=
stem_ISE_SoftMAC/linux/software/uClinux-2.4.x/drivers/usb/cy7c67300/" targe=
t=3D"_blank">http://www.sysf.physto.se/~attila/ATLAS/Digitizer/Testbench/Sy=
stem_ISE_SoftMAC/linux/software/uClinux-2.4.x/drivers/usb/cy7c67300/</a> ) =
I see that the hard resets are common using the ugly gpio method. <br>


<br>=C2=A0With the board on, if I reload the fpga programming and kernel im=
age into memory and set the PC to run properly, it gives different errors. =
Sometimes ERROR2 and some other times ERROR3. When ERROR2, the processor ha=
lts when calling WARN_ON(!res) and in the second, the interrupt handler kee=
ps writing to the output endlessly. <br>
<br>=C2=A0I have added some printks to trace the problem and the OF support=
 is simply a rewriting of the normal platform_driver registration. Any idea=
s?<br><br>Jorge<br><br>-- ERROR 1 (just after power on-- <br>Generic platfo=
rm RAM MTD, (c) 2004 Simtec Electronics<br>
usbmon: debugfs is not available<br>C67X00_DBG:c67x00_of_probe() - Request =
memory region<br>C67X00_DBG:c67x00_of_probe() - Allocating data structs<br>=
C67X00_DBG:c67x00_of_probe() - Configuring c67x00 device<br>C67X00_DBG:c67x=
00_of_probe() - Configure platform data based on the device-tree data<br>
C67X00_DBG:c67x00_of_probe() - hpi.regstep: 2<br>C67X00_DBG:c67x00_of_probe=
() - SIE_config: 1<br>C67X00_DBG:c67x00_of_probe() - SIE_config: 21<br>C67X=
00_DBG:c67x00_of_probe() - Low-level initizalization <br>C67X00_DBG:c67x00_=
ll_hpi_reg_init(): Reg:324 written=3D0x00 ; read: 0<br>
C67X00_DBG:c67x00_ll_hpi_reg_init(): Reg:328 written=3D0x00 ; read: 0<br>C6=
7X00_DBG:c67x00_of_probe() - Registering IRQ<br>C67X00_DBG:c67x00_of_probe(=
) - Trying to register IRQ:17 @ 17<br>C67X00_DBG:c67x00_irq() - Handling IR=
Q number 57005<br>
=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=EF=BF=BD;=EF=BF=BDL=EF=BF=
=BD=3D?=EF=BF=BD : Not all interrupts handled! status =3D 0xdead<br>C67X00_=
DBG:c67x00_irq() - Handling IRQ number 57005<br>C67X00_DBG:c67x00_of_probe(=
) - Low-level reset<br>C67X00_DBG:c67x00_ll_reset() - Send mbox<br>C67X00_D=
BG:c67x00_ll_reset() - recv_msg<br>
C67X00_DBG:ll_recv_msg() -=C2=A0 calling wait_for_completion_timeout <br>C6=
7X00_DBG:ll_recv_msg() res=3D5000<br>C67X00_DBG:c67x00_ll_reset() - done re=
cv_msg<br>C67X00_DBG:c67x00_of_probe() - Configuring SIEs<br>C67X00_DBG:ll_=
recv_msg() -=C2=A0 calling wait_for_completion_timeout <br>
C67X00_DBG:ll_recv_msg() res=3D5000<br>=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=
=BD=EF=BF=BD=C3=98=EF=BF=BD : SIE 0 not set to host mode<br>=C3=85=EF=BF=BD=
=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=C3=98=EF=BF=BD : Cypress C67X00 Host Cont=
roller<br>Unable to handle kernel paging request for data at address 0x0000=
0002<br>Faulting instruction address: 0xc0012654<br>
Oops: Kernel access of bad area, sig: 11 [#1]<br>PREEMPT Xilinx Virtex<br>M=
odules linked in:<br>NIP: c0012654 LR: c01c8ca0 CTR: c01fa0e4<br>REGS: c381=
db90 TRAP: 0300=C2=A0=C2=A0 Not tainted=C2=A0 (2.6.29.4)<br>MSR: 00029030 &=
lt;EE,ME,CE,IR,DR&gt;=C2=A0 CR: 35039055=C2=A0 XER: a000004b<br>
DEAR: 00000002, ESR: 00000000<br>TASK =3D c381a000[1] &#39;swapper&#39; THR=
EAD: c381c000<br>GPR00: 00000002 c381dc40 c381a000 00000002 00000001 000000=
00 fffffffe ffffffff <br>GPR08: 00000000 00000008 00000003 c380a0b1 3503905=
9 ffffffff ffffffff ffffffff <br>
GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff c398fee0 c035bdc4 c0360=
acc <br>GPR24: 00000000 00000000 c380a000 c03cac98 00000001 c385a84c 000000=
d0 c385a84c <br>NIP [c0012654] strlen+0x4/0x18<br>LR [c01c8ca0] kobject_get=
_path+0x34/0xe0<br>
Call Trace:<br>[c381dc40] [c01c91fc] add_uevent_var+0x74/0xf4 (unreliable)<=
br>[c381dc60] [c01fa190] dev_uevent+0xac/0x210<br>[c381dc80] [c01c94a8] kob=
ject_uevent_env+0x22c/0x454<br>[c381dcd0] [c01fb164] device_add+0x39c/0x594=
<br>
[c381dd20] [c01fb418] device_create_vargs+0x8c/0xd0<br>[c381dd50] [c01fb49c=
] device_create+0x40/0x50<br>[c381dd80] [c0219fc0] usb_add_hcd+0x140/0x6d4<=
br>[c381ddb0] [c022daac] c67x00_hcd_probe+0x120/0x1f0<br>[c381ddd0] [c022c8=
8c] c67x00_probe_sie+0xcc/0xe0<br>
[c381dde0] [c02f43a4] c67x00_of_probe+0x3fc/0x458<br>[c381de50] [c0258a88] =
of_platform_device_probe+0x5c/0x84<br>[c381de70] [c01fdb8c] driver_probe_de=
vice+0xbc/0x1f4<br>[c381de90] [c01fdd68] __driver_attach+0xa4/0xa8<br>[c381=
deb0] [c01fce78] bus_for_each_dev+0x5c/0x98<br>
[c381dee0] [c01fd990] driver_attach+0x24/0x34<br>[c381def0] [c01fd798] bus_=
add_driver+0x1d0/0x250<br>[c381df20] [c01fe0b4] driver_register+0x5c/0x150<=
br>[c381df40] [c0258950] of_register_driver+0x54/0x70<br>[c381df50] [c03aaa=
8c] c67x00_init+0x34/0x8c<br>
[c381df60] [c000236c] do_one_initcall+0x34/0x1a4<br>[c381dfd0] [c0393170] k=
ernel_init+0x90/0xfc<br>[c381dff0] [c000fa24] kernel_thread+0x4c/0x68<br>In=
struction dump:<br>4d820020 7ca903a6 38a3ffff 3884ffff 8c650001 2c830000 8c=
040001 7c601851 <br>
4d860020 4102ffec 4e800020 3883ffff &lt;8c040001&gt; 2c000000 4082fff8 7c63=
2050 <br>---[ end trace f8500dd73d54b5fd ]---<br>Kernel panic - not syncing=
: Attempted to kill init!<br>Rebooting in 180 seconds..<br><br>-- ERROR 2 (=
with the board already on, just reprogramming fpga, kernel and booting agai=
n)-- <br>
<br>Generic platform RAM MTD, (c) 2004 Simtec Electronics<br>usbmon: debugf=
s is not available<br>C67X00_DBG:c67x00_of_probe() - Request memory region<=
br>C67X00_DBG:c67x00_of_probe() - Allocating data structs<br>C67X00_DBG:c67=
x00_of_probe() - Configuring c67x00 device<br>
C67X00_DBG:c67x00_of_probe() - Configure platform data based on the device-=
tree data<br>C67X00_DBG:c67x00_of_probe() - hpi.regstep: 2<br>C67X00_DBG:c6=
7x00_of_probe() - SIE_config: 1<br>C67X00_DBG:c67x00_of_probe() - SIE_confi=
g: 21<br>
C67X00_DBG:c67x00_of_probe() - Low-level initizalization <br>C67X00_DBG:c67=
x00_ll_hpi_reg_init(): Reg:324 written=3D0x00 ; read: 0<br>C67X00_DBG:c67x0=
0_ll_hpi_reg_init(): Reg:328 written=3D0x00 ; read: 0<br>C67X00_DBG:c67x00_=
of_probe() - Registering IRQ<br>
C67X00_DBG:c67x00_of_probe() - Trying to register IRQ:17 @ 17<br>C67X00_DBG=
:c67x00_of_probe() - Low-level reset<br>C67X00_DBG:c67x00_ll_reset() - Send=
 mbox<br>C67X00_DBG:c67x00_ll_reset() - recv_msg<br>C67X00_DBG:ll_recv_msg(=
) -=C2=A0 calling wait_for_completion_timeout <br>
C67X00_DBG:ll_recv_msg() res=3D0<br>--&gt; Here the processor halts when in=
 call to WARN_ON(!res);<br><br>-- ERROR 3: gets stuck in the interrupt hand=
ler -- <br>=C3=85=EF=BF=BD=EF=BF=BD=C3=85=EF=BF=BD=EF=BF=BD=EF=BF=BD;=EF=BF=
=BDL=EF=BF=BD=3D?=EF=BF=BD : Not all interrupts handled! status =3D 0x0148<=
br>
C67X00_DBG:c67x00_irq() - Handling IRQ number 328<br><br><div class=3D"gmai=
l_quote">2009/6/29 Peter Korsgaard <span dir=3D"ltr">&lt;<a href=3D"mailto:=
jacmet@sunsite.dk" target=3D"_blank">jacmet@sunsite.dk</a>&gt;</span><br><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



&gt;&gt;&gt;&gt;&gt; &quot;Jorge&quot; =3D=3D Jorge S=C3=A1nchez de Nova &l=
t;<a href=3D"mailto:j.s.denova@gmail.com" target=3D"_blank">j.s.denova@gmai=
l.com</a>&gt; writes:<br>
<br>
=C2=A0Jorge&gt; Hi,<br>
<br>
=C2=A0Jorge&gt; It doesn&#39;t work at all since it doesn&#39;t load anythi=
ng. I have<br>
=C2=A0Jorge&gt; looked at the driver and there is apparently no openfirmwar=
e<br>
=C2=A0Jorge&gt; support for it, so maybe the dts info won&#39;t work withou=
t<br>
=C2=A0Jorge&gt; it. Am I wrong? Does this means that the c67x00 needs OF<br=
>
=C2=A0Jorge&gt; support to work in this configuration? How can I make it<br=
>
=C2=A0Jorge&gt; otherwise?<br>
<br>
Yes, the c67x00 driver doesn&#39;t currently have any OF bindings. Either<b=
r>
you can add it, or simply manually create the struct platform_device<br>
in your board file (or scan the DT in your board file and fill in the<br>
correct base address / interrupt number from it).<br>
<br>
Remember that arch/powerpc uses virtual interrupt numbers if you&#39;re<br>
going to fill in the platform_device by hand.<br>
<font color=3D"#888888"><br>
--<br>
Bye, Peter Korsgaard<br>
</font></blockquote></div><br>

--0015174c136e6f3b6b046e08c8ef--

--0015174c136e6f3b7c046e08c8f1
Content-Type: text/x-patch; charset=US-ASCII; name="c67x00_of.patch"
Content-Disposition: attachment; filename="c67x00_of.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwt68e7m0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2M2N3gwMC9jNjd4MDAtZHJ2LmMgYi9kcml2ZXJzL3Vz
Yi9jNjd4MDAvYzY3eDAwLWRydi5jCmluZGV4IDU2MzNiYzUuLjY5OWNiZWYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdXNiL2M2N3gwMC9jNjd4MDAtZHJ2LmMKKysrIGIvZHJpdmVycy91c2IvYzY3eDAw
L2M2N3gwMC1kcnYuYwpAQCAtMzksNiArMzksMTAgQEAKICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+
CiAjaW5jbHVkZSA8bGludXgvdXNiLmg+CiAjaW5jbHVkZSA8bGludXgvdXNiL2M2N3gwMC5oPgor
I2lmIGRlZmluZWQoQ09ORklHX09GKQorI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPgorI2lu
Y2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+CisjZW5kaWYKIAogI2luY2x1ZGUgImM2N3gwMC5o
IgogI2luY2x1ZGUgImM2N3gwMC1oY2QuaCIKQEAgLTg3LDggKzkxLDkgQEAgc3RhdGljIGlycXJl
dHVybl90IGM2N3gwMF9pcnEoaW50IGlycSwgdm9pZCAqX19kZXYpCiAJc3RydWN0IGM2N3gwMF9z
aWUgKnNpZTsKIAl1MTYgbXNnLCBpbnRfc3RhdHVzOwogCWludCBpLCBjb3VudCA9IDg7Ci0KKy8v
CXByaW50aygiSGFuZGxpbmcgSVJRIVxuIik7CiAJaW50X3N0YXR1cyA9IGM2N3gwMF9sbF9ocGlf
c3RhdHVzKGM2N3gwMCk7CisJcHJpbnRrKCJDNjdYMDBfREJHOmM2N3gwMF9pcnEoKSAtIEhhbmRs
aW5nIElSUSBudW1iZXIgJWRcbiIsaW50X3N0YXR1cyk7CiAJaWYgKCFpbnRfc3RhdHVzKQogCQly
ZXR1cm4gSVJRX05PTkU7CiAKQEAgLTIyNSwxNCArMjMwLDI0MSBAQCBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBjNjd4MDBfZHJpdmVyID0gewogfTsKIE1PRFVMRV9BTElBUygicGxhdGZv
cm06YzY3eDAwIik7CiAKKy8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorICogT0ZfUGxhdGZvcm0gQnVzIFN1cHBv
cnQKKyAqLworCisjaWYgZGVmaW5lZChDT05GSUdfT0YpCitzdGF0aWMgaW50IF9fZGV2aW5pdCBj
Njd4MDBfb2ZfcHJvYmUoc3RydWN0IG9mX2RldmljZSAqZGV2LCAKKwkJCQkgICAgIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoKQoreworIAlzdHJ1Y3QgYzY3eDAwX2RldmljZSAqYzY3
eDAwOworIAlzdHJ1Y3QgYzY3eDAwX3BsYXRmb3JtX2RhdGEgKnBkYXRhOworCXN0cnVjdCByZXNv
dXJjZSByX2lycV9zdHJ1Y3Q7CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJc3RydWN0IHJlc291
cmNlIG1lbW9yeTsKKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmRwID0gZGV2LT5ub2RlOworCXN0cnVj
dCByZXNvdXJjZSogcl9pcnEgPSAmcl9pcnFfc3RydWN0OworCXUzMiogaXByb3A7CisJaW50IGxl
biwgcmV0LCBpOworCisJLyogUmVxdWVzdCBtZW1vcnkgcmVnaW9uICovCisJcHJpbnRrKCJDNjdY
MDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gUmVxdWVzdCBtZW1vcnkgcmVnaW9uXG4iKTsKKwly
ZXQgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNlKGRwLCAwLCAmbWVtb3J5KTsKKwlpZiAocmV0KQor
CQlyZXR1cm4gLUVOWElPOworCisJcmVzID0gcmVxdWVzdF9tZW1fcmVnaW9uKG1lbW9yeS5zdGFy
dCwgbWVtb3J5LmVuZCAtIG1lbW9yeS5zdGFydCArIDEsCisJCQlkZXZfbmFtZSgmZGV2LT5kZXYp
KTsKKworCWlmICghcmVzKXsKKwkJZGV2X2VycigmZGV2LT5kZXYsICJNZW1vcnkgcmVnaW9uIGJ1
c3lcbiIpOyAKKwkJcmV0dXJuIC1FQlVTWTsJCQorCX0KKworCS8qIEFsbG9jYXRlIGRldmljZSBh
bmQgcGxhdGZvcm1fZGF0YSBzdHJ1Y3RzICovCisJcHJpbnRrKCJDNjdYMDBfREJHOmM2N3gwMF9v
Zl9wcm9iZSgpIC0gQWxsb2NhdGluZyBkYXRhIHN0cnVjdHNcbiIpOworCWM2N3gwMCA9IGt6YWxs
b2Moc2l6ZW9mKCpjNjd4MDApLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWM2N3gwMCkJCisJICAgIHJl
dHVybiAtRU5PTUVNOworCisJcGRhdGEgPSBremFsbG9jKHNpemVvZigqcGRhdGEpLCBHRlBfS0VS
TkVMKTsKKwlpZiAoIXBkYXRhKXsKKwkJcmV0ID0gLUVOT01FTTsKKwkgICAgICAgIGdvdG8gcmVx
dWVzdF9tZW1fZmFpbGVkOworCX0KKworCS8qIENvbmZpZ3VyZSBjNjd4MDAgZGV2aWNlICovCisJ
cHJpbnRrKCJDNjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gQ29uZmlndXJpbmcgYzY3eDAw
IGRldmljZVxuIik7CisJYzY3eDAwLT5ocGkuYmFzZSA9IGlvcmVtYXAobWVtb3J5LnN0YXJ0LCBt
ZW1vcnkuZW5kIC0gbWVtb3J5LnN0YXJ0ICsgMSk7CisKKwlpZiAoIWM2N3gwMC0+aHBpLmJhc2Up
IHsKKwkJZGV2X2VycigmZGV2LT5kZXYsICJVbmFibGUgdG8gbWFwIEhQSSByZWdpc3RlcnNcbiIp
OworCQlyZXQgPSAtRUlPOworCQlnb3RvIG1hcF9mYWlsZWQ7CisJfQorCisJLyogQ29uZmlndXJl
IHBsYXRmb3JtIGRhdGEgYmFzZWQgb24gdGhlIGRldmljZS10cmVlIGRhdGEgKi8JCisJcHJpbnRr
KCJDNjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gQ29uZmlndXJlIHBsYXRmb3JtIGRhdGEg
YmFzZWQgb24gdGhlIGRldmljZS10cmVlIGRhdGFcbiIpOworCXNwaW5fbG9ja19pbml0KCZjNjd4
MDAtPmhwaS5sb2NrKTsKKwkvL1RPRE86IENoZWNrIHRoYXQgd2UgYXJlIHVzaW5nIHRoZSBNTDQw
MworCisJaXByb3AgPSBvZl9nZXRfcHJvcGVydHkoZGV2LT5ub2RlLCAieGxueCxocGlfcmVnc3Rl
cCIsICZsZW4pOworCWlmICghaXByb3AgfHwgbGVuIDwgc2l6ZW9mKCppcHJvcCkpIHsKKwkJZGV2
X2VycigmZGV2LT5kZXYsICJObyAneGxueCxocGlfcmVnc3RlcCBwcm9wZXJ0eSdcbiIpOworCQly
ZXQgPSAtRUlPOworCQlnb3RvIG1hcF9mYWlsZWQ7IC8vVE9ETworCX0KKwljNjd4MDAtPmhwaS5y
ZWdzdGVwID0gKmlwcm9wOworCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfb2ZfcHJvYmUoKSAt
IGhwaS5yZWdzdGVwOiAleFxuIiwgYzY3eDAwLT5ocGkucmVnc3RlcCk7CQorCisJaXByb3AgPSBv
Zl9nZXRfcHJvcGVydHkoZGV2LT5ub2RlLCAieGxueCxzaWUxX2NvbmZpZyIsICZsZW4pOworCWlm
ICghaXByb3AgfHwgbGVuIDwgc2l6ZW9mKCppcHJvcCkpIHsKKwkJZGV2X2VycigmZGV2LT5kZXYs
ICJObyAneGxueCxzaWUxX2NvbmZpZydcbiIpOworCQlyZXQgPSAtRUlPOworCQlnb3RvIG1hcF9m
YWlsZWQ7IC8vVE9ETworCX0KKwlwZGF0YS0+c2llX2NvbmZpZyA9ICAqaXByb3A7CisJcHJpbnRr
KCJDNjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gU0lFX2NvbmZpZzogJXhcbiIsIHBkYXRh
LT5zaWVfY29uZmlnKTsJCisKKwlpcHJvcCA9IG9mX2dldF9wcm9wZXJ0eShkZXYtPm5vZGUsICJ4
bG54LHNpZTJfY29uZmlnIiwgJmxlbik7CisJaWYgKCFpcHJvcCB8fCBsZW4gPCBzaXplb2YoKmlw
cm9wKSkgeworCQlkZXZfZXJyKCZkZXYtPmRldiwgIk5vICd4bG54LHNpZTJfY29uZmlnJ1xuIik7
CisJCXJldCA9IC1FSU87CisJCWdvdG8gbWFwX2ZhaWxlZDsgLy9UT0RPCisJfQorCXBkYXRhLT5z
aWVfY29uZmlnIHw9ICppcHJvcCA8PCA0OworCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfb2Zf
cHJvYmUoKSAtIFNJRV9jb25maWc6ICV4XG4iLCBwZGF0YS0+c2llX2NvbmZpZyk7CisKKwljNjd4
MDAtPnBkYXRhID0gcGRhdGE7CisJYzY3eDAwLT5wZGV2ID0gZGV2OworCisJLyogTG93LWxldmVs
IGluaXRpemFsaXphdGlvbiAqLworCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfb2ZfcHJvYmUo
KSAtIExvdy1sZXZlbCBpbml0aXphbGl6YXRpb24gXG4iKTsKKwljNjd4MDBfbGxfaW5pdChjNjd4
MDApOworCWM2N3gwMF9sbF9ocGlfcmVnX2luaXQoYzY3eDAwKTsKKworCS8qIFJlcXVlc3QgSVJR
ICovCQorCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfb2ZfcHJvYmUoKSAtIFJlZ2lzdGVyaW5n
IElSUVxuIik7CisJZGV2X2RiZygmZGV2LT5kZXYsICJSZWdpc3RlcmluZyBJUlFcbiIpOworCXJl
dCA9IG9mX2lycV90b19yZXNvdXJjZShkZXYtPm5vZGUsIDAsIHJfaXJxKTsKKworCWlmIChyZXQg
PT0gTk9fSVJRKSB7CisJCWRldl9lcnIoJmRldi0+ZGV2LCAiQ291bGRuJ3QgZmluZCBJUlEgaW4g
ZGV2aWNlLXRyZWVcbiIpOworCQlnb3RvIHJlcXVlc3RfaXJxX2ZhaWxlZDsKKwl9CisJcHJpbnRr
KCJDNjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gVHJ5aW5nIHRvIHJlZ2lzdGVyIElSUTol
ZCBAICVkXG4iLHJldCxyX2lycS0+c3RhcnQpOworCXJldCA9IHJlcXVlc3RfaXJxKHJfaXJxLT5z
dGFydCwgYzY3eDAwX2lycSwgMCwgZGV2X25hbWUoJmRldi0+ZGV2KSwgYzY3eDAwKTsKKwlpZiAo
cmV0KSB7CisJCWRldl9lcnIoJmRldi0+ZGV2LCAiQ2Fubm90IGNsYWltIElSUVxuIik7CisJCWdv
dG8gcmVxdWVzdF9pcnFfZmFpbGVkOworCX0KKworCS8qIFJlc2V0IGM2N3gwMCBhcyBwYXJ0IG9m
IHRoZSBpbml0aXphbGl6YXRpb24qLworCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfb2ZfcHJv
YmUoKSAtIExvdy1sZXZlbCByZXNldFxuIik7CisJcmV0ID0gYzY3eDAwX2xsX3Jlc2V0KGM2N3gw
MCk7CisJaWYgKHJldCkgeworCQlwcmludGsoIkRldmljZSByZXNldCBmYWlsZWRcbiIpOworCQlk
ZXZfZXJyKCZkZXYtPmRldiwgIkRldmljZSByZXNldCBmYWlsZWRcbiIpOworCQlnb3RvIHJlc2V0
X2ZhaWxlZDsKKwl9CisKKwkvKiBQcm9iZSBlYWNoIG9mIHRoZSBTSUVzICovCisJcHJpbnRrKCJD
NjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gQ29uZmlndXJpbmcgU0lFc1xuIik7CisJZGV2
X2RiZygmZGV2LT5kZXYsICJDb25maWd1cmluZyBTSUVzXG4iKTsKKwlmb3IgKGkgPSAwOyBpIDwg
QzY3WDAwX1NJRVM7IGkrKykKKwkJYzY3eDAwX3Byb2JlX3NpZSgmYzY3eDAwLT5zaWVbaV0sIGM2
N3gwMCwgaSk7CisJcHJpbnRrKCJDNjdYMDBfREJHOmM2N3gwMF9vZl9wcm9iZSgpIC0gU2F2aW5n
IGRyaXZlciBkYXRhXG4iKTsKKwlkZXZfc2V0X2RydmRhdGEoJmRldi0+ZGV2LCBjNjd4MDApOwor
CXJldHVybiAwOworCisgcmVzZXRfZmFpbGVkOgorCWZyZWVfaXJxKHJfaXJxLT5zdGFydCwgYzY3
eDAwKTsKKyByZXF1ZXN0X2lycV9mYWlsZWQ6CisJaW91bm1hcChjNjd4MDAtPmhwaS5iYXNlKTsK
KyBtYXBfZmFpbGVkOgorCXJlbGVhc2VfbWVtX3JlZ2lvbihtZW1vcnkuc3RhcnQsIG1lbW9yeS5l
bmQgLSBtZW1vcnkuc3RhcnQgKyAxKTsKKwlrZnJlZShwZGF0YSk7CisgcmVxdWVzdF9tZW1fZmFp
bGVkOgorCWtmcmVlKGM2N3gwMCk7CisgICAgCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGlu
dCBfX2RldmV4aXQgYzY3eDAwX29mX3JlbW92ZShzdHJ1Y3Qgb2ZfZGV2aWNlICpkZXYpCit7CisJ
c3RydWN0IGM2N3gwMF9kZXZpY2UgKmM2N3gwMCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCXN0
cnVjdCByZXNvdXJjZSAqcmVzOworCWludCBpOworCisJZGV2X2RiZyhkZXYsICJjNjd4MDBfZnJl
ZSglcClcbiIsIGRldik7CisKKwlmb3IgKGkgPSAwOyBpIDwgQzY3WDAwX1NJRVM7IGkrKykKKwkJ
YzY3eDAwX3JlbW92ZV9zaWUoJmM2N3gwMC0+c2llW2ldKTsKKworCWM2N3gwMF9sbF9yZWxlYXNl
KGM2N3gwMCk7CisKKwkvL1RPRE86IHJlbGVhc2UgSVJRPworLy8gCXJlcyA9IHBsYXRmb3JtX2dl
dF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX0lSUSwgMCk7CisvLyAJaWYgKHJlcykKKy8vIAkJ
ZnJlZV9pcnEocmVzLT5zdGFydCwgYzY3eDAwKTsKKworCWlvdW5tYXAoYzY3eDAwLT5ocGkuYmFz
ZSk7CisKKworLy8gCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNF
X01FTSwgMCk7CisvLyAJaWYgKHJlcykKKy8vIAkJcmVsZWFzZV9tZW1fcmVnaW9uKHJlcy0+c3Rh
cnQsIHJlcy0+ZW5kIC0gcmVzLT5zdGFydCArIDEpOworCisJa2ZyZWUoYzY3eDAwKTsKKworCXJl
dHVybiAwOworfQorCisvKiBNYXRjaCB0YWJsZSBmb3Igb2ZfcGxhdGZvcm0gYmluZGluZyAqLwor
c3RhdGljIHN0cnVjdCBvZl9kZXZpY2VfaWQgYzY3eDAwX29mX21hdGNoW10gX19kZXZpbml0ZGF0
YSA9IHsJCisJeyAuY29tcGF0aWJsZSA9ICJjeSxjNjd4MDAiLCB9LAorCXsgLmNvbXBhdGlibGUg
PSAiY3ksYzY3MzAwIiwgfSwKKwl7fSwKK307CitNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBjNjd4
MDBfb2ZfbWF0Y2gpOworCitzdGF0aWMgc3RydWN0IG9mX3BsYXRmb3JtX2RyaXZlciBjNjd4MDBf
b2ZfZHJpdmVyID0geworCS5vd25lciA9IFRISVNfTU9EVUxFLAorCS5uYW1lID0gImM2N3gwMCIs
CisJLm1hdGNoX3RhYmxlID0gYzY3eDAwX29mX21hdGNoLAorCS5wcm9iZSA9IGM2N3gwMF9vZl9w
cm9iZSwKKwkucmVtb3ZlID0gX19kZXZleGl0X3AoYzY3eDAwX29mX3JlbW92ZSksCisJLmRyaXZl
ciA9IHsKKwkJLm5hbWUgPSAiYzY3eDAwIiwKKwkJLm93bmVyID0gVEhJU19NT0RVTEUsCisJfSwK
K307CisKKy8qIFJlZ2lzdHJhdGlvbiBoZWxwZXJzIHRvIGtlZXAgdGhlIG51bWJlciBvZiAjaWZk
ZWZzIHRvIGEgbWluaW11bSAqLworc3RhdGljIGlubGluZSBpbnQgX19pbml0IGM2N3gwMF9vZl9y
ZWdpc3Rlcih2b2lkKQoreworCXByX2RlYnVnKCJjNjd4MDA6IHJlZ2lzdGVyaW5nIE9GIGJpbmRp
bmdcbiIpOworCXJldHVybiBvZl9yZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoJmM2N3gwMF9vZl9k
cml2ZXIpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgX19leGl0IGM2N3gwMF9vZl91bnJlZ2lz
dGVyKHZvaWQpCit7CisJb2ZfdW5yZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoJmM2N3gwMF9vZl9k
cml2ZXIpOworfQorI2Vsc2UgLyogQ09ORklHX09GICovCisvKiBDT05GSUdfT0Ygbm90IGVuYWJs
ZWQ7IGRvIG5vdGhpbmcgaGVscGVycyAqLworc3RhdGljIGlubGluZSBpbnQgX19pbml0IGM2N3gw
MF9vZl9yZWdpc3Rlcih2b2lkKSB7IHJldHVybiAwOyB9CitzdGF0aWMgaW5saW5lIHZvaWQgX19l
eGl0IGM2N3gwMF9vZl91bnJlZ2lzdGVyKHZvaWQpIHsgfQorI2VuZGlmIC8qIENPTkZJR19PRiAq
LworCiBzdGF0aWMgaW50IF9faW5pdCBjNjd4MDBfaW5pdCh2b2lkKQogewotCXJldHVybiBwbGF0
Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmM2N3gwMF9kcml2ZXIpOworCWludCByYzsKKworCXJjID0g
YzY3eDAwX29mX3JlZ2lzdGVyKCk7CisJaWYgKHJjKQorCQlnb3RvIGVycl9vZjsKKworCXByX2Rl
YnVnKCJjNjd4MDA6IHJlZ2lzdGVyaW5nIHBsYXRmb3JtIGJpbmRpbmdcbiIpOworICAgICAgICBy
YyA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmYzY3eDAwX2RyaXZlcik7CisJaWYgKHJjKQor
CQlnb3RvIGVycl9wbGF0OworCisJcmV0dXJuIDA7IAorCitlcnJfb2Y6CisJYzY3eDAwX29mX3Vu
cmVnaXN0ZXIoKTsKK2Vycl9wbGF0OiAKKwlwcmludGsoImM2N3gwMDogcmVnaXN0cmF0aW9uIGZh
aWxlZDsgZXJyOiVpXG4iLHJjKTsKKwlyZXR1cm4gcmM7IAkKIH0KIAogc3RhdGljIHZvaWQgX19l
eGl0IGM2N3gwMF9leGl0KHZvaWQpCiB7CisJcHJfZGVidWcoIlVucmVnaXN0ZXJpbmcgYzY3eDAw
XG4iKTsgCiAJcGxhdGZvcm1fZHJpdmVyX3VucmVnaXN0ZXIoJmM2N3gwMF9kcml2ZXIpOworICAg
ICAgICBjNjd4MDBfb2ZfdW5yZWdpc3RlcigpOwogfQogCiBtb2R1bGVfaW5pdChjNjd4MDBfaW5p
dCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jNjd4MDAvYzY3eDAwLWxsLWhwaS5jIGIvZHJp
dmVycy91c2IvYzY3eDAwL2M2N3gwMC1sbC1ocGkuYwppbmRleCBhOTYzNmY0Li4yZTcwNjFhIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jNjd4MDAvYzY3eDAwLWxsLWhwaS5jCisrKyBiL2RyaXZl
cnMvdXNiL2M2N3gwMC9jNjd4MDAtbGwtaHBpLmMKQEAgLTIxOSw2ICsyMTksNyBAQCB2b2lkIGM2
N3gwMF9sbF9ocGlfcmVnX2luaXQoc3RydWN0IGM2N3gwMF9kZXZpY2UgKmRldikKIAlmb3IgKGkg
PSAwOyBpIDwgQzY3WDAwX1NJRVM7IGkrKykgewogCQlocGlfd3JpdGVfd29yZChkZXYsIFNJRU1T
R19SRUcoaSksIDApOwogCQlocGlfcmVhZF93b3JkKGRldiwgU0lFTVNHX1JFRyhpKSk7CisJCXBy
aW50aygiQzY3WDAwX0RCRzpjNjd4MDBfbGxfaHBpX3JlZ19pbml0KCk6IFJlZzolZCB3cml0dGVu
PTB4MDAgOyByZWFkOiAlZFxuIixTSUVNU0dfUkVHKGkpKTsKIAl9CiB9CiAKQEAgLTI0MCw4ICsy
NDEsOSBAQCB2b2lkIGM2N3gwMF9sbF9ocGlfZGlzYWJsZV9zb2Zlb3Aoc3RydWN0IGM2N3gwMF9z
aWUgKnNpZSkKIHN0YXRpYyBpbmxpbmUgdTE2IGxsX3JlY3ZfbXNnKHN0cnVjdCBjNjd4MDBfZGV2
aWNlICpkZXYpCiB7CiAJdTE2IHJlczsKLQorCXByaW50aygiQzY3WDAwX0RCRzpsbF9yZWN2X21z
ZygpIC0gIGNhbGxpbmcgd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0IFxuIik7CiAJcmVzID0g
d2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZkZXYtPmhwaS5sY3AubXNnX3JlY2VpdmVkLCA1
ICogSFopOworCXByaW50aygiQzY3WDAwX0RCRzpsbF9yZWN2X21zZygpIHJlcz0lZFxuIiwgcmVz
KTsKIAlXQVJOX09OKCFyZXMpOwogCiAJcmV0dXJuIChyZXMgPT0gMCkgPyAtRUlPIDogMDsKQEAg
LTM4OCwxMCArMzkwLDEzIEBAIHZvaWQgYzY3eDAwX2xsX2lycShzdHJ1Y3QgYzY3eDAwX2Rldmlj
ZSAqZGV2LCB1MTYgaW50X3N0YXR1cykKIGludCBjNjd4MDBfbGxfcmVzZXQoc3RydWN0IGM2N3gw
MF9kZXZpY2UgKmRldikKIHsKIAlpbnQgcmM7Ci0KKwkKIAltdXRleF9sb2NrKCZkZXYtPmhwaS5s
Y3AubXV0ZXgpOworCXByaW50aygiQzY3WDAwX0RCRzpjNjd4MDBfbGxfcmVzZXQoKSAtIFNlbmQg
bWJveFxuIik7CiAJaHBpX3NlbmRfbWJveChkZXYsIENPTU1fUkVTRVQpOworCXByaW50aygiQzY3
WDAwX0RCRzpjNjd4MDBfbGxfcmVzZXQoKSAtIHJlY3ZfbXNnXG4iKTsKIAlyYyA9IGxsX3JlY3Zf
bXNnKGRldik7CisJcHJpbnRrKCJDNjdYMDBfREJHOmM2N3gwMF9sbF9yZXNldCgpIC0gZG9uZSBy
ZWN2X21zZ1xuIik7CiAJbXV0ZXhfdW5sb2NrKCZkZXYtPmhwaS5sY3AubXV0ZXgpOwogCiAJcmV0
dXJuIHJjOwo=
--0015174c136e6f3b7c046e08c8f1--
