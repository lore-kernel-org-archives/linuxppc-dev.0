Return-Path: <s104259@yahoo.it>
Date: Fri, 5 Dec 2008 10:47:01 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: Installation on a MPC5200 based custom board
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1826372038-1228474021=:68610"
Message-ID: <688884.68610.qm@web23105.mail.ird.yahoo.com>
Reply-To: s104259@yahoo.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1826372038-1228474021=:68610
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all.

I saw that someones trying to work on a custom board based on mpc5200.
I have:
* u-boot 1.2.0
* kernel 2.6.21
* arch=3Dpowerpc
* custom dts based on lite5200b.dts
* USB port (USB2) configured on the Ethernet port

Is it necessary to combine Ethernet and usb nodes?
However this is the log when a usb-storage is plugged:

hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00010101 C=
SC PPS CCS
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00100103 P=
RSC PPS PES CCS
usb 1-2: new full speed USB device using ppc-of-ohci and address 2
BUG: soft lockup detected on CPU#0!
Call Trace:
[C7E05A50] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
[C7E05A80] [C004A380] softlockup_tick+0xa4/0xd4
[C7E05AA0] [C002B998] run_local_timers+0x18/0x28
[C7E05AB0] [C002B9D8] update_process_times+0x30/0x7c
[C7E05AC0] [C003FF3C] tick_sched_timer+0xb0/0x280
[C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x26c
[C7E05B80] [C000E744] timer_interrupt+0x88/0x354
[C7E05BF0] [C0011C04] ret_from_except+0x0/0x14
--- Exception: 901 at handle_IRQ_event+0x7c/0x1e8
=C2=A0=C2=A0=C2=A0 LR =3D handle_level_irq+0x90/0x13c
[C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)
[C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c
[C7E05CE0] [C0006304] do_IRQ+0x98/0xbc
[C7E05CF0] [C0011C04] ret_from_except+0x0/0x14
--- Exception: 501 at schedule+0x38/0x64c
=C2=A0=C2=A0=C2=A0 LR =3D schedule_timeout+0x68/0xe4
[C7E05DB0] [C01A1650] usb_hcd_submit_urb+0x190/0x8a0 (unreliable)
[C7E05E00] [C02389A4] schedule_timeout+0x68/0xe4
[C7E05E40] [C0238378] wait_for_completion_timeout+0x8c/0x138
[C7E05E80] [C01A2B60] usb_start_wait_urb+0x64/0x124
[C7E05EB0] [C01A2E1C] usb_control_msg+0xc4/0xf0
[C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614
[C7E05F40] [C019F42C] hub_thread+0x434/0xe64
[C7E05FC0] [C0037E60] kthread+0xc0/0xfc
[C7E05FF0] [C00123F8] original_kernel_thread+0x44/0x60
ppc-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled
ppc-of-ohci f0001000.usb: OHCI controller state
ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers
ppc-of-ohci f0001000.usb: control 0x093 HCFS=3Doperational CLE CBSR=3D3
ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0
ppc-of-ohci f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF
ppc-of-ohci f0001000.usb: intrenable 0x8000001a MIE UE RD WDH
ppc-of-ohci f0001000.usb: ed_controlhead 07fcc000
ppc-of-ohci f0001000.usb: ed_controlcurrent fffffff0
ppc-of-ohci f0001000.usb: hcca frame #ddb6
ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)
ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS
ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00030100 PESC CSC PPS
ppc-of-ohci f0001000.usb: HC died; cleaning up
irq 134: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[C046FDF0] [C0007FD8] show_stack+0x3c/0x194 (unreliable)
[C046FE20] [C004B358] __report_bad_irq+0x34/0xac
[C046FE40] [C004B4AC] note_interrupt+0xdc/0x288
[C046FE70] [C004C344] handle_level_irq+0xf4/0x13c
[C046FE80] [C0006304] do_IRQ+0x98/0xbc
[C046FE90] [C0011C04] ret_from_except+0x0/0x14
--- Exception: 501 at schedule+0x304/0x64c
=C2=A0=C2=A0=C2=A0 LR =3D schedule+0x2d8/0x64c
[C046FFA0] [C004A2B4] watchdog+0x4c/0x74
[C046FFC0] [C0037E60] kthread+0xc0/0xfc
[C046FFF0] [C00123F8] original_kernel_thread+0x44/0x60
handlers:
[<c01a1008>] (usb_hcd_irq+0x0/0x9c)
Disabling IRQ #134
usb 1-2: khubd timed out on ep0in len=3D0/64
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
ppc-of-ohci f0001000.usb: leak ed c7fcc000 (#00) state 0 (has tds)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot reset port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: cannot disable port 2 (err =3D -19)
hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004

Please mail me any idea...

Thanks,=20
@ngel

=0A=0A=0A      
--0-1826372038-1228474021=:68610
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi all.<br><br>I saw that someones trying to =
work on a custom board based on mpc5200.<br>I have:<br>* u-boot 1.2.0<br>* =
kernel 2.6.21<br>* arch=3Dpowerpc<br>* custom dts based on lite5200b.dts<br=
>* USB port (USB2) configured on the Ethernet port<br><br>Is it necessary t=
o combine Ethernet and usb nodes?<br>However this is the log when a usb-sto=
rage is plugged:<br><br>hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004<br>p=
pc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00010101 CS=
C PPS CCS<br>hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s<br>hub =
1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101<br>ppc-of-=
ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00100103 PRSC PPS=
 PES CCS<br>usb 1-2: new full speed USB device using ppc-of-ohci and addres=
s 2<br>BUG: soft lockup detected on CPU#0!<br>Call Trace:<br>[C7E05A50] [C0=
007FD8]
 show_stack+0x3c/0x194 (unreliable)<br>[C7E05A80] [C004A380] softlockup_tic=
k+0xa4/0xd4<br>[C7E05AA0] [C002B998] run_local_timers+0x18/0x28<br>[C7E05AB=
0] [C002B9D8] update_process_times+0x30/0x7c<br>[C7E05AC0] [C003FF3C] tick_=
sched_timer+0xb0/0x280<br>[C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x2=
6c<br>[C7E05B80] [C000E744] timer_interrupt+0x88/0x354<br>[C7E05BF0] [C0011=
C04] ret_from_except+0x0/0x14<br>--- Exception: 901 at handle_IRQ_event+0x7=
c/0x1e8<br>&nbsp;&nbsp;&nbsp; LR =3D handle_level_irq+0x90/0x13c<br>[C7E05C=
B0] [C7F15C00] 0xc7f15c00 (unreliable)<br>[C7E05CD0] [C004C2E0] handle_leve=
l_irq+0x90/0x13c<br>[C7E05CE0] [C0006304] do_IRQ+0x98/0xbc<br>[C7E05CF0] [C=
0011C04] ret_from_except+0x0/0x14<br>--- Exception: 501 at schedule+0x38/0x=
64c<br>&nbsp;&nbsp;&nbsp; LR =3D schedule_timeout+0x68/0xe4<br>[C7E05DB0] [=
C01A1650] usb_hcd_submit_urb+0x190/0x8a0 (unreliable)<br>[C7E05E00] [C02389=
A4] schedule_timeout+0x68/0xe4<br>[C7E05E40] [C0238378]
 wait_for_completion_timeout+0x8c/0x138<br>[C7E05E80] [C01A2B60] usb_start_=
wait_urb+0x64/0x124<br>[C7E05EB0] [C01A2E1C] usb_control_msg+0xc4/0xf0<br>[=
C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614<br>[C7E05F40] [C019F42C] hub=
_thread+0x434/0xe64<br>[C7E05FC0] [C0037E60] kthread+0xc0/0xfc<br>[C7E05FF0=
] [C00123F8] original_kernel_thread+0x44/0x60<br>ppc-of-ohci f0001000.usb: =
OHCI Unrecoverable Error, disabled<br>ppc-of-ohci f0001000.usb: OHCI contro=
ller state<br>ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registe=
rs<br>ppc-of-ohci f0001000.usb: control 0x093 HCFS=3Doperational CLE CBSR=
=3D3<br>ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0<br>ppc-of-ohci =
f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF<br>ppc-of-ohci f0001000.=
usb: intrenable 0x8000001a MIE UE RD WDH<br>ppc-of-ohci f0001000.usb: ed_co=
ntrolhead 07fcc000<br>ppc-of-ohci f0001000.usb: ed_controlcurrent fffffff0<=
br>ppc-of-ohci f0001000.usb: hcca frame #ddb6<br>ppc-of-ohci f0001000.usb:
 roothub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)<br>ppc-of-ohci f0001000.=
usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000<br>ppc-of-ohci f0001000.usb: =
roothub.status 00008000 DRWE<br>ppc-of-ohci f0001000.usb: roothub.portstatu=
s [0] 0x00000100 PPS<br>ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x=
00030100 PESC CSC PPS<br>ppc-of-ohci f0001000.usb: HC died; cleaning up<br>=
irq 134: nobody cared (try booting with the "irqpoll" option)<br>Call Trace=
:<br>[C046FDF0] [C0007FD8] show_stack+0x3c/0x194 (unreliable)<br>[C046FE20]=
 [C004B358] __report_bad_irq+0x34/0xac<br>[C046FE40] [C004B4AC] note_interr=
upt+0xdc/0x288<br>[C046FE70] [C004C344] handle_level_irq+0xf4/0x13c<br>[C04=
6FE80] [C0006304] do_IRQ+0x98/0xbc<br>[C046FE90] [C0011C04] ret_from_except=
+0x0/0x14<br>--- Exception: 501 at schedule+0x304/0x64c<br>&nbsp;&nbsp;&nbs=
p; LR =3D schedule+0x2d8/0x64c<br>[C046FFA0] [C004A2B4] watchdog+0x4c/0x74<=
br>[C046FFC0] [C0037E60] kthread+0xc0/0xfc<br>[C046FFF0] [C00123F8]
 original_kernel_thread+0x44/0x60<br>handlers:<br>[&lt;c01a1008&gt;] (usb_h=
cd_irq+0x0/0x9c)<br>Disabling IRQ #134<br>usb 1-2: khubd timed out on ep0in=
 len=3D0/64<br>hub 1-0:1.0: cannot reset port 2 (err =3D -19)<br>hub 1-0:1.=
0: cannot disable port 2 (err =3D -19)<br>ppc-of-ohci f0001000.usb: leak ed=
 c7fcc000 (#00) state 0 (has tds)<br>hub 1-0:1.0: cannot reset port 2 (err =
=3D -19)<br>hub 1-0:1.0: cannot disable port 2 (err =3D -19)<br>hub 1-0:1.0=
: cannot reset port 2 (err =3D -19)<br>hub 1-0:1.0: cannot disable port 2 (=
err =3D -19)<br>hub 1-0:1.0: cannot reset port 2 (err =3D -19)<br>hub 1-0:1=
.0: cannot disable port 2 (err =3D -19)<br>hub 1-0:1.0: cannot disable port=
 2 (err =3D -19)<br>hub 1-0:1.0: state 0 ports 2 chg 0000 evt 0004<br><br>P=
lease mail me any idea...<br><br>Thanks, <br>@ngel<br><br></td></tr></table=
><br>=0A=0A=0A=0A      
--0-1826372038-1228474021=:68610--
