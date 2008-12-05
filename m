Return-Path: <s104259@yahoo.it>
Received: from web23102.mail.ird.yahoo.com (web23102.mail.ird.yahoo.com
	[217.146.189.42]) by ozlabs.org (Postfix) with SMTP id BA7BBDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Dec 2008 20:22:24 +1100 (EST)
Date: Fri, 5 Dec 2008 09:22:21 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: usb / ohci on mpc52xx custom board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-213935981-1228468941=:94488"
Message-ID: <331926.94488.qm@web23102.mail.ird.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-213935981-1228468941=:94488
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all!

I need your help.
I have a custom board based on mpc52xx.
kernel: 2.6.21 arch: powerpc u-boot: 1.2.0

The board reach the shell and everything seems to work fine.
But when i plug-in a usb-storage the system try to do all the necessary ope=
rations to enable the device but after these prints:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@xxx>
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00010101 C=
SC PPS CCS
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
ppc-of-ohci f0001000.usb: GetStatus roothub.portstatus [1] =3D 0x00100103 P=
RSC PPS PES CCS
usb 1-2: new full speed USB device using ppc-of-ohci and address 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

the system sleep for just 1 minute and return with these prints:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
    LR =3D handle_level_irq+0x90/0x13c
[C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)
[C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c
[C7E05CE0] [C0006304] do_IRQ+0x98/0xbc
[C7E05CF0] [C0011C04] ret_from_except+0x0/0x14
--- Exception: 501 at schedule+0x38/0x64c
    LR =3D schedule_timeout+0x68/0xe4
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
    LR =3D schedule+0x2d8/0x64c
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I'd like to follow the message "try booting with the "irqpoll" option" but =
i don't know how to enable this option! I had looked for this option in my =
kernel but there isn't any similar symbol.

At boot time i can see these prints for usb-driver:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
ppc-of-ohci f0001000.usb: initializing PPC-OF USB Controller
irq: irq_create_mapping(0xc0455480, 0x86)
irq: -> using host @c0455480
irq: -> obtained virq 134
ppc-of-ohci f0001000.usb: OF OHCI
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
ppc-of-ohci f0001000.usb: created debug files
ppc-of-ohci f0001000.usb: resetting from state 'reset', control =3D 0x0
ppc-of-ohci f0001000.usb: OHCI controller state
ppc-of-ohci f0001000.usb: OHCI 1.0, NO legacy support registers
ppc-of-ohci f0001000.usb: control 0x083 HCFS=3Doperational CBSR=3D3
ppc-of-ohci f0001000.usb: cmdstatus 0x00000 SOC=3D0
ppc-of-ohci f0001000.usb: intrstatus 0x00000004 SF
ppc-of-ohci f0001000.usb: intrenable 0x8000005a MIE RHSC UE RD WDH
ppc-of-ohci f0001000.usb: hcca frame #0000
ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)
ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE
ppc-of-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS
ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OF OHCI
usb usb1: Manufacturer: Linux 2.6.21.7-hrt1-WR2.0bl_standard ohci_hcd
usb usb1: SerialNumber: PPC-OF USB
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Other info:
- I ahve the same problem with a new kernel (2.6.26)
- on my u-boot the usb is completely operational
- the actual kernel (2.6.21) compiled for PPC enable usb device and it work=
 fine
- MOST IMPORTANT: usb is on the Ethernet pin group instead of on the USB in=
 group. The kernel change the value of port_config when it boots (arch/powe=
rpc/lite5200.c).=20
I had to modify my device tree source for this??

Any idea is appreciate.
Thanks=0A=0A=0A      
--0-213935981-1228468941=:94488
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi all!<br><br>I need your help.<br>I have a =
custom board based on mpc52xx.<br>kernel: 2.6.21 arch: powerpc u-boot: 1.2.=
0<br><br>The board reach the shell and everything seems to work fine.<br>Bu=
t when i plug-in a usb-storage the system try to do all the necessary opera=
tions to enable the device but after these prints:<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>root@xxx&gt;<br>hub 1-0:1.0: state =
7 ports 2 chg 0000 evt 0004<br>ppc-of-ohci f0001000.usb: GetStatus roothub.=
portstatus [1] =3D 0x00010101 CSC PPS CCS<br>hub 1-0:1.0: port 2, status 01=
01, change 0001, 12 Mb/s<br>hub 1-0:1.0: debounce: port 2: total 100ms stab=
le 100ms status 0x101<br>ppc-of-ohci f0001000.usb: GetStatus roothub.portst=
atus [1] =3D 0x00100103 PRSC PPS PES CCS<br>usb 1-2: new full speed USB dev=
ice using ppc-of-ohci and address 2<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br><br>the
 system sleep for just 1 minute and return with these prints:<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>BUG: soft lockup detect=
ed on CPU#0!<br>Call Trace:<br>[C7E05A50] [C0007FD8] show_stack+0x3c/0x194 =
(unreliable)<br>[C7E05A80] [C004A380] softlockup_tick+0xa4/0xd4<br>[C7E05AA=
0] [C002B998] run_local_timers+0x18/0x28<br>[C7E05AB0] [C002B9D8] update_pr=
ocess_times+0x30/0x7c<br>[C7E05AC0] [C003FF3C] tick_sched_timer+0xb0/0x280<=
br>[C7E05B20] [C003C538] hrtimer_interrupt+0x214/0x26c<br>[C7E05B80] [C000E=
744] timer_interrupt+0x88/0x354<br>[C7E05BF0] [C0011C04] ret_from_except+0x=
0/0x14<br>--- Exception: 901 at handle_IRQ_event+0x7c/0x1e8<br>    LR =3D h=
andle_level_irq+0x90/0x13c<br>[C7E05CB0] [C7F15C00] 0xc7f15c00 (unreliable)=
<br>[C7E05CD0] [C004C2E0] handle_level_irq+0x90/0x13c<br>[C7E05CE0] [C00063=
04] do_IRQ+0x98/0xbc<br>[C7E05CF0] [C0011C04] ret_from_except+0x0/0x14<br>-=
-- Exception: 501 at schedule+0x38/0x64c<br>    LR =3D
 schedule_timeout+0x68/0xe4<br>[C7E05DB0] [C01A1650] usb_hcd_submit_urb+0x1=
90/0x8a0 (unreliable)<br>[C7E05E00] [C02389A4] schedule_timeout+0x68/0xe4<b=
r>[C7E05E40] [C0238378] wait_for_completion_timeout+0x8c/0x138<br>[C7E05E80=
] [C01A2B60] usb_start_wait_urb+0x64/0x124<br>[C7E05EB0] [C01A2E1C] usb_con=
trol_msg+0xc4/0xf0<br>[C7E05EF0] [C019D0D0] hub_port_init+0x424/0x614<br>[C=
7E05F40] [C019F42C] hub_thread+0x434/0xe64<br>[C7E05FC0] [C0037E60] kthread=
+0xc0/0xfc<br>[C7E05FF0] [C00123F8] original_kernel_thread+0x44/0x60<br>ppc=
-of-ohci f0001000.usb: OHCI Unrecoverable Error, disabled<br>ppc-of-ohci f0=
001000.usb: OHCI controller state<br>ppc-of-ohci f0001000.usb: OHCI 1.0, NO=
 legacy support registers<br>ppc-of-ohci f0001000.usb: control 0x093 HCFS=
=3Doperational CLE CBSR=3D3<br>ppc-of-ohci f0001000.usb: cmdstatus 0x00000 =
SOC=3D0<br>ppc-of-ohci f0001000.usb: intrstatus 0x00000074 RHSC FNO UE SF<b=
r>ppc-of-ohci f0001000.usb: intrenable 0x8000001a MIE UE RD
 WDH<br>ppc-of-ohci f0001000.usb: ed_controlhead 07fcc000<br>ppc-of-ohci f0=
001000.usb: ed_controlcurrent fffffff0<br>ppc-of-ohci f0001000.usb: hcca fr=
ame #ddb6<br>ppc-of-ohci f0001000.usb: roothub.a 02001202 POTPGT=3D2 NOCP N=
PS NDP=3D2(2)<br>ppc-of-ohci f0001000.usb: roothub.b 00000000 PPCM=3D0000 D=
R=3D0000<br>ppc-of-ohci f0001000.usb: roothub.status 00008000 DRWE<br>ppc-o=
f-ohci f0001000.usb: roothub.portstatus [0] 0x00000100 PPS<br>ppc-of-ohci f=
0001000.usb: roothub.portstatus [1] 0x00030100 PESC CSC PPS<br>ppc-of-ohci =
f0001000.usb: HC died; cleaning up<br>irq 134: nobody cared (try booting wi=
th the "irqpoll" option)<br>Call Trace:<br>[C046FDF0] [C0007FD8] show_stack=
+0x3c/0x194 (unreliable)<br>[C046FE20] [C004B358] __report_bad_irq+0x34/0xa=
c<br>[C046FE40] [C004B4AC] note_interrupt+0xdc/0x288<br>[C046FE70] [C004C34=
4] handle_level_irq+0xf4/0x13c<br>[C046FE80] [C0006304] do_IRQ+0x98/0xbc<br=
>[C046FE90] [C0011C04] ret_from_except+0x0/0x14<br>--- Exception: 501 at
 schedule+0x304/0x64c<br>    LR =3D schedule+0x2d8/0x64c<br>[C046FFA0] [C00=
4A2B4] watchdog+0x4c/0x74<br>[C046FFC0] [C0037E60] kthread+0xc0/0xfc<br>[C0=
46FFF0] [C00123F8] original_kernel_thread+0x44/0x60<br>handlers:<br>[&lt;c0=
1a1008&gt;] (usb_hcd_irq+0x0/0x9c)<br>Disabling IRQ #134<br>usb 1-2: khubd =
timed out on ep0in len=3D0/64<br>hub 1-0:1.0: cannot reset port 2 (err =3D =
-19)<br>hub 1-0:1.0: cannot disable port 2 (err =3D -19)<br>ppc-of-ohci f00=
01000.usb: leak ed c7fcc000 (#00) state 0 (has tds)<br>hub 1-0:1.0: cannot =
reset port 2 (err =3D -19)<br>hub 1-0:1.0: cannot disable port 2 (err =3D -=
19)<br>hub 1-0:1.0: cannot reset port 2 (err =3D -19)<br>hub 1-0:1.0: canno=
t disable port 2 (err =3D -19)<br>hub 1-0:1.0: cannot reset port 2 (err =3D=
 -19)<br>hub 1-0:1.0: cannot disable port 2 (err =3D -19)<br>hub 1-0:1.0: c=
annot disable port 2 (err =3D -19)<br>hub 1-0:1.0: state 0 ports 2 chg 0000=
 evt 0004<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
><br>I'd like to follow the
 message "try booting with the "irqpoll" option" but i don't know how to en=
able this option! I had looked for this option in my kernel but there isn't=
 any similar symbol.<br><br>At boot time i can see these prints for usb-dri=
ver:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>ohci_=
hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver<br>ohci_hc=
d: block sizes: ed 64 td 64<br>ppc-of-ohci f0001000.usb: initializing PPC-O=
F USB Controller<br>irq: irq_create_mapping(0xc0455480, 0x86)<br>irq: -&gt;=
 using host @c0455480<br>irq: -&gt; obtained virq 134<br>ppc-of-ohci f00010=
00.usb: OF OHCI<br>drivers/usb/core/inode.c: creating file 'devices'<br>dri=
vers/usb/core/inode.c: creating file '001'<br>ppc-of-ohci f0001000.usb: new=
 USB bus registered, assigned bus number 1<br>ppc-of-ohci f0001000.usb: irq=
 134, io mem 0xf0001000<br>ppc-of-ohci f0001000.usb: created debug files<br=
>ppc-of-ohci f0001000.usb: resetting from state 'reset', control =3D
 0x0<br>ppc-of-ohci f0001000.usb: OHCI controller state<br>ppc-of-ohci f000=
1000.usb: OHCI 1.0, NO legacy support registers<br>ppc-of-ohci f0001000.usb=
: control 0x083 HCFS=3Doperational CBSR=3D3<br>ppc-of-ohci f0001000.usb: cm=
dstatus 0x00000 SOC=3D0<br>ppc-of-ohci f0001000.usb: intrstatus 0x00000004 =
SF<br>ppc-of-ohci f0001000.usb: intrenable 0x8000005a MIE RHSC UE RD WDH<br=
>ppc-of-ohci f0001000.usb: hcca frame #0000<br>ppc-of-ohci f0001000.usb: ro=
othub.a 02001202 POTPGT=3D2 NOCP NPS NDP=3D2(2)<br>ppc-of-ohci f0001000.usb=
: roothub.b 00000000 PPCM=3D0000 DR=3D0000<br>ppc-of-ohci f0001000.usb: roo=
thub.status 00008000 DRWE<br>ppc-of-ohci f0001000.usb: roothub.portstatus [=
0] 0x00000100 PPS<br>ppc-of-ohci f0001000.usb: roothub.portstatus [1] 0x000=
00100 PPS<br>usb usb1: default language 0x0409<br>usb usb1: new device stri=
ngs: Mfr=3D3, Product=3D2, SerialNumber=3D1<br>usb usb1: Product: OF OHCI<b=
r>usb usb1: Manufacturer: Linux 2.6.21.7-hrt1-WR2.0bl_standard ohci_hcd<br>=
usb usb1:
 SerialNumber: PPC-OF USB<br>usb usb1: uevent<br>usb usb1: usb_probe_device=
<br>usb usb1: configuration #1 chosen from 1 choice<br>usb usb1: adding 1-0=
:1.0 (config #1, interface 0)<br>usb 1-0:1.0: uevent<br>hub 1-0:1.0: usb_pr=
obe_interface<br>hub 1-0:1.0: usb_probe_interface - got id<br>hub 1-0:1.0: =
USB hub found<br>hub 1-0:1.0: 2 ports detected<br>hub 1-0:1.0: standalone h=
ub<br>hub 1-0:1.0: ganged power switching<br>hub 1-0:1.0: global over-curre=
nt protection<br>hub 1-0:1.0: power on to power good time: 4ms<br>hub 1-0:1=
.0: local power source is good<br>hub 1-0:1.0: no over-current condition ex=
ists<br>hub 1-0:1.0: enabling power on all ports<br>hub 1-0:1.0: state 7 po=
rts 2 chg 0000 evt 0000<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br><br>Other info:<br>- I ahve the same problem with a new kernel=
 (2.6.26)<br>- on my u-boot the usb is completely operational<br>- the actu=
al kernel (2.6.21) compiled for PPC enable usb device and it work fine<br>-=
 MOST
 IMPORTANT: usb is on the Ethernet pin group instead of on the USB in group=
. The kernel change the value of port_config when it boots (arch/powerpc/li=
te5200.c). <br><span style=3D"font-weight: bold;">I had to modify my device=
 tree source for this??</span><br><br>Any idea is appreciate.<br>Thanks</td=
></tr></table><br>=0A=0A=0A=0A      
--0-213935981-1228468941=:94488--
