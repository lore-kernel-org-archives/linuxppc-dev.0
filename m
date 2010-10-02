Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 059D6B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 17:20:27 +1000 (EST)
Received: by qwj9 with SMTP id 9so2017500qwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Oct 2010 00:20:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikSaBR4vEikhGp0fsY3FnZCJQT2D-vw9=Kh4UHn@mail.gmail.com>
References: <AANLkTikSaBR4vEikhGp0fsY3FnZCJQT2D-vw9=Kh4UHn@mail.gmail.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Sat, 2 Oct 2010 09:20:04 +0200
Message-ID: <AANLkTimFgrRbRfsQqN9d9GOZhth072F9TKGXunaqJNVB@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6509e42125d5204919d25dd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6509e42125d5204919d25dd
Content-Type: text/plain; charset=ISO-8859-1

Hi,

It seems i forgot to include the relevant TLB entries in U-Boot and the
Device Tree in the e-mail, so here they are:

The TLB entries in U-Boot:

/*
 * TLB 3: 256M Non-cacheable, guarded
 * 0xc0000000 256M Rapid IO MEM First half
 */
SET_TLB_ENTRY(1, CONFIG_SYS_RIO_MEM_VIRT, CONFIG_SYS_RIO_MEM_PHYS,
      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
      0, 3, BOOKE_PAGESZ_256M, 1),

/*
 * TLB 4: 256M Non-cacheable, guarded
 * 0xd0000000 256M Rapid IO MEM Second half
 */
SET_TLB_ENTRY(1, CONFIG_SYS_RIO_MEM_VIRT + 0x10000000,
CONFIG_SYS_RIO_MEM_PHYS + 0x10000000,
      MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,
      0, 4, BOOKE_PAGESZ_256M, 1),


And the device tree entry:

 rapidio0:rapidio@c0000 {
           #address-cells = <1>;
           #size-cells = <1>;
           compatible = "fsl,rapidio-delta";
           reg = <0xc0000 0x20000>;
           ranges = <0x0 0xc0000000 0x20000000>;
           interrupt-parent = <&mpic>;
           /* err_irq bell_outb_irq bell_inb_irq
                   msg1_tx_irq msg1_rx_irq msg2_tx_irq msg2_rx_irq */
           interrupts = <0x30 0x2 0x31 0x2 0x32 0x2 0x35 0x2 0x36 0x2 0x37
0x2 0x38 0x2>;
  };

Regards,
Bastiaan Nijkamp

2010/10/2 Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>

> Hi,
>
> We are currently evaluating Serial RapidIO on two WindRiver SBC8548 boards
> that use a Freescale Powerquicc III processor (MPC8548E rev. 2). We are
> running U-Boot version 2010.09 as bootloader and are using kernel version
> 2.6.35.6 stable.
>
> We have consulted multiple resources to collect al the requirements for
> a successful RapidIO connection (LAW, TLB, Registers) and we seem to have
> configured everything correctly. However, as soon as the board that is
> configured as the host starts the enumeration process, the system locks up.
> It locks in such a manner that we cannot use a JTAG interface to read any of
> the registers.  We have also added a breakpoint just before the command that
> causes the lock up, to make sure the registers are correctly set at that
> point, and it seems they are.
>
> We have tripple checked everything that we could possibly think of and
> everything seems to be configured as required but the system keeps
> locking-up so there must be something that we are missing. I really hope
> that someone could point us in the right direction. The lock-up occurs when
> __fsl_read_rio_config is called by fsl_rio_config_read in fsl-rio.c.
>
> The LAW and TLB entries we have added to U-Boot are as follows:
>
> #define CONFIG_RIO 1
> #define CONFIG_SYS_RIO_MEM_VIRT 0xc0000000 /* base address */
> #define CONFIG_SYS_RIO_MEM_BUS 0xc0000000 /* base address */
> #define CONFIG_SYS_RIO_MEM_PHYS 0xc0000000
> #define CONFIG_SYS_RIO_MEM_SIZE 0x20000000 /* 512M */
>
> SET_LAW(CONFIG_SYS_RIO_MEM_PHYS, LAW_SIZE_512M, LAW_TRGT_IF_RIO),
>
> -------------
>
> Here is the kernel log:
>
> Using SBC8548 machine description
> Memory CAM mapping: 256 Mb, residual: 0Mb
> Linux version 2.6.35.6 (dl704@lxws006) (gcc version 4.1.2 (Wind River
> Linux Sourcery G++ 4.1-91)) #7 We
> d Sep 29 13:27:18 CEST 2010
> bootconsole [udbg0] enabled
> setup_arch: bootmem
> sbc8548_setup_arch()
> arch: exit
> Zone PFN ranges:
>  DMA      0x00000000 -> 0x00010000
>  Normal   empty
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>    0: 0x00000000 -> 0x00010000
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> Kernel command line: root=/dev/nfs rw nfsroot=192.168.100.21:/thales/target/rfs/sbc8548_wrlinux4
> ip=192
> .168.100.151:192.168.100.21:192.168.100.21:255.255.255.0:sbc8548_1:eth0:off
> console=ttyS0,115200 riohdid=1
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 256884k/262144k available (2712k kernel code, 5260k reserved, 112k
> data, 77k bss, 144k init)
> Kernel virtual memory layout:
>  * 0xfffdf000..0xfffff000  : fixmap
>  * 0xfc7f9000..0xfe000000  : early ioremap
>  * 0xd1000000..0xfc7f9000  : vmalloc & ioremap
> Hierarchical RCU implementation.
>        RCU-based detection of stalled CPUs is disabled.
>        Verbose stalled-CPUs detection is disabled.
> NR_IRQS:512 nr_irqs:512
> mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
> mpic: ISU size: 80, shift: 7, mask: 7f
> mpic: Initializing for 80 sources
> clocksource: timebase mult[50cede6] shift[22] registered
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
>
> PCI: Probing PCI hardware
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> Setting up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000
> fsl-of-rio e00c0000.rapidio: Of-device full name /soc8548@e0000000
> /rapidio@c0000
> fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]
> fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, size
> 0x0000000020000000.
> fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54
> fsl-of-rio e00c0000.rapidio: DeviceID is 0x1
> fsl-of-rio e00c0000.rapidio: Configured as HOST
> fsl-of-rio e00c0000.rapidio: RapidIO PHY type: serial
> fsl-of-rio e00c0000.rapidio: Hardware port width: 4
> fsl-of-rio e00c0000.rapidio: Training connection status: Four-lane
> fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256
> RIO: enumerate master port 0, RIO0 mport
> fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len 4
> fsl_rio_config_read: Passed IS_ALIGNED.
> fsl_rio_config_read: Passed 'out_be32_1'
> fsl_rio_config_read: Passed 'out_be32_2'
> fsl_rio_config_read: len is 4
> fsl_rio_config_read: about to trigger '__fsl_read_rio_config'
>
> Regards,
>  Bastiaan Nijkamp
>

--0016e6509e42125d5204919d25dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>It seems i forgot to include the relevant TLB entrie=
s in U-Boot and the Device Tree in the e-mail, so here they are:</div><div>=
<br></div><div>The TLB entries in U-Boot:</div><div><br></div><div><div>

/*</div><div>=A0* TLB 3:<span class=3D"Apple-tab-span" style=3D"white-space=
:pre">	</span>256M<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>Non-cacheable, guarded</div><div>=A0* 0xc0000000<span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">	</span>256M<span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>Rapid IO MEM First half</div>

<div>=A0*/</div><div>SET_TLB_ENTRY(1, CONFIG_SYS_RIO_MEM_VIRT, CONFIG_SYS_R=
IO_MEM_PHYS,</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span> =A0 =A0 =A0MAS3_SX|MAS3_SW|MAS3_SR, MAS2_I|MAS2_G,</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =A0 =A0 =
=A00, 3, BOOKE_PAGESZ_256M, 1),</div>

<div><br></div><div>/*</div><div>=A0* TLB 4:<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>256M<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>Non-cacheable, guarded</div><div>=A0* 0xd00000=
00<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>256M<spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>Rapid IO MEM S=
econd half</div>

<div>=A0*/</div><div>SET_TLB_ENTRY(1, CONFIG_SYS_RIO_MEM_VIRT + 0x10000000,=
 CONFIG_SYS_RIO_MEM_PHYS + 0x10000000,</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">	</span> =A0 =A0 =A0MAS3_SX|MAS3_SW|MAS3_SR,=
 MAS2_I|MAS2_G,</div>

<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =A0 =
=A0 =A00, 4, BOOKE_PAGESZ_256M, 1),</div><div><br></div><div><br></div><div=
>And the device tree entry:</div><div><br></div><div>=A0rapidio0:rapidio@c0=
000 {</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 #address-cells =3D &lt;1&gt;;</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 #size-cells =3D &lt;1&gt;;</div><div>=A0=A0 =A0 =A0 =A0 =A0=
 compatible =3D &quot;fsl,rapidio-delta&quot;;</div><div>=A0=A0 =A0 =A0 =A0=
 =A0 reg =3D &lt;0xc0000 0x20000&gt;;</div><div>=A0=A0 =A0 =A0 =A0 =A0 rang=
es =3D &lt;0x0 0xc0000000 0x20000000&gt;;</div>

<div>=A0=A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt;&amp;mpic&gt;;</div><d=
iv>=A0=A0 =A0 =A0 =A0 =A0 /* err_irq bell_outb_irq bell_inb_irq</div><div>=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg1_tx_irq msg1_rx_irq msg2_tx_irq =
msg2_rx_irq */</div><div>=A0=A0 =A0 =A0 =A0 =A0 interrupts =3D &lt;0x30 0x2=
 0x31 0x2 0x32 0x2 0x35 0x2 0x36 0x2 0x37 0x2 0x38 0x2&gt;;</div>

<div>=A0=A0};</div><div><br></div>Regards,</div><div>Bastiaan Nijkamp</div>=
<div><br><div class=3D"gmail_quote">2010/10/2 Bastiaan Nijkamp <span dir=3D=
"ltr">&lt;<a href=3D"mailto:bastiaan.nijkamp@gmail.com">bastiaan.nijkamp@gm=
ail.com</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Hi,<br><br>We are currently evaluating Seri=
al RapidIO on two WindRiver SBC8548 boards that use a Freescale Powerquicc =
III processor (MPC8548E rev. 2). We are running U-Boot version 2010.09 as b=
ootloader and are using kernel version 2.6.35.6 stable.=A0<br>


<br>We have consulted multiple resources to collect al the requirements for=
 a=A0successful=A0RapidIO connection (LAW, TLB, Registers) and we seem to h=
ave configured everything correctly. However, as soon as the board that is =
configured as the host starts the enumeration process, the system locks up.=
 It locks in such a manner that we cannot use a JTAG interface to read any =
of the registers. =A0We have also added a breakpoint just before the comman=
d that causes the lock up, to make sure the registers are correctly set at =
that point, and it seems they are.=A0<br>


<br>We have tripple checked everything that we could possibly think of and =
everything seems to be configured as required but the system keeps locking-=
up so there must be something that we are missing. I really hope that someo=
ne could point us in the right direction. The lock-up occurs when __fsl_rea=
d_rio_config is called by fsl_rio_config_read in fsl-rio.c.<div>


<br></div><div>The LAW and TLB entries we have added to U-Boot are as follo=
ws:</div><div><br></div><div><div>#define CONFIG_RIO 1</div><div>#define CO=
NFIG_SYS_RIO_MEM_VIRT<span style=3D"white-space:pre-wrap">	</span>0xc000000=
0<span style=3D"white-space:pre-wrap">	</span>/* base address */</div>


<div>#define CONFIG_SYS_RIO_MEM_BUS<span style=3D"white-space:pre-wrap">	</=
span>0xc0000000<span style=3D"white-space:pre-wrap">	</span>/* base address=
 */</div><div>#define CONFIG_SYS_RIO_MEM_PHYS<span style=3D"white-space:pre=
-wrap">	</span>0xc0000000</div>


<div>#define CONFIG_SYS_RIO_MEM_SIZE<span style=3D"white-space:pre-wrap">	<=
/span>0x20000000<span style=3D"white-space:pre-wrap">	</span>/* 512M */</di=
v></div><div><br></div><div>SET_LAW(CONFIG_SYS_RIO_MEM_PHYS, LAW_SIZE_512M,=
 LAW_TRGT_IF_RIO),</div>


<div><br></div><div>-------------<br><br>Here is the kernel log:<br><br>Usi=
ng SBC8548 machine description<br>Memory CAM mapping: 256 Mb, residual: 0Mb=
<br>Linux version 2.6.35.6 (dl704@lxws006) (gcc version 4.1.2 (Wind River L=
inux Sourcery G++ 4.1-91)) #7 We<br>


d Sep 29 13:27:18 CEST 2010<br>bootconsole [udbg0] enabled<br>setup_arch: b=
ootmem<br>sbc8548_setup_arch()<br>arch: exit<br>Zone PFN ranges:<br>=A0DMA =
=A0 =A0 =A00x00000000 -&gt; 0x00010000<br>=A0Normal =A0 empty<br>Movable zo=
ne start PFN for each node<br>


early_node_map[1] active PFN ranges<br>=A0 =A00: 0x00000000 -&gt; 0x0001000=
0<br>MMU: Allocated 1088 bytes of context maps for 255 contexts<br>Built 1 =
zonelists in Zone order, mobility grouping on. =A0Total pages: 65024<br>Ker=
nel command line: root=3D/dev/nfs rw nfsroot=3D192.168.100.21:/thales/targe=
t/rfs/sbc8548_wrlinux4 ip=3D192<br>


.168.100.151:192.168.100.21:192.168.100.21:255.255.255.0:sbc8548_1:eth0:off=
 console=3DttyS0,115200 riohdid=3D1<br>PID hash table entries: 1024 (order:=
 0, 4096 bytes)<br>Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)<br>


Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)<br>Memory: 25=
6884k/262144k available (2712k kernel code, 5260k reserved, 112k data, 77k =
bss, 144k init)<br>Kernel virtual memory layout:<br>=A0* 0xfffdf000..0xffff=
f000 =A0: fixmap<br>


=A0* 0xfc7f9000..0xfe000000 =A0: early ioremap<br>=A0* 0xd1000000..0xfc7f90=
00 =A0: vmalloc &amp; ioremap<br>Hierarchical RCU implementation.<br>=A0 =
=A0 =A0 =A0RCU-based detection of stalled CPUs is disabled.<br>=A0 =A0 =A0 =
=A0Verbose stalled-CPUs detection is disabled.<br>


NR_IRQS:512 nr_irqs:512<br>mpic: Setting up MPIC &quot; OpenPIC =A0&quot; v=
ersion 1.2 at e0040000, max 1 CPUs<br>mpic: ISU size: 80, shift: 7, mask: 7=
f<br>mpic: Initializing for 80 sources<br>clocksource: timebase mult[50cede=
6] shift[22] registered<br>


pid_max: default: 32768 minimum: 301<br>Mount-cache hash table entries: 512=
<br>NET: Registered protocol family 16<br>=A0 =A0 =A0 =A0 =A0 =A0=A0<br>PCI=
: Probing PCI hardware<br>bio: create slab &lt;bio-0&gt; at 0<br>vgaarb: lo=
aded<br>Switching to clocksource timebase<br>


NET: Registered protocol family 2<br>IP route cache hash table entries: 204=
8 (order: 1, 8192 bytes)<br>TCP established hash table entries: 8192 (order=
: 4, 65536 bytes)<br>TCP bind hash table entries: 8192 (order: 3, 32768 byt=
es)<br>


TCP: Hash tables configured (established 8192 bind 8192)<br>TCP reno regist=
ered<br>UDP hash table entries: 256 (order: 0, 4096 bytes)<br>UDP-Lite hash=
 table entries: 256 (order: 0, 4096 bytes)<br>NET: Registered protocol fami=
ly 1<br>


RPC: Registered udp transport module.<br>RPC: Registered tcp transport modu=
le.<br>RPC: Registered tcp NFSv4.1 backchannel transport module.<br>Setting=
 up RapidIO peer-to-peer network /soc8548@e0000000/rapidio@c0000<br>fsl-of-=
rio e00c0000.rapidio: Of-device full name /soc8548@e0000000/rapidio@c0000<b=
r>


fsl-of-rio e00c0000.rapidio: Regs: [mem 0xe00c0000-0xe00dffff]<br>fsl-of-ri=
o e00c0000.rapidio: LAW start 0x00000000c0000000, size 0x0000000020000000.<=
br>fsl-of-rio e00c0000.rapidio: pwirq: 48, bellirq: 50, txirq: 53, rxirq 54=
<br>


fsl-of-rio e00c0000.rapidio: DeviceID is 0x1<br>fsl-of-rio e00c0000.rapidio=
: Configured as HOST<br>fsl-of-rio e00c0000.rapidio: RapidIO PHY type: seri=
al<br>fsl-of-rio e00c0000.rapidio: Hardware port width: 4<br>fsl-of-rio e00=
c0000.rapidio: Training connection status: Four-lane<br>


fsl-of-rio e00c0000.rapidio: RapidIO Common Transport System size: 256<br>R=
IO: enumerate master port 0, RIO0 mport<br>fsl_rio_config_read: index 0 des=
tid 255 hopcount 0 offset 00000068 len 4<br>fsl_rio_config_read: Passed IS_=
ALIGNED.<br>


fsl_rio_config_read: Passed &#39;out_be32_1&#39;<br>fsl_rio_config_read: Pa=
ssed &#39;out_be32_2&#39;<br>fsl_rio_config_read: len is 4<br>fsl_rio_confi=
g_read:=A0about to trigger &#39;__fsl_read_rio_config&#39;<br><br>Regards,<=
br>

<font color=3D"#888888">
Bastiaan Nijkamp
</font></div>
</blockquote></div><br></div>

--0016e6509e42125d5204919d25dd--
