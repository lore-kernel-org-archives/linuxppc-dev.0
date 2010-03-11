Return-Path: <andrew.liu200917@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id D589DB7D0D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 19:57:14 +1100 (EST)
Received: by gyd10 with SMTP id 10so2314776gyd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 00:57:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <99C6B559-9FEC-4B6A-BE5A-213D3E61A2C6@kernel.crashing.org>
References: <54d399751003101920j598de9fdkd7c8617c8e4fa191@mail.gmail.com>
	<BCD4C354-E29A-4514-BB04-CFE92BFBC28A@kernel.crashing.org>
	<99C6B559-9FEC-4B6A-BE5A-213D3E61A2C6@kernel.crashing.org>
Date: Thu, 11 Mar 2010 16:57:10 +0800
Message-ID: <54d399751003110057m3ab71b58md737e5d70f6f06a1@mail.gmail.com>
Subject: Re: PowerPC 85xx board are caused die by Commit:
	864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc:
	Use lwarx/ldarx hint in bit locks)
From: Andrew Liu <andrew.liu200917@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=0016e6d26594a511580481829907
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d26594a511580481829907
Content-Type: text/plain; charset=ISO-8859-1

Just validated it, this fix can make fsl_p2020ds work again.

Andrew

On Thu, Mar 11, 2010 at 1:39 PM, Kumar Gala <galak@kernel.crashing.org>wrote:

>
> On Mar 10, 2010, at 11:20 PM, Kumar Gala wrote:
>
> >
> > On Mar 10, 2010, at 9:20 PM, Andrew Liu wrote:
> >
> >> Hi Guys:
> >> I have done several experiments on  fsl_8548cds and fsl_p2020rdb,
> pinpointed the commit: 864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc: Use
> lwarx/ldarx hint in bit locks)  cause the bootup stalledd.
> >>
> >> "
> >> Filename 'fsl_8548cds/uImage'.
> >> Load address: 0x1000000
> >> Loading:
> #################################################################
> >>     #######################################
> >> done
> >> Bytes transferred = 1526546 (174b12 hex)
> >> Speed: 100, full duplex
> >> Using eTSEC0 device
> >> Filename 'sliu/fsl_8548cds/mpc8548cds.dtb'.
> >> Load address: 0xc00000
> >> Loading: #
> >> done
> >> Bytes transferred = 9993 (2709 hex)
> >> ## Booting image at 01000000 ...
> >>   Image Name:   Linux-2.6.34-rc1-00005-g522dba7
> >>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >>   Data Size:    1526482 Bytes =  1.5 MB
> >>   Load Address: 00000000
> >>   Entry Point:  00000000
> >>   Verifying Checksum ... OK
> >>   Uncompressing Kernel Image ... OK
> >>   Booting using the fdt at 0xc00000
> >>   Loading Device Tree to 007fb000, end 007fd708 ... OK
> >> "
> >>
> >> I guess all 85xx or booke board has this issue.
> >
> > that's very odd since __PPC_EH should be ignored on PPC32 and thus 85xx.
>
> Found the issue and posted a fix.
>
> - k

--0016e6d26594a511580481829907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just validated it, this fix can make fsl_p2020ds work again.<br><br>Andrew<=
br><br><div class=3D"gmail_quote">On Thu, Mar 11, 2010 at 1:39 PM, Kumar Ga=
la <span dir=3D"ltr">&lt;<a href=3D"mailto:galak@kernel.crashing.org" targe=
t=3D"_blank">galak@kernel.crashing.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div><br>
On Mar 10, 2010, at 11:20 PM, Kumar Gala wrote:<br>
<br>
&gt;<br>
&gt; On Mar 10, 2010, at 9:20 PM, Andrew Liu wrote:<br>
&gt;<br>
&gt;&gt; Hi Guys:<br>
&gt;&gt; I have done several experiments on =A0fsl_8548cds and fsl_p2020rdb=
, pinpointed the commit: 864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc: =
Use lwarx/ldarx hint in bit locks) =A0cause the bootup stalledd.<br>
&gt;&gt;<br>
&gt;&gt; &quot;<br>
&gt;&gt; Filename &#39;fsl_8548cds/uImage&#39;.<br>
&gt;&gt; Load address: 0x1000000<br>
&gt;&gt; Loading: #########################################################=
########<br>
&gt;&gt; =A0 =A0 #######################################<br>
&gt;&gt; done<br>
&gt;&gt; Bytes transferred =3D 1526546 (174b12 hex)<br>
&gt;&gt; Speed: 100, full duplex<br>
&gt;&gt; Using eTSEC0 device<br>
&gt;&gt; Filename &#39;sliu/fsl_8548cds/mpc8548cds.dtb&#39;.<br>
&gt;&gt; Load address: 0xc00000<br>
&gt;&gt; Loading: #<br>
&gt;&gt; done<br>
&gt;&gt; Bytes transferred =3D 9993 (2709 hex)<br>
&gt;&gt; ## Booting image at 01000000 ...<br>
&gt;&gt; =A0 Image Name: =A0 Linux-2.6.34-rc1-00005-g522dba7<br>
&gt;&gt; =A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)<b=
r>
&gt;&gt; =A0 Data Size: =A0 =A01526482 Bytes =3D =A01.5 MB<br>
&gt;&gt; =A0 Load Address: 00000000<br>
&gt;&gt; =A0 Entry Point: =A000000000<br>
&gt;&gt; =A0 Verifying Checksum ... OK<br>
&gt;&gt; =A0 Uncompressing Kernel Image ... OK<br>
&gt;&gt; =A0 Booting using the fdt at 0xc00000<br>
&gt;&gt; =A0 Loading Device Tree to 007fb000, end 007fd708 ... OK<br>
&gt;&gt; &quot;<br>
&gt;&gt;<br>
&gt;&gt; I guess all 85xx or booke board has this issue.<br>
&gt;<br>
&gt; that&#39;s very odd since __PPC_EH should be ignored on PPC32 and thus=
 85xx.<br>
<br>
</div></div>Found the issue and posted a fix.<br>
<font color=3D"#888888"><br>
- k</font></blockquote></div><br>

--0016e6d26594a511580481829907--
