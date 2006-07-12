Return-Path: <M9402134@mail.ntust.edu.tw>
Received: from mail.ntust.edu.tw (mail.ntust.edu.tw [140.118.31.60])
	by ozlabs.org (Postfix) with SMTP id A630767BC0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 15:42:50 +1000 (EST)
Message-ID: <000701c6a575$154248a0$457b768c@Heclus>
From: "Kenny" <M9402134@mail.ntust.edu.tw>
To: <linuxppc-embedded@ozlabs.org>
Subject: Problem in PCI resource allocation with MPC8245
Date: Wed, 12 Jul 2006 13:36:11 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C6A5B8.235730C0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0004_01C6A5B8.235730C0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Freescale MPC8245 machine running Montavista Linux (kernel =
2.4.20).
There are two devices connected to the PCI bus:=20
a USB host controller (VIA VT6212L) and a single-chip network switch =
(Broadcom BCM5650).

Now BCM5650 is working but VT6212L is not.
I tried to modify the PCI code but met some problems.

Here are the PCI information and boot message:

Bus 0, device  0, devfn  0 (id 1057-0006, headertype 0x00)
        region 0: mask 0x00000008, now at 0x00000000
        region 0: type mem, size 0 (0MB)
        region 1: mask 0xfffff000, now at 0x00000000
        region 1: type mem, size 4096 (4KB)
        region 2: mask 0x00000008, now at 0x00000000
        region 2: type mem, size 0 (0MB)
Bus 0, device 16, devfn  0 (id 14e4-5650, headertype 0x00)  <-- BCM5650
        region 0: mask 0xffff0004, now at 0xbfff0000
        region 0: type mem, size 65536 (64KB)
        region 1: mask 0x000000ff, now at 0x00000000
        region 1: type I/O, size 65284 (65284B)
Bus 0, device 17, devfn  0 (id 1106-3038, headertype 0x00)  <-- VT6212L =
(UHCI 1)
        region 4: mask 0xffffffe1, now at 0x00bfffe0
        region 4: type I/O, size 32 (32B)
Bus 0, device 17, devfn  1 (id 1106-3038, headertype 0x00)  <-- VT6212L =
(UHCI 2)
        region 4: mask 0xffffffe1, now at 0x00bfffc0
        region 4: type I/O, size 32 (32B)
Bus 0, device 17, devfn  2 (id 1106-3104, headertype 0x00) <-- VT6212L =
(EHCI)
        region 0: mask 0xffffff00, now at 0xbffeff00
        region 0: type mem, size 256 (256B)
--
PCI: Probing PCI hardware
PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
PCI:00:00.0 Resource 1 [00000000-00000fff] is unassigned
PCI:00:00.0 Resource 2 [00000000-ffffffff] is unassigned
PCI: bridge rsrc 0..bfffff (100), parent c0179de4
PCI: bridge rsrc 80000000..fcffffff (200), parent c0179e00
PCI:00:10.0: Resource 0: bfff0000-bfffffff (f=3D204)     <-- BCM5650
PCI:00:11.0: Resource 4: 00bfffe0-00bfffff (f=3D101)    <-- VT6212L =
(UHCI 1)
PCI:00:11.1: Resource 4: 00bfffc0-00bfffdf (f=3D101)   <-- VT6212L (UHCI =
2)
PCI:00:11.2: Resource 0: bffeff00-bffeffff (f=3D200)     <-- VT6212L =
(EHCI)
--

It seems no problem with the allocated resource regions for VT6212L, but =
I got "Timeout" message printed by USB driver.
So, I modify the function "mpc10x_bridge_set_resources" in =
"arch/ppc/kernel/mpc10x_common.c":

 case MPC10X_MEM_MAP_B:
                        pci_init_resource(&hose->io_resource,
                                        0x00000000,
                                        0xffff,                       /* =
original value: 0x00bfffff, */
                                        IORESOURCE_IO,
                                        "PCI host bridge");
--
and the defination of MPC10X_MAPB_PCI_IO_END in "include/asm/mpc10x.h":

#define MPC10X_MAPB_PCI_IO_END         (0x00010000 - 1)    /* original =
value: (0x00c00000 - 1) */
--
After modification, the USB 1.x driver (UHCI) is working, and EHCI is =
still not working.
BUT I don't know why the UHCI works if I  do the above modification?

The PCI information after modification is shown below:

Bus  0, device  17, function  0:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=3D128.
      I/O at 0xffe0 [0xffff].                          <-- I/O change to =
0xffe0
  Bus  0, device  17, function  1:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=3D128.
      I/O at 0xffc0 [0xffdf].                        <-- I/O change to =
0xffc0
  Bus  0, device  17, function  2:
    Class 0c03: PCI device 1106:3104 (rev 99).
      IRQ 1.
      Master Capable.  Latency=3D128.
      Non-prefetchable 32 bit memory at 0xbffeff00 [0xbffeffff].
--

I do the modification for the PCI memory configuration similar to the =
modification for PCI I/O configuration:

[arch/ppc/kernel/mpc10x_common.c]
case MPC10X_MEM_MAP_B:
 ... snipped
                        pci_init_resource (&hose->mem_resources[0],
                                        0x00000000,              /*  =
original value: 0x80000000, */
                                        0x000fffff,                 /*  =
original value: 0xfcffffff, */
                                        IORESOURCE_MEM,
                                        "PCI host bridge");
--
[include/asm/mpc10x.h]
#define MPC10X_MAPB_ISA_MEM_BASE        0x00000000 /* original value: =
0x80000000 */
... snipped
#define MPC10X_MAPB_PCI_MEM_START       0x00000000      /* original =
value: 0x80000000 */
#define MPC10X_MAPB_PCI_MEM_END        (0x00100000 - 1) /* original =
value: (0xC0000000 - 1) */
--
Surprisingly, after this modification, the USB2.0 driver (EHCI) can =
work.
BUT, the BCM5650 driver failed...

Here are the PCI information and boot message:

  Bus  0, device  16, function  0:
    Class 0280: PCI device 14e4:5650 (rev 17).
      Master Capable.  Latency=3D128.
      Non-prefetchable 64 bit memory at 0xf0000 [0xfffff].  <-- BCM5650 =
PCI memory address change to 0xf0000
  Bus  0, device  17, function  0:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=3D128.
      I/O at 0xffe0 [0xffff].
  Bus  0, device  17, function  1:
    Class 0c03: PCI device 1106:3038 (rev 97).
      IRQ 1.
      Master Capable.  Latency=3D128.
      I/O at 0xffc0 [0xffdf].
  Bus  0, device  17, function  2:
    Class 0c03: PCI device 1106:3104 (rev 99).
      IRQ 1.
      Master Capable.  Latency=3D128.
      Non-prefetchable 32 bit memory at 0xeff00 [0xeffff]. <-- EHCI PCI =
memory address change to 0xeff00
--
PCI: bridge rsrc 0..ffff (100), parent c016fde4
PCI: bridge rsrc 0..fffff (200), parent c016fe00
PCI:00:10.0: Resource 0: 000f0000-000fffff (f=3D204)
PCI:00:11.0: Resource 4: 0000ffe0-0000ffff (f=3D101)
PCI:00:11.1: Resource 4: 0000ffc0-0000ffdf (f=3D101)
PCI:00:11.2: Resource 0: 000eff00-000effff (f=3D200)
--
And the failure message during inserting BCM5650 driver into kernel is:

__ioremap(): phys addr f0000 is RAM lr c0011db0
Oops: kernel access of bad area, sig: 11
NIP: C4881164 XER: 20000000 LR: C4887EDC SP: C3729C90 REGS: c3729be0 =
TRAP: 0300
   Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000148, DSISR: 22000000
TASK =3D c3728000[109] 'insmod' Last syscall: 128
... snipped
--

I have really no idea about this problem because I'm pretty new to =
PowerPC and PCI architecture :'(
(So I think my modification may not reasonable)
Can anyone help me solve this problem ?
Any pointers and help would be greatly appreciated.

Thank you!
Kenny

------=_NextPart_000_0004_01C6A5B8.235730C0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have a Freescale MPC8245 machine running Montavista Linux (kernel =

2.4.20).</DIV>
<DIV>There are two devices connected to the PCI bus: </DIV>
<DIV>a USB host controller (VIA VT6212L) and a single-chip network =
switch=20
(Broadcom BCM5650).</DIV>
<DIV>&nbsp;</DIV>
<DIV>Now&nbsp;BCM5650 is working but VT6212L is not.</DIV>
<DIV>I tried to modify the PCI code but met some problems.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Here&nbsp;are the PCI information and boot message:</DIV>
<DIV>&nbsp;</DIV>
<DIV>Bus 0, device&nbsp; 0, devfn&nbsp; 0 (id 1057-0006, headertype=20
0x00)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 0: mask =
0x00000008,=20
now at 0x00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region =
0: type=20
mem, size 0 (0MB)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region =
1: mask=20
0xfffff000, now at =
0x00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
region 1: type mem, size 4096=20
(4KB)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 2: mask =
0x00000008,=20
now at 0x00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region =
2: type=20
mem, size 0 (0MB)<BR>Bus 0, device 16, devfn&nbsp; 0 (id 14e4-5650, =
headertype=20
0x00)&nbsp; &lt;-- BCM5650<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
region=20
0: mask 0xffff0004, now at=20
0xbfff0000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 0: type =
mem,=20
size 65536 (64KB)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region =
1: mask=20
0x000000ff, now at =
0x00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
region 1: type I/O, size 65284 (65284B)<BR>Bus 0, device 17, devfn&nbsp; =
0 (id=20
1106-3038, headertype 0x00)&nbsp; &lt;-- VT6212L (UHCI=20
1)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 4: mask =
0xffffffe1, now=20
at 0x00bfffe0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 4: =
type I/O,=20
size 32 (32B)<BR>Bus 0, device 17, devfn&nbsp; 1 (id 1106-3038, =
headertype=20
0x00)&nbsp; &lt;-- VT6212L (UHCI=20
2)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 4: mask =
0xffffffe1, now=20
at 0x00bfffc0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; region 4: =
type I/O,=20
size 32 (32B)<BR>Bus 0, device 17, devfn&nbsp; 2 (id 1106-3104, =
headertype 0x00)=20
&lt;-- VT6212L (EHCI)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
region 0:=20
mask 0xffffff00, now at =
0xbffeff00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
region 0: type mem, size 256 (256B)</DIV>
<DIV>--</DIV>
<DIV>PCI: Probing PCI hardware<BR>PCI:00:00.0 Resource 0 =
[00000000-ffffffff] is=20
unassigned<BR>PCI:00:00.0 Resource 1 [00000000-00000fff] is=20
unassigned<BR>PCI:00:00.0 Resource 2 [00000000-ffffffff] is =
unassigned<BR>PCI:=20
bridge rsrc 0..bfffff (100), parent c0179de4<BR>PCI: bridge rsrc=20
80000000..fcffffff (200), parent c0179e00<BR>PCI:00:10.0: Resource 0:=20
bfff0000-bfffffff (f=3D204)&nbsp;&nbsp; &nbsp; &lt;-- =
BCM5650<BR>PCI:00:11.0:=20
Resource 4: 00bfffe0-00bfffff (f=3D101)&nbsp;&nbsp;&nbsp; &lt;-- VT6212L =
(UHCI=20
1)<BR>PCI:00:11.1: Resource 4: 00bfffc0-00bfffdf (f=3D101)&nbsp;&nbsp; =
&lt;--=20
VT6212L (UHCI 2)<BR>PCI:00:11.2: Resource 0: bffeff00-bffeffff=20
(f=3D200)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;-- VT6212L (EHCI)</DIV>
<DIV>--</DIV>
<DIV>&nbsp;</DIV>
<DIV>It seems no problem with the allocated resource regions for =
VT6212L, but I=20
got "Timeout" message printed by USB&nbsp;driver.</DIV>
<DIV>So, I modify the function "mpc10x_bridge_set_resources" in=20
"arch/ppc/kernel/mpc10x_common.c":</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;case=20
MPC10X_MEM_MAP_B:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
pci_init_resource(&amp;hose-&gt;io_resource,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x00000000,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0xffff,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* original value: 0x00bfffff,=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
IORESOURCE_IO,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
"PCI host bridge");</DIV>
<DIV>--</DIV>
<DIV>and the defination of MPC10X_MAPB_PCI_IO_END in=20
"include/asm/mpc10x.h":</DIV>
<DIV>&nbsp;</DIV>
<DIV>#define=20
MPC10X_MAPB_PCI_IO_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(0x00010000 - 1)&nbsp;&nbsp;&nbsp; /* original value: (0x00c00000 - 1) =
*/</DIV>
<DIV>--</DIV>
<DIV>After modification, the USB 1.x driver (UHCI) is working, and EHCI =
is still=20
not working.</DIV>
<DIV>BUT I don't know why the UHCI works if I&nbsp; do the above=20
modification?</DIV>
<DIV>&nbsp;</DIV>
<DIV>The PCI information&nbsp;after modification is shown below:</DIV>
<DIV>&nbsp;</DIV>
<DIV>Bus&nbsp; 0, device&nbsp; 17, function&nbsp; =
0:<BR>&nbsp;&nbsp;&nbsp; Class=20
0c03: PCI device 1106:3038 (rev 97).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
IRQ=20
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Master Capable.&nbsp;=20
Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O at 0xffe0=20
[0xffff].&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;=20
&lt;-- I/O change to 0xffe0<BR>&nbsp; Bus&nbsp; 0, device&nbsp; 17,=20
function&nbsp; 1:<BR>&nbsp;&nbsp;&nbsp; Class 0c03: PCI device 1106:3038 =
(rev=20
97).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IRQ =
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Master Capable.&nbsp; Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
I/O at=20
0xffc0=20
[0xffdf].&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
&lt;-- I/O&nbsp;change to 0xffc0<BR>&nbsp; Bus&nbsp; 0, device&nbsp; 17, =

function&nbsp; 2:<BR>&nbsp;&nbsp;&nbsp; Class 0c03: PCI device 1106:3104 =
(rev=20
99).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IRQ =
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Master Capable.&nbsp; Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Non-prefetchable 32 bit memory at 0xbffeff00 [0xbffeffff].</DIV>
<DIV>--</DIV>
<DIV>&nbsp;</DIV>
<DIV>I do the modification for the PCI memory configuration similar to =
the=20
modification for PCI I/O configuration:</DIV>
<DIV>&nbsp;</DIV>
<DIV>[arch/ppc/kernel/mpc10x_common.c]</DIV>
<DIV>case MPC10X_MEM_MAP_B:</DIV>
<DIV>&nbsp;... snipped</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;pci_init_resource=20
(&amp;hose-&gt;mem_resources[0],<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x00000000,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
/*&nbsp; original value: 0x80000000,=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
0x000fffff,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/*&nbsp; original value: 0xfcffffff,=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
IORESOURCE_MEM,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
"PCI host bridge");</DIV>
<DIV>--</DIV>
<DIV>[include/asm/mpc10x.h]</DIV>
<DIV>#define =
MPC10X_MAPB_ISA_MEM_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x00000000 /* original value: 0x80000000 */</DIV>
<DIV>... snipped</DIV>
<DIV>#define =
MPC10X_MAPB_PCI_MEM_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0x00000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* original value: 0x80000000=20
*/<BR>#define =
MPC10X_MAPB_PCI_MEM_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
(0x00100000 - 1) /* original value: (0xC0000000 - 1) */</DIV>
<DIV>--</DIV>
<DIV>Surprisingly, after this modification, the USB2.0 driver (EHCI) can =

work.</DIV>
<DIV>BUT,&nbsp;the BCM5650 driver failed...</DIV>
<DIV>&nbsp;</DIV>
<DIV>Here are the PCI information and boot message:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; Bus&nbsp; 0, device&nbsp; 16, function&nbsp;=20
0:<BR>&nbsp;&nbsp;&nbsp; Class 0280: PCI device 14e4:5650 (rev=20
17).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Master Capable.&nbsp;=20
Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Non-prefetchable 64 bit =
memory at=20
0xf0000 [0xfffff].&nbsp; &lt;-- BCM5650 PCI memory address change to=20
0xf0000<BR>&nbsp; Bus&nbsp; 0, device&nbsp; 17, function&nbsp;=20
0:<BR>&nbsp;&nbsp;&nbsp; Class 0c03: PCI device 1106:3038 (rev=20
97).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IRQ =
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Master Capable.&nbsp; Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
I/O at=20
0xffe0 [0xffff].<BR>&nbsp; Bus&nbsp; 0, device&nbsp; 17, function&nbsp;=20
1:<BR>&nbsp;&nbsp;&nbsp; Class 0c03: PCI device 1106:3038 (rev=20
97).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IRQ =
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Master Capable.&nbsp; Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
I/O at=20
0xffc0 [0xffdf].<BR>&nbsp; Bus&nbsp; 0, device&nbsp; 17, function&nbsp;=20
2:<BR>&nbsp;&nbsp;&nbsp; Class 0c03: PCI device 1106:3104 (rev=20
99).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IRQ =
1.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Master Capable.&nbsp; Latency=3D128.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Non-prefetchable 32 bit memory at 0xeff00 [0xeffff]. &lt;-- EHCI PCI =
memory=20
address change to 0xeff00</DIV>
<DIV>--</DIV>
<DIV>PCI: bridge rsrc 0..ffff (100), parent c016fde4<BR>PCI: bridge rsrc =

0..fffff (200), parent c016fe00<BR>PCI:00:10.0: Resource 0: =
000f0000-000fffff=20
(f=3D204)<BR>PCI:00:11.0: Resource 4: 0000ffe0-0000ffff =
(f=3D101)<BR>PCI:00:11.1:=20
Resource 4: 0000ffc0-0000ffdf (f=3D101)<BR>PCI:00:11.2: Resource 0:=20
000eff00-000effff (f=3D200)</DIV>
<DIV>--</DIV>
<DIV>And the failure message during inserting BCM5650 driver into kernel =

is:</DIV>
<DIV>&nbsp;</DIV>
<DIV>__ioremap(): phys addr f0000 is RAM lr c0011db0<BR>Oops: kernel =
access of=20
bad area, sig: 11<BR>NIP: C4881164 XER: 20000000 LR: C4887EDC SP: =
C3729C90 REGS:=20
c3729be0 TRAP: 0300<BR>&nbsp;&nbsp; Not tainted<BR>MSR: 00001032 EE: 0 =
PR: 0 FP:=20
0 ME: 1 IR/DR: 11<BR>DAR: 00000148, DSISR: 22000000<BR>TASK =3D =
c3728000[109]=20
'insmod' Last syscall: 128</DIV>
<DIV>... snipped</DIV>
<DIV>--</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV>I have really no idea about this problem because I'm pretty new to =
PowerPC=20
and PCI&nbsp;architecture :'(</DIV>
<DIV>(So I think my modification&nbsp;may not reasonable)</DIV>
<DIV>Can anyone help me solve this problem ?</DIV>
<DIV>Any pointers and help would be greatly appreciated.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you!</DIV>
<DIV><FONT size=3D2><FONT size=3D3>Kenny</FONT></FONT></DIV>
<DIV><FONT size=3D2><FONT =
size=3D3></FONT>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_0004_01C6A5B8.235730C0--
