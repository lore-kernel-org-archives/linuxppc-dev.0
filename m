Return-Path: <rdcorle@yahoo.com>
Received: from web56315.mail.re3.yahoo.com (web56315.mail.re3.yahoo.com
	[216.252.110.239]) by ozlabs.org (Postfix) with SMTP id 7447A67C37
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 02:08:57 +1100 (EST)
Message-ID: <20061104150855.53455.qmail@web56315.mail.re3.yahoo.com>
Date: Sat, 4 Nov 2006 07:08:55 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: RE : minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: alayrac <christophe.alayrac@cresitt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Chris;=0A=0AI obtained the linux tree from kernels.org and patched it using=
 the same patches you have.=0A=0AThe updated drivers for the TEMAC, however=
, I pulled from the EDK-generated files.  My notes describe what files and =
from =0Awhere.=0A=0AI used David B.'s uartlite drivers to get the uartlite =
to work.  There was some xparameters.h editing for that to work.  I don't k=
now if he has posted his latest work or not.=0A=0AI use the following comma=
nd to patch:=0A=0Apatch -p 1 --backup --verbose <file> <patch file>=0A=0Awh=
ere <file> is the first file to patch as per the patch file and=0A<patch fi=
le> is self-explanatory=0A=0A-cy=0A=0A----- Original Message ----=0AFrom: a=
layrac <christophe.alayrac@cresitt.com>=0ATo: robert corley <rdcorle@yahoo.=
com>; linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>=0ASent: Friday=
, November 3, 2006 8:39:23 AM=0ASubject: RE : minor progress with plb_temac=
 v3.00a, EDK 8.2, & 2.6.18.1=0A=0AHi Robert,=0A=0AThanks for your contribut=
ion.=0AI would like to know where did you get the kernel source 2.6.18.1?=
=0A=0AI've tried from kernel.org, but then temac drivers is not included.=
=0AI've then download the temac patch from mvista at following address :=0A=
http://source.mvista.com/~ank/paulus-powerpc/20060309/temac.paulus-power=0A=
pc.20060309.tgz=0A=0AWhen I try to pacth the kernel with following command =
:=0A    patch -i ppc32_xilinx_edk_temac.patch=0Athe process ask me the file=
 to pacth.=0A=0AI've try to get the kernel source code from mvista with cg-=
clone=0Acommande from =0Acg-clone git://source.mvista.com/git/linux-xilinx-=
26.git =0A=0Aand patch command give same message.=0A=0AAny track to properl=
y applying patch?=0A=0AKinds regards=0A=0AChris=0A=0ACRESITT INDUSTRIE=0A12=
 Rue de Blois, BP6744=0A45067 ORLEANS Cedex 2=0ATel : 02.38.49.45.59=0AFax =
:02.38.49.45.55=0AEmail : christophe.alayrac@cresitt.com =0AWeb : http://ww=
w.cresitt.com=0A=0A=0A<----> -----Message d'origine-----=0A<----> De : linu=
xppc-embedded-=0A<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org=
=0A[mailto:linuxppc-=0A<----> embedded-bounces+christophe.alayrac=3Dcresitt=
.com@ozlabs.org] De la=0A<----> part de robert corley=0A<----> Envoy=E9 : j=
eudi 2 novembre 2006 23:21=0A<----> =C0 : linux linuxppc-embedded=0A<----> =
Objet : minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1=0A<----> =
=0A<----> For those interested, I have acheived some measure of success=0Aw=
ith=0A<----> the plb_temac driver.=0A<----> =0A<----> I have attached a txt=
 file of what I had to do to get it working=0A<----> under 2.6.18.1=0A<----=
> =0A<----> I am using the plb_temac in DMA mode 3=0A<----> =0A<----> Below=
 you will see the boot dump.=0A<----> =0A<----> For those able to help, can=
 anyone provide insight as to the=0Afailure=0A<----> of setting PHY link sp=
eed?=0A<----> =0A<----> -cy=0A<----> =0A<----> =0A<----> =0A<----> =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A<---->=0A---------=
------------------------------------------------------------=0A<----> -=0A<=
----> 2.6.18.1 kernel with all patches=0A<----> 11/02/2006    15:30=0A<----=
> plb_temac v3.00a=0A<----> hard_temac v3.00b=0A<----> =0A<----> =0A<----> =
loaded at:     00400000 009F1138=0A<----> board data at: 009EF120 009EF138=
=0A<----> relocated to:  004040B4 004040CC=0A<----> zimage at:     00404EC7=
 0057C1F2=0A<----> initrd at:     0057D000 009EE6FE=0A<----> avail ram:    =
 009F2000 04000000=0A<----> =0A<----> =0A<----> Linux/PPC load: console=3Dt=
tyUL0 single=0A<----> ip=3D192.168.1.100:192.168.1.144:192.168.1.1:255.255.=
255.0:nab::=0A<----> ramdisk_size=3D4660000 root=3D/dev/ram rw=0A<----> =0A=
<----> Uncompressing Linux...done.=0A<----> =0A<----> Now booting the kerne=
l=0A<----> =0A<----> [    0.000000] Linux version 2.6.18.1 (rdcorle@athena)=
 (gcc=0Aversion=0A<----> 3.4.2) #2 Thu Nov 2 21:56:32 UTC 2006=0A<----> [  =
  0.000000] Xilinx ML403 Reference System (Virtex-4 FX)=0A<----> [    0.000=
000] Built 1 zonelists.  Total pages: 16384=0A<----> [    0.000000] Kernel =
command line: console=3DttyUL0 single=0A<----> ip=3D192.168.1.100:192.168.1=
.144:192.168.1.1:255.255.255.0:nab::=0A<----> ramdisk_size=3D4660000 root=
=3D/dev/ram rw=0A<----> [    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped =
to 0xFDFFFFC0=0A<----> [    0.000000] PID hash table entries: 512 (order: 9=
, 2048 bytes)=0A<----> [    0.000158] Console: colour dummy device 80x25=0A=
<----> [    0.000568] Dentry cache hash table entries: 8192 (order: 3,=0A32=
768=0A<----> bytes)=0A<----> [    0.001277] Inode-cache hash table entries:=
 4096 (order: 2,=0A16384=0A<----> bytes)=0A<----> [    0.012895] Memory: 57=
060k available (2548k kernel code, 640k=0A<----> data, 96k init, 0k highmem=
)=0A<----> [    0.104378] Mount-cache hash table entries: 512=0A<----> [   =
 0.106721] checking if image is initramfs...it isn't (no cpio=0A<----> magi=
c); looks like an initrd=0A<----> [    2.414242] Freeing initrd memory: 454=
9k freed=0A<----> [    2.418712] NET: Registered protocol family 16=0A<----=
> [    2.427313] NET: Registered protocol family 2=0A<----> [    2.464244] =
IP route cache hash table entries: 512 (order: -1,=0A<----> 2048 bytes)=0A<=
----> [    2.465037] TCP established hash table entries: 2048 (order:=0A1,=
=0A<----> 8192 bytes)=0A<----> [    2.465205] TCP bind hash table entries: =
1024 (order: 0, 4096=0A<----> bytes)=0A<----> [    2.465296] TCP: Hash tabl=
es configured (established 2048 bind=0A<----> 1024)=0A<----> [    2.465324]=
 TCP reno registered=0A<----> [    2.474633] NTFS driver 2.1.27 [Flags: R/O=
].=0A<----> [    2.475046] JFS: nTxBlock =3D 481, nTxLock =3D 3854=0A<---->=
 [    2.477623] SGI XFS with no debug enabled=0A<----> [    2.479001] io sc=
heduler noop registered=0A<----> [    2.479109] io scheduler anticipatory r=
egistered=0A<----> [    2.479197] io scheduler deadline registered=0A<---->=
 [    2.479402] io scheduler cfq registered (default)=0A<----> [    2.51762=
7] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D 1) is=0Aa=0A<----> uartli=
te=0A<----> [    2.691029] RAMDISK driver initialized: 16 RAM disks of=0A46=
60000K=0A<----> size 1024 blocksize=0A<----> [    2.703933] loop: loaded (m=
ax 8 devices)=0A<----> [    2.709698] XTemac: using sgDMA mode.=0A<----> [ =
   2.713493] XTemac: using TxDRE mode=0A<----> [    2.717081] XTemac: using=
 RxDRE mode=0A<----> [    2.720678] XTemac: buffer descriptor size: 32768 (=
0x8000)=0A<----> [    2.726622] XTemac: (buffer_descriptor_init) phy: 0x580=
000,=0Avirt:=0A<----> 0xff100000, size: 0x8000=0A<----> [    2.741073] eth0=
: Xilinx TEMAC #0 at 0x60000000 mapped to=0A<----> 0xC5050000, irq=3D0=0A<-=
---> [    2.748080] eth0: XTemac id 1.0f, block id 5, type 8=0A<----> [    =
2.753636] mice: PS/2 mouse device common for all mice=0A<----> [    2.75952=
9] TCP bic registered=0A<----> [    3.264317] eth0: XTemac: Options: 0xb8f2=
=0A<----> [   15.227339] eth0: XTemac: Not able to set the speed to 1000=0A=
<----> (status: 0x148)=0A<----> [   25.200394] eth0: XTemac: Not able to se=
t the speed to 100=0A<----> (status: 0x148)=0A<----> [   35.173357] eth0: X=
Temac: Not able to set the speed to 10=0A(status:=0A<----> 0x148)=0A<----> =
[   35.180122] eth0: XTemac: could not negotiate speed=0A<----> [   35.1877=
40] eth0: XTemac: Send Threshold =3D 16, Receive=0AThreshold =3D=0A<----> 2=
=0A<----> [   35.194116] eth0: XTemac: Send Wait bound =3D 1, Receive Wait=
=0Abound=0A<----> =3D 1=0A<----> [   36.205399] IP-Config: Complete:=0A<---=
-> [   36.208459]       device=3Deth0, addr=3D192.168.1.100,=0A<----> mask=
=3D255.255.255.0, gw=3D192.168.1.1,=0A<----> [   36.216339]      host=3Dnab=
, domain=3D, nis-domain=3D(none),=0A<----> [   36.221487]      bootserver=
=3D192.168.1.144,=0A<----> rootserver=3D192.168.1.144, rootpath=3D=0A<---->=
 [   36.229826] RAMDISK: Compressed image found at block 0=0A<----> [   37.=
200498] eth0: XTemac: PHY Link carrier lost.=0A<----> [   39.097820] VFS: M=
ounted root (ext2 filesystem).=0A<----> [   39.102751] Freeing unused kerne=
l memory: 96k init=0A<----> [   39.108356] ulite_startup: UART status =3D 0=
x0014=0A<----> [   39.124619] ulite_startup: UART status =3D 0x0014=0A<----=
> [   39.134313] ulite_startup: UART status =3D 0x0014=0A<----> =0A<----> =
=0A<----> BusyBox v1.00-pre9 (2004.04.18-19:53+0000) Built-in shell (ash)=
=0A<----> Enter 'help' for a list of built-in commands.=0A<----> =0A<----> =
-sh: can't access tty; job control turned off=0A<----> =0A=0A=0A___________=
____________________________________=0ALinuxppc-embedded mailing list=0ALin=
uxppc-embedded@ozlabs.org=0Ahttps://ozlabs.org/mailman/listinfo/linuxppc-em=
bedded=0A=0A=0A
