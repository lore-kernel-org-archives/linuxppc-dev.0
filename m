Return-Path: <jpl@xiphos.ca>
Received: from smtp161.iad.emailsrvr.com (smtp161.iad.emailsrvr.com
	[207.97.245.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D73EDDECF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Dec 2008 08:18:36 +1100 (EST)
Date: Tue, 30 Dec 2008 16:18:33 -0500 (EST)
Subject: RE: virtex uImage and serial ports
From: "Joshua Lamorie" <jpl@xiphos.ca>
To: "John Linn" <John.Linn@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
In-Reply-To: <20081230192309.05D4C158063@mail121-wa4.bigfish.com>
References: <20081230192309.05D4C158063@mail121-wa4.bigfish.com>
Message-ID: <1230671913.743311978@192.168.1.201>
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

Gidday John,=0A=0AThanks for the clue.  This works.  Now to get a proper 2.=
6 style (with udev, sysfs and all those new fangled things) root filesystem=
 up and running.  It boots fine with my old 2.4 style buildroot/busybox fil=
esystem.=0A=0AThanks again.=0A=0AJoshua=0A=0AOn Tuesday, 30 December, 2008 =
14:23, "John Linn" <John.Linn@xilinx.com> said:=0A=0A> It's been a while, b=
ut here's what I remember.=0A> =0A> You have to have SERIAL_OF* turned on i=
n the kernel configuration to get=0A> the code to work.=0A> =0A> Then the d=
evice tree gets parsed by of_serial.c functions for the 16550=0A> uart.=0A>=
 =0A> -- John=0A> =0A>> -----Original Message-----=0A>> From: Joshua Lamori=
e [mailto:jpl@xiphos.ca]=0A>> Sent: Tuesday, December 30, 2008 12:14 PM=0A>=
> To: John Linn=0A>> Cc: linuxppc-embedded@ozlabs.org=0A>> Subject: RE: vir=
tex uImage and serial ports=0A>>=0A>> Gidday John,=0A>>=0A>> Thanks for the=
 pointer.  I think I have already gone through every=0A> possible page on t=
he wiki, without=0A>> finding my answer.  There are some great pointers how=
ever, such as=0A>> http://xilinx.wikidot.com/debugging-kernel-boot-problems=
.=0A>>=0A>> As far as I can tell, if I do 'make uImage', there is no code b=
uilt=0A> into vmlinux that will parse the=0A>> device tree and set up the s=
erial ports (at least as far as I can see=0A> with objdump -S).  When it=0A=
>> boots, there is no console output and __log_buf doesn't show any=0A> ser=
ial ports detected during the=0A>> initialization of the serial driver.=0A>=
>=0A>> Which leads to my question, how does the 8250 serial driver get the=
=0A> information about the attached=0A>> serial ports from the dtb?  Which =
part of the code parses the dtb,=0A> finds the "ns16550" and=0A>> updates/b=
uilds the platform_device information for the 8250 serial=0A> port driver?=
=0A>>=0A>> Joshua=0A>>=0A>> On Tuesday, 30 December, 2008 13:16, "John Linn=
"=0A> <John.Linn@xilinx.com> said:=0A>>=0A>> > Hi Joshua,=0A>> >=0A>> > Hav=
e you looked at our wiki site at http://xilinx.wikidot.com as we=0A>> > qui=
te a bit of information there.=0A>> >=0A>> > The ML405 board is a V2Pro chi=
p so it should be pretty close to what=0A> you=0A>> > want using the defaul=
t kernel config for virtex4.=0A>> >=0A>> > I haven't tested the console at =
115,200 as I use it at 9600.=0A> Shouldn't=0A>> > be a problem, but may not=
 hurt to stay at 9600 to get it working.=0A>> >=0A>> > There are pages on t=
he wiki about using u-boot with the kernel also=0A> as=0A>> > it sounds lik=
e that's what you're doing.=0A>> >=0A>> > Thanks,=0A>> > John=0A>> >=0A>> >=
=0A>> >> -----Original Message-----=0A>> >> From: linuxppc-embedded-bounces=
+john.linn=3Dxilinx.com@ozlabs.org=0A>> > [mailto:linuxppc-embedded-=0A>> >=
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Joshua=0A> Lamori=
e=0A>> >> Sent: Wednesday, December 24, 2008 3:48 PM=0A>> >> To: linuxppc-e=
mbedded@ozlabs.org=0A>> >> Subject: virtex uImage and serial ports=0A>> >>=
=0A>> >> Gidday there,=0A>> >>=0A>> >> I am trying to get 2.6.27(ish) runni=
ng on my custom Virtex-II Pro=0A>> > platform (I call it Q5).  I already=0A=
>> >> have many years of running 2.4.26 and booting from u-boot.=0A>> >>=0A=
>> >> The problem is getting the console running.  I have a device tree=0A>=
 blob=0A>> > built and loaded into memory,=0A>> >> and by peeking at __log_=
buf I can see that it is reading this okay=0A>> > (i.e. it is correctly fin=
ding my=0A>> >> interrupt controller).  However, by the time it goes to mou=
nt the=0A>> > ramdisk as root, it complains that=0A>> >> there is no consol=
e.=0A>> >>=0A>> >> I'm fairly certain /chosen has stdout pointing to the co=
rrect UART,=0A>> > and the console arguments are=0A>> >> ttyS0,115200.=0A>>=
 >>=0A>> >> In looking through the code however, I cannot figure out how th=
e=0A>> > uImage code actually initializes the=0A>> >> serial-ports for the =
XILINX_VIRTEX_GENERIC_BOARD.  As I understand=0A> it,=0A>> > the only place=
 where=0A>> >> serial_console_init is called, is within platform_init, and =
this=0A> isn't=0A>> > called for uImage.=0A>> >>=0A>> >> So, three question=
s.=0A>> >>=0A>> >> 1) How is the serial driver supposed to know where the p=
latforms=0A>> > serial ports are?=0A>> >>=0A>> >> 2) If I wanted to scrap u=
-boot and just copy kernel/ramdisk/dtb to=0A>> > memory, which kernel make =
target=0A>> >> should I use?  dtbImage, simpleImage?=0A>> >>=0A>> >> 3) Wha=
t is the best, most modern image to build that should be used=0A> by=0A>> >=
 u-boot?=0A>> >>=0A>> >> Thanks in advance=0A>> >>=0A>> >> Joshua=0A>> >>=
=0A>> >> p.s. I've been trying with kernel.org mainline, xilinx git and den=
x=0A>> > ELDK xenomai (2.6.24).  U-boot is=0A>> >> built from latest git so=
urce.  DTS file built from XPS 9.1i with=0A>> > latest service packs, and t=
urned=0A>> >> into DTB with latest dtc source from git.=0A>> >>=0A>> >>=0A>=
> >> --=0A>> >> Xiphos Technologies=0A>> >> (514) 847-9474 x227=0A>> >> (51=
4) 848-9644 fax=0A>> >>=0A>> >> www.xiphos.com=0A>> >> ____________________=
___________________________=0A>> >> The information transmitted is intended=
 only for the=0A>> >> person or entity to which it is addressed and may con=
tain=0A>> >> confidential and/or privileged material.  If you have=0A>> >> =
received this in error, please contact the sender and delete=0A>> >> this c=
ommunication and any copy immediately. Thank you.=0A>> >>=0A>> >>=0A>> >>=
=0A>> >> _______________________________________________=0A>> >> Linuxppc-e=
mbedded mailing list=0A>> >> Linuxppc-embedded@ozlabs.org=0A>> >> https://o=
zlabs.org/mailman/listinfo/linuxppc-embedded=0A>> >=0A>> >=0A>> > This emai=
l and any attachments are intended for the sole use of the=0A> named=0A>> >=
 recipient(s) and contain(s) confidential information that may be=0A> propr=
ietary,=0A>> > privileged or copyrighted under applicable law. If you are n=
ot the=0A> intended=0A>> > recipient, do not read, copy, or forward this em=
ail message or any=0A> attachments.=0A>> > Delete this email message and an=
y attachments immediately.=0A>> >=0A>> >=0A>> > ___________________________=
____________________=0A>> > Linuxppc-embedded mailing list=0A>> > Linuxppc-=
embedded@ozlabs.org=0A>> > https://ozlabs.org/mailman/listinfo/linuxppc-emb=
edded=0A>> >=0A>>=0A>>=0A>> --=0A>> Xiphos Technologies=0A>> (514) 847-9474=
 x227=0A>> (514) 848-9644 fax=0A>>=0A>> www.xiphos.com=0A>> _______________=
________________________________=0A>> The information transmitted is intend=
ed only for the=0A>> person or entity to which it is addressed and may cont=
ain=0A>> confidential and/or privileged material.  If you have=0A>> receive=
d this in error, please contact the sender and delete=0A>> this communicati=
on and any copy immediately. Thank you.=0A>>=0A>>=0A>>=0A>>=0A> =0A> =0A> T=
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
