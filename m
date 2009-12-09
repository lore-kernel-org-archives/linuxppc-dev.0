Return-Path: <ajijuni@gmail.com>
MIME-Version: 1.0
Date: Wed, 9 Dec 2009 09:57:37 -0800
Message-ID: <72d214170912090957g3743c63bq48836f6faa4b8269@mail.gmail.com>
Subject: dts file for MPC8343EA - cuImage doesn't boot , but uImage with DTS
	shows serial output
From: Junita Ajith <ajijuni@gmail.com>
To: "Lee, Eric" <eric.lee@hp.com>
Content-Type: multipart/alternative; boundary=000e0cd3289e08fbfa047a4f6d62
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd3289e08fbfa047a4f6d62
Content-Type: text/plain; charset=ISO-8859-1

Hi Eric,

I am building the linux kernel V-2.6.27  based on MPC8349miTXGP dts file.
I am still not able to boot the cuImage.

But, I see serial outuput from kernel when I try to boot with <kernel>
<ramdisk> <dtb file>

Still the kernel hangs after "Dentry cache hash table entries: 32768 (order:
5, 131072 bytes)".

Any clues ..?? We have DDR2 in this board and we are initializing it in
U-Boot.

Please find the screen dump below:

Thanks,
Junita

Screen shot:
===========
u-boot> bootm 0x2000000 0x3000000 0x4000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.27.18-svn52-dirty8
   Created:      2009-12-08  23:49:28 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1416039 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FF9BD48 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFFA6
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
Not skipping initrd
## Loading RAMDisk Image at 03000000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Created:      2009-10-30  20:15:22 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3889103 Bytes =  3.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using the fdt at 0x4000000
## initrd at 0x03000040 ... 0x033B580E (len=3889103=0x3B57CF)
   Loading Ramdisk to 0fbe5000, end 0ff9a7cf ... OK
## device tree at 0x04000000 ... 0x04002FFF (len=12288=0x3000)
   Loading Device Tree to 007fc000, end 007fefff ... OK
Updating property '/soc8349@e0000000/ethernet@24000/mac-address' =  00 e0 0c
001Updating property '/soc8349@e0000000/ethernet@24000/local-mac-address' =
00 e01Updating property 'timebase-frequency' =  03 f9 40 aa
Updating property 'bus-frequency' =  0f e5 02 a8
Updating property 'clock-frequency' =  17 d7 83 fc
Updating property 'bus-frequency' =  0f e5 02 a8
Updating property 'clock-frequency' =  0f e5 02 a8
## Transferring control to Linux (at address 00000000) ...
Using MPC834x ITX machine description
Linux version 2.6.27.18-svn52-dirty8 (root@localhost.localdomain) (gcc
version 9Found initrd at 0xcfbe5000:0xcff9a7cf
console [udbg0] enabled
setup_arch: bootmem
mpc834x_itx_setup_arch()
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs rw nfsroot=192.168.200.230:/nfsroot/rootfs
i0IPIC (128 IRQ sources) at fdffc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)





On 12/9/09, Lee, Eric <eric.lee@hp.com> wrote:
>
> I would probably remove the bcsr region.  this was some cpld I believe on a
> reference board.  with this dts it'll try to write to some hardware
> registers that do not exist or are not mapped to the same area.
>
>
>
>
> -----Original Message-----
> From: linuxppc-dev-bounces+eric.lee=hp.com@lists.ozlabs.org [mailto:
> linuxppc-dev-bounces+eric.lee <linuxppc-dev-bounces%2Beric.lee>=hp.com@
> lists.ozlabs.org] On Behalf Of ajijuni@gmail.com
> Sent: Sunday, December 06, 2009 11:41 PM
> To: Linuxppc-dev@lists.ozlabs.org
> Subject: dts file for MPC8343EA
>
> Hi
>
> We have an MPC8343EA based custom board.
>
> I am not able to get Linux up and running in this. No serial output to
> debug further.
>   U-boot shows correct 'bdinfo' & 'clocks' output.
> inux hangs at machine_probe.
>
>
> I doubt the DTS file in Linux. anyone has DTS file for MPC8343??
>
> u-boot version - 1.3.2
> linux-2.6.27
> The board base files are drived from MPC8349Imtx-GP since we have the
> reference board in which we tested the linux image.
>
> My current DTS file
> /dts-v1/;
>
> / {
>         model = "MPC8343";
>         compatible = "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
>         linux,phandle = <0x100>;
>         #size-cells = <0x1>;
>         #address-cells = <0x1>;
>
>         aliases {
>                 ethernet0 = &enet0;
>                 ethernet1 = &enet1;
>                 serial0 = &serial0;
>                 serial1 = &serial1;
>                 pci0 = &pci0;
>                 pci1 = &pci1;
>         };
>          cpus {
>                 linux,phandle = <0x200>;
>                 #cpus = <0x1>;
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>   PowerPC,8343EA@0 {
>                         device_type = "cpu";
>                         reg = <0x0>;
>                         d-cache-line-size = <20>;
>                         i-cache-line-size = <20>;
>                         d-cache-size = <8000>;
>                         i-cache-size = <8000>;
>                         timebase-frequency = <0>;       // from bootloader
>                         bus-frequency = <0>;            // from bootloader
>                         clock-frequency = <0>;          // from bootloader
>                         32-bit;
>                 };
>         };
>
>
>         memory {
>                 device_type = "memory";
>                 reg = <0x00000000 0x10000000>;  // 256MB at 0
>         };
>
>         bcsr@e2400000 {
>                 device_type = "board-control";
>                 reg = <0xe2400000 0x8000>;
>         };
>         soc8343@e0000000 {
>                 bus-frequency = <0x1>;
>                 reg = <0xe0000000 0x200>;
>                 ranges = <0x0 0xe0000000 0x100000>;
>                 device_type = "soc";
>                 #interrupt-cells = <0x2>;
>                 #size-cells = <0x1>;
>                 #address-cells = <0x1>;
>
>                 wdt@200 {
>                         device_type = "watchdog";
>                         compatible = "mpc83xx_wdt";
>                         reg = <0x200 0x100>;
>                 };
>
> i2c@3000 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <0>;
>                         compatible = "fsl-i2c";
>                         reg = <0x3000 0x100>;
>                         interrupts = <14 0x8>;
>                         interrupt-parent = <&ipic>;
>                         dfsrr;
>
>                         rtc@68 {
>                                 compatible = "dallas,ds1374";
>                                 reg = <0x68>;
>                         };
>                 };
>
>                 i2c@3100 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         cell-index = <1>;
>                         compatible = "fsl-i2c";
>                         reg = <0x3100 0x100>;
>                         interrupts = <15 0x8>;
>                         interrupt-parent = <&ipic>;
>                         dfsrr;
>                 };
>
>                 spi@7000 {
>                         cell-index = <0>;
>                         compatible = "fsl,spi";
>                         reg = <0x7000 0x1000>;
>                         interrupts = <16 0x8>;
>                         interrupt-parent = <&ipic>;
>                         mode = "cpu";
>                 };
>
> dma@82a8 {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
>                         reg = <0x82a8 4>;
>                         ranges = <0 0x8100 0x1a8>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <71 8>;
>                         cell-index = <0>;
>                         dma-channel@0 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@80 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x80 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@100 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x100 0x80>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                         dma-channel@180 {
>                                 compatible = "fsl,mpc8349-dma-channel",
> "fsl,elo-dma-channel";
>                                 reg = <0x180 0x28>;
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <71 8>;
>                         };
>                 };
> /* phy type (ULPI or SERIAL) are only types supported for MPH */
>                 /* port = 0 or 1 */
>                 usb@22000 {
>                         compatible = "fsl-usb2-mph";
>                         reg = <0x22000 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <39 0x8>;
>                         phy_type = "ulpi";
>                         port1;
>                 };
>                 /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
>                 usb@23000 {
>                         compatible = "fsl-usb2-dr";
>                         reg = <0x23000 0x1000>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         interrupt-parent = <&ipic>;
>                         interrupts = <38 0x8>;
>                         dr_mode = "otg";
>                         phy_type = "ulpi";
>                 };
>
>                 mdio@24520 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         compatible = "fsl,gianfar-mdio";
>                         reg = <0x24520 0x20>;
>
>                         phy0: ethernet-phy@0 {
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <17 0x8>;
>                                 reg = <0x0>;
>                                 device_type = "ethernet-phy";
>                         };
>                         phy1: ethernet-phy@1 {
>                                 interrupt-parent = <&ipic>;
>                                 interrupts = <18 0x8>;
>                                 reg = <0x1>;
>                                 device_type = "ethernet-phy";
>                         };
> enet0: ethernet@24000 {
>                         cell-index = <0>;
>                         device_type = "network";
>                         model = "TSEC";
>                         compatible = "gianfar";
>                         reg = <0x24000 0x1000>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <32 0x8 33 0x8 34 0x8>;
>                         interrupt-parent = <&ipic>;
>                         phy-handle = <&phy0>;
>                         linux,network-index = <0>;
>                 };
>
>                 enet1: ethernet@25000 {
>                         cell-index = <1>;
>                         device_type = "network";
>                         model = "TSEC";
>                         compatible = "gianfar";
>                         reg = <0x25000 0x1000>;
>                         local-mac-address = [ 00 00 00 00 00 00 ];
>                         interrupts = <35 0x8 36 0x8 37 0x8>;
>                         interrupt-parent = <&ipic>;
>                         phy-handle = <&phy1>;
>                         linux,network-index = <1>;
>                 };
>
> serial0: serial@4500 {
>                         cell-index = <0>;
>                         device_type = "serial";
>                         compatible = "ns16550";
>                         reg = <0x4500 0x100>;
>                         clock-frequency = <0>;
>                         interrupts = <9 0x8>;
>                         interrupt-parent = <&ipic>;
>                 };
>
>                 serial1: serial@4600 {
>                         cell-index = <1>;
>                         device_type = "serial";
>                         compatible = "ns16550";
>                         reg = <0x4600 0x100>;
>                         clock-frequency = <0>;
>                         interrupts = <10 0x8>;
>                         interrupt-parent = <&ipic>;
>                 };
>
>                 crypto@30000 {
>                         compatible = "fsl,sec2.0";
>                         reg = <0x30000 0x10000>;
>                         interrupts = <11 0x8>;
>                         interrupt-parent = <&ipic>;
>                         fsl,num-channels = <4>;
>                         fsl,channel-fifo-len = <24>;
>                         fsl,exec-units-mask = <0x7e>;
>                         fsl,descriptor-types-mask = <0x01010ebf>;
>                 };
>
> Thanks,
> agnel
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--000e0cd3289e08fbfa047a4f6d62
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGkgRXJpYyw8YnI+Cjxicj4KSSBhbSBidWlsZGluZyB0aGUgbGludXgga2VybmVsIFYtMi42LjI3
oCBiYXNlZCBvbiBNUEM4MzQ5bWlUWEdQIGR0cyBmaWxlLjxicj4KSSBhbSBzdGlsbCBub3QgYWJs
ZSB0byBib290IHRoZSBjdUltYWdlLjxicj4KPGJyPgpCdXQsIEkgc2VlIHNlcmlhbCBvdXR1cHV0
IGZyb20ga2VybmVsIHdoZW4gSSB0cnkgdG8gYm9vdCB3aXRoICZsdDtrZXJuZWwmZ3Q7ICZsdDty
YW1kaXNrJmd0OyAmbHQ7ZHRiIGZpbGUmZ3Q7PGJyPgo8YnI+ClN0aWxsIHRoZSBrZXJuZWwgaGFu
Z3MgYWZ0ZXIgJnF1b3Q7RGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMzI3NjggKG9y
ZGVyOiA1LCAxMzEwNzIgYnl0ZXMpJnF1b3Q7Ljxicj4KPGJyPgpBbnkgY2x1ZXMgLi4/PyBXZSBo
YXZlIEREUjIgaW4gdGhpcyBib2FyZCBhbmQgd2UgYXJlIGluaXRpYWxpemluZyBpdCBpbiBVLUJv
b3QuIDxicj4KPGJyPgpQbGVhc2UgZmluZCB0aGUgc2NyZWVuIGR1bXAgYmVsb3c6PGJyPgo8YnI+
ClRoYW5rcyw8YnI+Ckp1bml0YTxicj4KPGJyPgpTY3JlZW4gc2hvdDo8YnI+Cj09PT09PT09PT09
PGJyPgp1LWJvb3QmZ3Q7IGJvb3RtIDB4MjAwMDAwMCAweDMwMDAwMDAgMHg0MDAwMDAwPGJyPgoj
IyBCb290aW5nIGltYWdlIGF0IDAyMDAwMDAwIC4uLjxicj4KoKAgSW1hZ2UgTmFtZTqgoCBMaW51
eC0yLjYuMjcuMTgtc3ZuNTItZGlydHk4PGJyPgqgoCBDcmVhdGVkOqCgoKCgIDIwMDktMTItMDig
IDIzOjQ5OjI4IFVUQzxicj4KoKAgSW1hZ2UgVHlwZTqgoCBQb3dlclBDIExpbnV4IEtlcm5lbCBJ
bWFnZSAoZ3ppcCBjb21wcmVzc2VkKTxicj4KoKAgRGF0YSBTaXplOqCgoCAxNDE2MDM5IEJ5dGVz
ID2gIDEuNCBNQjxicj4KoKAgTG9hZCBBZGRyZXNzOiAwMDAwMDAwMDxicj4KoKAgRW50cnkgUG9p
bnQ6oCAwMDAwMDAwMDxicj4KoKAgVmVyaWZ5aW5nIENoZWNrc3VtIC4uLiBPSzxicj4KoKAgVW5j
b21wcmVzc2luZyBLZXJuZWwgSW1hZ2UgLi4uIE9LPGJyPgojIyBDdXJyZW50IHN0YWNrIGVuZHMg
YXQgMHgwRkY5QkQ0OCA9Jmd0OyBzZXQgdXBwZXIgbGltaXQgdG8gMHgwMDgwMDAwMDxicj4KIyMg
Y21kbGluZSBhdCAweDAwN0ZGRjAwIC4uLiAweDAwN0ZGRkE2PGJyPgpiZCBhZGRyZXNzoCA9IDB4
MEZGOUJGQzQ8YnI+Cm1lbXN0YXJ0oKCgID0gMHgwMDAwMDAwMDxicj4KbWVtc2l6ZaCgoKAgPSAw
eDEwMDAwMDAwPGJyPgpmbGFzaHN0YXJ0oCA9IDB4RkUwMDAwMDA8YnI+CmZsYXNoc2l6ZaCgID0g
MHgwMDA4MDAwMDxicj4KZmxhc2hvZmZzZXQgPSAweDAwMDM0MDAwPGJyPgpzcmFtc3RhcnSgoCA9
IDB4MDAwMDAwMDA8YnI+CnNyYW1zaXploKCgID0gMHgwMDAwMDAwMDxicj4KYm9vdGZsYWdzoKAg
PSAweDAwMDAwMDAxPGJyPgppbnRmcmVxoKCgoCA9IDM5OS45OTkgTUh6PGJyPgpidXNmcmVxoKCg
oCA9IDI2Ni42NjYgTUh6PGJyPgpldGhhZGRyoKCgoCA9IDAwOkUwOjBDOjAwOjhDOjAxPGJyPgpJ
UCBhZGRyoKCgoCA9IDE5Mi4xNjguMjAxLjE5OTxicj4KYmF1ZHJhdGWgoKAgPSAxMTUyMDAgYnBz
PGJyPgpOb3Qgc2tpcHBpbmcgaW5pdHJkPGJyPgojIyBMb2FkaW5nIFJBTURpc2sgSW1hZ2UgYXQg
MDMwMDAwMDAgLi4uPGJyPgqgoCBJbWFnZSBOYW1lOqCgIHVib290IGV4dDIgcmFtZGlzayByb290
ZnM8YnI+CqCgIENyZWF0ZWQ6oKCgoKAgMjAwOS0xMC0zMKAgMjA6MTU6MjIgVVRDPGJyPgqgoCBJ
bWFnZSBUeXBlOqCgIFBvd2VyUEMgTGludXggUkFNRGlzayBJbWFnZSAoZ3ppcCBjb21wcmVzc2Vk
KTxicj4KoKAgRGF0YSBTaXplOqCgoCAzODg5MTAzIEJ5dGVzID2gIDMuNyBNQjxicj4KoKAgTG9h
ZCBBZGRyZXNzOiAwMDAwMDAwMDxicj4KoKAgRW50cnkgUG9pbnQ6oCAwMDAwMDAwMDxicj4KoKAg
VmVyaWZ5aW5nIENoZWNrc3VtIC4uLiBPSzxicj4KoKAgQm9vdGluZyB1c2luZyB0aGUgZmR0IGF0
IDB4NDAwMDAwMDxicj4KIyMgaW5pdHJkIGF0IDB4MDMwMDAwNDAgLi4uIDB4MDMzQjU4MEUgKGxl
bj0zODg5MTAzPTB4M0I1N0NGKTxicj4KoKAgTG9hZGluZyBSYW1kaXNrIHRvIDBmYmU1MDAwLCBl
bmQgMGZmOWE3Y2YgLi4uIE9LPGJyPgojIyBkZXZpY2UgdHJlZSBhdCAweDA0MDAwMDAwIC4uLiAw
eDA0MDAyRkZGIChsZW49MTIyODg9MHgzMDAwKTxicj4KoKAgTG9hZGluZyBEZXZpY2UgVHJlZSB0
byAwMDdmYzAwMCwgZW5kIDAwN2ZlZmZmIC4uLiBPSzxicj4KVXBkYXRpbmcgcHJvcGVydHkgJiMz
OTsvc29jODM0OUBlMDAwMDAwMC9ldGhlcm5ldEAyNDAwMC9tYWMtYWRkcmVzcyYjMzk7Cj2gIDAw
IGUwIDBjIDAwMVVwZGF0aW5nIHByb3BlcnR5CiYjMzk7L3NvYzgzNDlAZTAwMDAwMDAvZXRoZXJu
ZXRAMjQwMDAvbG9jYWwtbWFjLWFkZHJlc3MmIzM5OyA9oCAwMAplMDFVcGRhdGluZyBwcm9wZXJ0
eSAmIzM5O3RpbWViYXNlLWZyZXF1ZW5jeSYjMzk7ID2gIDAzIGY5IDQwIGFhPGJyPgpVcGRhdGlu
ZyBwcm9wZXJ0eSAmIzM5O2J1cy1mcmVxdWVuY3kmIzM5OyA9oCAwZiBlNSAwMiBhODxicj4KVXBk
YXRpbmcgcHJvcGVydHkgJiMzOTtjbG9jay1mcmVxdWVuY3kmIzM5OyA9oCAxNyBkNyA4MyBmYzxi
cj4KVXBkYXRpbmcgcHJvcGVydHkgJiMzOTtidXMtZnJlcXVlbmN5JiMzOTsgPaAgMGYgZTUgMDIg
YTg8YnI+ClVwZGF0aW5nIHByb3BlcnR5ICYjMzk7Y2xvY2stZnJlcXVlbmN5JiMzOTsgPaAgMGYg
ZTUgMDIgYTg8YnI+CiMjIFRyYW5zZmVycmluZyBjb250cm9sIHRvIExpbnV4IChhdCBhZGRyZXNz
IDAwMDAwMDAwKSAuLi48YnI+ClVzaW5nIE1QQzgzNHggSVRYIG1hY2hpbmUgZGVzY3JpcHRpb248
YnI+CkxpbnV4IHZlcnNpb24gMi42LjI3LjE4LXN2bjUyLWRpcnR5OCAocm9vdEBsb2NhbGhvc3Qu
bG9jYWxkb21haW4pIChnY2MgdmVyc2lvbiA5Rm91bmQgaW5pdHJkIGF0IDB4Y2ZiZTUwMDA6MHhj
ZmY5YTdjZjxicj4KY29uc29sZSBbdWRiZzBdIGVuYWJsZWQ8YnI+CnNldHVwX2FyY2g6IGJvb3Rt
ZW08YnI+Cm1wYzgzNHhfaXR4X3NldHVwX2FyY2goKTxicj4KYXJjaDogZXhpdDxicj4KWm9uZSBQ
Rk4gcmFuZ2VzOjxicj4KoCBETUGgoKCgoCAweDAwMDAwMDAwIC0mZ3Q7IDB4MDAwMTAwMDA8YnI+
CqAgTm9ybWFsoKAgMHgwMDAxMDAwMCAtJmd0OyAweDAwMDEwMDAwPGJyPgpNb3ZhYmxlIHpvbmUg
c3RhcnQgUEZOIGZvciBlYWNoIG5vZGU8YnI+CmVhcmx5X25vZGVfbWFwWzFdIGFjdGl2ZSBQRk4g
cmFuZ2VzPGJyPgqgoKAgMDogMHgwMDAwMDAwMCAtJmd0OyAweDAwMDEwMDAwPGJyPgpCdWlsdCAx
IHpvbmVsaXN0cyBpbiBab25lIG9yZGVyLCBtb2JpbGl0eSBncm91cGluZyBvbi6gIFRvdGFsIHBh
Z2VzOiA2NTAyNDxicj4KS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L25mcyBydyBuZnNy
b290PTE5Mi4xNjguMjAwLjIzMDovbmZzcm9vdC9yb290ZnMgaTBJUElDICgxMjggSVJRIHNvdXJj
ZXMpIGF0IGZkZmZjNzAwPGJyPgpQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjog
MTAsIDQwOTYgYnl0ZXMpPGJyPgpjbG9ja3NvdXJjZTogdGltZWJhc2UgbXVsdFszYzAwMDAxXSBz
aGlmdFsyMl0gcmVnaXN0ZXJlZDxicj4KRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
MzI3NjggKG9yZGVyOiA1LCAxMzEwNzIgYnl0ZXMpPGJyPgo8YnI+Cjxicj4KPGJyPgo8YnI+PGJy
PjxkaXY+PHNwYW4gY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiAxMi85LzA5LCA8YiBjbGFzcz0iZ21h
aWxfc2VuZGVybmFtZSI+TGVlLCBFcmljPC9iPiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmVyaWMubGVl
QGhwLmNvbSI+ZXJpYy5sZWVAaHAuY29tPC9hPiZndDsgd3JvdGU6PC9zcGFuPjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9ImJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIw
NCwgMjA0LCAyMDQpOyBtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBwYWRkaW5nLWxlZnQ6IDFl
eDsiPgpJCndvdWxkIHByb2JhYmx5IHJlbW92ZSB0aGUgYmNzciByZWdpb24uoKB0aGlzIHdhcyBz
b21lIGNwbGQgSQpiZWxpZXZlIG9uIGEgcmVmZXJlbmNlIGJvYXJkLqCgd2l0aCB0aGlzIGR0cyBp
dCYjMzk7bGwgdHJ5IHRvCndyaXRlIHRvIHNvbWUgaGFyZHdhcmUgcmVnaXN0ZXJzIHRoYXQgZG8g
bm90IGV4aXN0IG9yIGFyZSBub3QgbWFwcGVkIHRvCnRoZSBzYW1lIGFyZWEuPGJyPiA8YnI+PGJy
PiA8YnI+IDxicj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS08YnI+IEZyb206IGxpbnV4cHBj
LWRldi1ib3VuY2VzK2VyaWMubGVlPTxhIGhyZWY9Imh0dHA6Ly9ocC5jb20iPmhwLmNvbTwvYT5A
PGEgaHJlZj0iaHR0cDovL2xpc3RzLm96bGFicy5vcmciPmxpc3RzLm96bGFicy5vcmc8L2E+IFtt
YWlsdG86PGEgaHJlZj0ibWFpbHRvOmxpbnV4cHBjLWRldi1ib3VuY2VzJTJCZXJpYy5sZWUiPmxp
bnV4cHBjLWRldi1ib3VuY2VzK2VyaWMubGVlPC9hPj08YSBocmVmPSJodHRwOi8vaHAuY29tIj5o
cC5jb208L2E+QDxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vemxhYnMub3JnIj5saXN0cy5vemxhYnMu
b3JnPC9hPl0gT24gQmVoYWxmIE9mIDxhIGhyZWY9Im1haWx0bzphamlqdW5pQGdtYWlsLmNvbSI+
YWppanVuaUBnbWFpbC5jb208L2E+PGJyPgogU2VudDogU3VuZGF5LCBEZWNlbWJlciAwNiwgMjAw
OSAxMTo0MSBQTTxicj4gVG86IDxhIGhyZWY9Im1haWx0bzpMaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZyI+TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc8L2E+PGJyPiBTdWJqZWN0OiBk
dHMgZmlsZSBmb3IgTVBDODM0M0VBPGJyPiA8YnI+IEhpPGJyPiA8YnI+IFdlIGhhdmUgYW4gTVBD
ODM0M0VBIGJhc2VkIGN1c3RvbSBib2FyZC48YnI+CiA8YnI+IEkgYW0gbm90IGFibGUgdG8gZ2V0
IExpbnV4IHVwIGFuZCBydW5uaW5nIGluIHRoaXMuIE5vIHNlcmlhbCBvdXRwdXQgdG8gZGVidWcg
ZnVydGhlci48YnI+oKBVLWJvb3Qgc2hvd3MgY29ycmVjdCAmIzM5O2JkaW5mbyYjMzk7ICZhbXA7
ICYjMzk7Y2xvY2tzJiMzOTsgb3V0cHV0Ljxicj4gaW51eCBoYW5ncyBhdCBtYWNoaW5lX3Byb2Jl
Ljxicj4gPGJyPiA8YnI+SSBkb3VidCB0aGUgRFRTIGZpbGUgaW4gTGludXguIGFueW9uZSBoYXMg
RFRTIGZpbGUgZm9yIE1QQzgzNDM/Pzxicj4KIDxicj4gdS1ib290IHZlcnNpb24gLSAxLjMuMjxi
cj4gbGludXgtMi42LjI3PGJyPiBUaGUgYm9hcmQgYmFzZSBmaWxlcyBhcmUgZHJpdmVkIGZyb20g
TVBDODM0OUltdHgtR1Agc2luY2Ugd2UgaGF2ZSB0aGUgcmVmZXJlbmNlIGJvYXJkIGluIHdoaWNo
IHdlIHRlc3RlZCB0aGUgbGludXggaW1hZ2UuPGJyPiA8YnI+IE15IGN1cnJlbnQgRFRTIGZpbGU8
YnI+IC9kdHMtdjEvOzxicj4gPGJyPgogLyB7PGJyPqCgoKCgoKCgbW9kZWwgPSAmcXVvdDtNUEM4
MzQzJnF1b3Q7Ozxicj6goKCgoKCgoGNvbXBhdGlibGUgPSAmcXVvdDtNUEM4MzQ5RU1EUyZxdW90
OywgJnF1b3Q7TVBDODM0eE1EUyZxdW90OywgJnF1b3Q7TVBDODN4eE1EUyZxdW90Ozs8YnI+oKCg
oKCgoKBsaW51eCxwaGFuZGxlID0gJmx0OzB4MTAwJmd0Ozs8YnI+oKCgoKCgoKAjc2l6ZS1jZWxs
cyA9ICZsdDsweDEmZ3Q7Ozxicj4KoKCgoKCgoKAjYWRkcmVzcy1jZWxscyA9ICZsdDsweDEmZ3Q7
Ozxicj4gPGJyPqCgoKCgoKCgYWxpYXNlcyB7PGJyPqCgoKCgoKCgoKCgoKCgoKBldGhlcm5ldDAg
PSAmYW1wO2VuZXQwOzxicj6goKCgoKCgoKCgoKCgoKCgZXRoZXJuZXQxID0gJmFtcDtlbmV0MTs8
YnI+oKCgoKCgoKCgoKCgoKCgoHNlcmlhbDAgPSAmYW1wO3NlcmlhbDA7PGJyPqCgoKCgoKCgoKCg
oKCgoKBzZXJpYWwxID0gJmFtcDtzZXJpYWwxOzxicj4KoKCgoKCgoKCgoKCgoKCgoHBjaTAgPSAm
YW1wO3BjaTA7PGJyPqCgoKCgoKCgoKCgoKCgoKBwY2kxID0gJmFtcDtwY2kxOzxicj6goKCgoKCg
oH07PGJyPqCgoKCgoKCgIGNwdXMgezxicj6goKCgoKCgoKCgoKCgoKCgbGludXgscGhhbmRsZSA9
ICZsdDsweDIwMCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKAjY3B1cyA9ICZsdDsweDEmZ3Q7Ozxi
cj6goKCgoKCgoKCgoKCgoKCgI2FkZHJlc3MtY2VsbHMgPSAmbHQ7MSZndDs7PGJyPgqgoKCgoKCg
oKCgoKCgoKCgI3NpemUtY2VsbHMgPSAmbHQ7MCZndDs7PGJyPiA8YnI+oKBQb3dlclBDLDgzNDNF
QUAwIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZGV2aWNlX3R5cGUKPSAmcXVvdDtjcHUm
cXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDAmZ3Q7Ozxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkLWNhY2hlLWxpbmUtc2l6ZQo9ICZsdDsyMCZndDs7PGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGktY2FjaGUtbGluZS1zaXplCj0gJmx0OzIwJmd0Ozs8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZC1jYWNoZS1zaXplCj0gJmx0OzgwMDAmZ3Q7Ozxi
cj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpLWNhY2hlLXNpemUKPSAmbHQ7ODAwMCZndDs7PGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHRpbWViYXNlLWZyZXF1ZW5jeQo9ICZsdDswJmd0Ozug
oKCgoKAgLy8gZnJvbSBib290bG9hZGVyPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGJ1cy1m
cmVxdWVuY3kKPQombHQ7MCZndDs7oKCgoKCgoKCgoKCgLy8KZnJvbSBib290bG9hZGVyPGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNsb2NrLWZyZXF1ZW5jeQo9CiZsdDswJmd0OzugoKCgoKCg
oKCgLy8KZnJvbSBib290bG9hZGVyPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoDMyLWJpdDs8
YnI+oKCgoKCgoKCgoKCgoKCgoH07PGJyPqCgoKCgoKCgfTs8YnI+IDxicj4gPGJyPqCgoKCgoKCg
bWVtb3J5IHs8YnI+oKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlID0gJnF1b3Q7bWVtb3J5JnF1
b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MDAwMDAwMDAgMHgxMDAwMDAwMCZn
dDs7oKAvLyAyNTZNQiBhdCAwPGJyPqCgoKCgoKCgfTs8YnI+IDxicj6goKCgoKCgoGJjc3JAZTI0
MDAwMDAgezxicj6goKCgoKCgoKCgoKCgoKCgZGV2aWNlX3R5cGUgPSAmcXVvdDtib2FyZC1jb250
cm9sJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgcmVnID0gJmx0OzB4ZTI0MDAwMDAgMHg4MDAw
Jmd0Ozs8YnI+oKCgoKCgoKB9Ozxicj4KoKCgoKCgoKBzb2M4MzQzQGUwMDAwMDAwIHs8YnI+oKCg
oKCgoKCgoKCgoKCgoGJ1cy1mcmVxdWVuY3kgPSAmbHQ7MHgxJmd0Ozs8YnI+oKCgoKCgoKCgoKCg
oKCgoHJlZyA9ICZsdDsweGUwMDAwMDAwIDB4MjAwJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoHJh
bmdlcwo9ICZsdDsweDAgMHhlMDAwMDAwMCAweDEwMDAwMCZndDs7PGJyPqCgoKCgoKCgoKCgoKCg
oKBkZXZpY2VfdHlwZSA9ICZxdW90O3NvYyZxdW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoCNpbnRl
cnJ1cHQtY2VsbHMgPSAmbHQ7MHgyJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoCNzaXplLWNlbGxz
ID0gJmx0OzB4MSZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKAjYWRkcmVzcy1jZWxscyA9ICZsdDsw
eDEmZ3Q7Ozxicj4KIDxicj6goKCgoKCgoKCgoKCgoKCgd2R0QDIwMCB7PGJyPqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7d2F0Y2hkb2cmcXVvdDs7PGJyPqCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDttcGM4M3h4X3dkdCZxdW90Ozs8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MjAwIDB4MTAwJmd0Ozs8YnI+
oKCgoKCgoKCgoKCgoKCgoH07PGJyPiA8YnI+IGkyY0AzMDAwIHs8YnI+oKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgI2FkZHJlc3MtY2VsbHMKPSAmbHQ7MSZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCNzaXplLWNlbGxzCj0gJmx0OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBjZWxsLWluZGV4Cj0gJmx0OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21w
YXRpYmxlCj0gJnF1b3Q7ZnNsLWkyYyZxdW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
cmVnCj0gJmx0OzB4MzAwMCAweDEwMCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGlu
dGVycnVwdHMKPSAmbHQ7MTQgMHg4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50
ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBkZnNycjs8YnI+IDxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBydGNANjgKezxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDtkYWxsYXMs
ZHMxMzc0JnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZs
dDsweDY4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgfTs8YnI+oKCgoKCgoKCgoKCg
oKCgoH07PGJyPiA8YnI+oKCgoKCgoKCgoKCgoKCgoGkyY0AzMTAwIHs8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgI2FkZHJlc3MtY2VsbHMKPSAmbHQ7MSZndDs7PGJyPqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCNzaXplLWNlbGxzCj0gJmx0OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBjZWxsLWluZGV4Cj0gJmx0OzEmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBj
b21wYXRpYmxlCj0gJnF1b3Q7ZnNsLWkyYyZxdW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgcmVnCj0gJmx0OzB4MzEwMCAweDEwMCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oGludGVycnVwdHMKPSAmbHQ7MTUgMHg4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
aW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKBkZnNycjs8YnI+oKCgoKCgoKCgoKCgoKCgoH07PGJyPiA8YnI+oKCgoKCgoKCgoKCg
oKCgoHNwaUA3MDAwIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY2VsbC1pbmRleAo9ICZs
dDswJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2Zz
bCxzcGkmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDcwMDAg
MHgxMDAwJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDsx
NiAweDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0g
Jmx0OyZhbXA7aXBpYyZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoG1vZGUKPSAmcXVv
dDtjcHUmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKB9Ozxicj4gPGJyPiBkbWFAODJhOCB7PGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNhZGRyZXNzLWNlbGxzCj0gJmx0OzEmZ3Q7Ozxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjc2l6ZS1jZWxscwo9ICZsdDsxJmd0Ozs8YnI+oKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbCxtcGM4MzQ5LWRtYSZxdW90
OywgJnF1b3Q7ZnNsLGVsby1kbWEmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJl
Zwo9ICZsdDsweDgyYTggNCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJhbmdlcwo9
ICZsdDswIDB4ODEwMCAweDFhOCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVy
cnVwdC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgaW50ZXJydXB0cwo9ICZsdDs3MSA4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
Y2VsbC1pbmRleAo9ICZsdDswJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZG1hLWNo
YW5uZWxAMAp7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9
ICZxdW90O2ZzbCxtcGM4MzQ5LWRtYS1jaGFubmVsJnF1b3Q7LCAmcXVvdDtmc2wsZWxvLWRtYS1j
aGFubmVsJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZs
dDswIDB4ODAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVw
dC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKBpbnRlcnJ1cHRzCj0gJmx0OzcxIDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKB9Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkbWEtY2hhbm5lbEA4MAp7PGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbCxtcGM4
MzQ5LWRtYS1jaGFubmVsJnF1b3Q7LCAmcXVvdDtmc2wsZWxvLWRtYS1jaGFubmVsJnF1b3Q7Ozxi
cj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDgwIDB4ODAmZ3Q7
Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdC1wYXJlbnQKPSAm
bHQ7JmFtcDtpcGljJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRl
cnJ1cHRzCj0gJmx0OzcxIDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKB9Ozxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkbWEtY2hhbm5lbEAxMDAKezxicj6goKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVvdDtmc2wsbXBjODM0OS1kbWEtY2hh
bm5lbCZxdW90OywgJnF1b3Q7ZnNsLGVsby1kbWEtY2hhbm5lbCZxdW90Ozs8YnI+oKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHgxMDAgMHg4MCZndDs7PGJyPqCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lw
aWMmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAm
bHQ7NzEgOCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoH07PGJyPqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoGRtYS1jaGFubmVsQDE4MAp7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbCxtcGM4MzQ5LWRtYS1jaGFubmVsJnF1b3Q7
LCAmcXVvdDtmc2wsZWxvLWRtYS1jaGFubmVsJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDE4MCAweDI4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDs3MSA4Jmd0
Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgfTs8YnI+oKCgoKCgoKCgoKCgoKCgoH07PGJy
PiAvKiBwaHkgdHlwZSAoVUxQSSBvciBTRVJJQUwpIGFyZSBvbmx5IHR5cGVzIHN1cHBvcnRlZCBm
b3IgTVBIICovPGJyPqCgoKCgoKCgoKCgoKCgoKAvKiBwb3J0ID0gMCBvciAxICovPGJyPqCgoKCg
oKCgoKCgoKCgoKB1c2JAMjIwMDAgezxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRp
YmxlCj0gJnF1b3Q7ZnNsLXVzYjItbXBoJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKByZWcKPSAmbHQ7MHgyMjAwMCAweDEwMDAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAjYWRkcmVzcy1jZWxscwo9ICZsdDsxJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
I3NpemUtY2VsbHMKPSAmbHQ7MCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVy
cnVwdC1wYXJlbnQKPSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgaW50ZXJydXB0cwo9ICZsdDszOSAweDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBwaHlfdHlwZQo9ICZxdW90O3VscGkmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oHBvcnQxOzxicj6goKCgoKCgoKCgoKCgoKCgfTs8YnI+oKCgoKCgoKCgoKCgoKCgoC8qCnBoeSB0
eXBlIChVTFBJLCBVVE1JLCBVVE1JX1dJREUsIFNFUklBTCkgKi88YnI+oKCgoKCgoKCgoKCgoKCg
oHVzYkAyMzAwMCB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNvbXBhdGlibGUKPSAmcXVv
dDtmc2wtdXNiMi1kciZxdW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0
OzB4MjMwMDAgMHgxMDAwJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgI2FkZHJlc3Mt
Y2VsbHMKPSAmbHQ7MSZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNzaXplLWNlbGxz
Cj0gJmx0OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHQtcGFyZW50
Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVw
dHMKPSAmbHQ7MzggMHg4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZHJfbW9kZQo9
ICZxdW90O290ZyZxdW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcGh5X3R5cGUKPSAm
cXVvdDt1bHBpJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgfTs8YnI+IDxicj6goKCgoKCgoKCg
oKCgoKCgbWRpb0AyNDUyMCB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCNhZGRyZXNzLWNl
bGxzCj0gJmx0OzEmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAjc2l6ZS1jZWxscwo9
ICZsdDswJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90
O2ZzbCxnaWFuZmFyLW1kaW8mcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9
ICZsdDsweDI0NTIwIDB4MjAmZ3Q7Ozxicj4gPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHBo
eTA6CmV0aGVybmV0LXBoeUAwIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBp
bnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0cwo9ICZsdDsxNyAweDgmZ3Q7Ozxicj6goKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7ZXRoZXJuZXQtcGh5JnF1b3Q7
Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKB9Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBwaHkxOgpldGhlcm5ldC1waHlAMSB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgaW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj6goKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTggMHg4Jmd0Ozs8YnI+oKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZWcKPSAmbHQ7MHgxJmd0Ozs8YnI+oKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZxdW90O2V0aGVybmV0LXBoeSZx
dW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgfTs8YnI+IGVuZXQwOiBldGhlcm5ldEAy
NDAwMCB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNlbGwtaW5kZXgKPSAmbHQ7MCZndDs7
PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7bmV0d29yayZx
dW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgbW9kZWwKPSAmcXVvdDtUU0VDJnF1b3Q7
Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0gJnF1b3Q7Z2lhbmZhciZx
dW90Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MjQwMDAgMHgxMDAw
Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgbG9jYWwtbWFjLWFkZHJlc3MKPSBbIDAw
IDAwIDAwIDAwIDAwIDAwIF07PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMK
PSAmbHQ7MzIgMHg4IDMzIDB4OCAzNCAweDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBpbnRlcnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoHBoeS1oYW5kbGUKPSAmbHQ7JmFtcDtwaHkwJmd0Ozs8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgbGludXgsbmV0d29yay1pbmRleAo9ICZsdDswJmd0Ozs8YnI+oKCgoKCgoKCg
oKCgoKCgoH07PGJyPiA8YnI+oKCgoKCgoKCgoKCgoKCgoGVuZXQxOiBldGhlcm5ldEAyNTAwMCB7
PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGNlbGwtaW5kZXgKPSAmbHQ7MSZndDs7PGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGRldmljZV90eXBlCj0gJnF1b3Q7bmV0d29yayZxdW90Ozs8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgbW9kZWwKPSAmcXVvdDtUU0VDJnF1b3Q7Ozxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjb21wYXRpYmxlCj0gJnF1b3Q7Z2lhbmZhciZxdW90Ozs8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgcmVnCj0gJmx0OzB4MjUwMDAgMHgxMDAwJmd0Ozs8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgbG9jYWwtbWFjLWFkZHJlc3MKPSBbIDAwIDAwIDAw
IDAwIDAwIDAwIF07PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7
MzUgMHg4IDM2IDB4OCAzNyAweDgmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRl
cnJ1cHQtcGFyZW50Cj0gJmx0OyZhbXA7aXBpYyZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoHBoeS1oYW5kbGUKPSAmbHQ7JmFtcDtwaHkxJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgbGludXgsbmV0d29yay1pbmRleAo9ICZsdDsxJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCg
oH07PGJyPiA8YnI+IHNlcmlhbDA6IHNlcmlhbEA0NTAwIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgY2VsbC1pbmRleAo9ICZsdDswJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
ZGV2aWNlX3R5cGUKPSAmcXVvdDtzZXJpYWwmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoGNvbXBhdGlibGUKPSAmcXVvdDtuczE2NTUwJnF1b3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKByZWcKPSAmbHQ7MHg0NTAwIDB4MTAwJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgY2xvY2stZnJlcXVlbmN5Cj0gJmx0OzAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBpbnRlcnJ1cHRzCj0gJmx0OzkgMHg4Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgaW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7Ozxicj6goKCgoKCgoKCgoKCg
oKCgfTs8YnI+IDxicj6goKCgoKCgoKCgoKCgoKCgc2VyaWFsMTogc2VyaWFsQDQ2MDAgezxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjZWxsLWluZGV4Cj0gJmx0OzEmZ3Q7Ozxicj6goKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKBkZXZpY2VfdHlwZQo9ICZxdW90O3NlcmlhbCZxdW90Ozs8YnI+oKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O25zMTY1NTAmcXVvdDs7PGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDQ2MDAgMHgxMDAmZ3Q7Ozxicj6g
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBjbG9jay1mcmVxdWVuY3kKPSAmbHQ7MCZndDs7PGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdHMKPSAmbHQ7MTAgMHg4Jmd0Ozs8YnI+oKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgaW50ZXJydXB0LXBhcmVudAo9ICZsdDsmYW1wO2lwaWMmZ3Q7
Ozxicj6goKCgoKCgoKCgoKCgoKCgfTs8YnI+IDxicj6goKCgoKCgoKCgoKCgoKCgY3J5cHRvQDMw
MDAwIHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgY29tcGF0aWJsZQo9ICZxdW90O2ZzbCxz
ZWMyLjAmcXVvdDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHJlZwo9ICZsdDsweDMwMDAw
IDB4MTAwMDAmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpbnRlcnJ1cHRzCj0gJmx0
OzExIDB4OCZndDs7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGludGVycnVwdC1wYXJlbnQK
PSAmbHQ7JmFtcDtpcGljJmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZnNsLG51bS1j
aGFubmVscwo9ICZsdDs0Jmd0Ozs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZnNsLGNoYW5u
ZWwtZmlmby1sZW4KPSAmbHQ7MjQmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBmc2ws
ZXhlYy11bml0cy1tYXNrCj0gJmx0OzB4N2UmZ3Q7Ozxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBmc2wsZGVzY3JpcHRvci10eXBlcy1tYXNrCj0gJmx0OzB4MDEwMTBlYmYmZ3Q7Ozxicj6goKCg
oKCgoKCgoKCgoKCgfTs8YnI+IDxicj4gVGhhbmtzLDxicj4gYWduZWw8YnI+IDxicj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+IExpbnV4cHBjLWRl
diBtYWlsaW5nIGxpc3Q8YnI+IDxhIGhyZWY9Im1haWx0bzpMaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZyI+TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc8L2E+PGJyPgogPGEgaHJlZj0i
aHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldiI+aHR0cHM6Ly9s
aXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldjwvYT48YnI+IDwvYmxvY2txdW90
ZT48L2Rpdj48YnI+Cg==
--000e0cd3289e08fbfa047a4f6d62--
