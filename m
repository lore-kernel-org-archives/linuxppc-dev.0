Return-Path: <arunkat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 4CDE367A70
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 21:53:00 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c31so50028nfb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 04:52:58 -0700 (PDT)
Message-ID: <edd12c050606290452r7cd68f36w55a3eac737c73bf3@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:22:58 +0530
From: "Arun Kumar" <arunkat@gmail.com>
To: "Laurent Pinchart" <laurent.pinchart@tbox.biz>
Subject: Re: entry point of kernel in RAM at 0x0c--linux tree file name
In-Reply-To: <200606231218.14788.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15507_14842791.1151581978742"
References: <edd12c050606220146i57282781o2052679c8f6108ef@mail.gmail.com>
	<200606221735.15761.laurent.pinchart@tbox.biz>
	<edd12c050606230253u5842ea5bvd78d06f0354cb4bd@mail.gmail.com>
	<200606231218.14788.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_15507_14842791.1151581978742
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Laurent ,
I have made marginally more progress in my porting effort .Now I can see th=
e
early debug text by enabling the CONFIG_SERIAL_TEXT_DEBUG and pointing the
gen550.c code to my sandpoint 8260 LSP code and UART adresses .

I have a Sandpoint 8260 LSP .However now my code crashes in mapin_ram
roputine .

Here is a dump of serial console :


loaded at:     00800000 0099A1D8
zimage at:     008057B7 0086B0E9
initrd at:     0086C000 0099645B
avail ram:     00400000 00800000

Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/ram
Uncompressing Linux...done.
Now booting the kernel

id mach(): =81init
MMU:mapin
MMU:have_bats
MMU:PPC_STD_MMU

The mapin_ram code in pgtable.c is as follows :

void __init mapin_ram(void)
{
    unsigned long v, s, f;
    phys_addr_t p;

#ifdef HAVE_BATS
    if (!__map_without_bats)
    {    bat_mapin_ram(__bat2, __bat3);
        ppc_md.progress("MMU:have_bats", 0x401);
}

#endif /* HAVE_BATS */

    v =3D KERNELBASE;
    p =3D PPC_MEMSTART;
    for (s =3D 0; s < total_lowmem; s +=3D PAGE_SIZE) {
        /* On the MPC8xx, we want the page shared so we
         * don't get ASID compares on kernel space.
         */
        f =3D _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_SHARED | _PAGE_HWEXEC;
#ifdef CONFIG_440
        /* Prevent bogus speculative cycles */
        f |=3D _PAGE_GUARDED;
#endif
#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) ||
defined(CONFIG_BDI_SWITCH)
        /* Allows stub to set breakpoints everywhere */
        f |=3D _PAGE_WRENABLE;
        ppc_md.progress("MMU:in kgdb", 0x401);
#else    /* !CONFIG_KGDB && !CONFIG_XMON && !CONFIG_BDI_SWITCH */
        if ((char *) v < _stext || (char *) v >=3D etext)
        {    f |=3D _PAGE_WRENABLE;
        ppc_md.progress("MMU:else of kgdb", 0x401);
}
#ifdef CONFIG_PPC_STD_MMU
        else
            /* On the powerpc (not all), no user access
               forces R/W kernel access */
            f |=3D _PAGE_USER;
        ppc_md.progress("MMU:PPC_STD_MMU", 0x401);
#endif /* CONFIG_PPC_STD_MMU */
#endif /* CONFIG_KGDB || CONFIG_XMON */
        map_page(v, p, f);
        v +=3D PAGE_SIZE;
        p +=3D PAGE_SIZE;
    }
    if (ppc_md.progress)
        ppc_md.progress("MMU:mapin_ram done", 0x401);
}

This is crashing somewhere in map_page routine .
I have 64Mb in DRAM and 8 Mb of Flash .I have really no idea why my MMU_ini=
t
code is crashing .. Any help would be greatly appreciated .


Thanks,
Arun

On 6/23/06, Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:
>
> Hi Arun,
>
> please keep the list posted when you reply.
>
> > Thanks for the response .I would also like to ask another query hoever
> > naive it might sound .I am using a Linux 2.4.1
>
> That's very old. Can't you upgrade to 2.6 ?
>
> > wherein my entry point
> > code at 0x0c expects at R3 ,R4,R5,R6 some parameters which I strongly
> > suspect to be residual record bi_rec *,start of initrd and end of initr=
d
> > sections as my kernel is crashing immediately after  MMU_init and I
> > suspect that machine _init that is done prior to  MMU_init expects __re=
s
> > in R3 as a input parameter .Please confirm .
>
> Depending on your platform and boot loader, r3 to r7 are initialized with
> different values. If you're using ppcboot, the kernel expects r3 to be
> initialized with the residual record, right.
>
> > I am using ppcboot2..0.0 as my bootloader .
>
> That' very old too. You should upgrade to U-Boot.
>
> > Also I would like to know how can i enable serial console in these earl=
y
> > kernel initialsaiotns process. I am using a CONFIG_SANDPOINT(8260) on a
> > MPC 8245 platform and trying to port the code on MPC8245 platform .the
> > board has a very similar config as a SANDPOINT board .
>
> If I'm not mistaken, you can't enable a serial console that early. Do you
> have
> a hardware debugger (BDI2000) ? If not, you could try LED debugging.
>
> Best regards,
>
> Laurent Pinchart
>



--=20
Arun Kumar Singh
Tech Lead.
Agere India
Bangalore

------=_Part_15507_14842791.1151581978742
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Laurent ,<br>I have made marginally more progress in my porting effort .=
Now I can see the early debug text by enabling the CONFIG_SERIAL_TEXT_DEBUG=
 and pointing the gen550.c code to my sandpoint 8260 LSP code and UART adre=
sses .
<br><br>I have a Sandpoint 8260 LSP .However now my code crashes in mapin_r=
am roputine .<br><br>Here is a dump of serial console :<br><br><br>loaded a=
t:&nbsp;&nbsp;&nbsp;&nbsp; 00800000 0099A1D8<br>zimage at:&nbsp;&nbsp;&nbsp=
;&nbsp; 008057B7 0086B0E9<br>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 0086C000 00=
99645B
<br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00400000 00800000<br><br>Linux/PPC l=
oad: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/ram<br>Uncompressing L=
inux...done.<br>Now booting the kernel<br><br>id mach(): =81init<br>MMU:map=
in<br>MMU:have_bats<br>MMU:PPC_STD_MMU
<br><br>The mapin_ram code in pgtable.c is as follows :<br><br>void __init =
mapin_ram(void)<br>{<br>&nbsp;&nbsp;&nbsp; unsigned long v, s, f;<br>&nbsp;=
&nbsp;&nbsp; phys_addr_t p;<br><br>#ifdef HAVE_BATS<br>&nbsp;&nbsp;&nbsp; i=
f (!__map_without_bats)<br>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; bat_mapin=
_ram(__bat2, __bat3);
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ppc_md.progress(&quot;MMU:have_ba=
ts&quot;, 0x401);<br>}<br><br>#endif /* HAVE_BATS */<br><br>&nbsp;&nbsp;&nb=
sp; v =3D KERNELBASE;<br>&nbsp;&nbsp;&nbsp; p =3D PPC_MEMSTART;<br>&nbsp;&n=
bsp;&nbsp; for (s =3D 0; s &lt; total_lowmem; s +=3D PAGE_SIZE) {<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* On the MPC8xx, we want the page shared s=
o we
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* don't get ASID compares o=
n kernel space.<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; f =3D _PAGE_PRESENT | _PAGE_ACCESSED | _PAG=
E_SHARED | _PAGE_HWEXEC;<br>#ifdef CONFIG_440<br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; /* Prevent bogus speculative cycles */<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; f |=3D _PAGE_GUARDED;<br>#endif<br>#i=
f defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH=
)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Allows stub to set breakpoint=
s everywhere */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; f |=3D _PAGE_WRENA=
BLE;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ppc_md.progress(&quot;MMU:in =
kgdb&quot;, 0x401);&nbsp;=20
<br>#else&nbsp;&nbsp;&nbsp; /* !CONFIG_KGDB &amp;&amp; !CONFIG_XMON &amp;&a=
mp; !CONFIG_BDI_SWITCH */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ((cha=
r *) v &lt; _stext || (char *) v &gt;=3D etext)<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; f |=3D _PAGE_WRENABLE;<br>&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; ppc_md.progress(&quot;MMU:else of kgdb&quot;, 0x401)=
;&nbsp;=20
<br>}<br>#ifdef CONFIG_PPC_STD_MMU<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 else<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* On the=
 powerpc (not all), no user access<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; forces R/W kernel access */<br>&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; f |=3D _PAGE_USER;<br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ppc_md.progress(&quot;MMU:PPC_STD_MMU&quot;,=
 0x401);
<br>#endif /* CONFIG_PPC_STD_MMU */<br>#endif /* CONFIG_KGDB || CONFIG_XMON=
 */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; map_page(v, p, f);<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; v +=3D PAGE_SIZE;<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; p +=3D PAGE_SIZE;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbs=
p; if (ppc_md.progress)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ppc_md.pro=
gress(&quot;MMU:mapin_ram done&quot;, 0x401);
<br>}<br><br>This is crashing somewhere in map_page routine .<br>I have 64M=
b in DRAM and 8 Mb of Flash .I have really no idea why my MMU_init code is =
crashing .. Any help would be greatly appreciated .<br><br><br>Thanks,<br>
Arun<br><br><div><span class=3D"gmail_quote">On 6/23/06, <b class=3D"gmail_=
sendername">Laurent Pinchart</b> &lt;<a href=3D"mailto:laurent.pinchart@tbo=
x.biz">laurent.pinchart@tbox.biz</a>&gt; wrote:</span><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Arun,<br><br>please keep the list posted when you reply.<br><br>&gt; Tha=
nks for the response .I would also like to ask another query hoever<br>&gt;=
 naive it might sound .I am using a Linux 2.4.1<br><br>That's very old. Can=
't you upgrade to=20
2.6 ?<br><br>&gt; wherein my entry point<br>&gt; code at 0x0c expects at R3=
 ,R4,R5,R6 some parameters which I strongly<br>&gt; suspect to be residual =
record bi_rec *,start of initrd and end of initrd<br>&gt; sections as my ke=
rnel is crashing immediately after&nbsp;&nbsp;MMU_init and I
<br>&gt; suspect that machine _init that is done prior to&nbsp;&nbsp;MMU_in=
it expects __res<br>&gt; in R3 as a input parameter .Please confirm .<br><b=
r>Depending on your platform and boot loader, r3 to r7 are initialized with=
<br>different values. If you're using ppcboot, the kernel expects r3 to be
<br>initialized with the residual record, right.<br><br>&gt; I am using ppc=
boot2..0.0 as my bootloader .<br><br>That' very old too. You should upgrade=
 to U-Boot.<br><br>&gt; Also I would like to know how can i enable serial c=
onsole in these early
<br>&gt; kernel initialsaiotns process. I am using a CONFIG_SANDPOINT(8260)=
 on a<br>&gt; MPC 8245 platform and trying to port the code on MPC8245 plat=
form .the<br>&gt; board has a very similar config as a SANDPOINT board .
<br><br>If I'm not mistaken, you can't enable a serial console that early. =
Do you have<br>a hardware debugger (BDI2000) ? If not, you could try LED de=
bugging.<br><br>Best regards,<br><br>Laurent Pinchart<br></blockquote></div=
>
<br><br clear=3D"all"><br>-- <br>Arun Kumar Singh<br>Tech Lead.<br>Agere In=
dia <br>Bangalore

------=_Part_15507_14842791.1151581978742--
