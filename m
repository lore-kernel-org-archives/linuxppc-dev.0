Return-Path: <Einar.Bjorgvinsson@marel.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E1DFB6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 22:59:15 +1000 (EST)
Received: from mail16-db3 (localhost.localdomain [127.0.0.1])	by
	mail16-db3-R.bigfish.com (Postfix) with ESMTP id 371F9EC8898	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2011 12:59:09 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.241])	by
	mail16-db3.bigfish.com (Postfix) with ESMTP id A1DCC180053	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2011 12:59:08 +0000 (UTC)
From: =?iso-8859-1?Q?Einar_M=E1r_Bj=F6rgvinsson?=
	<Einar.Bjorgvinsson@marel.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Linux 2.6.33.9 (RT) on mpc5121
Date: Fri, 27 May 2011 12:59:07 +0000
Message-ID: <76E1146DEE728E4E95C1C6D1EEA1DBA952A7A0DA@GRBSR0004.marel.net>
Content-Type: multipart/alternative;
	boundary="_000_76E1146DEE728E4E95C1C6D1EEA1DBA952A7A0DAGRBSR0004mareln_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_76E1146DEE728E4E95C1C6D1EEA1DBA952A7A0DAGRBSR0004mareln_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

  hi

I'm currently trying to port an older kernel version (2.6.33-rc6 non realti=
me) to a newer one (2.6.33.9 with RT-PREEMPT 2.6.33.9).
The initial support for USB and CAN was done by Denx.

I've been working on moving this support to the new kernel which is nearly =
completed except from the a kernel panic in the USB setup. It has something=
 to do with the fsl bus setup and the panic happens in drivers/usb/host/ehc=
i-hcd.c::echi_run(struct usb_hcd *hcd):

----------------------------------------------

/* start HC running; it's halted, ehci_init() has been run (once) */
static int ehci_run (struct usb_hcd *hcd)
{
    struct ehci_hcd        *ehci =3D hcd_to_ehci (hcd);
    int            retval;
    u32            temp;
    u32            hcc_params;

    hcd->uses_new_polling =3D 1;
    hcd->poll_rh =3D 0;

    /* EHCI spec section 4.1 */
    if ((retval =3D ehci_reset(ehci)) !=3D 0) {
        ehci_mem_cleanup(ehci);
        return retval;
    }
    ehci_writel(ehci, ehci->periodic_dma, &ehci->regs->frame_list);
    ehci_writel(ehci, (u32)ehci->async->qh_dma, &ehci->regs->async_next);

----------------------------------------------

The panic happens every time the ehci_reset(ehci) is called. I've been tryi=
ng to locate the problem and it seems so that I can't go any further becaus=
e I expect the problem to be earlier in the process, e.g. I must be forgett=
ing something earlier on.

Here is the kernel boot output:

----------------------------------------------

[  261.521847] console [netcon0] enabled
[  261.525493] netconsole: network logging started
[  261.531162] eth0: fs_enet: 00:60:35:0d:dc:93
[  261.536393] FEC MII Bus: probed
[  261.540330] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[  261.547065] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[  261.553709] fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus nu=
mber 1
[  261.561165] fsl-ehci fsl-ehci.0: irq 44, io mem 0x80004000
[  261.574366] Unable to handle kernel paging request for data at address 0=
x00000014
[  261.581914] Faulting instruction address: 0xc02e4c48
[  261.586924] Oops: Kernel access of bad area, sig: 11 [#1]
[  261.592360] PREEMPT Marel v39
[  261.595350] NIP: c02e4c48 LR: c02e488c CTR: c02c3a3c
[  261.600358] REGS: cf831d10 TRAP: 0300   Not tainted  (2.6.33.9-rt31marel=
-svn934)
[  261.607817] MSR: 00009032 <EE,ME,IR,DR>  CR: 24004022  XER: 20000000
[  261.614229] DAR: 00000014, DSISR: 22000000
[  261.618359] TASK =3D cf82fae0[1] 'swapper' THREAD: cf830000
[  261.623624] GPR00: 00000000 cf831dc0 cf82fae0 0000001d 000026e8 ffffffff=
 cf831d0e 00020000
[  261.632054] GPR08: c0574d20 00000014 0001ffff 00000000 24004022 05011000=
 0ffb9000 00000000
[  261.640485] GPR16: c4653600 00000000 00000000 00000000 00000000 00000000=
 00000000 c05a1938
[  261.648916] GPR24: 0000002c 00000002 c055b9d8 cfa32c00 00000080 cfa39048=
 cfa39000 cfa390cc
[  261.657544] NIP [c02e4c48] ehci_run+0x404/0x458
[  261.662096] LR [c02e488c] ehci_run+0x48/0x458
[  261.666479] Call Trace:
[  261.668947] [cf831dc0] [c02e488c] ehci_run+0x48/0x458 (unreliable)
[  261.675191] [cf831e30] [c02cd960] usb_add_hcd+0x2f8/0x600
[  261.680627] [cf831e60] [c02e6024] usb_hcd_fsl_probe+0x234/0x394
[  261.686598] [cf831e90] [c0272bb8] platform_drv_probe+0x20/0x30
[  261.692491] [cf831ea0] [c0271798] driver_probe_device+0x88/0x180
[  261.698541] [cf831ec0] [c027194c] __driver_attach+0xbc/0xc0
[  261.704162] [cf831ee0] [c0270e94] bus_for_each_dev+0x70/0xac
[  261.709870] [cf831f10] [c02715dc] driver_attach+0x24/0x34
[  261.715314] [cf831f20] [c027062c] bus_add_driver+0xb4/0x278
[  261.720935] [cf831f50] [c0271c88] driver_register+0x70/0x160
[  261.726641] [cf831f70] [c0272f78] platform_driver_register+0x6c/0x7c
[  261.733056] [cf831f80] [c051d860] ehci_hcd_init+0xf0/0x140
[  261.738589] [cf831fa0] [c000389c] do_one_initcall+0x3c/0x1e0
[  261.744295] [cf831fd0] [c0505204] kernel_init+0xe4/0x154
[  261.749660] [cf831ff0] [c0010ed4] kernel_thread+0x4c/0x68
[  261.755087] Instruction dump:
[  261.758075] 4bfffd4c 7c0004ac 7d204c2c 0c090000 4c00012c 4bfffccc 392900=
18 7c0004ac
[  261.765889] 7c004d2c 4bfffc8c 39290014 7c0004ac <7d604d2c> 4bfffc5c 801f=
0114 813f0004
[  261.773988] ---[ end trace 364ef0f9c3fc06c7 ]---
[  261.778597] Kernel panic - not syncing: Attempted to kill init!
[  261.784550] Rebooting in 1 seconds..

----------------------------------------------

If there are any that are familiar with this and could perhaps point out th=
e problem I hope to hear from you.

Regards
Einar M. Bjorgvinsson
Embedded Software Engineer
Marel
Iceland

--_000_76E1146DEE728E4E95C1C6D1EEA1DBA952A7A0DAGRBSR0004mareln_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;"><font size=3D"2"><span style=3D"font-size: 10pt;">&nbsp; hi<br>
<br>
I'm currently trying to port an older kernel version (2.6.33-rc6 non realti=
me) to a newer one (2.6.33.9 with RT-PREEMPT 2.6.33.9).<br>
The initial support for USB and CAN was done by Denx.<br>
<br>
I've been working on moving this support to the new kernel which is nearly =
completed except from the a kernel panic in the USB setup. It has something=
 to do with the fsl bus setup and the panic happens in drivers/usb/host/ehc=
i-hcd.c::echi_run(struct usb_hcd
 *hcd):<br>
<br>
----------------------------------------------<br>
<br>
/* start HC running; it's halted, ehci_init() has been run (once) */<br>
static int ehci_run (struct usb_hcd *hcd)<br>
{<br>
&nbsp;&nbsp;&nbsp; struct ehci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; *ehci =3D hcd_to_ehci (hcd);<br>
&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; retval;<br>
&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; temp;<br>
&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; hcc_params;<br>
<br>
&nbsp;&nbsp;&nbsp; hcd-&gt;uses_new_polling =3D 1;<br>
&nbsp;&nbsp;&nbsp; hcd-&gt;poll_rh =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp; /* EHCI spec section 4.1 */<br>
&nbsp;&nbsp;&nbsp; if ((retval =3D ehci_reset(ehci)) !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ehci_mem_cleanup(ehci);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; ehci_writel(ehci, ehci-&gt;periodic_dma, &amp;ehci-&gt;r=
egs-&gt;frame_list);<br>
&nbsp;&nbsp;&nbsp; ehci_writel(ehci, (u32)ehci-&gt;async-&gt;qh_dma, &amp;e=
hci-&gt;regs-&gt;async_next);<br>
<br>
----------------------------------------------<br>
<br>
The panic happens every time the ehci_reset(ehci) is called. I've been tryi=
ng to locate the problem and it seems so that I can't go any further becaus=
e I expect the problem to be earlier in the process, e.g. I must be forgett=
ing something earlier on.<br>
<br>
Here is the kernel boot output:<br>
<br>
----------------------------------------------<br>
<br>
[&nbsp; 261.521847] console [netcon0] enabled<br>
[&nbsp; 261.525493] netconsole: network logging started<br>
[&nbsp; 261.531162] eth0: fs_enet: 00:60:35:0d:dc:93<br>
[&nbsp; 261.536393] FEC MII Bus: probed<br>
[&nbsp; 261.540330] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dri=
ver<br>
[&nbsp; 261.547065] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Contro=
ller<br>
[&nbsp; 261.553709] fsl-ehci fsl-ehci.0: new USB bus registered, assigned b=
us number 1<br>
[&nbsp; 261.561165] fsl-ehci fsl-ehci.0: irq 44, io mem 0x80004000<br>
[&nbsp; 261.574366] Unable to handle kernel paging request for data at addr=
ess 0x00000014<br>
[&nbsp; 261.581914] Faulting instruction address: 0xc02e4c48<br>
[&nbsp; 261.586924] Oops: Kernel access of bad area, sig: 11 [#1]<br>
[&nbsp; 261.592360] PREEMPT Marel v39<br>
[&nbsp; 261.595350] NIP: c02e4c48 LR: c02e488c CTR: c02c3a3c<br>
[&nbsp; 261.600358] REGS: cf831d10 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp;=
 (2.6.33.9-rt31marel-svn934)<br>
[&nbsp; 261.607817] MSR: 00009032 &lt;EE,ME,IR,DR&gt;&nbsp; CR: 24004022&nb=
sp; XER: 20000000<br>
[&nbsp; 261.614229] DAR: 00000014, DSISR: 22000000<br>
[&nbsp; 261.618359] TASK =3D cf82fae0[1] 'swapper' THREAD: cf830000<br>
[&nbsp; 261.623624] GPR00: 00000000 cf831dc0 cf82fae0 0000001d 000026e8 fff=
fffff cf831d0e 00020000<br>
[&nbsp; 261.632054] GPR08: c0574d20 00000014 0001ffff 00000000 24004022 050=
11000 0ffb9000 00000000<br>
[&nbsp; 261.640485] GPR16: c4653600 00000000 00000000 00000000 00000000 000=
00000 00000000 c05a1938<br>
[&nbsp; 261.648916] GPR24: 0000002c 00000002 c055b9d8 cfa32c00 00000080 cfa=
39048 cfa39000 cfa390cc<br>
[&nbsp; 261.657544] NIP [c02e4c48] ehci_run&#43;0x404/0x458<br>
[&nbsp; 261.662096] LR [c02e488c] ehci_run&#43;0x48/0x458<br>
[&nbsp; 261.666479] Call Trace:<br>
[&nbsp; 261.668947] [cf831dc0] [c02e488c] ehci_run&#43;0x48/0x458 (unreliab=
le)<br>
[&nbsp; 261.675191] [cf831e30] [c02cd960] usb_add_hcd&#43;0x2f8/0x600<br>
[&nbsp; 261.680627] [cf831e60] [c02e6024] usb_hcd_fsl_probe&#43;0x234/0x394=
<br>
[&nbsp; 261.686598] [cf831e90] [c0272bb8] platform_drv_probe&#43;0x20/0x30<=
br>
[&nbsp; 261.692491] [cf831ea0] [c0271798] driver_probe_device&#43;0x88/0x18=
0<br>
[&nbsp; 261.698541] [cf831ec0] [c027194c] __driver_attach&#43;0xbc/0xc0<br>
[&nbsp; 261.704162] [cf831ee0] [c0270e94] bus_for_each_dev&#43;0x70/0xac<br=
>
[&nbsp; 261.709870] [cf831f10] [c02715dc] driver_attach&#43;0x24/0x34<br>
[&nbsp; 261.715314] [cf831f20] [c027062c] bus_add_driver&#43;0xb4/0x278<br>
[&nbsp; 261.720935] [cf831f50] [c0271c88] driver_register&#43;0x70/0x160<br=
>
[&nbsp; 261.726641] [cf831f70] [c0272f78] platform_driver_register&#43;0x6c=
/0x7c<br>
[&nbsp; 261.733056] [cf831f80] [c051d860] ehci_hcd_init&#43;0xf0/0x140<br>
[&nbsp; 261.738589] [cf831fa0] [c000389c] do_one_initcall&#43;0x3c/0x1e0<br=
>
[&nbsp; 261.744295] [cf831fd0] [c0505204] kernel_init&#43;0xe4/0x154<br>
[&nbsp; 261.749660] [cf831ff0] [c0010ed4] kernel_thread&#43;0x4c/0x68<br>
[&nbsp; 261.755087] Instruction dump:<br>
[&nbsp; 261.758075] 4bfffd4c 7c0004ac 7d204c2c 0c090000 4c00012c 4bfffccc 3=
9290018 7c0004ac<br>
[&nbsp; 261.765889] 7c004d2c 4bfffc8c 39290014 7c0004ac &lt;7d604d2c&gt; 4b=
fffc5c 801f0114 813f0004<br>
[&nbsp; 261.773988] ---[ end trace 364ef0f9c3fc06c7 ]---<br>
[&nbsp; 261.778597] Kernel panic - not syncing: Attempted to kill init!<br>
[&nbsp; 261.784550] Rebooting in 1 seconds..<br>
<br>
----------------------------------------------<br>
<br>
If there are any that are familiar with this and could perhaps point out th=
e problem I hope to hear from you.<br>
<br>
Regards<br>
Einar M. Bjorgvinsson<br>
Embedded Software Engineer<br>
Marel<br>
Iceland</span></font></div>
</body>
</html>

--_000_76E1146DEE728E4E95C1C6D1EEA1DBA952A7A0DAGRBSR0004mareln_--
