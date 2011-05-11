Return-Path: <pskhanapur@googlemail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 923711007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 21:23:53 +1000 (EST)
Received: by qwf7 with SMTP id 7so208660qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 04:23:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <45903308677306428B6EE7E6FF5A5204120187@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTik7tZSJ9-OPDbQEPJDHpZ13wMmo_Q@mail.gmail.com>
	<4DC84D09.5020909@mentor.com>
	<45903308677306428B6EE7E6FF5A5204120187@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Wed, 11 May 2011 13:23:48 +0200
Message-ID: <BANLkTimPgGjJXE+zJzumE=GcPeLEWK78mQ@mail.gmail.com>
Subject: Re: Regarding P2020 in AMP mode
From: Prasanna Khanapur <pskhanapur@googlemail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=0015175d023879595004a2fe4ebd
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175d023879595004a2fe4ebd
Content-Type: text/plain; charset=ISO-8859-1

I tried the suggestion of setting eTSEC2 as active port for the u-boot .
Ethernet  of Core1 (connected to 1G) is working now.

Thanks for the inputs , they really helped !

Best Regards
Prasanna Khanapur


On Tue, May 10, 2011 at 9:50 AM, Aggrwal Poonam-B10812 <B10812@freescale.com
> wrote:

> The code looks to be correct in upstream,
> Can u mention the AMP boot steps you are using.
>
>
> 5.5.2.4 Test Procedure
> 1. Power on the board
> 2. Follow the command below at U-boot prompt
> => setenv <serverip>
> => setenv <ipaddr>
> => setenv ethact eTSEC2
> => setenv bootargs root=/dev/ram rw console=ttyS0,115200
> 3. Bring up core1's kernel first:
> => setenv bootm_low 0x10000000
> => setenv bootm_size 0x8000000
> => tftp 11000000 uImage.core1
> => tftp 12000000 rootfs_min.ext2.gz.uboot
> => tftp 10c00000 p1020rdb_camp_core1.dtb
> => interrupts off
>
> => bootm start 11000000 12000000 10c00000
> => bootm loados
> => bootm ramdisk
> => bootm fdt
> => fdt boardsetup
> => fdt chosen $initrd_start $initrd_end
> => bootm prep
> => cpu 1 release $bootm_low - $fdtaddr -
>
> As soon as, when you run the cpu 1 release $bootm_low - $fdtaddr - command,
> Core-1 starts booting
> and boot-up log can be observed on the UART#2 console.
> 4. Bring up core0's kernel(on the same u-boot console -UART#1):
> => setenv bootm_low 0x0
> => setenv bootm_size 0x10000000
> => tftp 1000000 uImage.core0
> => tftp 2000000 rootfs_min.ext2.gz.uboot
> => tftp c00000 p1020rdb_camp_core0.dtb
> => bootm 1000000 2000000 c00000
>
>
> The main catch  here is to use eTSEC2 as active port at u-boot. I think I
> remember we also  faced similar issue.
> Regards
> Poonam
>
> > -----Original Message-----
> > From: linuxppc-dev-bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org
> > [mailto:linuxppc-dev-
> > bounces+poonam.aggrwal=freescale.com@lists.ozlabs.org] On Behalf Of
> > Hollis Blanchard
> > Sent: Tuesday, May 10, 2011 1:53 AM
> > To: Prasanna Khanapur
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: Regarding P2020 in AMP mode
> >
> > On 05/07/2011 05:20 AM, Prasanna Khanapur wrote:
> > > Hi,
> > > I'm running P2020 in AMP mode, each core running its linux os.
> > > Ethernet 1(@25000) and Ethernet 2(@26000) assigned to Core0 are
> > > working fine.
> > > I'm facing problems with Ethernet interface(@24000) assigned to Core1,
> > > its not working.
> > >
> > > I'm using dts file which were added by :
> > > http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-September/075594.h
> > > tml
> > >
> > > Looks either there is some mistake in the dts file or my understanding
> > > is wrong.
> > >
> > > MDIO @24000 is defined in core0 dts file though the Ethernet is
> > > assigned to Core 1.
> > >
> > > DTS files :
> > > http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p202
> > > 0rdb_camp_core0.dts
> > > http://web.mornfall.net/repos/linux-2.6/git/arch/powerpc/boot/dts/p202
> > > 0rdb_camp_core1.dts
> >
> > The fixed-link property in core1.dts indicates enet0 should use 1Gb link.
> > Is that device connected to a 1Gb network?
> >
> > --
> > Hollis Blanchard
> > Mentor Graphics, Embedded Systems Division
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>

--0015175d023879595004a2fe4ebd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I tried the suggestion of setting=A0eTSEC2=A0as active port for the u-boot =
.<div><div>Ethernet =A0of Core1 (connected to 1G) is working now.</div><div=
><br><div>Thanks for the inputs , they really=A0helped=A0!</div><div><br></=
div><div>
Best Regards</div><div>Prasanna Khanapur</div><div><br><br><div class=3D"gm=
ail_quote">On Tue, May 10, 2011 at 9:50 AM, Aggrwal Poonam-B10812 <span dir=
=3D"ltr">&lt;<a href=3D"mailto:B10812@freescale.com">B10812@freescale.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">The code looks to be correct in upstream,<b=
r>
Can u mention the AMP boot steps you are using.<br>
<br>
<br>
5.5.2.4 Test Procedure<br>
1. Power on the board<br>
2. Follow the command below at U-boot prompt<br>
=3D&gt; setenv &lt;serverip&gt;<br>
=3D&gt; setenv &lt;ipaddr&gt;<br>
=3D&gt; setenv ethact eTSEC2<br>
=3D&gt; setenv bootargs root=3D/dev/ram rw console=3DttyS0,115200<br>
3. Bring up core1&#39;s kernel first:<br>
=3D&gt; setenv bootm_low 0x10000000<br>
=3D&gt; setenv bootm_size 0x8000000<br>
=3D&gt; tftp 11000000 uImage.core1<br>
=3D&gt; tftp 12000000 rootfs_min.ext2.gz.uboot<br>
=3D&gt; tftp 10c00000 p1020rdb_camp_core1.dtb<br>
=3D&gt; interrupts off<br>
<br>
=3D&gt; bootm start 11000000 12000000 10c00000<br>
=3D&gt; bootm loados<br>
=3D&gt; bootm ramdisk<br>
=3D&gt; bootm fdt<br>
=3D&gt; fdt boardsetup<br>
=3D&gt; fdt chosen $initrd_start $initrd_end<br>
=3D&gt; bootm prep<br>
=3D&gt; cpu 1 release $bootm_low - $fdtaddr -<br>
<br>
As soon as, when you run the cpu 1 release $bootm_low - $fdtaddr - command,=
 Core-1 starts booting<br>
and boot-up log can be observed on the UART#2 console.<br>
4. Bring up core0&#39;s kernel(on the same u-boot console -UART#1):<br>
=3D&gt; setenv bootm_low 0x0<br>
=3D&gt; setenv bootm_size 0x10000000<br>
=3D&gt; tftp 1000000 uImage.core0<br>
=3D&gt; tftp 2000000 rootfs_min.ext2.gz.uboot<br>
=3D&gt; tftp c00000 p1020rdb_camp_core0.dtb<br>
=3D&gt; bootm 1000000 2000000 c00000<br>
<br>
<br>
The main catch =A0here is to use eTSEC2 as active port at u-boot. I think I=
 remember we also =A0faced similar issue.<br>
Regards<br>
Poonam<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: linuxppc-dev-bounces+poonam.aggrwal=3D<a href=3D"http://freescal=
e.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://lists.ozlabs.o=
rg" target=3D"_blank">lists.ozlabs.org</a><br>
&gt; [mailto:<a href=3D"mailto:linuxppc-dev-">linuxppc-dev-</a><br>
&gt; bounces+poonam.aggrwal=3D<a href=3D"http://freescale.com" target=3D"_b=
lank">freescale.com</a>@<a href=3D"http://lists.ozlabs.org" target=3D"_blan=
k">lists.ozlabs.org</a>] On Behalf Of<br>
&gt; Hollis Blanchard<br>
&gt; Sent: Tuesday, May 10, 2011 1:53 AM<br>
&gt; To: Prasanna Khanapur<br>
&gt; Cc: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@list=
s.ozlabs.org</a><br>
&gt; Subject: Re: Regarding P2020 in AMP mode<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; On 05/07/2011 05:20 AM, Prasanna Khanapur wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt; I&#39;m running P2020 in AMP mode, each core running its linux os=
.<br>
&gt; &gt; Ethernet 1(@25000) and Ethernet 2(@26000) assigned to Core0 are<b=
r>
&gt; &gt; working fine.<br>
&gt; &gt; I&#39;m facing problems with Ethernet interface(@24000) assigned =
to Core1,<br>
&gt; &gt; its not working.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;m using dts file which were added by :<br>
&gt; &gt; <a href=3D"http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-Se=
ptember/075594.h" target=3D"_blank">http://lists.ozlabs.org/pipermail/linux=
ppc-dev/2009-September/075594.h</a><br>
&gt; &gt; tml<br>
&gt; &gt;<br>
&gt; &gt; Looks either there is some mistake in the dts file or my understa=
nding<br>
&gt; &gt; is wrong.<br>
&gt; &gt;<br>
&gt; &gt; MDIO @24000 is defined in core0 dts file though the Ethernet is<b=
r>
&gt; &gt; assigned to Core 1.<br>
&gt; &gt;<br>
&gt; &gt; DTS files :<br>
&gt; &gt; <a href=3D"http://web.mornfall.net/repos/linux-2.6/git/arch/power=
pc/boot/dts/p202" target=3D"_blank">http://web.mornfall.net/repos/linux-2.6=
/git/arch/powerpc/boot/dts/p202</a><br>
&gt; &gt; 0rdb_camp_core0.dts<br>
&gt; &gt; <a href=3D"http://web.mornfall.net/repos/linux-2.6/git/arch/power=
pc/boot/dts/p202" target=3D"_blank">http://web.mornfall.net/repos/linux-2.6=
/git/arch/powerpc/boot/dts/p202</a><br>
&gt; &gt; 0rdb_camp_core1.dts<br>
&gt;<br>
&gt; The fixed-link property in core1.dts indicates enet0 should use 1Gb li=
nk.<br>
&gt; Is that device connected to a 1Gb network?<br>
&gt;<br>
&gt; --<br>
&gt; Hollis Blanchard<br>
&gt; Mentor Graphics, Embedded Systems Division<br>
</div></div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_=
blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
<br>
<br>
</blockquote></div><br></div></div></div>

--0015175d023879595004a2fe4ebd--
