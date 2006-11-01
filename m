Return-Path: <rcorley@aegis-inc.net>
Received: from web56302.mail.re3.yahoo.com (web56302.mail.re3.yahoo.com
	[216.252.110.226]) by ozlabs.org (Postfix) with SMTP id 5912067A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 01:59:27 +1100 (EST)
Message-ID: <20061101145926.62661.qmail@web56302.mail.re3.yahoo.com>
Date: Wed, 1 Nov 2006 06:59:26 -0800 (PST)
From: Robert Corley <rcorley@aegis-inc.net>
Subject: plb_temac w/linux 2.6.18.1 driver init error
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone made progress with the MVL drivers for the plb_temac in linux 2.=
6.18?=0A=0AI am having initialization problems as is shown in the kernel du=
mp below.  Note that I have added=0Asome printk's to show the status of the=
 device before XTemac_VmInitialize(...) is called.=0A=0A2.6.18 kernel with =
all patches=0A11/01/2006    09:45=0APLB_TEMAC=0A=0Aloaded at:     00400000 =
00985138=0Aboard data at: 00983120 00983138=0Arelocated to:  0040407C 00404=
094=0Azimage at:     00404E8F 0051024E=0Ainitrd at:     00511000 009826FE=
=0Aavail ram:     00986000 04000000=0A=0ALinux/PPC load: console=3DttyUL0 s=
ingle ip=3Doff ramdisk_size=3D4660000 root=3D/dev/ram rw=0A=0AUncompressing=
 Linux...done.=0A=0ANow booting the kernel=0A=0A[    0.000000] Linux versio=
n 2.6.17.1 (rdcorle@athena) (gcc version 3.4.2) #6 Wed Nov 1 14:28:43 UTC 2=
006=0A[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)=0A[    0.0=
00000] Built 1 zonelists.  Total pages: 16384=0A[    0.000000] Kernel comma=
nd line: console=3DttyUL0 single ip=3Doff ramdisk_size=3D4660000 root=3D/de=
v/ram rw=0A[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFDFFFFC0=
=0A[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)=0A[   =
 0.000157] Console: colour dummy device 80x25=0A[    0.000567] Dentry cache=
 hash table entries: 8192 (order: 3, 32768 bytes)=0A[    0.001275] Inode-ca=
che hash table entries: 4096 (order: 2, 16384 bytes)=0A[    0.012989] Memor=
y: 58024k available (1740k kernel code, 484k data, 92k init, 0k highmem)=0A=
[    0.104387] Mount-cache hash table entries: 512=0A[    0.106727] checkin=
g if image is initramfs...it isn't (no cpio magic); looks like an initrd=0A=
[    2.410153] Freeing initrd memory: 4549k freed=0A[    2.414699] NET: Reg=
istered protocol family 16=0A[    2.423477] NET: Registered protocol family=
 2=0A[    2.460259] IP route cache hash table entries: 512 (order: -1, 2048=
 bytes)=0A[    2.461080] TCP established hash table entries: 2048 (order: 1=
, 8192 bytes)=0A[    2.461247] TCP bind hash table entries: 1024 (order: 0,=
 4096 bytes)=0A[    2.461339] TCP: Hash tables configured (established 2048=
 bind 1024)=0A[    2.461368] TCP reno registered=0A[    2.469853] NTFS driv=
er 2.1.27 [Flags: R/O].=0A[    2.470086] io scheduler noop registered=0A[  =
  2.470162] io scheduler anticipatory registered=0A[    2.470234] io schedu=
ler deadline registered=0A[    2.470362] io scheduler cfq registered (defau=
lt)=0A[    2.509013] uartlite.0: ttyUL0 at MMIO 0xa0000000 (irq =3D 1) is a=
 uartlite=0A[    2.669456] RAMDISK driver initialized: 16 RAM disks of 4660=
000K size 1024 blocksize=0A[    2.682424] loop: loaded (max 8 devices)=0A[ =
   2.688358] xtenet_probe: xtemac 0: IO resources obtained.  IRQ =3D 0, MEM=
 =3D 0x60000000=0A[    2.696263] xtenet_probe: xtemac 0: private data initi=
alized=0A[    2.701997] xtenet_probe: TEMAC config lookup succeeded.  Detai=
ls =3D =0A[    2.708372]         Base address    =3D 0x60000000, remap addr=
ess =3D 0xC5008000=0A[    2.714899]         Unique ID       =3D 0x0000=0A[ =
   2.718659]         RCV FIFO depth  =3D 0x131072=0A[    2.722589]         =
XMIT FIFO depth =3D 0x131072=0A[    2.726520]         MAC FIFO depth  =3D 0=
x16=0A[    2.730105]         IPIF/DMA config =3D 0x03=0A[    2.733689]     =
    DCR Host        =3D 0x0=0A[    2.737189]         DRE Engine?     =3D 0x=
1=0A[    2.740695] Data machine check in kernel mode.=0A[    2.745138] Oops=
: machine check, sig: 7 [#1]=0A[    2.749399] NIP: C013A538 LR: C013A510 CT=
R: 00000000=0A[    2.754354] REGS: c022ef50 TRAP: 0202   Not tainted  (2.6.=
17.1)=0A[    2.760252] MSR: 00029030 <EE,ME,IR,DR>  CR: 84000022  XER: 4000=
001D=0A[    2.766601] TASK =3D c02d5b70[1] 'swapper' THREAD: c0988000=0A[  =
  2.771811] GPR00: 00000001 C0989DE0 C02D5B70 C0945344 00000068 C500A200 C0=
94544C C01E4F98 =0A[    2.780191] GPR08: C500A010 C0230000 11111111 C094532=
4 24000022 C000A09C BBE6EA1D C0230000 =0A[    2.788572] GPR16: 00000000 00B=
EF29E 00000000 C0231B50 00000000 C01E0000 C01E0000 C01E4820 =0A[    2.79693=
4] GPR24: C09452F8 C01C0000 C09452F8 C01E4818 C01E4EA0 C5008000 C0945000 C0=
9452F8 =0A[    2.805487] NIP [C013A538] XTemac_ConfigureFifoAccess+0x50/0xb=
4=0A[    2.811422] LR [C013A510] XTemac_ConfigureFifoAccess+0x28/0xb4=0A[  =
  2.817250] Call Trace:=0A[    2.819695] [C0989DE0] [C013A510] XTemac_Confi=
gureFifoAccess+0x28/0xb4 (unreliable)=0A[    2.827340] [C0989E00] [C01389D8=
] Initialize+0x3c/0xe8=0A[    2.832506] [C0989E20] [C0137F04] xtenet_probe+=
0x228/0x7c8=0A[    2.838001] [C0989EA0] [C012F124] driver_probe_device+0xc8=
/0x118=0A[    2.844006] [C0989EC0] [C012F30C] __driver_attach+0xdc/0x108=0A=
[    2.849664] [C0989EE0] [C012E32C] bus_for_each_dev+0x54/0x98=0A[    2.85=
5322] [C0989F10] [C012F35C] driver_attach+0x24/0x34=0A[    2.860722] [C0989=
F20] [C012EA20] bus_add_driver+0x88/0x14c=0A[    2.866295] [C0989F50] [C012=
F924] driver_register+0x70/0xbc=0A[    2.871867] [C0989F70] [C0226684] xten=
et_init+0x18/0x28=0A[    2.877093] [C0989F80] [C0002428] init+0x84/0x2e4=0A=
[    2.881801] [C0989FF0] [C00051DC] kernel_thread+0x44/0x60=0A[    2.88720=
4] Instruction dump:=0A[    2.890159] 38842010 4800619d 38000001 2f830000 3=
87f004c 419e001c 7c030378 80010024 =0A[    2.897926] 83e1001c 38210020 7c08=
03a6 4e800020 <809f0000> 38a42100 38842000 48006165 =0A[    2.906034] Kerne=
l panic - not syncing: Attempted to kill init!=0A[    2.911957]  <0>Rebooti=
ng in 180 seconds..=0A=0A-cy=0A=0A
