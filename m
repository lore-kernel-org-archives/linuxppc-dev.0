Return-Path: <JanakaS@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 29B9FDDE19
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 18:07:16 +1000 (EST)
From: Janaka Subhawickrama <JanakaS@optiscan.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Wed, 3 Sep 2008 17:50:10 +1000
Subject: Kernel crash while initialising PCI 
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA073580F459@mailsvr.optiscan.com>
Content-Type: multipart/alternative;
	boundary="_000_DE0CCFFBFF707949BEABD4537A14ACBA073580F459mailsvroptisc_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA073580F459mailsvroptisc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
I am trying to setup the PCI on a Flattened Device Tree (DTS file) for a Mi=
crosys MPX8349 board. I have the PCI outbound windows setup as follows:
0xA0000000      of size         0x20000000,     none pre-fechable PCI memor=
y window
0xD8000000      of size         0x01000000,     PCI IO window
These windows are setup on Uboot and I can see the configuration space of P=
CI  and the PCI card installed from Uboot.
When I try to boot my linux kernel  (2.6.23 stable Denx kernel) it crashes =
with:

[    0.000000] Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmwar=
e bus number: 0->0
[    0.000000] Observed: pci a0000000 phys ffffffff00000000 size 20000000
[    0.000000] phb0: MEM 0xffffffff00000000 -> 0x11ffffffe
[    0.000000] Observed: pci d8000000 phys ffffffff00000000 size 1000000
arch: exit
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    65536
[    0.000000]   Normal      65536 ->    65536
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    65536
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 65024
[    0.000000] Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.1.=
1:/home/OPTISCAN/janakas/nfs ip=3D192.168.1.15:192.168.1.1:192.168.1.1:255.=
255.255.0:xepm2:eth0:off console=3DttyS0,9600
[    0.000000] IPIC (128 IRQ sources) at fdffb700
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.001117] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.085122] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)
[    0.194097] Memory: 255232k/262144k available (4096k kernel code, 6672k =
reserved, 168k data, 116k bss, 156k init)
[    0.337215] Mount-cache hash table entries: 512
[    0.392115] NET: Registered protocol family 16

[    0.459868] PCI: Probing PCI hardware
[    0.503247] Fixup res 0 (1208) of dev 0000:00:0d.0: a0000000 -> ffffffff
[    0.583128] Fixup res 1 (200) of dev 0000:00:0d.0: ffffffffa4000000 -> 3=
ffffff
[    0.669552] Fixup res 6 (7200) of dev 0000:00:0d.0: 0 -> 5fffffff
[    0.742403] Try to map irq for 0000:00:0d.0...
[    0.795365] pci_busdev_to_OF_node(0,0x68)
[    0.843233]  parent is /soc8349@e0000000/pci@8500
[    0.899500]  result is <NULL>
[    0.935174] debug 1112
[    0.962902] PCI->OF bus map:
[    0.997267] 0 -> 0
[    1.021159] debug 1124
[    1.049295] PCI: bridge rsrc 0..ffffffff (100), parent c0404fe4
[    1.120308] PCI:0000:00:0d.0: Resource 0: 00000000ffffffff-0000000003fff=
ffe (f=3D1208)
[    1.213074] PCI: Cannot allocate resource region 0 of device 0000:00:0d.=
0
[    1.294229] PCI:  parent is c044d05c: 00000000ffffffff-000000001ffffffe =
(f=3D200)
[    1.381720] PCI:0000:00:0d.0: Resource 1: 0000000003ffffff-000000000403f=
ffe (f=3D200)
[    1.473369] PCI: Cannot allocate resource region 1 of device 0000:00:0d.=
0
[    1.554532] PCI:0000:00:0d.0: Resource 2: 00000000d8000000-00000000d8000=
07f (f=3D101)
[    1.646210] debug 1128
[    1.674012] debug 1134
[    1.702129] [debug 48]Size 04000000, Algn 04000000, Min 10000000, Type 0=
0001300
[    1.789877] [debug 48]Size 04000000, Algn 04000000, Min 10000000, Type 0=
0000300
[    1.877345] PCI: Failed to allocate mem resource #0:4000000@0 for 0000:0=
0:0d.0
[    1.963755] ------------[ cut here ]------------
[    2.018513] kernel BUG at arch/powerpc/kernel/pci_32.c:590!
[    2.085155] Oops: Exception in kernel mode, sig: 5 [#1]
[    2.147621] PREEMPT MPX8349
[    2.180940] Modules linked in:
[    2.217386] NIP: c03e3c48 LR: c03e3c48 CTR: c001065c
[    2.276737] REGS: cffc3e90 TRAP: 0700   Not tainted  (2.6.23MPX8349_Powe=
rPC)
[    2.361070] MSR: 00029032 <EE,ME,IR,DR>  CR: 24004022  XER: 00000000
[    2.437081] TASK =3D cffc1a20[1] 'swapper' THREAD: cffc2000
[    2.499551] GPR00: c03e3c48 cffc3f40 cffc1a20 fffffff0 00000001 00000001=
 00000000 00000033
[    2.599508] GPR08: 00000000 00000000 0000114e c0430000 42004022 08000180=
 0fffd000 00800000
[    2.699464] GPR16: ffffffff 00000001 00000000 c0380000 c0400000 c0400000=
 00000000 c0380000
[    2.799420] GPR24: c0430000 c04312a0 c04312a0 cffe9990 cffe9800 cffe9990=
 00000000 00000000
[    2.901459] NIP [c03e3c48] pcibios_init+0x1f8/0x274
[    2.959767] LR [c03e3c48] pcibios_init+0x1f8/0x274
[    3.017033] Call Trace:
[    3.046189] [cffc3f40] [c03e3c48] pcibios_init+0x1f8/0x274 (unreliable)
[    3.125321] [cffc3f70] [c03d9898] kernel_init+0xa8/0x29c
[    3.188835] [cffc3ff0] [c0010498] kernel_thread+0x44/0x60
[    3.253389] Instruction dump:
[    3.288791] 2f800000 419e0018 7c0803a6 4e800021 2f830000 409e0020 813d00=
0c 552000c2
[    3.381458] 7f83e378 7fe4fb78 901d000c 4bdca38d <0f030000> 2f9f0005 3bde=
001c 3bff0001
[    3.476213] Kernel panic - not syncing: Attempted to kill init!
[    3.547013] Rebooting in 180 seconds..



My DTS file entries for PCI are as follows:

pci@8500 {
                        interrupt-map-mask =3D <  // Mask the child UnitIrq=
Spec
                                                //ff00 0 0 7
                                                ffff ff ff f
                                                >;
                        interrupt-map =3D <
                                        // Child UnitIrqSpec, Parent PIC ha=
ndle, Parent UnitIrqSpec
                                        // PCI unit address (0000 0 0), Int=
errupt specifier IDSEL 0x0D (CRX board hard wired to IDSEL 13),
                                        //      parent Phandle, IRQ7=3D0x17=
 (jumper based) level sensitive(8)
                                        //0d00 0 0 1 &ipic 17 8
                                        00006800 0 0 1 &ipic 17 8
                                        >;
                        interrupt-parent =3D < &ipic >;
                        interrupts =3D <42 8>;            //PCI1 interrupt,=
 level sensitive
                        bus-range =3D <0 0>;              //Bus number and =
largest bus under this
                        /*
                                struct ranges_pci {
                                        unsigned int pci_space; //Prefechab=
le/relocatable .... IEEE1275
                                        u64 pci_addr;
                                        phys_addr_t phys_addr;
                                        u64 size;
                                };
                        */
                        ranges =3D < 02000000 0 A0000000 A0000000 0 2000000=
0
                                   01000000 0 D8000000 D8000000 0 01000000 =
>;
                        clock-frequency =3D <1FCA055>;    //33333333Hz
                        #interrupt-cells =3D <1>;         //PCI aparently u=
ses 1
                        #size-cells =3D <2>;              //Max of 2 ints
                        #address-cells =3D <3>;           //int size
                        reg =3D <8500 100>; //??
                        compatible =3D "fsl,mpc8349-pci";
                        device_type =3D "pci";
                };


What am I doing wrong ?
Thanks in advance.
    Janaka


--_000_DE0CCFFBFF707949BEABD4537A14ACBA073580F459mailsvroptisc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri, sans-serif" size=3D"2">
<div>Hi all,</div>
<div>I am trying to setup the PCI on a Flattened Device Tree (DTS file) for=
 a Microsys MPX8349 board. I have the PCI outbound windows setup as follows=
:</div>
<div>0xA0000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of size&nbsp; 0x2000000=
0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; none pre-fechable PCI memory window</div>
<div>0xD8000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of size&nbsp; 0x01000000,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PCI IO window</div>
<div>These windows are setup on Uboot and I can see the configuration space=
 of PCI&nbsp; and the PCI card installed from Uboot.</div>
<div>When I try to boot my linux kernel&nbsp; (2.6.23 stable Denx kernel) i=
t crashes with:</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Found MPC83xx PCI host bridge at 0x00000=
000e0008500. Firmware bus number: 0-&gt;0</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Observed: pci a0000000 phys ffffffff0000=
0000 size 20000000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] phb0: MEM 0xffffffff00000000 -&gt; 0x11f=
fffffe</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Observed: pci d8000000 phys ffffffff0000=
0000 size 1000000</div>
<div>arch: exit</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 6=
5536</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 65536 -&gt;&nbsp;&nbsp;&nbsp; 65536</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 -&gt;&nbsp;&nbsp;&nbsp; 65536</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order.&nbsp; T=
otal pages: 65024</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: root=3D/dev/nfs rw =
nfsroot=3D192.168.1.1:/home/OPTISCAN/janakas/nfs ip=3D192.168.1.15:192.168.=
1.1:192.168.1.1:255.255.255.0:xepm2:eth0:off console=3DttyS0,9600</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] IPIC (128 IRQ sources) at fdffb700</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 1024 (order: 10,=
 4096 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.001117] Dentry cache hash table entries: 32768 (=
order: 5, 131072 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.085122] Inode-cache hash table entries: 16384 (o=
rder: 4, 65536 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.194097] Memory: 255232k/262144k available (4096k=
 kernel code, 6672k reserved, 168k data, 116k bss, 156k init)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.337215] Mount-cache hash table entries: 512</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.392115] NET: Registered protocol family 16</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.459868] PCI: Probing PCI hardware</div>
<div>[&nbsp;&nbsp;&nbsp; 0.503247] Fixup res 0 (1208) of dev 0000:00:0d.0: =
a0000000 -&gt; ffffffff</div>
<div>[&nbsp;&nbsp;&nbsp; 0.583128] Fixup res 1 (200) of dev 0000:00:0d.0: f=
fffffffa4000000 -&gt; 3ffffff</div>
<div>[&nbsp;&nbsp;&nbsp; 0.669552] Fixup res 6 (7200) of dev 0000:00:0d.0: =
0 -&gt; 5fffffff</div>
<div>[&nbsp;&nbsp;&nbsp; 0.742403] Try to map irq for 0000:00:0d.0...</div>
<div>[&nbsp;&nbsp;&nbsp; 0.795365] pci_busdev_to_OF_node(0,0x68)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.843233]&nbsp; parent is /soc8349@e0000000/pci@85=
00</div>
<div>[&nbsp;&nbsp;&nbsp; 0.899500]&nbsp; result is &lt;NULL&gt;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.935174] debug 1112</div>
<div>[&nbsp;&nbsp;&nbsp; 0.962902] PCI-&gt;OF bus map:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.997267] 0 -&gt; 0</div>
<div>[&nbsp;&nbsp;&nbsp; 1.021159] debug 1124</div>
<div>[&nbsp;&nbsp;&nbsp; 1.049295] PCI: bridge rsrc 0..ffffffff (100), pare=
nt c0404fe4</div>
<div>[&nbsp;&nbsp;&nbsp; 1.120308] PCI:0000:00:0d.0: Resource 0: 00000000ff=
ffffff-0000000003fffffe (f=3D1208)</div>
<div>[&nbsp;&nbsp;&nbsp; 1.213074] PCI: Cannot allocate resource region 0 o=
f device 0000:00:0d.0</div>
<div>[&nbsp;&nbsp;&nbsp; 1.294229] PCI:&nbsp; parent is c044d05c: 00000000f=
fffffff-000000001ffffffe (f=3D200)</div>
<div>[&nbsp;&nbsp;&nbsp; 1.381720] PCI:0000:00:0d.0: Resource 1: 0000000003=
ffffff-000000000403fffe (f=3D200)</div>
<div>[&nbsp;&nbsp;&nbsp; 1.473369] PCI: Cannot allocate resource region 1 o=
f device 0000:00:0d.0</div>
<div>[&nbsp;&nbsp;&nbsp; 1.554532] PCI:0000:00:0d.0: Resource 2: 00000000d8=
000000-00000000d800007f (f=3D101)</div>
<div>[&nbsp;&nbsp;&nbsp; 1.646210] debug 1128</div>
<div>[&nbsp;&nbsp;&nbsp; 1.674012] debug 1134</div>
<div>[&nbsp;&nbsp;&nbsp; 1.702129] [debug 48]Size 04000000, Algn 04000000, =
Min 10000000, Type 00001300</div>
<div>[&nbsp;&nbsp;&nbsp; 1.789877] [debug 48]Size 04000000, Algn 04000000, =
Min 10000000, Type 00000300</div>
<div>[&nbsp;&nbsp;&nbsp; 1.877345] PCI: Failed to allocate mem resource #0:=
4000000@0 for 0000:00:0d.0</div>
<div>[&nbsp;&nbsp;&nbsp; 1.963755] ------------[ cut here ]------------</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 2.018513] kernel BUG at arch/powerpc/kernel/pci_32=
.c:590!</div>
<div>[&nbsp;&nbsp;&nbsp; 2.085155] Oops: Exception in kernel mode, sig: 5 [=
#1]</div>
<div>[&nbsp;&nbsp;&nbsp; 2.147621] PREEMPT MPX8349</div>
<div>[&nbsp;&nbsp;&nbsp; 2.180940] Modules linked in:</div>
<div>[&nbsp;&nbsp;&nbsp; 2.217386] NIP: c03e3c48 LR: c03e3c48 CTR: c001065c=
</div>
<div>[&nbsp;&nbsp;&nbsp; 2.276737] REGS: cffc3e90 TRAP: 0700&nbsp;&nbsp; No=
t tainted&nbsp; (2.6.23MPX8349_PowerPC)</div>
<div>[&nbsp;&nbsp;&nbsp; 2.361070] MSR: 00029032 &lt;EE,ME,IR,DR&gt;&nbsp; =
CR: 24004022&nbsp; XER: 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.437081] TASK =3D cffc1a20[1] 'swapper' THREAD: c=
ffc2000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.499551] GPR00: c03e3c48 cffc3f40 cffc1a20 ffffff=
f0 00000001 00000001 00000000 00000033</div>
<div>[&nbsp;&nbsp;&nbsp; 2.599508] GPR08: 00000000 00000000 0000114e c04300=
00 42004022 08000180 0fffd000 00800000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.699464] GPR16: ffffffff 00000001 00000000 c03800=
00 c0400000 c0400000 00000000 c0380000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.799420] GPR24: c0430000 c04312a0 c04312a0 cffe99=
90 cffe9800 cffe9990 00000000 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.901459] NIP [c03e3c48] pcibios_init&#43;0x1f8/0x=
274</div>
<div>[&nbsp;&nbsp;&nbsp; 2.959767] LR [c03e3c48] pcibios_init&#43;0x1f8/0x2=
74</div>
<div>[&nbsp;&nbsp;&nbsp; 3.017033] Call Trace:</div>
<div>[&nbsp;&nbsp;&nbsp; 3.046189] [cffc3f40] [c03e3c48] pcibios_init&#43;0=
x1f8/0x274 (unreliable)</div>
<div>[&nbsp;&nbsp;&nbsp; 3.125321] [cffc3f70] [c03d9898] kernel_init&#43;0x=
a8/0x29c</div>
<div>[&nbsp;&nbsp;&nbsp; 3.188835] [cffc3ff0] [c0010498] kernel_thread&#43;=
0x44/0x60</div>
<div>[&nbsp;&nbsp;&nbsp; 3.253389] Instruction dump:</div>
<div>[&nbsp;&nbsp;&nbsp; 3.288791] 2f800000 419e0018 7c0803a6 4e800021 2f83=
0000 409e0020 813d000c 552000c2</div>
<div>[&nbsp;&nbsp;&nbsp; 3.381458] 7f83e378 7fe4fb78 901d000c 4bdca38d &lt;=
0f030000&gt; 2f9f0005 3bde001c 3bff0001</div>
<div>[&nbsp;&nbsp;&nbsp; 3.476213] Kernel panic - not syncing: Attempted to=
 kill init!</div>
<div>[&nbsp;&nbsp;&nbsp; 3.547013] Rebooting in 180 seconds..</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>My DTS file entries for PCI are as follows:</div>
<div>&nbsp;</div>
<div>pci@8500 {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interr=
upt-map-mask =3D &lt;&nbsp; // Mask the child UnitIrqSpec</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //ff00 0 0 7=
</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ffff ff ff f=
</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interr=
upt-map =3D &lt;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // Child UnitIrqSpec, Parent PIC handle, Parent UnitIrqSpec<=
/div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // PCI unit address (0000 0 0), Interrupt specifier IDSEL 0x=
0D (CRX board hard wired to IDSEL 13),</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parent Phandle, IRQ7=3D0x17=
 (jumper based) level sensitive(8)</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //0d00 0 0 1 &amp;ipic 17 8</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 00006800 0 0 1 &amp;ipic 17 8</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &gt;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interr=
upt-parent =3D &lt; &amp;ipic &gt;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interr=
upts =3D &lt;42 8&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; //PCI1 interrupt, level sensitive</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bus-ra=
nge =3D &lt;0 0&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; //Bus number and largest bus under this</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*</di=
v>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ranges_pci {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; unsigned int pci_space; //Prefechable/relocatable .... IEEE1=
275</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; u64 pci_addr;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; phys_addr_t phys_addr;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; u64 size;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</di=
v>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges=
 =3D &lt; 02000000 0 A0000000 A0000000 0 20000000</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 01000000 0 D8000000 =
D8000000 0 01000000 &gt;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-=
frequency =3D &lt;1FCA055&gt;;&nbsp;&nbsp;&nbsp; //33333333Hz</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #inter=
rupt-cells =3D &lt;1&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /=
/PCI aparently uses 1</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-=
cells =3D &lt;2&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Max of 2 ints</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #addre=
ss-cells =3D &lt;3&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; //int size</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =
=3D &lt;8500 100&gt;; //??</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compat=
ible =3D &quot;fsl,mpc8349-pci&quot;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=
_type =3D &quot;pci&quot;;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; };</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>What am I doing wrong ?</div>
<div>Thanks in advance.</div>
<div>&nbsp;&nbsp;&nbsp; Janaka</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_DE0CCFFBFF707949BEABD4537A14ACBA073580F459mailsvroptisc_--
