Return-Path: <aiyuanwang@yahoo.com>
Received: from web52905.mail.re2.yahoo.com (web52905.mail.re2.yahoo.com
	[206.190.49.15]) by ozlabs.org (Postfix) with SMTP id E82E6B7B60
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 15:22:49 +1100 (EST)
Message-ID: <880531.39933.qm@web52905.mail.re2.yahoo.com>
References: <401793.31718.qm@web52903.mail.re2.yahoo.com>
	<20091201231022.AB72CE6D391@gemini.denx.de>
Date: Tue, 1 Dec 2009 20:22:47 -0800 (PST)
From: Allan Wang <aiyuanwang@yahoo.com>
Subject: Re: EP440XS board boot problem(Note:similart to Sequoia)
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20091201231022.AB72CE6D391@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Mr Denk,=0A=0AThank you for your help. My answer to your questions a=
re between the lines. Attached is the dts file I use.=0A=0ABest regards,=0A=
=0AAllan=0A=0A=0A=0A----- Original Message ----=0AFrom: Wolfgang Denk <wd@d=
enx.de>=0ATo: Allan Wang <aiyuanwang@yahoo.com>=0ACc: linuxppc-dev@lists.oz=
labs.org=0ASent: Tue, December 1, 2009 6:10:22 PM=0ASubject: Re: EP440XS bo=
ard boot problem(Note:similart to Sequoia)=0A=0ADear Allan Wang,=0A=0AIn me=
ssage <401793.31718.qm@web52903.mail.re2.yahoo.com> you wrote:=0A>=0A> I am=
 new to the list. I am still newbie to embedded linux. I have=0A> bought an=
 ep440xs board which is similar to sequoia board. u-boot is=0A> working. I =
am trying to make it run linux. I have the following=0A> problems and need =
your help. Thank you very much:=0A=0AWhich exact version of U-Boot are you =
running on this board?=0A=0A=3D> version=0A=0AU-Boot 1.1.6 (Oct 25 2009 - 1=
3:26:41)=0A=0A=0AI guess this is a out-of-tree port, i. e. not part of the =
mainline=0AU-Boot repository - so are you sure that device tree support is=
=0Aenabled in your version of U-Boot?=0A=0AThe device tree is not enabled i=
n u-boot. I am building cuImage, so the device tree is supported in kernel(=
2.6.30.4).=0A=0A> =0A> I am using linux kernel 2.6.30.4. I encounter 2 prob=
lems:=0A> 1. After console_init() is called inside start_kernel(), the cons=
ole starts printing garbage like:=0A> Serial: 8250/16550 driver, 4 ports, I=
RQ sharing enabled=0A> serial8250.0: ttyS0 at MMIO 0x1ef600300 (irq =3D 16)=
 is a 16550A=0A> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=0A...=0A=0A=
What is your exact boot command?=0A=0AI tftp the cuImage to address 0x20000=
0 and bootm to boot.=0A=0AWhich boot arguments do you pass to the kernel?=
=0A=0Abootargs=3D$(bootargs) console=3DttyS0,$(baudrate)=0A=0AWhat is ytour=
 console baud rate in U-Boot, and what sort of "console=3D"=0Aboot argument=
 do you pass to the Linux kernel?=0A=0AThe u-boot sets it to 115.2k. the dt=
s file is set to 115.2k. Here is the boot parameter:=0Abaudrate=3D115200=0A=
=0AWhat does your device tree look like?=0A=0AI attached my dts file.=0A=0A=
> 2. It pakics when mounting the root file system(NFS):=0A> (gdb) bt=0A> #0=
 panic (fmt=3D0xc0290e94 "VFS: Unable to mount root fs on %s")=0A=0ASo what=
 is the "%s" argument here? Which sort of root file system are=0Ayou trying=
 to mount - NFS, ramdisk, UBIFS, ... ?=0A=0AI try to use NFS for the root f=
ile system.=0A=0ABest regards,=0A=0AWolfgang Denk=0A=0A-- =0ADENX Software =
Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel=0AHRB 165235 Munich=
, Office: Kirchenstr.5, D-82194 Groebenzell, Germany=0APhone: (+49)-8142-66=
989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de=0A"He only drinks when he=
 gets depressed." "Why does he get depressed?"=0A"Sometimes it's because he=
 hasn't had a drink."=0A                                     - Terry Pratch=
ett, _Men at Arms_=0A=0A=0A=0A      
