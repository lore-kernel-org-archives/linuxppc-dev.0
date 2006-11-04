Return-Path: <rdcorle@yahoo.com>
Received: from web56301.mail.re3.yahoo.com (web56301.mail.re3.yahoo.com
	[216.252.110.225]) by ozlabs.org (Postfix) with SMTP id 44F7967B5B
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:02:30 +1100 (EST)
Message-ID: <20061104150210.7507.qmail@web56301.mail.re3.yahoo.com>
Date: Sat, 4 Nov 2006 07:02:09 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: Pradeep Sampath <pradeepsampath@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1342000333-1162652529=:6320"
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1342000333-1162652529=:6320
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Pradeep;=0A=0ABooting with a ramdisk is a matter of putting the appropriate=
 image in the arch/ppc/boot/images directory (I obtained mine from the gsrd=
 design files), adding the root=3D/dev/ram rw on the command-line boot opti=
ons, making the .config changes for ram disk support and initrd usage, and =
issuing a make zImage.initrd command.=0A=0ABeware when upgrading to 2.6.18.=
1 as you may have difficulties with the adapter.c you obtained previously. =
 The adapter.c in EDK 8.2 is not as easy to find.  Using the EDK to generat=
e software components for linux will not expose the proper adapter.c.  I ha=
d to use the path that Rick Moleres posted earlier to retrieve the adapter.=
c which I used for 2.6.18.1 and in my notes.=0A=0A-cy=0A=0A----- Original M=
essage ----=0AFrom: Pradeep Sampath <pradeepsampath@yahoo.com>=0ATo: robert=
 corley <rdcorle@yahoo.com>=0ASent: Thursday, November 2, 2006 7:57:25 PM=
=0ASubject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1=
=0A=0AThis is great! I played around for a while with the Sysace CF driver =
patches and got it to work. Since you are booting with ramdisk image would =
you be kind enough to add more text on how to do that? I see that you are u=
sing UART Lite? Does it require any special setting for the boot logs to sh=
ow up on the standard hyperterminal. =0A   =0A  I am planning on rebuilding=
 the whole system using EDK 8.2 and linux kernel 2.6.18.1.=0A   =0A  -Prade=
ep=0A=0Arobert corley <rdcorle@yahoo.com> wrote:=0A  For those interested, =
I have acheived some measure of success with the plb_temac driver.=0A=0AI h=
ave attached a txt file of what I had to do to get it working under 2.6.18.=
1=0A=0AI am using the plb_temac in DMA mode 3=0A=0ABelow you will see the b=
oot dump.=0A=0AFor those able to help, can=0A anyone provide insight as to =
the failure of setting PHY link speed?=0A=0A-cy=0A=0A=0A=0A=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A---------------------------=
-------------------------------------------=0A2.6.18.1 kernel with all patc=
hes=0A11/02/2006 15:30=0Aplb_temac v3.00a=0Ahard_temac v3.00b=0A=0A=0Aloade=
d at: 00400000 009F1138=0Aboard data at: 009EF120 009EF138=0Arelocated to: =
004040B4 004040CC=0Azimage at: 00404EC7 0057C1F2=0Ainitrd at: 0057D000 009E=
E6FE=0Aavail ram: 009F2000 04000000=0A=0A=0ALinux/PPC load: console=3DttyUL=
0 single ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: r=
amdisk_size=3D4660000 root=3D/dev/ram rw=0A=0AUncompressing Linux...done.=
=0A=0ANow booting the kernel=0A=0A[ 0.000000] Linux version 2.6.18.1 (rdcor=
le@athena) (gcc version 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006=0A[ 0.000000]=
 Xilinx ML403 Reference System (Virtex-4 FX)=0A[ 0.000000] Built 1 zonelist=
s. Total pages: 16384=0A[ 0.000000] Kernel command line: console=3DttyUL0 s=
ingle=0A ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: r=
amdisk_size=3D4660000 root=3D/dev/ram rw=0A[ 0.000000] Xilinx INTC #0 at 0x=
D1000FC0 mapped to 0xFDFFFFC0=0A[ 0.000000] PID hash table entries: 512 (or=
der: 9, 2048 bytes)=0A[ 0.000158] Console: colour dummy device 80x25=0A[ 0.=
000568] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)=0A[ 0=
.001277] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A[ 0=
.012895] Memory: 57060k available (2548k kernel code, 640k data, 96k init, =
0k highmem)=0A[ 0.104378] Mount-cache hash table entries: 512=0A[ 0.106721]=
 checking if image is initramfs...it isn't (no cpio magic); looks like an i=
nitrd=0A[ 2.414242] Freeing initrd memory: 4549k freed=0A[ 2.418712] NET: R=
egistered protocol family 16=0A[ 2.427313] NET: Registered protocol family =
2=0A[ 2.464244] IP route cache hash table entries: 512 (order: -1, 2048 byt=
es)=0A[ 2.465037] TCP established hash table entries: 2048 (order: 1, 8192 =
bytes)=0A[=0A 2.465205] TCP bind hash table entries: 1024 (order: 0, 4096 b=
ytes)=0A[ 2.465296] TCP: Hash tables configured (established 2048 bind 1024=
)=0A[ 2.465324] TCP reno registered=0A[ 2.474633] NTFS driver 2.1.27 [Flags=
: R/O].=0A[ 2.475046] JFS: nTxBlock =3D 481, nTxLock =3D 3854=0A[ 2.477623]=
 SGI XFS with no debug enabled=0A[ 2.479001] io scheduler noop registered=
=0A[ 2.479109] io scheduler anticipatory registered=0A[ 2.479197] io schedu=
ler deadline registered=0A[ 2.479402] io scheduler cfq registered (default)=
=0A[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D 1) is a uartl=
ite=0A[ 2.691029] RAMDISK driver initialized: 16 RAM disks of 4660000K size=
 1024 blocksize=0A[ 2.703933] loop: loaded (max 8 devices)=0A[ 2.709698] XT=
emac: using sgDMA mode.=0A[ 2.713493] XTemac: using TxDRE mode=0A[ 2.717081=
] XTemac: using RxDRE mode=0A[ 2.720678] XTemac: buffer descriptor size: 32=
768 (0x8000)=0A[ 2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, =
virt: 0xff100000,=0A size: 0x8000=0A[ 2.741073] eth0: Xilinx TEMAC #0 at 0x=
60000000 mapped to 0xC5050000, irq=3D0=0A[ 2.748080] eth0: XTemac id 1.0f, =
block id 5, type 8=0A[ 2.753636] mice: PS/2 mouse device common for all mic=
e=0A[ 2.759529] TCP bic registered=0A[ 3.264317] eth0: XTemac: Options: 0xb=
8f2=0A[ 15.227339] eth0: XTemac: Not able to set the speed to 1000 (status:=
 0x148)=0A[ 25.200394] eth0: XTemac: Not able to set the speed to 100 (stat=
us: 0x148)=0A[ 35.173357] eth0: XTemac: Not able to set the speed to 10 (st=
atus: 0x148)=0A[ 35.180122] eth0: XTemac: could not negotiate speed=0A[ 35.=
187740] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =3D 2=0A[ 35=
.194116] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =3D 1=0A[ =
36.205399] IP-Config: Complete:=0A[ 36.208459] device=3Deth0, addr=3D192.16=
8.1.100, mask=3D255.255.255.0, gw=3D192.168.1.1,=0A[ 36.216339] host=3Dnab,=
 domain=3D, nis-domain=3D(none),=0A[ 36.221487] bootserver=3D192.168.1.144,=
 rootserver=3D192.168.1.144, rootpath=3D=0A[=0A 36.229826] RAMDISK: Compres=
sed image found at block 0=0A[ 37.200498] eth0: XTemac: PHY Link carrier lo=
st.=0A[ 39.097820] VFS: Mounted root (ext2 filesystem).=0A[ 39.102751] Free=
ing unused kernel memory: 96k init=0A[ 39.108356] ulite_startup: UART statu=
s =3D 0x0014=0A[ 39.124619] ulite_startup: UART status =3D 0x0014=0A[ 39.13=
4313] ulite_startup: UART status =3D 0x0014=0A=0A=0ABusyBox v1.00-pre9 (200=
4.04.18-19:53+0000) Built-in shell (ash)=0AEnter 'help' for a list of built=
-in commands.=0A=0A-sh: can't access tty; job control turned off=0A=0A=0Ast=
eps for plb_temac drivers under EDK 8.2.02i (w/SP2.4+0)=0AUsing plb_temac v=
3.00a & hard_temac v3.00b=0A=0AGenerate s/w libraries=0A=0A1. copy or ftp t=
he following files from C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\=
=0Ato the base directory of the linux source tree=0A=0AUSED:=0Aarch\ppc\pla=
tforms\4xx\xparameters\xparameters.h=0A=0A**=0A UNUSED=0Aarch\ppc\platforms=
\4xx\virtex.c=0Aarch\ppc\boot\simple\embed_config.c=0Ainclude\linux\xilinx_=
devices.h=0A=0A2. copy C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\t=
emac_linux_2_6_v2_00_b\src\adapter.c to=0A../drivers/net/xilinx_temac/adapt=
er.c=0A=0A3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =3D> driver=
s/xilinx_edk=0ANote: Remove all old files first *except* Kconfig, xio.h=0A=
=0A4. modify drivers/xilinx_edk/Makefile with the following to look like th=
is:=0A=0A# Linux file to EXPORT_SYMBOL all of the Xilinx entries.=0Aobj-$(C=
ONFIG_XILINX_EDK) +=3D xilinx_syms.o=0A#=0A# # The Xilinx OS independent co=
de.=0Axilinx_syms-objs :=3D xbasic_types.o \=0Axdmav3.o xdmav3_intr.o xdmav=
3_selftest.o xdmav3_simple.o xdmav3_sg.o \=0Axipif_v1_23_b.o \=0Axpacket_fi=
fo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \=0Axversion.o=0A=0A5. Modify your co=
pied xparameters_ml403.h (see notes below) as follows:=0Aadd these lines af=
ter #define=0A XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM=0A=0A#define XPAR_TEMAC_0_I=
PIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH=0A#define XPAR_TEMAC_0_IPIF_=
WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH=0A#define XPAR_TEMAC_0_MAC_FIFO_=
DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH=0A#define XPAR_TEMAC_0_TEMAC_DCR_HOST=
 0=0A#define XPAR_TEMAC_0_INCLUDE_DRE 1=0A=0A=0A6. (optional) modify arch/p=
pc/platforms/virtex.h to accomodate RX_CSUM XPAR=0A=0Astruct xtemac_platfor=
m_data {=0A#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM=0Au8 tx_dre;=0Au8 rx_dre;=0A=
u8 tx_csum;=0Au8 rx_csum;=0Au8 phy_type;=0A#endif=0Au8 dma_mode;=0Au32 rx_p=
kt_fifo_depth;=0Au32 tx_pkt_fifo_depth;=0Au16 mac_fifo_depth;=0Au8 dcr_host=
;=0Au8 dre;=0Au8 mac_addr[6];=0A};=0A=0A7. Modify ../drivers/net/xilinx_tem=
ac/adapter.c to remove #include and=0Aadd #include =0Aadd #include=0A =0A=
=0A________________________________________________________________________=
____________=0ANOTES:=0A1. Don't forget to copy EDK-generated xparameters.h=
 to ../arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h=0A=0A=0A=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0AFiles in latest patch:=0A../drivers/net/xilinx_temac =3D=0AMake=
file=0Aadapter.c=0Axtemac.c=0Axtemac_control.c=0Axtemac_fifo.c=0Axtemac_int=
r.c=0Axtemac_intr_fifo.c=0Axtemac_intr_sgdma.c=0Axtemac_l.c=0Axtemac_sgdma.=
c=0Axtemac.h=0Axtemac_i.h=0Axtemac_l.h=0A=0AFiles in ..\linux\drivers\net\x=
ilinx_temac =3D> (** =3D new=0A files)=0A=0AMakefile=0Aadapter.c=0Axtemac.c=
=0Axtemac_control.c=0Axtemac_fifo.c=0Axtemac_g.c**=0Axtemac_intr.c=0Axtemac=
_intr_fifo.c=0Axtemac_intr_sgdma.c=0Axtemac_l.c=0Axtemac_selftest.c**=0Axte=
mac_sgdma.c=0Axtemac_sinit.c**=0Axtemac_stats.c**=0Axtemac.h=0Axtemac_i.h=
=0Axtemac_l.h=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AFiles in ../drivers/x=
ilinx_edk =3D>=0A=0AKconfig=0AMakefile=0Axbasic_types.c=0Axdmav2.c=0Axdmav2=
_intr.c=0Axdmav2_sg.c=0Axdmav2_simple.c=0Axilinx_syms.c=0Axpacket_fifo_l_v2=
_00_a.c=0Axpacket_fifo_v2_00_a.c=0Axbasic_types.h=0Axdmabdv2.h=0Axdmav2.h=
=0Axdmav2_l.h=0Axio.h=0Axpacket_fifo_l_v2_00_a.h=0Axpacket_fifo_v2_00_a.h=
=0Axstatus.h=0A=0AFiles in=0A ..\linux\arch\ppc\platforms\xilinx_ocp=3D>=0A=
Makefile=0Axbasic_types.c=0Axutil_memtest.c=0Axpacket_fifo_v2_00_a.c=0Axdma=
v3.c=0Axpacket_fifo_l_v2_00_a.c=0Axdmav3_intr.c=0Axipif_v1_23_b.c=0Axdmav3_=
selftest.c=0Axdmav3_sg.c=0Axdmav3_simple.c=0Axversion.c=0Axenv.h=0Axenv_non=
e.h=0Axenv_vxworks.h=0Axdmav3_l.h=0Axipif_v1_23_b.h=0Axdmav3.h=0Axpacket_fi=
fo_l_v2_00_a.h=0Axdmabdv3.h=0Axpacket_fifo_v2_00_a.h=0Axparameters_ml300.h=
=0Axstatus.h=0Axutil.h=0Axbasic_types.h=0Axenv_linux.h=0Axversion.h=0A_____=
__________________________________________=0ALinuxppc-embedded mailing list=
=0ALinuxppc-embedded@ozlabs.org=0Ahttps://ozlabs.org/mailman/listinfo/linux=
ppc-embedded=0A=0A=0A=0A
--0-1342000333-1162652529=:6320
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Pradeep;<br><br>Booting with a ramdisk is a matter =
of putting the appropriate image in the arch/ppc/boot/images directory (I o=
btained mine from the gsrd design files), adding the root=3D/dev/ram rw on =
the command-line boot options, making the .config changes for ram disk supp=
ort and initrd usage, and issuing a make zImage.initrd command.<br><br>Bewa=
re when upgrading to 2.6.18.1 as you may have difficulties with the adapter=
.c you obtained previously.&nbsp; The adapter.c in EDK 8.2 is not as easy t=
o find.&nbsp; Using the EDK to generate software components for linux will =
not expose the proper adapter.c.&nbsp; I had to use the path that Rick Mole=
res posted earlier to retrieve the adapter.c which I used for 2.6.18.1 and =
in my
 notes.<br><br>-cy<br><br><div style=3D"font-family: times new roman,new yo=
rk,times,serif; font-size: 12pt;">----- Original Message ----<br>From: Prad=
eep Sampath &lt;pradeepsampath@yahoo.com&gt;<br>To: robert corley &lt;rdcor=
le@yahoo.com&gt;<br>Sent: Thursday, November 2, 2006 7:57:25 PM<br>Subject:=
 Re: minor progress with plb_temac v3.00a, EDK 8.2, &amp; 2.6.18.1<br><br><=
div>This is great! I played around for a while with the Sysace&nbsp;CF&nbsp=
;driver patches and got it to work. Since you are booting with ramdisk imag=
e would you be kind enough to add more text on how to do that? I see that y=
ou are using UART Lite? Does it require any special setting for the boot&nb=
sp;logs to show up on the standard hyperterminal. </div>  <div>&nbsp;</div>=
  <div>I am planning on rebuilding the whole system using EDK 8.2 and linux=
 kernel 2.6.18.1.</div>  <div>&nbsp;</div>  <div>-Pradeep<br><br><b><i>robe=
rt corley &lt;rdcorle@yahoo.com&gt;</i></b> wrote:</div>  <blockquote class=
=3D"replbq"
 style=3D"border-left: 2px solid rgb(16, 16, 255); padding-left: 5px; margi=
n-left: 5px;">For those interested, I have acheived some measure of success=
 with the plb_temac driver.<br><br>I have attached a txt file of what I had=
 to do to get it working under 2.6.18.1<br><br>I am using the plb_temac in =
DMA mode 3<br><br>Below you will see the boot dump.<br><br>For those able t=
o help, can=0A anyone provide insight as to the failure of setting PHY link=
 speed?<br><br>-cy<br><br><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>--------------------------------------------------=
--------------------<br>2.6.18.1 kernel with all patches<br>11/02/2006 15:3=
0<br>plb_temac v3.00a<br>hard_temac v3.00b<br><br><br>loaded at: 00400000 0=
09F1138<br>board data at: 009EF120 009EF138<br>relocated to: 004040B4 00404=
0CC<br>zimage at: 00404EC7 0057C1F2<br>initrd at: 0057D000 009EE6FE<br>avai=
l ram: 009F2000 04000000<br><br><br>Linux/PPC load: console=3DttyUL0 single=
 ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_s=
ize=3D4660000 root=3D/dev/ram rw<br><br>Uncompressing Linux...done.<br><br>=
Now booting the kernel<br><br>[ 0.000000] Linux version 2.6.18.1 (rdcorle@a=
thena) (gcc version 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006<br>[ 0.000000] Xi=
linx ML403 Reference System (Virtex-4 FX)<br>[ 0.000000] Built 1 zonelists.=
 Total pages: 16384<br>[ 0.000000] Kernel command line: console=3DttyUL0 si=
ngle=0A ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ra=
mdisk_size=3D4660000 root=3D/dev/ram rw<br>[ 0.000000] Xilinx INTC #0 at 0x=
D1000FC0 mapped to 0xFDFFFFC0<br>[ 0.000000] PID hash table entries: 512 (o=
rder: 9, 2048 bytes)<br>[ 0.000158] Console: colour dummy device 80x25<br>[=
 0.000568] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br=
>[ 0.001277] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<b=
r>[ 0.012895] Memory: 57060k available (2548k kernel code, 640k data, 96k i=
nit, 0k highmem)<br>[ 0.104378] Mount-cache hash table entries: 512<br>[ 0.=
106721] checking if image is initramfs...it isn't (no cpio magic); looks li=
ke an initrd<br>[ 2.414242] Freeing initrd memory: 4549k freed<br>[ 2.41871=
2] NET: Registered protocol family 16<br>[ 2.427313] NET: Registered protoc=
ol family 2<br>[ 2.464244] IP route cache hash table entries: 512 (order: -=
1, 2048 bytes)<br>[ 2.465037] TCP established hash table entries: 2048 (ord=
er: 1, 8192 bytes)<br>[=0A 2.465205] TCP bind hash table entries: 1024 (ord=
er: 0, 4096 bytes)<br>[ 2.465296] TCP: Hash tables configured (established =
2048 bind 1024)<br>[ 2.465324] TCP reno registered<br>[ 2.474633] NTFS driv=
er 2.1.27 [Flags: R/O].<br>[ 2.475046] JFS: nTxBlock =3D 481, nTxLock =3D 3=
854<br>[ 2.477623] SGI XFS with no debug enabled<br>[ 2.479001] io schedule=
r noop registered<br>[ 2.479109] io scheduler anticipatory registered<br>[ =
2.479197] io scheduler deadline registered<br>[ 2.479402] io scheduler cfq =
registered (default)<br>[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (=
irq =3D 1) is a uartlite<br>[ 2.691029] RAMDISK driver initialized: 16 RAM =
disks of 4660000K size 1024 blocksize<br>[ 2.703933] loop: loaded (max 8 de=
vices)<br>[ 2.709698] XTemac: using sgDMA mode.<br>[ 2.713493] XTemac: usin=
g TxDRE mode<br>[ 2.717081] XTemac: using RxDRE mode<br>[ 2.720678] XTemac:=
 buffer descriptor size: 32768 (0x8000)<br>[ 2.726622] XTemac: (buffer_desc=
riptor_init) phy: 0x580000, virt: 0xff100000,=0A size: 0x8000<br>[ 2.741073=
] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000, irq=3D0<br>[ 2.=
748080] eth0: XTemac id 1.0f, block id 5, type 8<br>[ 2.753636] mice: PS/2 =
mouse device common for all mice<br>[ 2.759529] TCP bic registered<br>[ 3.2=
64317] eth0: XTemac: Options: 0xb8f2<br>[ 15.227339] eth0: XTemac: Not able=
 to set the speed to 1000 (status: 0x148)<br>[ 25.200394] eth0: XTemac: Not=
 able to set the speed to 100 (status: 0x148)<br>[ 35.173357] eth0: XTemac:=
 Not able to set the speed to 10 (status: 0x148)<br>[ 35.180122] eth0: XTem=
ac: could not negotiate speed<br>[ 35.187740] eth0: XTemac: Send Threshold =
=3D 16, Receive Threshold =3D 2<br>[ 35.194116] eth0: XTemac: Send Wait bou=
nd =3D 1, Receive Wait bound =3D 1<br>[ 36.205399] IP-Config: Complete:<br>=
[ 36.208459] device=3Deth0, addr=3D192.168.1.100, mask=3D255.255.255.0, gw=
=3D192.168.1.1,<br>[ 36.216339] host=3Dnab, domain=3D, nis-domain=3D(none),=
<br>[ 36.221487] bootserver=3D192.168.1.144, rootserver=3D192.168.1.144, ro=
otpath=3D<br>[=0A 36.229826] RAMDISK: Compressed image found at block 0<br>=
[ 37.200498] eth0: XTemac: PHY Link carrier lost.<br>[ 39.097820] VFS: Moun=
ted root (ext2 filesystem).<br>[ 39.102751] Freeing unused kernel memory: 9=
6k init<br>[ 39.108356] ulite_startup: UART status =3D 0x0014<br>[ 39.12461=
9] ulite_startup: UART status =3D 0x0014<br>[ 39.134313] ulite_startup: UAR=
T status =3D 0x0014<br><br><br>BusyBox v1.00-pre9 (2004.04.18-19:53+0000) B=
uilt-in shell (ash)<br>Enter 'help' for a list of built-in commands.<br><br=
>-sh: can't access tty; job control turned off<br><br><br>steps for plb_tem=
ac drivers under EDK 8.2.02i (w/SP2.4+0)<br>Using plb_temac v3.00a &amp; ha=
rd_temac v3.00b<br><br>Generate s/w libraries<br><br>1. copy or ftp the fol=
lowing files from C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\<br>to t=
he base directory of the linux source tree<br><br>USED:<br>arch\ppc\platfor=
ms\4xx\xparameters\xparameters.h<br><br>**=0A UNUSED<br>arch\ppc\platforms\=
4xx\virtex.c<br>arch\ppc\boot\simple\embed_config.c<br>include\linux\xilinx=
_devices.h<br><br>2. copy C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\driver=
s\temac_linux_2_6_v2_00_b\src\adapter.c to<br>../drivers/net/xilinx_temac/a=
dapter.c<br><br>3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =3D&g=
t; drivers/xilinx_edk<br>Note: Remove all old files first *except* Kconfig,=
 xio.h<br><br>4. modify drivers/xilinx_edk/Makefile with the following to l=
ook like this:<br><br># Linux file to EXPORT_SYMBOL all of the Xilinx entri=
es.<br>obj-$(CONFIG_XILINX_EDK) +=3D xilinx_syms.o<br>#<br># # The Xilinx O=
S independent code.<br>xilinx_syms-objs :=3D xbasic_types.o \<br>xdmav3.o x=
dmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \<br>xipif_v1_23=
_b.o \<br>xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \<br>xversion.o<b=
r><br>5. Modify your copied xparameters_ml403.h (see notes below) as follow=
s:<br>add these lines after #define=0A XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM<br>=
<br>#define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH<br=
>#define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH<br>#d=
efine XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH<br>#defin=
e XPAR_TEMAC_0_TEMAC_DCR_HOST 0<br>#define XPAR_TEMAC_0_INCLUDE_DRE 1<br><b=
r><br>6. (optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSU=
M XPAR<br><br>struct xtemac_platform_data {<br>#ifdef XPAR_TEMAC_0_INCLUDE_=
RX_CSUM<br>u8 tx_dre;<br>u8 rx_dre;<br>u8 tx_csum;<br>u8 rx_csum;<br>u8 phy=
_type;<br>#endif<br>u8 dma_mode;<br>u32 rx_pkt_fifo_depth;<br>u32 tx_pkt_fi=
fo_depth;<br>u16 mac_fifo_depth;<br>u8 dcr_host;<br>u8 dre;<br>u8 mac_addr[=
6];<br>};<br><br>7. Modify ../drivers/net/xilinx_temac/adapter.c to remove =
#include and<br>add #include <br>add #include=0A <br><br>__________________=
__________________________________________________________________<br>NOTES=
:<br>1. Don't forget to copy EDK-generated xparameters.h to ../arch/ppc/pla=
tforms/4xx/xparameters/xparameters_ml403.h<br><br><br><br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Fi=
les in latest patch:<br>../drivers/net/xilinx_temac =3D<br>Makefile<br>adap=
ter.c<br>xtemac.c<br>xtemac_control.c<br>xtemac_fifo.c<br>xtemac_intr.c<br>=
xtemac_intr_fifo.c<br>xtemac_intr_sgdma.c<br>xtemac_l.c<br>xtemac_sgdma.c<b=
r>xtemac.h<br>xtemac_i.h<br>xtemac_l.h<br><br>Files in ..\linux\drivers\net=
\xilinx_temac =3D&gt; (** =3D new=0A files)<br><br>Makefile<br>adapter.c<br=
>xtemac.c<br>xtemac_control.c<br>xtemac_fifo.c<br>xtemac_g.c**<br>xtemac_in=
tr.c<br>xtemac_intr_fifo.c<br>xtemac_intr_sgdma.c<br>xtemac_l.c<br>xtemac_s=
elftest.c**<br>xtemac_sgdma.c<br>xtemac_sinit.c**<br>xtemac_stats.c**<br>xt=
emac.h<br>xtemac_i.h<br>xtemac_l.h<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Files in ../drivers/xilinx_edk =3D&gt;<br><br>Kconfig<br>Makefile<br>xbasi=
c_types.c<br>xdmav2.c<br>xdmav2_intr.c<br>xdmav2_sg.c<br>xdmav2_simple.c<br=
>xilinx_syms.c<br>xpacket_fifo_l_v2_00_a.c<br>xpacket_fifo_v2_00_a.c<br>xba=
sic_types.h<br>xdmabdv2.h<br>xdmav2.h<br>xdmav2_l.h<br>xio.h<br>xpacket_fif=
o_l_v2_00_a.h<br>xpacket_fifo_v2_00_a.h<br>xstatus.h<br><br>Files in=0A ..\=
linux\arch\ppc\platforms\xilinx_ocp=3D&gt;<br>Makefile<br>xbasic_types.c<br=
>xutil_memtest.c<br>xpacket_fifo_v2_00_a.c<br>xdmav3.c<br>xpacket_fifo_l_v2=
_00_a.c<br>xdmav3_intr.c<br>xipif_v1_23_b.c<br>xdmav3_selftest.c<br>xdmav3_=
sg.c<br>xdmav3_simple.c<br>xversion.c<br>xenv.h<br>xenv_none.h<br>xenv_vxwo=
rks.h<br>xdmav3_l.h<br>xipif_v1_23_b.h<br>xdmav3.h<br>xpacket_fifo_l_v2_00_=
a.h<br>xdmabdv3.h<br>xpacket_fifo_v2_00_a.h<br>xparameters_ml300.h<br>xstat=
us.h<br>xutil.h<br>xbasic_types.h<br>xenv_linux.h<br>xversion.h<br>________=
_______________________________________<br>Linuxppc-embedded mailing list<b=
r>Linuxppc-embedded@ozlabs.org<br><span><a target=3D"_blank" href=3D"https:=
//ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman=
/listinfo/linuxppc-embedded</a></span></blockquote><br></div><br></div></di=
v></body></html>
--0-1342000333-1162652529=:6320--
