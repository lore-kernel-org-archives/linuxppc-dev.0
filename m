Return-Path: <jpl@xiphos.ca>
Received: from smtp231.iad.emailsrvr.com (smtp231.iad.emailsrvr.com
	[207.97.245.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07AD5DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Dec 2008 06:13:56 +1100 (EST)
Date: Tue, 30 Dec 2008 14:13:53 -0500 (EST)
Subject: RE: virtex uImage and serial ports
From: "Joshua Lamorie" <jpl@xiphos.ca>
To: "John Linn" <John.Linn@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
In-Reply-To: <20081230181636.49A821BA0065@mail222-wa4.bigfish.com>
References: <20081230181636.49A821BA0065@mail222-wa4.bigfish.com>
Message-ID: <1230664433.702423004@192.168.1.201>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday John,=0A=0AThanks for the pointer.  I think I have already gone thro=
ugh every possible page on the wiki, without finding my answer.  There are =
some great pointers however, such as http://xilinx.wikidot.com/debugging-ke=
rnel-boot-problems.  =0A=0AAs far as I can tell, if I do 'make uImage', the=
re is no code built into vmlinux that will parse the device tree and set up=
 the serial ports (at least as far as I can see with objdump -S).  When it =
boots, there is no console output and __log_buf doesn't show any serial por=
ts detected during the initialization of the serial driver.=0A=0AWhich lead=
s to my question, how does the 8250 serial driver get the information about=
 the attached serial ports from the dtb?  Which part of the code parses the=
 dtb, finds the "ns16550" and updates/builds the platform_device informatio=
n for the 8250 serial port driver?=0A=0AJoshua=0A=0AOn Tuesday, 30 December=
, 2008 13:16, "John Linn" <John.Linn@xilinx.com> said:=0A=0A> Hi Joshua,=0A=
> =0A> Have you looked at our wiki site at http://xilinx.wikidot.com as we=
=0A> quite a bit of information there.=0A> =0A> The ML405 board is a V2Pro =
chip so it should be pretty close to what you=0A> want using the default ke=
rnel config for virtex4.=0A> =0A> I haven't tested the console at 115,200 a=
s I use it at 9600.  Shouldn't=0A> be a problem, but may not hurt to stay a=
t 9600 to get it working.=0A> =0A> There are pages on the wiki about using =
u-boot with the kernel also as=0A> it sounds like that's what you're doing.=
=0A> =0A> Thanks,=0A> John=0A> =0A> =0A>> -----Original Message-----=0A>> F=
rom: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org=0A> [mailt=
o:linuxppc-embedded-=0A>> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Beh=
alf Of Joshua Lamorie=0A>> Sent: Wednesday, December 24, 2008 3:48 PM=0A>> =
To: linuxppc-embedded@ozlabs.org=0A>> Subject: virtex uImage and serial por=
ts=0A>>=0A>> Gidday there,=0A>>=0A>> I am trying to get 2.6.27(ish) running=
 on my custom Virtex-II Pro=0A> platform (I call it Q5).  I already=0A>> ha=
ve many years of running 2.4.26 and booting from u-boot.=0A>>=0A>> The prob=
lem is getting the console running.  I have a device tree blob=0A> built an=
d loaded into memory,=0A>> and by peeking at __log_buf I can see that it is=
 reading this okay=0A> (i.e. it is correctly finding my=0A>> interrupt cont=
roller).  However, by the time it goes to mount the=0A> ramdisk as root, it=
 complains that=0A>> there is no console.=0A>>=0A>> I'm fairly certain /cho=
sen has stdout pointing to the correct UART,=0A> and the console arguments =
are=0A>> ttyS0,115200.=0A>>=0A>> In looking through the code however, I can=
not figure out how the=0A> uImage code actually initializes the=0A>> serial=
-ports for the XILINX_VIRTEX_GENERIC_BOARD.  As I understand it,=0A> the on=
ly place where=0A>> serial_console_init is called, is within platform_init,=
 and this isn't=0A> called for uImage.=0A>>=0A>> So, three questions.=0A>>=
=0A>> 1) How is the serial driver supposed to know where the platforms=0A> =
serial ports are?=0A>>=0A>> 2) If I wanted to scrap u-boot and just copy ke=
rnel/ramdisk/dtb to=0A> memory, which kernel make target=0A>> should I use?=
  dtbImage, simpleImage?=0A>>=0A>> 3) What is the best, most modern image t=
o build that should be used by=0A> u-boot?=0A>>=0A>> Thanks in advance=0A>>=
=0A>> Joshua=0A>>=0A>> p.s. I've been trying with kernel.org mainline, xili=
nx git and denx=0A> ELDK xenomai (2.6.24).  U-boot is=0A>> built from lates=
t git source.  DTS file built from XPS 9.1i with=0A> latest service packs, =
and turned=0A>> into DTB with latest dtc source from git.=0A>>=0A>>=0A>> --=
=0A>> Xiphos Technologies=0A>> (514) 847-9474 x227=0A>> (514) 848-9644 fax=
=0A>>=0A>> www.xiphos.com=0A>> ____________________________________________=
___=0A>> The information transmitted is intended only for the=0A>> person o=
r entity to which it is addressed and may contain=0A>> confidential and/or =
privileged material.  If you have=0A>> received this in error, please conta=
ct the sender and delete=0A>> this communication and any copy immediately. =
Thank you.=0A>>=0A>>=0A>>=0A>> ____________________________________________=
___=0A>> Linuxppc-embedded mailing list=0A>> Linuxppc-embedded@ozlabs.org=
=0A>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A> =0A> =0A> T=
his email and any attachments are intended for the sole use of the named=0A=
> recipient(s) and contain(s) confidential information that may be propriet=
ary,=0A> privileged or copyrighted under applicable law. If you are not the=
 intended=0A> recipient, do not read, copy, or forward this email message o=
r any attachments.=0A> Delete this email message and any attachments immedi=
ately.=0A> =0A> =0A> _______________________________________________=0A> Li=
nuxppc-embedded mailing list=0A> Linuxppc-embedded@ozlabs.org=0A> https://o=
zlabs.org/mailman/listinfo/linuxppc-embedded=0A> =0A=0A=0A-- =0AXiphos Tech=
nologies=0A(514) 847-9474 x227=0A(514) 848-9644 fax=0A=0Awww.xiphos.com=0A_=
______________________________________________=0AThe information transmitte=
d is intended only for the=0Aperson or entity to which it is addressed and =
may contain=0Aconfidential and/or privileged material.  If you have=0Arecei=
ved this in error, please contact the sender and delete=0Athis communicatio=
n and any copy immediately. Thank you.=0A=0A=0A
