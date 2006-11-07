Return-Path: <rdcorle@yahoo.com>
Received: from web56307.mail.re3.yahoo.com (web56307.mail.re3.yahoo.com
	[216.252.110.231]) by ozlabs.org (Postfix) with SMTP id A210467CC3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 05:37:02 +1100 (EST)
Message-ID: <20061107183700.62673.qmail@web56307.mail.re3.yahoo.com>
Date: Tue, 7 Nov 2006 10:37:00 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: Re: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: Pradeep Sampath <pradeepsampath@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1626708952-1162924620=:61408"
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

--0-1626708952-1162924620=:61408
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Pradeep;=0A=0AI found the process of "uprading" the xapp902 reference desig=
n to be troublesome when I removed the GMII loop-back; as=0Asuch, I aborted=
 the process and just started from scratch.=0A=0AI am currently debugging m=
y design and have a functional plb_temac but only at 10Mbps speeds.=0A=0A-R=
. Corley=0A=0A----- Original Message ----=0AFrom: Pradeep Sampath <pradeeps=
ampath@yahoo.com>=0ATo: David H. Lynch Jr. <dhlii@dlasys.net>; robert corle=
y <rdcorle@yahoo.com>=0ACc: linux linuxppc-embedded <linuxppc-embedded@ozla=
bs.org>=0ASent: Tuesday, November 7, 2006 1:05:08 PM=0ASubject: Re: minor p=
rogress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1=0A=0AHello,=0A   =0A  I =
was able to get the booting with a ramdisk working and also  David B./Peter=
's uartlite patches to work. Now I see the linux command line without any k=
ernel panics. Thanks to everybody out there.=0A   =0A  Next step is to get =
the PLB TEMAC 3.00.a working...=0A   =0A  Question 1: I have started with t=
he xapp902 reference design. I replaced the existing plb_temac_0 and hard_t=
emac_0 instances with the plb_temac_0 (version 3.00.a) and hard_temac_0 (ve=
rsion 3.00.b). When I "generate libraries and BSP" I get the following erro=
r.=0A  =0AERROR:MDT - intc () - Internal error: Number of interrupt inputs =
on opb_intc_0=0A   (1) is not the same as length of total number of interru=
pt sources (2). If=0A   any interrupt source is a vector then libgen does n=
ot support this use case=0A       while=0A executing=0A   "error "Internal =
error: Number of interrupt inputs on $periph_name=0A   ($num_intr_inputs) i=
s not the same as length of total number of interrupt.....=0A  .....=0A   A=
RG: C_PHY_TYPE VALUE: 1=0AERROR:MDT - Error while running "generate" for pr=
ocessor ppc405_0...=0A   =0A  Or is it better to generate the EDK design fr=
om start rather than using the reference design?=0A   =0A  Question 2: For =
the adapter.c for TEMAC, I am using the C:\EDK\sw\ThirdParty\bsp\linux_2_6_=
v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c as indicated by Rick =
Moleres. Can I use it as is or it requires further tweaking? If yes, then w=
hat are the changes.=0A   =0A  Question 3: Are the files under linux\arch\p=
pc\platforms\xilinx_ocp required? I thought the files in ../drivers/xilinx_=
edk =3D> should take care of all the dma stuff?=0A=0A  Could someone provid=
e=0A some insight into all these questions?=0A  -Pradeep=0A  =0A=0A"David H=
. Lynch Jr." <dhlii@dlasys.net> wrote:=0A  robert corley wrote:           P=
radeep;=0A=0ABooting with a ramdisk is a matter of putting the appropriate =
image in the arch/ppc/boot/images directory (I obtained mine from the gsrd =
design files), adding the root=3D/dev/ram rw on the command-line boot optio=
ns, making the .config changes for ram disk support and initrd usage, and i=
ssuing a make zImage.initrd command.=0A=0ABeware when upgrading to 2.6.18.1=
 as=0A you may have difficulties with the adapter.c you obtained previously=
.  The adapter.c in EDK 8.2 is not as easy to find.  Using the EDK to gener=
ate software components for linux will not expose the proper adapter.c.  I =
had to use the path that Rick Moleres posted earlier to retrieve the adapte=
r.c which I used for 2.6.18.1 and in my notes.=0A=0A-cy=0A=0A=0A=0A    I am=
 booting with a ramdisk using initramfs. Aside from its being somewhat hard=
er to find documentation I beleive it is actually easier.=0A    =0A    In t=
he simplest form, create a directory on your host that contains exactly wha=
t you want on the ramdisk.=0A    Enable CONFIG_INITRAMFS=0A    and point th=
e CONFIG_INITRAMFS_SOURCE  to that directory.=0A=0A    It is pretty much th=
at simple. The linux build process creates a kernel - I use zImage.elf that=
 has the ramdisk compressed=0A and concatentated.=0A    Nothing except the =
Linux kernel itself has to make any accomidations for the ramdisk. The boot=
loader does not have to deal with another file, or pass pointers to it to L=
inux, ....=0A    It took some time to get it working - mostly because I did=
 nto know what I was doing, but in hindsight it is really easy.=0A=0A=0A=0A=
        ----- Original Message ----=0AFrom: Pradeep Sampath <pradeepsampath=
@yahoo.com>=0ATo: robert corley <rdcorle@yahoo.com>=0ASent: Thursday, Novem=
ber 2, 2006 7:57:25 PM=0ASubject: Re: minor progress with plb_temac v3.00a,=
 EDK 8.2, & 2.6.18.1=0A=0A  This is great! I played around for a while with=
 the Sysace CF driver patches and got it to work. Since you are booting wit=
h ramdisk image would you be kind enough to add more text on how to do that=
? I see that you are using UART Lite? Does it require any special setting f=
or the boot logs to show up on the standard hyperterminal. =0A   =0A  I am =
planning on rebuilding the whole system using EDK 8.2 and linux kernel 2.6.=
18.1.=0A   =0A  -Pradeep=0A=0Arobert corley <rdcorle@yahoo.com> wrote:=0A  =
For those interested, I have=0A acheived some measure of success with the p=
lb_temac driver.=0A=0AI have attached a txt file of what I had to do to get=
 it working under 2.6.18.1=0A=0AI am using the plb_temac in DMA mode 3=0A=
=0ABelow you will see the boot dump.=0A=0AFor those able to help, can anyon=
e provide insight as to the failure of setting PHY link speed?=0A=0A-cy=0A=
=0A=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A---=
-------------------------------------------------------------------=0A2.6.1=
8.1 kernel with all patches=0A11/02/2006 15:30=0Aplb_temac v3.00a=0Ahard_te=
mac v3.00b=0A=0A=0Aloaded at: 00400000 009F1138=0Aboard data at: 009EF120 0=
09EF138=0Arelocated to: 004040B4 004040CC=0Azimage at: 00404EC7 0057C1F2=0A=
initrd at: 0057D000 009EE6FE=0Aavail ram: 009F2000 04000000=0A=0A=0ALinux/P=
PC load: console=3DttyUL0 single ip=3D192.168.1.100:192.168.1.144:192.168.1=
.1:255.255.255.0:nab:: ramdisk_size=3D4660000 root=3D/dev/ram rw=0A=0AUncom=
pressing Linux...done.=0A=0ANow booting the kernel=0A=0A[=0A 0.000000] Linu=
x version 2.6.18.1 (rdcorle@athena) (gcc version 3.4.2) #2 Thu Nov 2 21:56:=
32 UTC 2006=0A[ 0.000000] Xilinx ML403 Reference System (Virtex-4 FX)=0A[ 0=
.000000] Built 1 zonelists. Total pages: 16384=0A[ 0.000000] Kernel command=
 line: console=3DttyUL0 single ip=3D192.168.1.100:192.168.1.144:192.168.1.1=
:255.255.255.0:nab:: ramdisk_size=3D4660000 root=3D/dev/ram rw=0A[ 0.000000=
] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0=0A[ 0.000000] PID hash =
table entries: 512 (order: 9, 2048 bytes)=0A[ 0.000158] Console: colour dum=
my device 80x25=0A[ 0.000568] Dentry cache hash table entries: 8192 (order:=
 3, 32768 bytes)=0A[ 0.001277] Inode-cache hash table entries: 4096 (order:=
 2, 16384 bytes)=0A[ 0.012895] Memory: 57060k available (2548k kernel code,=
 640k data, 96k init, 0k highmem)=0A[ 0.104378] Mount-cache hash table entr=
ies: 512=0A[ 0.106721] checking if image is initramfs...it isn't (no cpio m=
agic); looks like an initrd=0A[ 2.414242] Freeing initrd memory:=0A 4549k f=
reed=0A[ 2.418712] NET: Registered protocol family 16=0A[ 2.427313] NET: Re=
gistered protocol family 2=0A[ 2.464244] IP route cache hash table entries:=
 512 (order: -1, 2048 bytes)=0A[ 2.465037] TCP established hash table entri=
es: 2048 (order: 1, 8192 bytes)=0A[ 2.465205] TCP bind hash table entries: =
1024 (order: 0, 4096 bytes)=0A[ 2.465296] TCP: Hash tables configured (esta=
blished 2048 bind 1024)=0A[ 2.465324] TCP reno registered=0A[ 2.474633] NTF=
S driver 2.1.27 [Flags: R/O].=0A[ 2.475046] JFS: nTxBlock =3D 481, nTxLock =
=3D 3854=0A[ 2.477623] SGI XFS with no debug enabled=0A[ 2.479001] io sched=
uler noop registered=0A[ 2.479109] io scheduler anticipatory registered=0A[=
 2.479197] io scheduler deadline registered=0A[ 2.479402] io scheduler cfq =
registered (default)=0A[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (i=
rq =3D 1) is a uartlite=0A[ 2.691029] RAMDISK driver initialized: 16 RAM di=
sks of 4660000K size 1024 blocksize=0A[ 2.703933] loop: loaded (max 8=0A de=
vices)=0A[ 2.709698] XTemac: using sgDMA mode.=0A[ 2.713493] XTemac: using =
TxDRE mode=0A[ 2.717081] XTemac: using RxDRE mode=0A[ 2.720678] XTemac: buf=
fer descriptor size: 32768 (0x8000)=0A[ 2.726622] XTemac: (buffer_descripto=
r_init) phy: 0x580000, virt: 0xff100000, size: 0x8000=0A[ 2.741073] eth0: X=
ilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000, irq=3D0=0A[ 2.748080] et=
h0: XTemac id 1.0f, block id 5, type 8=0A[ 2.753636] mice: PS/2 mouse devic=
e common for all mice=0A[ 2.759529] TCP bic registered=0A[ 3.264317] eth0: =
XTemac: Options: 0xb8f2=0A[ 15.227339] eth0: XTemac: Not able to set the sp=
eed to 1000 (status: 0x148)=0A[ 25.200394] eth0: XTemac: Not able to set th=
e speed to 100 (status: 0x148)=0A[ 35.173357] eth0: XTemac: Not able to set=
 the speed to 10 (status: 0x148)=0A[ 35.180122] eth0: XTemac: could not neg=
otiate speed=0A[ 35.187740] eth0: XTemac: Send Threshold =3D 16, Receive Th=
reshold =3D 2=0A[ 35.194116] eth0: XTemac: Send Wait bound =3D 1, Receive=
=0A Wait bound =3D 1=0A[ 36.205399] IP-Config: Complete:=0A[ 36.208459] dev=
ice=3Deth0, addr=3D192.168.1.100, mask=3D255.255.255.0, gw=3D192.168.1.1,=
=0A[ 36.216339] host=3Dnab, domain=3D, nis-domain=3D(none),=0A[ 36.221487] =
bootserver=3D192.168.1.144, rootserver=3D192.168.1.144, rootpath=3D=0A[ 36.=
229826] RAMDISK: Compressed image found at block 0=0A[ 37.200498] eth0: XTe=
mac: PHY Link carrier lost.=0A[ 39.097820] VFS: Mounted root (ext2 filesyst=
em).=0A[ 39.102751] Freeing unused kernel memory: 96k init=0A[ 39.108356] u=
lite_startup: UART status =3D 0x0014=0A[ 39.124619] ulite_startup: UART sta=
tus =3D 0x0014=0A[ 39.134313] ulite_startup: UART status =3D 0x0014=0A=0A=
=0ABusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)=0AEnter =
'help' for a list of built-in commands.=0A=0A-sh: can't access tty; job con=
trol turned off=0A=0A=0Asteps for plb_temac drivers under EDK 8.2.02i (w/SP=
2.4+0)=0AUsing plb_temac v3.00a & hard_temac v3.00b=0A=0AGenerate s/w libra=
ries=0A=0A1. copy=0A or ftp the following files from C:\EDK\sw\ThirdParty\b=
sp\linux_2_6_v1_00_a\linux\=0Ato the base directory of the linux source tre=
e=0A=0AUSED:=0Aarch\ppc\platforms\4xx\xparameters\xparameters.h=0A=0A** UNU=
SED=0Aarch\ppc\platforms\4xx\virtex.c=0Aarch\ppc\boot\simple\embed_config.c=
=0Ainclude\linux\xilinx_devices.h=0A=0A2. copy C:\EDK\sw\ThirdParty\bsp\lin=
ux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c to=0A../driver=
s/net/xilinx_temac/adapter.c=0A=0A3. copy or ftp ..\linux\arch\ppc\platform=
s\xilinx_ocp =3D> drivers/xilinx_edk=0ANote: Remove all old files first *ex=
cept* Kconfig, xio.h=0A=0A4. modify drivers/xilinx_edk/Makefile with the fo=
llowing to look like this:=0A=0A# Linux file to EXPORT_SYMBOL all of the Xi=
linx entries.=0Aobj-$(CONFIG_XILINX_EDK) +=3D xilinx_syms.o=0A#=0A# # The X=
ilinx OS independent code.=0Axilinx_syms-objs :=3D xbasic_types.o \=0Axdmav=
3.o xdmav3_intr.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \=0Axipif_v=
1_23_b.o=0A \=0Axpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \=0Axversio=
n.o=0A=0A5. Modify your copied xparameters_ml403.h (see notes below) as fol=
lows:=0Aadd these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM=0A=
=0A#define XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH=0A#=
define XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH=0A#defi=
ne XPAR_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH=0A#define XP=
AR_TEMAC_0_TEMAC_DCR_HOST 0=0A#define XPAR_TEMAC_0_INCLUDE_DRE 1=0A=0A=0A6.=
 (optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSUM XPAR=
=0A=0Astruct xtemac_platform_data {=0A#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM=
=0Au8 tx_dre;=0Au8 rx_dre;=0Au8 tx_csum;=0Au8 rx_csum;=0Au8 phy_type;=0A#en=
dif=0Au8 dma_mode;=0Au32 rx_pkt_fifo_depth;=0Au32 tx_pkt_fifo_depth;=0Au16 =
mac_fifo_depth;=0Au8 dcr_host;=0Au8 dre;=0Au8 mac_addr[6];=0A};=0A=0A7. Mod=
ify ../drivers/net/xilinx_temac/adapter.c to remove #include and=0Aadd=0A #=
include =0Aadd #include =0A=0A_____________________________________________=
_______________________________________=0ANOTES:=0A1. Don't forget to copy =
EDK-generated xparameters.h to ../arch/ppc/platforms/4xx/xparameters/xparam=
eters_ml403.h=0A=0A=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0AFiles in latest patch:=0A../drivers/=
net/xilinx_temac =3D=0AMakefile=0Aadapter.c=0Axtemac.c=0Axtemac_control.c=
=0Axtemac_fifo.c=0Axtemac_intr.c=0Axtemac_intr_fifo.c=0Axtemac_intr_sgdma.c=
=0Axtemac_l.c=0Axtemac_sgdma.c=0Axtemac.h=0Axtemac_i.h=0Axtemac_l.h=0A=0AFi=
les in ..\linux\drivers\net\xilinx_temac =3D> (** =3D new=0A files)=0A=0AMa=
kefile=0Aadapter.c=0Axtemac.c=0Axtemac_control.c=0Axtemac_fifo.c=0Axtemac_g=
.c**=0Axtemac_intr.c=0Axtemac_intr_fifo.c=0Axtemac_intr_sgdma.c=0Axtemac_l.=
c=0Axtemac_selftest.c**=0Axtemac_sgdma.c=0Axtemac_sinit.c**=0Axtemac_stats.=
c**=0Axtemac.h=0Axtemac_i.h=0Axtemac_l.h=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0AFiles in ../drivers/xilinx_edk =3D>=0A=0AKconfig=0AMakefile=0Axbasic_=
types.c=0Axdmav2.c=0Axdmav2_intr.c=0Axdmav2_sg.c=0Axdmav2_simple.c=0Axilinx=
_syms.c=0Axpacket_fifo_l_v2_00_a.c=0Axpacket_fifo_v2_00_a.c=0Axbasic_types.=
h=0Axdmabdv2.h=0Axdmav2.h=0Axdmav2_l.h=0Axio.h=0Axpacket_fifo_l_v2_00_a.h=
=0Axpacket_fifo_v2_00_a.h=0Axstatus.h=0A=0AFiles in=0A ..\linux\arch\ppc\pl=
atforms\xilinx_ocp=3D>=0AMakefile=0Axbasic_types.c=0Axutil_memtest.c=0Axpac=
ket_fifo_v2_00_a.c=0Axdmav3.c=0Axpacket_fifo_l_v2_00_a.c=0Axdmav3_intr.c=0A=
xipif_v1_23_b.c=0Axdmav3_selftest.c=0Axdmav3_sg.c=0Axdmav3_simple.c=0Axvers=
ion.c=0Axenv.h=0Axenv_none.h=0Axenv_vxworks.h=0Axdmav3_l.h=0Axipif_v1_23_b.=
h=0Axdmav3.h=0Axpacket_fifo_l_v2_00_a.h=0Axdmabdv3.h=0Axpacket_fifo_v2_00_a=
.h=0Axparameters_ml300.h=0Axstatus.h=0Axutil.h=0Axbasic_types.h=0Axenv_linu=
x.h=0Axversion.h=0A_______________________________________________=0ALinuxp=
pc-embedded mailing list=0ALinuxppc-embedded@ozlabs.org=0Ahttps://ozlabs.or=
g/mailman/listinfo/linuxppc-embedded=0A=0A=0A=0A=0A =0A ___________________=
____________________________  Linuxppc-embedded mailing list  Linuxppc-embe=
dded@ozlabs.org  https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=
=0A--   Dave Lynch             DLA Systems  Software Development:          =
     Embedded Linux  717.627.3770         dhlii@dlasys.net    http://www.dl=
asys.net  fax: 1.253.369.9244               Cell: 1.717.587.7774  Over 25 y=
ears' experience in platforms, languages, and technologies too numerous to =
list.    "Any intelligent fool can make things bigger and more complex... I=
t takes a touch of genius - and a lot of courage to move in the opposite=0A=
 direction."  Albert Einstein  =0A=0A=0A=0A
--0-1626708952-1162924620=:61408
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Pradeep;<br><br>I found the process of "uprading" t=
he xapp902 reference design to be troublesome when I removed the GMII loop-=
back; as<br>such, I aborted the process and just started from scratch.<br><=
br>I am currently debugging my design and have a functional plb_temac but o=
nly at 10Mbps speeds.<br><br>-R. Corley<br><br><div style=3D"font-family: t=
imes new roman,new york,times,serif; font-size: 12pt;">----- Original Messa=
ge ----<br>From: Pradeep Sampath &lt;pradeepsampath@yahoo.com&gt;<br>To: Da=
vid H. Lynch Jr. &lt;dhlii@dlasys.net&gt;; robert corley &lt;rdcorle@yahoo.=
com&gt;<br>Cc: linux linuxppc-embedded &lt;linuxppc-embedded@ozlabs.org&gt;=
<br>Sent: Tuesday, November 7, 2006 1:05:08 PM<br>Subject: Re: minor progre=
ss with plb_temac
 v3.00a, EDK 8.2, &amp; 2.6.18.1<br><br><div>Hello,</div>  <div>&nbsp;</div=
>  <div>I was able to get the booting with a ramdisk working&nbsp;and also&=
nbsp;&nbsp;David B./Peter's&nbsp;uartlite patches to work. Now I see the li=
nux command line without any kernel panics. Thanks to everybody out there.<=
/div>  <div>&nbsp;</div>  <div>Next step is to get the PLB TEMAC 3.00.a wor=
king...</div>  <div>&nbsp;</div>  <div>Question 1: I have started with the =
xapp902 reference design. I replaced the existing plb_temac_0 and hard_tema=
c_0 instances with the plb_temac_0 (version 3.00.a) and hard_temac_0 (versi=
on 3.00.b). When&nbsp;I "generate libraries and BSP"&nbsp;I get the followi=
ng error.</div>  <div><br>ERROR:MDT - intc () - Internal error: Number of i=
nterrupt inputs on opb_intc_0<br>&nbsp;&nbsp; (1) is not the same as length=
 of total number of interrupt sources (2). If<br>&nbsp;&nbsp; any interrupt=
 source is a vector then libgen does not support this use
 case<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while=0A executing<br>&nbsp;&=
nbsp; "error "Internal error: Number of interrupt inputs on $periph_name<br=
>&nbsp;&nbsp; ($num_intr_inputs) is not the same as length of total number =
of interrupt.....</div>  <div>.....<br>&nbsp;&nbsp; ARG: C_PHY_TYPE VALUE: =
1<br>ERROR:MDT - Error while running "generate" for processor ppc405_0...</=
div>  <div>&nbsp;</div>  <div>Or is it better to generate the EDK design fr=
om start rather than using the reference design?</div>  <div>&nbsp;</div>  =
<div>Question 2: For the adapter.c for TEMAC, I am using the C:\EDK\sw\Thir=
dParty\bsp\linux_2_6_v1_00_a\drivers\temac_linux_2_6_v2_00_b\src\adapter.c =
as indicated by Rick Moleres. Can I use it as is or it requires further twe=
aking? If yes, then what are the changes.</div>  <div>&nbsp;</div>  <div>Qu=
estion 3:&nbsp;Are the files under linux\arch\ppc\platforms\xilinx_ocp requ=
ired? I thought the files in ../drivers/xilinx_edk =3D&gt; should take care=
 of all the dma stuff?<br></div>  <div>Could&nbsp;someone provide=0A some&n=
bsp;insight&nbsp;into all&nbsp;these questions?</div>  <div>-Pradeep</div> =
 <div><br><br><b><i>"David H. Lynch Jr." &lt;dhlii@dlasys.net&gt;</i></b> w=
rote:</div>  <blockquote class=3D"replbq" style=3D"border-left: 2px solid r=
gb(16, 16, 255); padding-left: 5px; margin-left: 5px;">robert corley wrote:=
   <blockquote type=3D"cite">      <div style=3D"font-size: 12pt; font-fami=
ly: times new roman,new york,times,serif;">  <div style=3D"font-size: 12pt;=
 font-family: times new roman,new york,times,serif;">Pradeep;<br><br>Bootin=
g with a ramdisk is a matter of putting the appropriate image in the arch/p=
pc/boot/images directory (I obtained mine from the gsrd design files), addi=
ng the root=3D/dev/ram rw on the command-line boot options, making the .con=
fig changes for ram disk support and initrd usage, and issuing a make zImag=
e.initrd command.<br><br>Beware when upgrading to 2.6.18.1 as=0A you may ha=
ve difficulties with the adapter.c you obtained previously.&nbsp; The adapt=
er.c in EDK 8.2 is not as easy to find.&nbsp; Using the EDK to generate sof=
tware components for linux will not expose the proper adapter.c.&nbsp; I ha=
d to use the path that Rick Moleres posted earlier to retrieve the adapter.=
c which I used for 2.6.18.1 and in my notes.<br><br>-cy<br><br></div></div>=
</blockquote>&nbsp;&nbsp;&nbsp; I am booting with a ramdisk using initramfs=
. Aside from its being somewhat harder to find documentation I beleive it i=
s actually easier.<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; In the simp=
lest form, create a directory on your host that contains exactly what you w=
ant on the ramdisk.<br>&nbsp;&nbsp;&nbsp; Enable CONFIG_INITRAMFS<br>&nbsp;=
&nbsp;&nbsp; and point the CONFIG_INITRAMFS_SOURCE&nbsp; to that directory.=
<br><br>&nbsp;&nbsp;&nbsp; It is pretty much that simple. The linux build p=
rocess creates a kernel - I use zImage.elf that has the ramdisk compressed=
=0A and concatentated.<br>&nbsp;&nbsp;&nbsp; Nothing except the Linux kerne=
l itself has to make any accomidations for the ramdisk. The bootloader does=
 not have to deal with another file, or pass pointers to it to Linux, ....<=
br>&nbsp;&nbsp;&nbsp; It took some time to get it working - mostly because =
I did nto know what I was doing, but in hindsight it is really easy.<br><br=
><br><br>  <blockquote type=3D"cite">  <div style=3D"font-size: 12pt; font-=
family: times new roman,new york,times,serif;">  <div style=3D"font-size: 1=
2pt; font-family: times new roman,new york,times,serif;">  <div style=3D"fo=
nt-size: 12pt; font-family: times new roman,new york,times,serif;">----- Or=
iginal Message ----<br>From: Pradeep Sampath <a rel=3D"nofollow" class=3D"m=
oz-txt-link-rfc2396E" target=3D"_blank" href=3D"mailto:pradeepsampath@yahoo=
.com">&lt;pradeepsampath@yahoo.com&gt;</a><br>To: robert corley <a rel=3D"n=
ofollow" class=3D"moz-txt-link-rfc2396E" target=3D"_blank"
 href=3D"mailto:rdcorle@yahoo.com">&lt;rdcorle@yahoo.com&gt;</a><br>Sent: T=
hursday, November 2, 2006 7:57:25 PM<br>Subject: Re: minor progress with pl=
b_temac v3.00a, EDK 8.2, &amp; 2.6.18.1<br><br>  <div>This is great! I play=
ed around for a while with the Sysace&nbsp;CF&nbsp;driver patches and got i=
t to work. Since you are booting with ramdisk image would you be kind enoug=
h to add more text on how to do that? I see that you are using UART Lite? D=
oes it require any special setting for the boot&nbsp;logs to show up on the=
 standard hyperterminal. </div>  <div>&nbsp;</div>  <div>I am planning on r=
ebuilding the whole system using EDK 8.2 and linux kernel 2.6.18.1.</div>  =
<div>&nbsp;</div>  <div>-Pradeep<br><br><b><i>robert corley <a rel=3D"nofol=
low" class=3D"moz-txt-link-rfc2396E" target=3D"_blank" href=3D"mailto:rdcor=
le@yahoo.com">&lt;rdcorle@yahoo.com&gt;</a></i></b> wrote:</div>  <blockquo=
te class=3D"replbq" style=3D"border-left: 2px solid rgb(16, 16, 255); paddi=
ng-left: 5px; margin-left:
 5px;">For those interested, I have=0A acheived some measure of success wit=
h the plb_temac driver.<br><br>I have attached a txt file of what I had to =
do to get it working under 2.6.18.1<br><br>I am using the plb_temac in DMA =
mode 3<br><br>Below you will see the boot dump.<br><br>For those able to he=
lp, can anyone provide insight as to the failure of setting PHY link speed?=
<br><br>-cy<br><br><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>-----------------------------------------------------------=
-----------<br>2.6.18.1 kernel with all patches<br>11/02/2006 15:30<br>plb_=
temac v3.00a<br>hard_temac v3.00b<br><br><br>loaded at: 00400000 009F1138<b=
r>board data at: 009EF120 009EF138<br>relocated to: 004040B4 004040CC<br>zi=
mage at: 00404EC7 0057C1F2<br>initrd at: 0057D000 009EE6FE<br>avail ram: 00=
9F2000 04000000<br><br><br>Linux/PPC load: console=3DttyUL0 single ip=3D192=
.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=3D466=
0000 root=3D/dev/ram rw<br><br>Uncompressing Linux...done.<br><br>Now booti=
ng the kernel<br><br>[=0A 0.000000] Linux version 2.6.18.1 (rdcorle@athena)=
 (gcc version 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006<br>[ 0.000000] Xilinx M=
L403 Reference System (Virtex-4 FX)<br>[ 0.000000] Built 1 zonelists. Total=
 pages: 16384<br>[ 0.000000] Kernel command line: console=3DttyUL0 single i=
p=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_siz=
e=3D4660000 root=3D/dev/ram rw<br>[ 0.000000] Xilinx INTC #0 at 0xD1000FC0 =
mapped to 0xFDFFFFC0<br>[ 0.000000] PID hash table entries: 512 (order: 9, =
2048 bytes)<br>[ 0.000158] Console: colour dummy device 80x25<br>[ 0.000568=
] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)<br>[ 0.0012=
77] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>[ 0.012=
895] Memory: 57060k available (2548k kernel code, 640k data, 96k init, 0k h=
ighmem)<br>[ 0.104378] Mount-cache hash table entries: 512<br>[ 0.106721] c=
hecking if image is initramfs...it isn't (no cpio magic); looks like an ini=
trd<br>[ 2.414242] Freeing initrd memory:=0A 4549k freed<br>[ 2.418712] NET=
: Registered protocol family 16<br>[ 2.427313] NET: Registered protocol fam=
ily 2<br>[ 2.464244] IP route cache hash table entries: 512 (order: -1, 204=
8 bytes)<br>[ 2.465037] TCP established hash table entries: 2048 (order: 1,=
 8192 bytes)<br>[ 2.465205] TCP bind hash table entries: 1024 (order: 0, 40=
96 bytes)<br>[ 2.465296] TCP: Hash tables configured (established 2048 bind=
 1024)<br>[ 2.465324] TCP reno registered<br>[ 2.474633] NTFS driver 2.1.27=
 [Flags: R/O].<br>[ 2.475046] JFS: nTxBlock =3D 481, nTxLock =3D 3854<br>[ =
2.477623] SGI XFS with no debug enabled<br>[ 2.479001] io scheduler noop re=
gistered<br>[ 2.479109] io scheduler anticipatory registered<br>[ 2.479197]=
 io scheduler deadline registered<br>[ 2.479402] io scheduler cfq registere=
d (default)<br>[ 2.517627] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D 1=
) is a uartlite<br>[ 2.691029] RAMDISK driver initialized: 16 RAM disks of =
4660000K size 1024 blocksize<br>[ 2.703933] loop: loaded (max 8=0A devices)=
<br>[ 2.709698] XTemac: using sgDMA mode.<br>[ 2.713493] XTemac: using TxDR=
E mode<br>[ 2.717081] XTemac: using RxDRE mode<br>[ 2.720678] XTemac: buffe=
r descriptor size: 32768 (0x8000)<br>[ 2.726622] XTemac: (buffer_descriptor=
_init) phy: 0x580000, virt: 0xff100000, size: 0x8000<br>[ 2.741073] eth0: X=
ilinx TEMAC #0 at 0x60000000 mapped to 0xC5050000, irq=3D0<br>[ 2.748080] e=
th0: XTemac id 1.0f, block id 5, type 8<br>[ 2.753636] mice: PS/2 mouse dev=
ice common for all mice<br>[ 2.759529] TCP bic registered<br>[ 3.264317] et=
h0: XTemac: Options: 0xb8f2<br>[ 15.227339] eth0: XTemac: Not able to set t=
he speed to 1000 (status: 0x148)<br>[ 25.200394] eth0: XTemac: Not able to =
set the speed to 100 (status: 0x148)<br>[ 35.173357] eth0: XTemac: Not able=
 to set the speed to 10 (status: 0x148)<br>[ 35.180122] eth0: XTemac: could=
 not negotiate speed<br>[ 35.187740] eth0: XTemac: Send Threshold =3D 16, R=
eceive Threshold =3D 2<br>[ 35.194116] eth0: XTemac: Send Wait bound =3D 1,=
 Receive=0A Wait bound =3D 1<br>[ 36.205399] IP-Config: Complete:<br>[ 36.2=
08459] device=3Deth0, addr=3D192.168.1.100, mask=3D255.255.255.0, gw=3D192.=
168.1.1,<br>[ 36.216339] host=3Dnab, domain=3D, nis-domain=3D(none),<br>[ 3=
6.221487] bootserver=3D192.168.1.144, rootserver=3D192.168.1.144, rootpath=
=3D<br>[ 36.229826] RAMDISK: Compressed image found at block 0<br>[ 37.2004=
98] eth0: XTemac: PHY Link carrier lost.<br>[ 39.097820] VFS: Mounted root =
(ext2 filesystem).<br>[ 39.102751] Freeing unused kernel memory: 96k init<b=
r>[ 39.108356] ulite_startup: UART status =3D 0x0014<br>[ 39.124619] ulite_=
startup: UART status =3D 0x0014<br>[ 39.134313] ulite_startup: UART status =
=3D 0x0014<br><br><br>BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in s=
hell (ash)<br>Enter 'help' for a list of built-in commands.<br><br>-sh: can=
't access tty; job control turned off<br><br><br>steps for plb_temac driver=
s under EDK 8.2.02i (w/SP2.4+0)<br>Using plb_temac v3.00a &amp; hard_temac =
v3.00b<br><br>Generate s/w libraries<br><br>1. copy=0A or ftp the following=
 files from C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\linux\<br>to the bas=
e directory of the linux source tree<br><br>USED:<br>arch\ppc\platforms\4xx=
\xparameters\xparameters.h<br><br>** UNUSED<br>arch\ppc\platforms\4xx\virte=
x.c<br>arch\ppc\boot\simple\embed_config.c<br>include\linux\xilinx_devices.=
h<br><br>2. copy C:\EDK\sw\ThirdParty\bsp\linux_2_6_v1_00_a\drivers\temac_l=
inux_2_6_v2_00_b\src\adapter.c to<br>../drivers/net/xilinx_temac/adapter.c<=
br><br>3. copy or ftp ..\linux\arch\ppc\platforms\xilinx_ocp =3D&gt; driver=
s/xilinx_edk<br>Note: Remove all old files first *except* Kconfig, xio.h<br=
><br>4. modify drivers/xilinx_edk/Makefile with the following to look like =
this:<br><br># Linux file to EXPORT_SYMBOL all of the Xilinx entries.<br>ob=
j-$(CONFIG_XILINX_EDK) +=3D xilinx_syms.o<br>#<br># # The Xilinx OS indepen=
dent code.<br>xilinx_syms-objs :=3D xbasic_types.o \<br>xdmav3.o xdmav3_int=
r.o xdmav3_selftest.o xdmav3_simple.o xdmav3_sg.o \<br>xipif_v1_23_b.o=0A \=
<br>xpacket_fifo_l_v2_00_a.o xpacket_fifo_v2_00_a.o \<br>xversion.o<br><br>=
5. Modify your copied xparameters_ml403.h (see notes below) as follows:<br>=
add these lines after #define XPAR_PLB_TEMAC_0_INCLUDE_RX_CSUM<br><br>#defi=
ne XPAR_TEMAC_0_IPIF_RDFIFO_DEPTH XPAR_PLB_TEMAC_0_RXFIFO_DEPTH<br>#define =
XPAR_TEMAC_0_IPIF_WRFIFO_DEPTH XPAR_PLB_TEMAC_0_TXFIFO_DEPTH<br>#define XPA=
R_TEMAC_0_MAC_FIFO_DEPTH XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH<br>#define XPAR_TE=
MAC_0_TEMAC_DCR_HOST 0<br>#define XPAR_TEMAC_0_INCLUDE_DRE 1<br><br><br>6. =
(optional) modify arch/ppc/platforms/virtex.h to accomodate RX_CSUM XPAR<br=
><br>struct xtemac_platform_data {<br>#ifdef XPAR_TEMAC_0_INCLUDE_RX_CSUM<b=
r>u8 tx_dre;<br>u8 rx_dre;<br>u8 tx_csum;<br>u8 rx_csum;<br>u8 phy_type;<br=
>#endif<br>u8 dma_mode;<br>u32 rx_pkt_fifo_depth;<br>u32 tx_pkt_fifo_depth;=
<br>u16 mac_fifo_depth;<br>u8 dcr_host;<br>u8 dre;<br>u8 mac_addr[6];<br>};=
<br><br>7. Modify ../drivers/net/xilinx_temac/adapter.c to remove #include =
and<br>add=0A #include <br>add #include <br><br>___________________________=
_________________________________________________________<br>NOTES:<br>1. D=
on't forget to copy EDK-generated xparameters.h to ../arch/ppc/platforms/4x=
x/xparameters/xparameters_ml403.h<br><br><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Files in la=
test patch:<br>../drivers/net/xilinx_temac =3D<br>Makefile<br>adapter.c<br>=
xtemac.c<br>xtemac_control.c<br>xtemac_fifo.c<br>xtemac_intr.c<br>xtemac_in=
tr_fifo.c<br>xtemac_intr_sgdma.c<br>xtemac_l.c<br>xtemac_sgdma.c<br>xtemac.=
h<br>xtemac_i.h<br>xtemac_l.h<br><br>Files in ..\linux\drivers\net\xilinx_t=
emac =3D&gt; (** =3D new=0A files)<br><br>Makefile<br>adapter.c<br>xtemac.c=
<br>xtemac_control.c<br>xtemac_fifo.c<br>xtemac_g.c**<br>xtemac_intr.c<br>x=
temac_intr_fifo.c<br>xtemac_intr_sgdma.c<br>xtemac_l.c<br>xtemac_selftest.c=
**<br>xtemac_sgdma.c<br>xtemac_sinit.c**<br>xtemac_stats.c**<br>xtemac.h<br=
>xtemac_i.h<br>xtemac_l.h<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Files in=
 ../drivers/xilinx_edk =3D&gt;<br><br>Kconfig<br>Makefile<br>xbasic_types.c=
<br>xdmav2.c<br>xdmav2_intr.c<br>xdmav2_sg.c<br>xdmav2_simple.c<br>xilinx_s=
yms.c<br>xpacket_fifo_l_v2_00_a.c<br>xpacket_fifo_v2_00_a.c<br>xbasic_types=
.h<br>xdmabdv2.h<br>xdmav2.h<br>xdmav2_l.h<br>xio.h<br>xpacket_fifo_l_v2_00=
_a.h<br>xpacket_fifo_v2_00_a.h<br>xstatus.h<br><br>Files in=0A ..\linux\arc=
h\ppc\platforms\xilinx_ocp=3D&gt;<br>Makefile<br>xbasic_types.c<br>xutil_me=
mtest.c<br>xpacket_fifo_v2_00_a.c<br>xdmav3.c<br>xpacket_fifo_l_v2_00_a.c<b=
r>xdmav3_intr.c<br>xipif_v1_23_b.c<br>xdmav3_selftest.c<br>xdmav3_sg.c<br>x=
dmav3_simple.c<br>xversion.c<br>xenv.h<br>xenv_none.h<br>xenv_vxworks.h<br>=
xdmav3_l.h<br>xipif_v1_23_b.h<br>xdmav3.h<br>xpacket_fifo_l_v2_00_a.h<br>xd=
mabdv3.h<br>xpacket_fifo_v2_00_a.h<br>xparameters_ml300.h<br>xstatus.h<br>x=
util.h<br>xbasic_types.h<br>xenv_linux.h<br>xversion.h<br>_________________=
______________________________<br>Linuxppc-embedded mailing list<br><a rel=
=3D"nofollow" class=3D"moz-txt-link-abbreviated" target=3D"_blank" href=3D"=
mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br><s=
pan><a rel=3D"nofollow" target=3D"_blank" href=3D"https://ozlabs.org/mailma=
n/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-=
embedded</a></span></blockquote><br></div><br></div></div><pre><hr size=3D"=
4" width=3D"90%">
 <br> _______________________________________________  Linuxppc-embedded ma=
iling list  <a rel=3D"nofollow" class=3D"moz-txt-link-abbreviated" target=
=3D"_blank" href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@=
ozlabs.org</a>  <a rel=3D"nofollow" class=3D"moz-txt-link-freetext" target=
=3D"_blank" href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">=
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre></blockquote=
><br><br><pre class=3D"moz-signature">--   Dave Lynch             DLA Syste=
ms  Software Development:               Embedded Linux  717.627.3770       =
  <a rel=3D"nofollow" class=3D"moz-txt-link-abbreviated" target=3D"_blank" =
href=3D"mailto:dhlii@dlasys.net">dhlii@dlasys.net</a>    <a rel=3D"nofollow=
" class=3D"moz-txt-link-freetext" target=3D"_blank" href=3D"http://www.dlas=
ys.net/">http://www.dlasys.net</a>  fax: 1.253.369.9244               Cell:=
 1.717.587.7774  Over 25 years' experience in platforms, languages, and tec=
hnologies too numerous to list.    "Any
 intelligent fool can make things bigger and more complex... It takes a tou=
ch of genius - and a lot of courage to move in the opposite<br> direction."=
  Albert Einstein  </pre></blockquote><br></div><br></div></div></body></ht=
ml>
--0-1626708952-1162924620=:61408--
