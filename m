Return-Path: <tony.p.lee@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.198])
	by ozlabs.org (Postfix) with ESMTP id 4F857681D2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 11:17:52 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i36so61770wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 18:17:51 -0700 (PDT)
Message-ID: <470b639705083118114bcd2070@mail.gmail.com>
Date: Wed, 31 Aug 2005 18:11:06 -0700
From: Tony Lee <tony.p.lee@gmail.com>
To: Peter Ryser <peter.ryser@xilinx.com>
In-Reply-To: <4313FA43.1040206@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7469_18531567.1125537066659"
References: <OF9C3C40D4.4EC5E6BD-ON0725706C.0064A09D-0725706C.0065B9FC@mck.us.ray.com>
	<4313FA43.1040206@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linuxppc-2.4.30-pre1 crashes with root fs on Xilinx SystemACE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7469_18531567.1125537066659
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Keith,=20

Some suggestions, before you verify your hw board/FPGA works fine with=20
SYSACE,=20
* don't use sysace as root fs.
* use a ram fs as root fs.=20
* Next, load sysace driver a loadable driver module. It works, I tried it.
* check mount read only and see if it works.
* Next, mount it writable.

We have some issues with sysace driver initially, everything works out fine=
=20
later.
There were small errors in our HW layout.

I had to hack the sysace driver left and right to id the problem. But at th=
e=20

end, after I fixed the layout problem from the fpga's ucf file, the origina=
l=20
driver
run perfectly without any modification.

In my experiences, the ppc linux distribution and its linux sysace driver=
=20
are good
if everything is setup correctly.

One minor issues: The sysace driver's write performance sucks. I have to=20
explain
to others why the upgrade 10 MBytes files with usb flash writer takes tens=
=20
of=20
seconds. When we do it from linux (nfs or ftp), it tooks minutes to sync.

Peter, maybe you can push the xilinx a bit on sysace write performance? :-)

-Tony

On 8/29/05, Peter Ryser <peter.ryser@xilinx.com> wrote:
>=20
> Hi Keith,
>=20
> I sent you a private email but for other interested people:
> Downloading the latest linuxppc-2.4 kernel I could boot from and access
> System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a ML310
> (Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with
> config_xilinx_ml300.
>=20
> - Peter
>=20
>=20
>=20
> Keith J Outwater wrote:
>=20
> >Hello -
> >Per a previous suggestion from this list, I rsynced the linuxppc-2.4
> >kernel sources from MontaVista and modified the kernel to run on my=20
> custom
> >ppc405/VirtexII Pro based system with U-Boot as the bootloader.
> >When I try to use the SystemACE device as the root filesystem, the kerne=
l
> >crashes with a sig 11. Looking at the 'oops' output it appears the
> >SystemACE driver may be to blame. The crash is random - sometimes I get
> >all the way to login as root and then things crash on a file copy or a
> >file read.
> >Before I start digging deeper, is anyone running a VirtexIIPro based
> >system with the root filesystem in the CF card attached to a SystemACE?
> >I'm wondering if I really have the best kernel and SystemACE driver.
> >BTW, I'm developing the hardware design using Xilinx EDK 7.02i.
> >Thanks,
> >Keith
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> >
> >
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20



--=20
-Tony
Having fun with FPGA HW + ppc + Linux

------=_Part_7469_18531567.1125537066659
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Keith,&nbsp; <br>
<br>
Some suggestions, before you verify your hw board/FPGA works fine with SYSA=
CE, <br>
&nbsp;&nbsp;&nbsp; * don't use sysace as root fs.<br>
&nbsp;&nbsp;&nbsp; * use a ram fs as root fs.&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; * Next, load sysace driver a loadable driver module.&nbs=
p; It works, I tried it.<br>
&nbsp;&nbsp;&nbsp; * check mount read only and see if it works.<br>
&nbsp;&nbsp;&nbsp; * Next, mount it writable.<br>
<br>
We have some issues with sysace driver initially, everything works out fine=
 later.<br>
There were small errors in our HW layout.<br>
<br>
I had to hack the sysace driver left and right to id the problem.&nbsp; But=
 at the <br>
end, after I fixed the layout problem from the fpga's ucf file, the origina=
l driver<br>
run perfectly without any modification.<br>
<br>
In my experiences, the ppc linux distribution and its linux sysace driver a=
re good<br>
if everything is setup correctly.<br>
<br>
One minor issues:&nbsp; The sysace driver's write performance sucks.&nbsp; =
I have to explain<br>

to others why the upgrade 10 MBytes files with usb flash writer takes tens =
of <br>

seconds.&nbsp; When we do it from linux (nfs or ftp), it tooks minutes to s=
ync.<br>

<br>
Peter, maybe you can push the xilinx a bit on sysace write performance? :-)=
<br>
<br>
-Tony<br><br><div><span class=3D"gmail_quote">On 8/29/05, <b class=3D"gmail=
_sendername">Peter Ryser</b> &lt;<a href=3D"mailto:peter.ryser@xilinx.com">=
peter.ryser@xilinx.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Hi Keith,<br><br>I sent you a private email but for other interested people=
:<br>Downloading the latest linuxppc-2.4 kernel I could boot from and acces=
s<br>System ACE CF without problems on a ML403 (Virtex-4, 4VFX12) and a ML3=
10
<br>(Virtex-II Pro, 2VP30) using EDK 7.1.2. In both cases I started with<br=
>config_xilinx_ml300.<br><br>- Peter<br><br><br><br>Keith J Outwater wrote:=
<br><br>&gt;Hello -<br>&gt;Per a previous suggestion from this list, I rsyn=
ced the=20
linuxppc-2.4<br>&gt;kernel sources from MontaVista and modified the kernel =
to run on my custom<br>&gt;ppc405/VirtexII Pro based system with U-Boot as =
the bootloader.<br>&gt;When I try to use the SystemACE device as the root f=
ilesystem, the kernel
<br>&gt;crashes with a sig 11.&nbsp;&nbsp;Looking at the 'oops' output it a=
ppears&nbsp;&nbsp;the<br>&gt;SystemACE driver may be to blame.&nbsp;&nbsp;T=
he crash is random - sometimes I get<br>&gt;all the way to login as root an=
d then things crash on a file copy or a
<br>&gt;file read.<br>&gt;Before I start digging deeper, is anyone running =
a VirtexIIPro based<br>&gt;system with the root filesystem in the CF card a=
ttached to a SystemACE?<br>&gt;I'm wondering if I really have the best kern=
el and SystemACE driver.
<br>&gt;BTW, I'm developing the hardware design using Xilinx EDK 7.02i.<br>=
&gt;Thanks,<br>&gt;Keith<br>&gt;___________________________________________=
____<br>&gt;Linuxppc-embedded mailing list<br>&gt;<a href=3D"mailto:Linuxpp=
c-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br>&gt;<a href=3D"https://ozlabs.org/mailm=
an/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc=
-embedded</a><br>&gt;<br>&gt;<br>&gt;<br>&gt;<br><br><br><br>______________=
_________________________________
<br>Linuxppc-embedded mailing list<br><a href=3D"mailto:Linuxppc-embedded@o=
zlabs.org">Linuxppc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.or=
g/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/l=
inuxppc-embedded
</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br>-Tony<br>Having=
 fun with FPGA HW + ppc + Linux<br>

------=_Part_7469_18531567.1125537066659--
