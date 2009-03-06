Return-Path: <ben.menchaca@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 73AB8DDF81
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 17:17:06 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so169523yxb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 22:17:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
Date: Fri, 6 Mar 2009 00:10:00 -0600
Message-ID: <64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: multipart/alternative; boundary=00221532cba08b911804646d228b
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00221532cba08b911804646d228b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I can look at ACR morning...although I can say with a fair amount of
certainty that I have not changed it from the POR value.

I will try enabling No Snoop for CSB in the descriptor (bit 3, yes?)...this
seems a bit counterintuitive to me.

What is the hope regarding these two?  Some combination I am not seeing?


On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:

>  what is the value of ACR register?
>
>  ------------------------------
> *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
> *Sent:* Friday, March 06, 2009 1:38 PM
> *To:* Liu Dave-R63238
> *Cc:* linuxppc-dev@ozlabs.org
> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>
> 1.  BAT2 in linux is set to WIMG=0010, and covers all 64M
> 2.  PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020
> 3.  PEX_xDMA_CTRL is set to 0x00000401 at the initiation of the DMA.
> 4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
> 5.  The DMA descriptor (randomly chosen when I hit a trigger...just ignore
> the size...) contains 0002AFF3 at offset 0, so nosnoops are cleared.
>
> Core is 400MHz, and CSB is 133MHz.
>
> - Ben
>
> On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>
>> and what settings  is DMA description bit 3?
>>
>> > -----Original Message-----
>> > From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>=
>> freescale.com@ozlabs.org]
>>   >  On Behalf Of Liu Dave-R63238
>> > Sent: Friday, March 06, 2009 1:22 PM
>> > To: Ben Menchaca; linuxppc-dev@ozlabs.org
>> > Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
>> >
>> > Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and
>> > PEX_RDMA_CTRL[SNOOP]?
>> >
>> > What is the freq settings? CORE/CSB bus.
>> >
>> > Thanks, Dave
>> >
>> > ________________________________
>> >
>> >       From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>=
>> freescale.com@ozlabs.org]
>> >  On Behalf Of Ben Menchaca
>> >       Sent: Friday, March 06, 2009 12:33 PM
>> >       To: linuxppc-dev@ozlabs.org
>> >       Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
>> >
>> >
>> >       I am working on a Freescale 8314e design, and the
>> > embedded device is configured as a PCI-e endpoint running a
>> > 2.6.27-5 kernel.  For context, we have written a kernel
>> > module which, among other things, uses the RDMA/WDMA engine
>> > in the PCI-e IP block.  On the host side, these DMAs are
>> > coherent.  However, on the embedded side, things are quite a
>> > bit less rosy; we must manually flush/invalidate cache lines
>> > for WDMA/RDMAs to occur successfully.  After speaking with
>> > (several) FAEs at Freescale, we believe there is a
>> > configuration issue that is the cause, but we have yet to
>> > have anyone successfully point to it.
>> >
>> >       Disabling the data cache altogether resolves the issue
>> > entirely, but of course, also completely tanks performance.
>> > As a temporary workaround, I would like to simply mark the
>> > pages (obtained currently via dma_alloc_coherent) involved as
>> > cache-inhibited.  I have attempted to do this via some
>> > snippets remaining in fec.c (va_to_pte, uncache_pte to set
>> > _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is
>> > almost certainly braindead; va_to_pte is not a part of the
>> > 83xx source, as far as I can tell; 8xx only.
>> >
>> >       A quick pointer in the correct direction for marking
>> > pages as cache-inhibited on a 2.6.27-5 kernel would be
>> > appreciated, or if my approach to a workaround is flawed, a
>> > pointer to the correct way would be great.
>> >
>> >       Ben Menchaca
>> >
>> >
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>> >
>> >
>>
>
>

--00221532cba08b911804646d228b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I can look at ACR morning...although I can say with a fair amount of certai=
nty that I have not changed it from the POR value.<br><br>I will try enabli=
ng No Snoop for CSB in the descriptor (bit 3, yes?)...this seems a bit coun=
terintuitive to me.<br>
<br>What is the hope regarding these two?=A0 Some combination I am not seei=
ng?<br><br>
<br><div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R6=
3238 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=
=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">what is the value of ACR register?</font></span></div><br>
<blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left: 5=
px; margin-left: 5px; margin-right: 0px;">
  <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
  <hr>
  <font size=3D"2" face=3D"Tahoma"><b>From:</b> Ben Menchaca=20
  [mailto:<a href=3D"mailto:ben.menchaca@gmail.com" target=3D"_blank">ben.m=
enchaca@gmail.com</a>] <br><b>Sent:</b> Friday, March 06, 2009 1:38=20
  PM<br><b>To:</b> Liu Dave-R63238<br><b>Cc:</b>=20
  <a href=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev=
@ozlabs.org</a><br><b>Subject:</b> Re: 83xx: Marking or Allocating=20
  Pages as Cache-Inhibited<br></font><br></div><div><div></div><div>
  <div></div><font style=3D"font-size: 10pt; font-family: Tahoma;"><font st=
yle=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10p=
t; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahom=
a;"><font style=3D"font-size: 10pt; font-family: Tahoma;">1.=A0 BAT2 in lin=
ux is set to=20
  WIMG=3D0010, and covers all 64M<br>2.=A0 PEX_DEVICE_CONTROL in PCI-E Conf=
ig=20
  Space (0x54): 0x1020<br>3.=A0 PEX_xDMA_CTRL is set to=20
  <span></span>0x00000401 at the initiation of the DMA.<br>4.=A0 OWAR0 is s=
et=20
  to 0xFFFFF005, so NSNP is 0.<br>5.=A0 The DMA descriptor (randomly chosen=
=20
  when I hit a trigger...just ignore the size...) contains 0002AFF3 at offs=
et 0,=20
  so nosnoops are cleared.</font></font></font></font></font><font style=3D=
"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; fon=
t-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><f=
ont style=3D"font-size: 10pt; font-family: Tahoma;">=A0 <br>

<br>Core is 400MHz,=20
  and CSB is 133MHz.</font></font></font></font><br><font color=3D"#888888"=
><br>-=20
  Ben<br></font><br>
  <div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R632=
38 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=3D=
"_blank">DaveLiu@freescale.com</a>&gt;</span>=20
  wrote:<br>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">and=20
    what settings =A0is DMA description bit 3?<br>
    <div><br>&gt; -----Original Message-----<br>&gt; From:=20
    linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescale.com" target=
=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" target=3D"_blan=
k">ozlabs.org</a><br>&gt; [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2B=
daveliu" target=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D<a href=3D"ht=
tp://freescale.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://o=
zlabs.org" target=3D"_blank">ozlabs.org</a>]<br>

</div>
    <div>
    <div></div>
    <div>&gt; =A0On Behalf Of Liu Dave-R63238<br>&gt; Sent: Friday,=20
    March 06, 2009 1:22 PM<br>&gt; To: Ben Menchaca; <a href=3D"mailto:linu=
xppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a><br>&gt;=
=20
    Subject: RE: 83xx: Marking or Allocating Pages as=20
    Cache-Inhibited<br>&gt;<br>&gt; Did you enable the snoop bit at=20
    PEX_WDMA_CTRL[SNOOP] and<br>&gt; PEX_RDMA_CTRL[SNOOP]?<br>&gt;<br>&gt; =
What=20
    is the freq settings? CORE/CSB bus.<br>&gt;<br>&gt; Thanks,=20
    Dave<br>&gt;<br>&gt; ________________________________<br>&gt;<br>&gt; =
=A0=20
    =A0 =A0 From: linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescal=
e.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" ta=
rget=3D"_blank">ozlabs.org</a><br>&gt; [mailto:<a href=3D"mailto:linuxppc-d=
ev-bounces%2Bdaveliu" target=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D=
<a href=3D"http://freescale.com" target=3D"_blank">freescale.com</a>@<a hre=
f=3D"http://ozlabs.org" target=3D"_blank">ozlabs.org</a>]<br>

&gt; =A0On=20
    Behalf Of Ben Menchaca<br>&gt; =A0 =A0 =A0 Sent: Friday, March 06,=20
    2009 12:33 PM<br>&gt; =A0 =A0 =A0 To: <a href=3D"mailto:linuxppc-dev@oz=
labs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a><br>&gt;=20
    =A0 =A0 =A0 Subject: 83xx: Marking or Allocating Pages as=20
    Cache-Inhibited<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 I am working on=20
    a Freescale 8314e design, and the<br>&gt; embedded device is configured=
 as a=20
    PCI-e endpoint running a<br>&gt; 2.6.27-5 kernel. =A0For context, we ha=
ve=20
    written a kernel<br>&gt; module which, among other things, uses the=20
    RDMA/WDMA engine<br>&gt; in the PCI-e IP block. =A0On the host side,=20
    these DMAs are<br>&gt; coherent. =A0However, on the embedded side, thin=
gs=20
    are quite a<br>&gt; bit less rosy; we must manually flush/invalidate ca=
che=20
    lines<br>&gt; for WDMA/RDMAs to occur successfully. =A0After speaking=
=20
    with<br>&gt; (several) FAEs at Freescale, we believe there is a<br>&gt;=
=20
    configuration issue that is the cause, but we have yet to<br>&gt; have=
=20
    anyone successfully point to it.<br>&gt;<br>&gt; =A0 =A0 =A0=20
    Disabling the data cache altogether resolves the issue<br>&gt; entirely=
, but=20
    of course, also completely tanks performance.<br>&gt; As a temporary=20
    workaround, I would like to simply mark the<br>&gt; pages (obtained=20
    currently via dma_alloc_coherent) involved as<br>&gt; cache-inhibited.=
=20
    =A0I have attempted to do this via some<br>&gt; snippets remaining in=
=20
    fec.c (va_to_pte, uncache_pte to set<br>&gt; _PAGE_NO_CACHE, flush_tlb_=
page,=20
    then unmap_pte), but this is<br>&gt; almost certainly braindead; va_to_=
pte=20
    is not a part of the<br>&gt; 83xx source, as far as I can tell; 8xx=20
    only.<br>&gt;<br>&gt; =A0 =A0 =A0 A quick pointer in the correct=20
    direction for marking<br>&gt; pages as cache-inhibited on a 2.6.27-5 ke=
rnel=20
    would be<br>&gt; appreciated, or if my approach to a workaround is flaw=
ed,=20
    a<br>&gt; pointer to the correct way would be great.<br>&gt;<br>&gt; =
=A0=20
    =A0 =A0 Ben Menchaca<br>&gt;<br>&gt;<br></div></div>&gt;=20
    _______________________________________________<br>&gt; Linuxppc-dev ma=
iling=20
    list<br>&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org" target=3D"_blan=
k">Linuxppc-dev@ozlabs.org</a><br>&gt; <a href=3D"https://ozlabs.org/mailma=
n/listinfo/linuxppc-dev" target=3D"_blank">https://ozlabs.org/mailman/listi=
nfo/linuxppc-dev</a><br>

&gt;<br>&gt;<br></blockquote></div><br></div></div></blockquote></div>
</blockquote></div><br>

--00221532cba08b911804646d228b--
