Return-Path: <ginger.xiao@gmail.com>
MIME-Version: 1.0
Date: Sun, 17 Apr 2011 13:56:24 +0800
Message-ID: <BANLkTi=SST3nLy-CFEBvj98WBmCS4mqKwQ@mail.gmail.com>
Subject: [Help] MPC8377 2.6.18 PCI-E doesn't work well
From: Ginger Xiao <ginger.xiao@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd172c45ed4a404a116ef54
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd172c45ed4a404a116ef54
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi All

My board is MPC8377 with linux 2.6.18.

When using the  PCI-E device PCE9901, there is one serial can't work.
 The following is the message:

/myapp # insmod 9900.ko
0001:02:00.0: ttyT0 at I/O 0x0 (irq =3D 22) is a starex-serial
starex-serial: probe of 0001:02:00.1 failed with error -12

>From the kernel logs, I found that=A3=BA
PCI: Assigning unassigned resouces...
PCI: Failed to allocate I/O resource #0:8@1000 for 0001:02:00.1


All the PCI devices are as follows:
~ # lspci
0000:00:00.0 Power PC: Freescale Semiconductor Inc Unknown device 00c7 (rev
21)
0000:00:0f.0 Serial controller: Unknown device 4348:3253 (rev 10)
0001:01:00.0 PCI bridge: Freescale Semiconductor Inc Unknown device 00c7
(rev 21)
0001:02:00.0 Serial controller: NetMos Technology Unknown device 9901
0001:02:00.1 Serial controller: NetMos Technology Unknown device 9901


Parts Kernel booting message is :
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number:
0->0
 ->Hose at 0xc0417000, cfg_addr=3D0xfdffd300,cfg_data=3D0xfdffd304
PCI host bridge /pci@e0008500 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000090000000
 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 Prefetch
  IO 0x00000000e0300000..0x00000000e03fffff -> 0x0000000000000000
mpc83xx_add_bridge():Adding PCI host bridge /pcie@e0009000.
Found MPC83xx PCI host bridge at 0x00000000e0009000. Firmware bus number:
0->0
 ->Hose at 0xc04170c0, cfg_addr=3D0xf5efc000,cfg_data=3D0xfdefc000
PCI host bridge /pcie@e0009000 (primary) ranges:
 MEM 0x00000000a8000000..0x00000000b7ffffff -> 0x00000000a8000000
  IO 0x00000000b8000000..0x00000000b87fffff -> 0x0000000000000000


I fount that because the "0001:02:00.1" does not have the IO map.
How can I configure it?

--000e0cd172c45ed4a404a116ef54
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi All<br><br>My board is MPC8377 with linux 2.6.18.<br><br>When using the&=
nbsp; PCI-E device PCE9901, there is one serial can&#39;t work.<br>&nbsp;Th=
e following is the message:<br><br>/myapp # insmod 9900.ko<br>0001:02:00.0:=
 ttyT0 at I/O 0x0 (irq =3D 22) is a starex-serial<br>
starex-serial: probe of 0001:02:00.1 failed with error -12<br><br>From the =
kernel logs, I found that=A3=BA<br>PCI: Assigning unassigned resouces...<br=
>PCI: Failed to allocate I/O resource #0:8@1000 for 0001:02:00.1<br><br><br=
>
All the PCI devices are as follows:<br>~ # lspci<br>0000:00:00.0 Power PC: =
Freescale Semiconductor Inc Unknown device 00c7 (rev 21)<br>0000:00:0f.0 Se=
rial controller: Unknown device 4348:3253 (rev 10)<br>0001:01:00.0 PCI brid=
ge: Freescale Semiconductor Inc Unknown device 00c7 (rev 21)<br>
0001:02:00.0 Serial controller: NetMos Technology Unknown device 9901<br>00=
01:02:00.1 Serial controller: NetMos Technology Unknown device 9901<br><br>=
<br>Parts Kernel booting message is :<br>Found MPC83xx PCI host bridge at 0=
x00000000e0008500. Firmware bus number: 0-&gt;0<br>
&nbsp;-&gt;Hose at 0xc0417000, cfg_addr=3D0xfdffd300,cfg_data=3D0xfdffd304<=
br>PCI host bridge /pci@e0008500 (primary) ranges:<br>&nbsp;MEM 0x000000009=
0000000..0x000000009fffffff -&gt; 0x0000000090000000 <br>&nbsp;MEM 0x000000=
0080000000..0x000000008fffffff -&gt; 0x0000000080000000 Prefetch<br>
&nbsp; IO 0x00000000e0300000..0x00000000e03fffff -&gt; 0x0000000000000000<b=
r>mpc83xx_add_bridge():Adding PCI host bridge /pcie@e0009000. <br>Found MPC=
83xx PCI host bridge at 0x00000000e0009000. Firmware bus number: 0-&gt;0<br=
>
&nbsp;-&gt;Hose at 0xc04170c0, cfg_addr=3D0xf5efc000,cfg_data=3D0xfdefc000<=
br>PCI host bridge /pcie@e0009000 (primary) ranges:<br>&nbsp;MEM 0x00000000=
a8000000..0x00000000b7ffffff -&gt; 0x00000000a8000000 <br>&nbsp; IO 0x00000=
000b8000000..0x00000000b87fffff -&gt; 0x0000000000000000<br>
<br><br>I fount that because the &quot;0001:02:00.1&quot; does not have the=
 IO map.<br>How can I configure it?<br><br>

--000e0cd172c45ed4a404a116ef54--
