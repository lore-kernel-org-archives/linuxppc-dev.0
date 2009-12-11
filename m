Return-Path: <ajijuni@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20091207180719.GB8914@loki.buserror.net>
References: <7675847.584551260168085277.JavaMail.nabble@isper.nabble.com>
	<20091207180719.GB8914@loki.buserror.net>
Date: Thu, 10 Dec 2009 16:34:23 -0800
Message-ID: <72d214170912101634l1fab97fewc849a819f767415c@mail.gmail.com>
Subject: Re: dts file for MPC8343EA
From: Junita Ajith <ajijuni@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001636e1f8f5daf117047a69157d
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e1f8f5daf117047a69157d
Content-Type: text/plain; charset=ISO-8859-1

Hi Scott:

I am still stuck at Linux kernel booting in MPC8343EA based board.

I have disabled "Ethernet, PCI, USB, dma engines " in the *.dts file and
also in the kernel config.
I am using MPC8349emitxgp.dts  ; enabled MPC8349ITX support in kernel config
also. In fact, I tried building MPC8349emITX; MPC8349MDS also. Same
behaviour!

With this, the kernel boots up (explicitly passing the DTB file and cuImage
NEVER worked) and hangs after

I am using Linux-V-2.6.27.18 and using powerpc-e300c3-gnu  toolchain  -
gcc-4.1.69-eglibc-2.5.69-1 to build u-boot-1.3.2 & linux.

With this, the kernel boots up (explicitly passing the DTB file and cuImage
NEVER worked) and hangs after printing
"Calibrating delay loop... 133.12 BogoMIPS (lpj=266240)"

With a few debug printks looks like the kernel hangs in
"cpu_idle" in --main/init.c

Any clues..?? HELP!!!
Please find the dts file and screen-dump below:

Thanks,
Junita
DTS file:
=======

/dts-v1/;

/ {
        model = "MPC8349EMITXGP";
        compatible = "MPC8349EMITXGP", "MPC834xMITX", "MPC83xxMITX";
        #address-cells = <1>;
        #size-cells = <1>;

        aliases {
                serial0 = &serial0;
        };

        cpus {
                #address-cells = <1>;
                #size-cells = <0>;

                PowerPC,8349@0 {
                        device_type = "cpu";
                        reg = <0x0>;
                        d-cache-line-size = <32>;
                        i-cache-line-size = <32>;
                        d-cache-size = <32768>;
                        i-cache-size = <32768>;
                        timebase-frequency = <0>;       // from bootloader
                        bus-frequency = <0>;            // from bootloader
                        clock-frequency = <0>;          // from bootloader
                };
        };
memory {
                device_type = "memory";
                reg = <0x00000000 0x10000000>;
        };


        soc8349@e0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                device_type = "soc";
                compatible = "simple-bus";
                ranges = <0x0 0xe0000000 0x00100000>;
                reg = <0xe0000000 0x00000200>;
                bus-frequency = <0x0fe502a8>;                    // from
bootloader

                wdt@200 {
                        device_type = "watchdog";
                        compatible = "mpc83xx_wdt";
                        reg = <0x200 0x100>;
                };

                i2c@3000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        cell-index = <0>;
                        compatible = "fsl-i2c";
                        reg = <0x3000 0x100>;
                        interrupts = <14 0x8>;
                        interrupt-parent = <&ipic>;
                        dfsrr;
                };

                mdio@24520 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "fsl,gianfar-mdio";
                        reg = <0x24520 0x20>;

                };
serial0: serial@4500 {
                        cell-index = <0>;
                        device_type = "serial";
                        compatible = "ns16550";
                        reg = <0x4500 0x100>;
                        clock-frequency = <0>;          // from bootloader
                        interrupts = <9 0x8>;
                        interrupt-parent = <&ipic>;
                };

                ipic: pic@700 {
                        interrupt-controller;
                        #address-cells = <0>;
                        #interrupt-cells = <2>;
                        reg = <0x700 0x100>;
                        device_type = "ipic";
                };
        };

};

Screen-shot:
==========
Trying TSEC0
Speed: 100, full duplex
Using TSEC0 device
TFTP from server 192.168.201.14; our IP address is 192.168.201.199
Filename '8349.dtb'.
Load address: 0x900000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
SC3000> bootm 0x00600000 - 0x00900000
## Booting image at 00600000 ...
   Image Name:   Linux-2.6.27.18
   Created:      2009-12-11   0:16:24 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    850785 Bytes = 830.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FF9BD48 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF2E
bd address  = 0x0FF9BFC4
memstart    = 0x00000000
memsize     = 0x10000000
flashstart  = 0xFE000000
flashsize   = 0x00080000
flashoffset = 0x00034000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x00000001
intfreq     = 399.999 MHz
busfreq     = 266.666 MHz
ethaddr     = 00:E0:0C:00:8C:01
IP addr     = 192.168.201.199
baudrate    = 115200 bps
Skipping initrd
   Booting using the fdt at 0x900000
No initrd
## device tree at 0x00900000 ... 0x00902FFF (len=12288=0x3000)
   Loading Device Tree to 007fc000, end 007fefff ... OK
Updating property 'timebase-frequency' =  03 f9 40 aa
Updating property 'bus-frequency' =  0f e5 02 a8
Updating property 'clock-frequency' =  17 d7 83 fc
Updating property 'bus-frequency' =  0f e5 02 a8
Updating property 'clock-frequency' =  0f e5 02 a8
## Transferring control to Linux (at address 00000000) ...
Using MPC834x ITX machine description
Linux version 2.6.27.18 (root@localhost.localdomain) (gcc version 4.1.2) #26
Th9 -> find_legacy_serial_port()
stdout is /soc8349@e0000000/serial@4500
Found legacy serial port 0 for /soc8349@e0000000/serial@4500
  mem=e0004500, taddr=e0004500, irq=0, clk=266666664, speed=0
legacy_serial_console = 0
default console speed = 115740
 <- find_legacy_serial_port()
console [udbg0] enabled
setup_arch: bootmem
mpc834x_itx_setup_arch()
arch: exit
Top of RAM: 0x8000000, Total RAM: 0x8000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c01b6224, node_mem_map c01d0000
  DMA zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/ram rw console=ttyS0,115200 mem=128M
IPIC (128 IRQ sources) at fdffd700
PID hash table entries: 512 (order: 9, 2048 bytes)
time_init: decrementer frequency = 66.666666 MHz
time_init: processor frequency   = 399.999996 MHz
clocksource: timebase mult[3c00001] shift[22] registered
clockevent: decrementer mult[1111] shift[16] cpu[0]
 -> check_legacy_serial_console()
 console was specified !
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
SC3000 - After vfs_caches_init_early -1
SC3000 - After vfs_caches_init_early-2
Memory: 127912k/131072k available (1688k kernel code, 3000k reserved, 68k
data,)SC3000 - After vfs_caches_init_early-3
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 133.12 BogoMIPS (lpj=266240)



On 12/7/09, Scott Wood <scottwood@freescale.com> wrote:
>
> On Sun, Dec 06, 2009 at 10:41:25PM -0800, ajijuni@gmail.com wrote:
> > Hi
> >
> > We have an MPC8343EA based custom board.
> >
> > I am not able to get Linux up and running in this. No serial output to
> debug further.
> >  U-boot shows correct 'bdinfo' & 'clocks' output.
> > inux hangs at machine_probe.
>
> Check that the platform file you're intending to use matches the compatible
> field in the root node of the device tree -- and that said platform file is
> actually being built.
>
>
> -Scott
>

--001636e1f8f5daf117047a69157d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Scott:<br>
<br>
I am still stuck at Linux kernel booting in MPC8343EA based board.<br>
<br>
I have disabled &quot;Ethernet, PCI, USB, dma engines &quot; in the *.dts f=
ile and also in the kernel config.<br>
I am using MPC8349emitxgp.dts=A0 ; enabled MPC8349ITX support in
kernel config also. In fact, I tried building MPC8349emITX; MPC8349MDS
also. Same behaviour!<br>
<br>
With this, the kernel boots up (explicitly passing the DTB file and cuImage=
 NEVER worked) and hangs after<br>
<br>
I am using Linux-V-2.6.27.18 and using powerpc-e300c3-gnu=A0
toolchain=A0 - gcc-4.1.69-eglibc-2.5.69-1 to build u-boot-1.3.2
&amp; linux.<br>
<br>
With this, the kernel boots up (explicitly passing the DTB file and cuImage=
 NEVER worked) and hangs after printing<br>
&quot;Calibrating delay loop... 133.12 BogoMIPS (lpj=3D266240)&quot;<br>
<br>
With a few debug printks looks like the kernel hangs in <br>
&quot;cpu_idle&quot; in --main/init.c<br>
<br>
Any clues..?? HELP!!!<br>
Please find the dts file and screen-dump below:<br>
<br>
Thanks,<br>
Junita<br>
DTS file:<br>
=3D=3D=3D=3D=3D=3D=3D<br>
<br>
/dts-v1/;<br>
<br>
/ {<br>
=A0=A0=A0=A0=A0=A0=A0 model =3D &quot;MPC8349EMITXGP&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quot;MPC8349EMITXGP&quot;, &quot;MPC8=
34xMITX&quot;, &quot;MPC83xxMITX&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;1&gt;;<br>
<br>
=A0=A0=A0=A0=A0=A0=A0 aliases {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial0 =3D &amp;serial0;<br>
=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
=A0=A0=A0=A0=A0=A0=A0 cpus {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;=
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;0&gt;;<br=
>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PowerPC,8349@0 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
device_type =3D &quot;cpu&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
d-cache-line-size =3D &lt;32&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
i-cache-line-size =3D &lt;32&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
d-cache-size =3D &lt;32768&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
i-cache-size =3D &lt;32768&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
timebase-frequency =3D &lt;0&gt;;=A0=A0=A0=A0=A0=A0 //
from bootloader<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
bus-frequency =3D
&lt;0&gt;;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
// from bootloader<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
clock-frequency =3D
&lt;0&gt;;=A0=A0=A0=A0=A0=A0=A0=A0=A0 //
from bootloader<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
=A0=A0=A0=A0=A0=A0=A0 };<br>
memory {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D &quot;memory&=
quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt;0x00000000 0x1000=
0000&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
<br>
=A0=A0=A0=A0=A0=A0=A0 soc8349@e0000000 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #address-cells =3D &lt;1&gt;;=
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #size-cells =3D &lt;1&gt;;<br=
>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D &quot;soc&quo=
t;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compatible =3D &quot;simple-b=
us&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
ranges =3D &lt;0x0 0xe0000000 0x00100000&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt;0xe0000000 0x0000=
0200&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
bus-frequency =3D
&lt;0x0fe502a8&gt;;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
// from bootloader<br>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wdt@200 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
device_type =3D &quot;watchdog&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
compatible =3D &quot;mpc83xx_wdt&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x200 0x100&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i2c@3000 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#address-cells =3D &lt;1&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#size-cells =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
cell-index =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
compatible =3D &quot;fsl-i2c&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x3000 0x100&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
interrupts =3D &lt;14 0x8&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
dfsrr;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mdio@24520 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#address-cells =3D &lt;1&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#size-cells =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
compatible =3D &quot;fsl,gianfar-mdio&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x24520 0x20&gt;;<br>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
serial0: serial@4500 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
cell-index =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
device_type =3D &quot;serial&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
compatible =3D &quot;ns16550&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x4500 0x100&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
clock-frequency =3D
&lt;0&gt;;=A0=A0=A0=A0=A0=A0=A0=A0=A0 //
from bootloader<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
interrupts =3D &lt;9 0x8&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
interrupt-parent =3D &lt;&amp;ipic&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ipic: pic@700 {<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
interrupt-controller;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#address-cells =3D &lt;0&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
#interrupt-cells =3D &lt;2&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
reg =3D &lt;0x700 0x100&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
device_type =3D &quot;ipic&quot;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };<br>
=A0=A0=A0=A0=A0=A0=A0 };<br>
<br>
};<br>
<br>
Screen-shot:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
Trying TSEC0<br>
Speed: 100, full duplex<br>
Using TSEC0 device<br>
TFTP from server 192.168.201.14; our IP address is 192.168.201.199<br>
Filename &#39;8349.dtb&#39;.<br>
Load address: 0x900000<br>
Loading: #<br>
done<br>
Bytes transferred =3D 12288 (3000 hex)<br>
SC3000&gt; bootm 0x00600000 - 0x00900000<br>
## Booting image at 00600000 ...<br>
=A0=A0 Image Name:=A0=A0 Linux-2.6.27.18<br>
=A0=A0 Created:=A0=A0=A0=A0=A0 2009-12-11=A0=A0 0:16:24 UTC<br>
=A0=A0 Image Type:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)<br>
=A0=A0 Data Size:=A0=A0=A0 850785 Bytes =3D 830.8 kB<br>
=A0=A0 Load Address: 00000000<br>
=A0=A0 Entry Point:=A0 00000000<br>
=A0=A0 Verifying Checksum ... OK<br>
=A0=A0 Uncompressing Kernel Image ... OK<br>
## Current stack ends at 0x0FF9BD48 =3D&gt; set upper limit to 0x00800000<b=
r>
## cmdline at 0x007FFF00 ... 0x007FFF2E<br>
bd address=A0 =3D 0x0FF9BFC4<br>
memstart=A0=A0=A0 =3D 0x00000000<br>
memsize=A0=A0=A0=A0 =3D 0x10000000<br>
flashstart=A0 =3D 0xFE000000<br>
flashsize=A0=A0 =3D 0x00080000<br>
flashoffset =3D 0x00034000<br>
sramstart=A0=A0 =3D 0x00000000<br>
sramsize=A0=A0=A0 =3D 0x00000000<br>
bootflags=A0=A0 =3D 0x00000001<br>
intfreq=A0=A0=A0=A0 =3D 399.999 MHz<br>
busfreq=A0=A0=A0=A0 =3D 266.666 MHz<br>
ethaddr=A0=A0=A0=A0 =3D 00:E0:0C:00:8C:01<br>
IP addr=A0=A0=A0=A0 =3D 192.168.201.199<br>
baudrate=A0=A0=A0 =3D 115200 bps<br>
Skipping initrd<br>
=A0=A0 Booting using the fdt at 0x900000<br>
No initrd<br>
## device tree at 0x00900000 ... 0x00902FFF (len=3D12288=3D0x3000)<br>
=A0=A0 Loading Device Tree to 007fc000, end 007fefff ... OK<br>
Updating property &#39;timebase-frequency&#39; =3D=A0 03 f9 40 aa<br>
Updating property &#39;bus-frequency&#39; =3D=A0 0f e5 02 a8<br>
Updating property &#39;clock-frequency&#39; =3D=A0 17 d7 83 fc<br>
Updating property &#39;bus-frequency&#39; =3D=A0 0f e5 02 a8<br>
Updating property &#39;clock-frequency&#39; =3D=A0 0f e5 02 a8<br>
## Transferring control to Linux (at address 00000000) ...<br>
Using MPC834x ITX machine description<br>
Linux version 2.6.27.18 (root@localhost.localdomain) (gcc version 4.1.2) #2=
6 Th9 -&gt; find_legacy_serial_port()<br>
stdout is /soc8349@e0000000/serial@4500<br>
Found legacy serial port 0 for /soc8349@e0000000/serial@4500<br>
=A0 mem=3De0004500, taddr=3De0004500, irq=3D0, clk=3D266666664, speed=3D0<b=
r>
legacy_serial_console =3D 0<br>
default console speed =3D 115740<br>
=A0&lt;- find_legacy_serial_port()<br>
console [udbg0] enabled<br>
setup_arch: bootmem<br>
mpc834x_itx_setup_arch()<br>
arch: exit<br>
Top of RAM: 0x8000000, Total RAM: 0x8000000<br>
Memory hole size: 0MB<br>
Zone PFN ranges:<br>
=A0 DMA=A0=A0=A0=A0=A0 0x00000000 -&gt; 0x00008000<br>
=A0 Normal=A0=A0 0x00008000 -&gt; 0x00008000<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
=A0=A0=A0 0: 0x00000000 -&gt; 0x00008000<br>
On node 0 totalpages: 32768<br>
free_area_init_node: node 0, pgdat c01b6224, node_mem_map c01d0000<br>
=A0 DMA zone: 32512 pages, LIFO batch:7<br>
Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 3251=
2<br>
Kernel command line: root=3D/dev/ram rw console=3DttyS0,115200 mem=3D128M<b=
r>
IPIC (128 IRQ sources) at fdffd700<br>
PID hash table entries: 512 (order: 9, 2048 bytes)<br>
time_init: decrementer frequency =3D 66.666666 MHz<br>
time_init: processor frequency=A0=A0 =3D 399.999996 MHz<br>
clocksource: timebase mult[3c00001] shift[22] registered<br>
clockevent: decrementer mult[1111] shift[16] cpu[0]<br>
=A0-&gt; check_legacy_serial_console()<br>
=A0console was specified !<br>
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)<br>
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
SC3000 - After vfs_caches_init_early -1<br>
SC3000 - After vfs_caches_init_early-2<br>
Memory: 127912k/131072k available (1688k kernel code, 3000k reserved, 68k d=
ata,)SC3000 - After vfs_caches_init_early-3<br>
SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1<br>
Calibrating delay loop... 133.12 BogoMIPS (lpj=3D266240)<br>
<br>
<br>
<br><div><span class=3D"gmail_quote">On 12/7/09, <b class=3D"gmail_senderna=
me">Scott Wood</b> &lt;<a href=3D"mailto:scottwood@freescale.com">scottwood=
@freescale.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
On Sun, Dec 06, 2009 at 10:41:25PM -0800, <a href=3D"mailto:ajijuni@gmail.c=
om">ajijuni@gmail.com</a> wrote:<br> &gt; Hi<br> &gt;<br> &gt; We have an M=
PC8343EA based custom board.<br> &gt;<br> &gt; I am not able to get Linux u=
p and running in this. No serial output to debug further.<br>
 &gt;=A0=A0U-boot shows correct &#39;bdinfo&#39; &amp; &#39;clocks&#39; out=
put.<br> &gt; inux hangs at machine_probe.<br> <br> Check that the platform=
 file you&#39;re intending to use matches the compatible<br> field in the r=
oot node of the device tree -- and that said platform file is<br>
 actually being built.<br> <br><br> -Scott<br> </blockquote></div><br>

--001636e1f8f5daf117047a69157d--
