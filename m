Return-Path: <ben.menchaca@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id DEA61DDF11
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 03:30:21 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so255884ywb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 08:30:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
	<64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
Date: Fri, 6 Mar 2009 10:30:19 -0600
Message-ID: <64ac01180903060830m1e5927c6y76b8302b0fb68eb6@mail.gmail.com>
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: multipart/alternative; boundary=002354333bc6f315a4046475ccd9
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--002354333bc6f315a4046475ccd9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you for your help!  That bit resolved all of the RDMA/WDMA coherency
issues on the CSB side...except:

We expose a 1MB region of memory from CSB via a BAR (BAR1, if it matters) to
the Host.  This region is also not behaving correctly with respect to
coherency on SOME hosts; again, disabling our cache makes it work correctly
on all hosts.  We have set PEX_DEVICE_CONTROL in PCI-E Config Space (0x54)
to 0x2010 (sorry about the endianness below).  We thought that CLEARING the
no-snoop bit here would indicate that snooping was required for this
region...is this a similar issue?

- Ben

On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca <ben.menchaca@gmail.com>wrote:

> Testing now...it looks like it (almost) works, though!  Why does setting
> no-snoop cause snooping to work?  More on the effect on setting that bit in
> a few minutes...need more testing.
>
> ACR is 0x00030300.
>
> - Ben
>
>
> On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>
>>  Did you enable the descriptor bit 3 to have a try?
>>
>>  ------------------------------
>> *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
>> *Sent:* Friday, March 06, 2009 2:10 PM
>>
>> *To:* Liu Dave-R63238
>> *Cc:* linuxppc-dev@ozlabs.org
>> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>
>> I can look at ACR morning...although I can say with a fair amount of
>> certainty that I have not changed it from the POR value.
>>
>> I will try enabling No Snoop for CSB in the descriptor (bit 3,
>> yes?)...this seems a bit counterintuitive to me.
>>
>> What is the hope regarding these two?  Some combination I am not seeing?
>>
>>
>> On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>>
>>>  what is the value of ACR register?
>>>
>>>  ------------------------------
>>> *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
>>> *Sent:* Friday, March 06, 2009 1:38 PM
>>> *To:* Liu Dave-R63238
>>> *Cc:* linuxppc-dev@ozlabs.org
>>> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>
>>>   1.  BAT2 in linux is set to WIMG=0010, and covers all 64M
>>> 2.  PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020
>>> 3.  PEX_xDMA_CTRL is set to 0x00000401 at the initiation of the DMA.
>>> 4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
>>> 5.  The DMA descriptor (randomly chosen when I hit a trigger...just
>>> ignore the size...) contains 0002AFF3 at offset 0, so nosnoops are cleared.
>>>
>>>
>>> Core is 400MHz, and CSB is 133MHz.
>>>
>>> - Ben
>>>
>>> On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>>>
>>>> and what settings  is DMA description bit 3?
>>>>
>>>> > -----Original Message-----
>>>> > From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>>>> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>
>>>> =freescale.com@ozlabs.org]
>>>>   >  On Behalf Of Liu Dave-R63238
>>>> > Sent: Friday, March 06, 2009 1:22 PM
>>>> > To: Ben Menchaca; linuxppc-dev@ozlabs.org
>>>> > Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>> >
>>>> > Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and
>>>> > PEX_RDMA_CTRL[SNOOP]?
>>>> >
>>>> > What is the freq settings? CORE/CSB bus.
>>>> >
>>>> > Thanks, Dave
>>>> >
>>>> > ________________________________
>>>> >
>>>> >       From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>>>> > [mailto:linuxppc-dev-bounces+daveliu <linuxppc-dev-bounces%2Bdaveliu>
>>>> =freescale.com@ozlabs.org]
>>>> >  On Behalf Of Ben Menchaca
>>>> >       Sent: Friday, March 06, 2009 12:33 PM
>>>> >       To: linuxppc-dev@ozlabs.org
>>>> >       Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>> >
>>>> >
>>>> >       I am working on a Freescale 8314e design, and the
>>>> > embedded device is configured as a PCI-e endpoint running a
>>>> > 2.6.27-5 kernel.  For context, we have written a kernel
>>>> > module which, among other things, uses the RDMA/WDMA engine
>>>> > in the PCI-e IP block.  On the host side, these DMAs are
>>>> > coherent.  However, on the embedded side, things are quite a
>>>> > bit less rosy; we must manually flush/invalidate cache lines
>>>> > for WDMA/RDMAs to occur successfully.  After speaking with
>>>> > (several) FAEs at Freescale, we believe there is a
>>>> > configuration issue that is the cause, but we have yet to
>>>> > have anyone successfully point to it.
>>>> >
>>>> >       Disabling the data cache altogether resolves the issue
>>>> > entirely, but of course, also completely tanks performance.
>>>> > As a temporary workaround, I would like to simply mark the
>>>> > pages (obtained currently via dma_alloc_coherent) involved as
>>>> > cache-inhibited.  I have attempted to do this via some
>>>> > snippets remaining in fec.c (va_to_pte, uncache_pte to set
>>>> > _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is
>>>> > almost certainly braindead; va_to_pte is not a part of the
>>>> > 83xx source, as far as I can tell; 8xx only.
>>>> >
>>>> >       A quick pointer in the correct direction for marking
>>>> > pages as cache-inhibited on a 2.6.27-5 kernel would be
>>>> > appreciated, or if my approach to a workaround is flawed, a
>>>> > pointer to the correct way would be great.
>>>> >
>>>> >       Ben Menchaca
>>>> >
>>>> >
>>>> > _______________________________________________
>>>> > Linuxppc-dev mailing list
>>>> > Linuxppc-dev@ozlabs.org
>>>> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>>> >
>>>> >
>>>>
>>>
>>>
>>
>

--002354333bc6f315a4046475ccd9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you for your help!=A0 That bit resolved all of the RDMA/WDMA coherenc=
y issues on the CSB side...except:<br><br>We expose a 1MB region of memory =
from CSB via a BAR (BAR1, if it matters) to the Host.=A0 This region is als=
o not behaving correctly with respect to coherency on SOME hosts; again, di=
sabling our cache makes it work correctly on all hosts.=A0 We have set <fon=
t style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size:=
 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: T=
ahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=
=3D"font-size: 10pt; font-family: Tahoma;">PEX_DEVICE_CONTROL in PCI-E=20
      Config Space (0x54) to </font></font></font></font></font><font style=
=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; =
font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;"=
><font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-=
size: 10pt; font-family: Tahoma;">0x2010 (sorry about the endianness below)=
.=A0 We thought that CLEARING the no-snoop bit here would indicate that sno=
oping was required for this region...is this a similar issue?<br>
<br>- Ben<br></font></font></font></font></font><br><div class=3D"gmail_quo=
te">On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca <span dir=3D"ltr">&lt;<a =
href=3D"mailto:ben.menchaca@gmail.com">ben.menchaca@gmail.com</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Testing now...it =
looks like it (almost) works, though!=A0 Why does setting no-snoop cause sn=
ooping to work?=A0 More on the effect on setting that bit in a few minutes.=
..need more testing.<br>
=A0<br>ACR is 0x00030300.<br><font color=3D"#888888"><br>- Ben</font><div><=
div></div><div class=3D"h5"><br>
<br><div class=3D"gmail_quote">On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R6=
3238 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=
=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div>
<div dir=3D"ltr" align=3D"left"><span><font size=3D"2" color=3D"#0000ff" fa=
ce=3D"Arial">Did you enable the descriptor bit 3 to have a=20
try?</font></span></div><br>
<blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left: 5=
px; margin-left: 5px; margin-right: 0px;">
  <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
  <hr>
  <font size=3D"2" face=3D"Tahoma"><div><b>From:</b> Ben Menchaca=20
  [mailto:<a href=3D"mailto:ben.menchaca@gmail.com" target=3D"_blank">ben.m=
enchaca@gmail.com</a>] <br></div><b>Sent:</b> Friday, March 06, 2009 2:10=
=20
  PM<div><div></div><div><br><b>To:</b> Liu Dave-R63238<br><b>Cc:</b>=20
  <a href=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev=
@ozlabs.org</a><br><b>Subject:</b> Re: 83xx: Marking or Allocating=20
  Pages as Cache-Inhibited<br></div></div></font><br></div><div><div></div>=
<div>
  <div></div>I can look at ACR morning...although I can say with a fair amo=
unt=20
  of certainty that I have not changed it from the POR value.<br><br>I will=
 try=20
  enabling No Snoop for CSB in the descriptor (bit 3, yes?)...this seems a =
bit=20
  counterintuitive to me.<br><br>What is the hope regarding these two?=A0=
=20
  Some combination I am not seeing?<br><br><br>
  <div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R632=
38 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=3D=
"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div>
    <div dir=3D"ltr" align=3D"left"><span><font size=3D"2" color=3D"#0000ff=
" face=3D"Arial">what is=20
    the value of ACR register?</font></span></div><br>
    <blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-lef=
t: 5px; margin-left: 5px; margin-right: 0px;">
      <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
      <hr>
      <font size=3D"2" face=3D"Tahoma"><b>From:</b> Ben Menchaca [mailto:<a=
 href=3D"mailto:ben.menchaca@gmail.com" target=3D"_blank">ben.menchaca@gmai=
l.com</a>] <br><b>Sent:</b> Friday, March=20
      06, 2009 1:38 PM<br><b>To:</b> Liu Dave-R63238<br><b>Cc:</b> <a href=
=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.o=
rg</a><br><b>Subject:</b> Re: 83xx:=20
      Marking or Allocating Pages as Cache-Inhibited<br></font><br></div>
      <div>
      <div></div>
      <div>
      <div></div><font style=3D"font-size: 10pt; font-family: Tahoma;"><fon=
t style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size:=
 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: T=
ahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;">1.=A0 BAT2 in=
 linux is set=20
      to WIMG=3D0010, and covers all 64M<br>2.=A0 PEX_DEVICE_CONTROL in PCI=
-E=20
      Config Space (0x54): 0x1020<br>3.=A0 PEX_xDMA_CTRL is set to=20
      <span></span>0x00000401 at the initiation of the DMA.<br>4.=A0 OWAR0 =
is=20
      set to 0xFFFFF005, so NSNP is 0.<br>5.=A0 The DMA descriptor (randoml=
y=20
      chosen when I hit a trigger...just ignore the size...) contains 0002A=
FF3=20
      at offset 0, so nosnoops are=20
      cleared.</font></font></font></font></font><font style=3D"font-size: =
10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Ta=
homa;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D=
"font-size: 10pt; font-family: Tahoma;">=A0 <br>

<br>Core is=20
      400MHz, and CSB is 133MHz.</font></font></font></font><br><font color=
=3D"#888888"><br>- Ben<br></font><br>
      <div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-=
R63238=20
      <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=
=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br>
      <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">and=20
        what settings =A0is DMA description bit 3?<br>
        <div><br>&gt; -----Original Message-----<br>&gt; From:=20
        linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescale.com" tar=
get=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" target=3D"_b=
lank">ozlabs.org</a><br>&gt; [mailto:<a href=3D"mailto:linuxppc-dev-bounces=
%2Bdaveliu" target=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D<a href=3D=
"http://freescale.com" target=3D"_blank">freescale.com</a>@<a href=3D"http:=
//ozlabs.org" target=3D"_blank">ozlabs.org</a>]<br>

</div>
        <div>
        <div></div>
        <div>&gt; =A0On Behalf Of Liu Dave-R63238<br>&gt; Sent: Friday, Mar=
ch=20
        06, 2009 1:22 PM<br>&gt; To: Ben Menchaca; <a href=3D"mailto:linuxp=
pc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a><br>&gt; Su=
bject: RE: 83xx:=20
        Marking or Allocating Pages as Cache-Inhibited<br>&gt;<br>&gt; Did =
you=20
        enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and<br>&gt;=20
        PEX_RDMA_CTRL[SNOOP]?<br>&gt;<br>&gt; What is the freq settings?=20
        CORE/CSB bus.<br>&gt;<br>&gt; Thanks, Dave<br>&gt;<br>&gt;=20
        ________________________________<br>&gt;<br>&gt; =A0 =A0 =A0=20
        From: linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescale.co=
m" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" target=
=3D"_blank">ozlabs.org</a><br>&gt; [mailto:<a href=3D"mailto:linuxppc-dev-b=
ounces%2Bdaveliu" target=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D<a h=
ref=3D"http://freescale.com" target=3D"_blank">freescale.com</a>@<a href=3D=
"http://ozlabs.org" target=3D"_blank">ozlabs.org</a>]<br>

&gt; =A0On=20
        Behalf Of Ben Menchaca<br>&gt; =A0 =A0 =A0 Sent: Friday, March=20
        06, 2009 12:33 PM<br>&gt; =A0 =A0 =A0 To: <a href=3D"mailto:linuxpp=
c-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a><br>&gt; =A0=
 =A0 =A0=20
        Subject: 83xx: Marking or Allocating Pages as=20
        Cache-Inhibited<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 I am=20
        working on a Freescale 8314e design, and the<br>&gt; embedded devic=
e is=20
        configured as a PCI-e endpoint running a<br>&gt; 2.6.27-5 kernel.=
=20
        =A0For context, we have written a kernel<br>&gt; module which, amon=
g=20
        other things, uses the RDMA/WDMA engine<br>&gt; in the PCI-e IP blo=
ck.=20
        =A0On the host side, these DMAs are<br>&gt; coherent. =A0However,=
=20
        on the embedded side, things are quite a<br>&gt; bit less rosy; we =
must=20
        manually flush/invalidate cache lines<br>&gt; for WDMA/RDMAs to occ=
ur=20
        successfully. =A0After speaking with<br>&gt; (several) FAEs at=20
        Freescale, we believe there is a<br>&gt; configuration issue that i=
s the=20
        cause, but we have yet to<br>&gt; have anyone successfully point to=
=20
        it.<br>&gt;<br>&gt; =A0 =A0 =A0 Disabling the data cache=20
        altogether resolves the issue<br>&gt; entirely, but of course, also=
=20
        completely tanks performance.<br>&gt; As a temporary workaround, I =
would=20
        like to simply mark the<br>&gt; pages (obtained currently via=20
        dma_alloc_coherent) involved as<br>&gt; cache-inhibited. =A0I have=
=20
        attempted to do this via some<br>&gt; snippets remaining in fec.c=
=20
        (va_to_pte, uncache_pte to set<br>&gt; _PAGE_NO_CACHE, flush_tlb_pa=
ge,=20
        then unmap_pte), but this is<br>&gt; almost certainly braindead;=20
        va_to_pte is not a part of the<br>&gt; 83xx source, as far as I can=
=20
        tell; 8xx only.<br>&gt;<br>&gt; =A0 =A0 =A0 A quick pointer in=20
        the correct direction for marking<br>&gt; pages as cache-inhibited =
on a=20
        2.6.27-5 kernel would be<br>&gt; appreciated, or if my approach to =
a=20
        workaround is flawed, a<br>&gt; pointer to the correct way would be=
=20
        great.<br>&gt;<br>&gt; =A0 =A0 =A0 Ben=20
        Menchaca<br>&gt;<br>&gt;<br></div></div>&gt;=20
        _______________________________________________<br>&gt; Linuxppc-de=
v=20
        mailing list<br>&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org" tar=
get=3D"_blank">Linuxppc-dev@ozlabs.org</a><br>&gt; <a href=3D"https://ozlab=
s.org/mailman/listinfo/linuxppc-dev" target=3D"_blank">https://ozlabs.org/m=
ailman/listinfo/linuxppc-dev</a><br>

&gt;<br>&gt;<br></blockquote></div><br></div></div></blockquote></div></blo=
ckquote></div><br></div></div></blockquote></div>
</blockquote></div><br>
</div></div></blockquote></div><br>

--002354333bc6f315a4046475ccd9--
