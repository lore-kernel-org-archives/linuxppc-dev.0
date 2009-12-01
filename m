Return-Path: <aiyuanwang@yahoo.com>
Received: from web52902.mail.re2.yahoo.com (web52902.mail.re2.yahoo.com
	[206.190.49.12]) by ozlabs.org (Postfix) with SMTP id 7B09DB7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 16:35:18 +1100 (EST)
Message-ID: <288168.33010.qm@web52902.mail.re2.yahoo.com>
Date: Mon, 30 Nov 2009 21:35:15 -0800 (PST)
From: Allan Wang <aiyuanwang@yahoo.com>
Subject: ep440xs board boot problem
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, All,=0A=0AI am new to the list. I am still newbie to embedded linux.=
 I have bought an ep440xs board which is similar to sequoia board. u-boot i=
s working. I am trying to make it run linux.  I have the following problems=
 and need your help. Thank you very much:=0A=0A=0AI am using linux kernel 2=
.6.30.4. I encounter 2 problems:=0A1. After console_init() is called inside=
 start_kernel(), the console starts printing garbage like:=0ASerial: 8250/1=
6550 driver, 4 ports, IRQ sharing enabled=0Aserial8250.0: ttyS0 at MMIO 0x1=
ef600300 (irq =3D 16) is a 16550A=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=0A=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD.=0A2. It pakics when mounting the root file system(NFS):=0A=
(gdb) bt=0A#0  panic (fmt=3D0xc0290e94 "VFS: Unable to mount root fs on %s"=
)=0Aat kernel/panic.c:70=0A#1  0xc02d8ce0 in mount_block_root (name=3D0xc02=
90de4 "/dev/root", flags=3D0x8001)=0Aat init/do_mounts.c:272=0A#2  0xc02d90=
84 in prepare_namespace () at init/do_mounts.c:415=0A#3  0xc02d81ec in kern=
el_init (unused=3D<value optimized out>) at init/main.c:885=0A#4  0xc000de6=
0 in kernel_thread ()=0AThere is a patch for Sequoia board to delete /chose=
n part in sequoia.dts, is /chosen required?=0A=0AAllan=0A=0A=0A=0A      
