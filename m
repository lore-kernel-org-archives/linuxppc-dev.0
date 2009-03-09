Return-Path: <ben.menchaca@gmail.com>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 48F28DDE41
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 14:27:41 +1100 (EST)
Received: by gxk22 with SMTP id 22so3580943gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Mar 2009 20:27:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208916D077@zch01exm21.fsl.freescale.net>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF81@zch01exm21.fsl.freescale.net>
	<64ac01180903052210r2aee7246g50fd0656c491a40b@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF98@zch01exm21.fsl.freescale.net>
	<64ac01180903060812n1f355207lb3fa6de3ed17ae41@mail.gmail.com>
	<64ac01180903060830m1e5927c6y76b8302b0fb68eb6@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916D077@zch01exm21.fsl.freescale.net>
Date: Sun, 8 Mar 2009 22:27:39 -0500
Message-ID: <64ac01180903082027j4542a69dg3b6bc557d3ddf967@mail.gmail.com>
Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
From: Ben Menchaca <ben.menchaca@gmail.com>
To: Liu Dave-R63238 <DaveLiu@freescale.com>
Content-Type: multipart/alternative; boundary=00032557467a7104090464a737fe
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00032557467a7104090464a737fe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The only problem host found so far is a newer Asus 970FX motherboard,
regardless of OS.

We are seeing that some time after LTSSM finishes, but long before OS load,
our PEX_DEVICE_CONTROL register is changed.  On the "working" motherboards,
NO_SNOOP is enabled; if I read the spec correctly, this means that TLPs with
no-snoop are permitted.  On the non-working motherboards, NO_SNOOP is
disabled; this is supposed to mean that TLPs with no-snoop are not permitted
(again, if I understand correctly).  Is it possible that there has been
another misinterpretation of this bit?  Something regarding the generation
of snoops on CSB when it is cleared?

This bit could be a complete red herring; it was one of the few differences
in the config space, however, so it was my best guess.

- Ben

On Sun, Mar 8, 2009 at 9:56 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:

>  Hi Ben,
>
> The second issue. you told me "some hosts" has problem,
> and some hosts worked well.
>
> what is the problem-hosts?
>
> The issue seems like the hosts did set the NO SNOOP attribute
> bit at TLP.
>
> The PEX_DEVICE_CONTROL is standard PCI configuration space
> register, it controls the behavior of the initiator's transaction.
> For 8315, it is outbound, not inbound transaction.
>
> Thanks, Dave
>
>  ------------------------------
> *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
> *Sent:* Saturday, March 07, 2009 12:30 AM
> *To:* Liu Dave-R63238
> *Cc:* linuxppc-dev@ozlabs.org
> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>
> Thank you for your help!  That bit resolved all of the RDMA/WDMA coherency
> issues on the CSB side...except:
>
> We expose a 1MB region of memory from CSB via a BAR (BAR1, if it matters)
> to the Host.  This region is also not behaving correctly with respect to
> coherency on SOME hosts; again, disabling our cache makes it work correctly
> on all hosts.  We have set PEX_DEVICE_CONTROL in PCI-E Config Space (0x54)
> to 0x2010 (sorry about the endianness below).  We thought that CLEARING
> the no-snoop bit here would indicate that snooping was required for this
> region...is this a similar issue?
>
> - Ben
>
> On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca <ben.menchaca@gmail.com>wrote:
>
>> Testing now...it looks like it (almost) works, though!  Why does setting
>> no-snoop cause snooping to work?  More on the effect on setting that bit in
>> a few minutes...need more testing.
>>
>> ACR is 0x00030300.
>>
>> - Ben
>>
>>
>> On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>>
>>>  Did you enable the descriptor bit 3 to have a try?
>>>
>>>  ------------------------------
>>>  *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
>>> *Sent:* Friday, March 06, 2009 2:10 PM
>>>
>>> *To:* Liu Dave-R63238
>>> *Cc:* linuxppc-dev@ozlabs.org
>>> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>
>>>   I can look at ACR morning...although I can say with a fair amount of
>>> certainty that I have not changed it from the POR value.
>>>
>>> I will try enabling No Snoop for CSB in the descriptor (bit 3,
>>> yes?)...this seems a bit counterintuitive to me.
>>>
>>> What is the hope regarding these two?  Some combination I am not seeing?
>>>
>>>
>>> On Thu, Mar 5, 2009 at 11:40 PM, Liu Dave-R63238 <DaveLiu@freescale.com>wrote:
>>>
>>>>  what is the value of ACR register?
>>>>
>>>>  ------------------------------
>>>> *From:* Ben Menchaca [mailto:ben.menchaca@gmail.com]
>>>> *Sent:* Friday, March 06, 2009 1:38 PM
>>>> *To:* Liu Dave-R63238
>>>> *Cc:* linuxppc-dev@ozlabs.org
>>>> *Subject:* Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>>
>>>>   1.  BAT2 in linux is set to WIMG=0010, and covers all 64M
>>>> 2.  PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020
>>>> 3.  PEX_xDMA_CTRL is set to 0x00000401 at the initiation of the DMA.
>>>> 4.  OWAR0 is set to 0xFFFFF005, so NSNP is 0.
>>>> 5.  The DMA descriptor (randomly chosen when I hit a trigger...just
>>>> ignore the size...) contains 0002AFF3 at offset 0, so nosnoops are cleared.
>>>>
>>>>
>>>> Core is 400MHz, and CSB is 133MHz.
>>>>
>>>> - Ben
>>>>
>>>> On Thu, Mar 5, 2009 at 11:27 PM, Liu Dave-R63238 <DaveLiu@freescale.com
>>>> > wrote:
>>>>
>>>>> and what settings  is DMA description bit 3?
>>>>>
>>>>> > -----Original Message-----
>>>>> > From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>>>>> > [mailto:linuxppc-dev-bounces+daveliu<linuxppc-dev-bounces%2Bdaveliu>
>>>>> =freescale.com@ozlabs.org]
>>>>>  >  On Behalf Of Liu Dave-R63238
>>>>> > Sent: Friday, March 06, 2009 1:22 PM
>>>>> > To: Ben Menchaca; linuxppc-dev@ozlabs.org
>>>>> > Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>>> >
>>>>> > Did you enable the snoop bit at PEX_WDMA_CTRL[SNOOP] and
>>>>> > PEX_RDMA_CTRL[SNOOP]?
>>>>> >
>>>>> > What is the freq settings? CORE/CSB bus.
>>>>> >
>>>>> > Thanks, Dave
>>>>> >
>>>>> > ________________________________
>>>>> >
>>>>> >       From: linuxppc-dev-bounces+daveliu=freescale.com@ozlabs.org
>>>>> > [mailto:linuxppc-dev-bounces+daveliu<linuxppc-dev-bounces%2Bdaveliu>
>>>>> =freescale.com@ozlabs.org]
>>>>> >  On Behalf Of Ben Menchaca
>>>>> >       Sent: Friday, March 06, 2009 12:33 PM
>>>>> >       To: linuxppc-dev@ozlabs.org
>>>>> >       Subject: 83xx: Marking or Allocating Pages as Cache-Inhibited
>>>>> >
>>>>> >
>>>>> >       I am working on a Freescale 8314e design, and the
>>>>> > embedded device is configured as a PCI-e endpoint running a
>>>>> > 2.6.27-5 kernel.  For context, we have written a kernel
>>>>> > module which, among other things, uses the RDMA/WDMA engine
>>>>> > in the PCI-e IP block.  On the host side, these DMAs are
>>>>> > coherent.  However, on the embedded side, things are quite a
>>>>> > bit less rosy; we must manually flush/invalidate cache lines
>>>>> > for WDMA/RDMAs to occur successfully.  After speaking with
>>>>> > (several) FAEs at Freescale, we believe there is a
>>>>> > configuration issue that is the cause, but we have yet to
>>>>> > have anyone successfully point to it.
>>>>> >
>>>>> >       Disabling the data cache altogether resolves the issue
>>>>> > entirely, but of course, also completely tanks performance.
>>>>> > As a temporary workaround, I would like to simply mark the
>>>>> > pages (obtained currently via dma_alloc_coherent) involved as
>>>>> > cache-inhibited.  I have attempted to do this via some
>>>>> > snippets remaining in fec.c (va_to_pte, uncache_pte to set
>>>>> > _PAGE_NO_CACHE, flush_tlb_page, then unmap_pte), but this is
>>>>> > almost certainly braindead; va_to_pte is not a part of the
>>>>> > 83xx source, as far as I can tell; 8xx only.
>>>>> >
>>>>> >       A quick pointer in the correct direction for marking
>>>>> > pages as cache-inhibited on a 2.6.27-5 kernel would be
>>>>> > appreciated, or if my approach to a workaround is flawed, a
>>>>> > pointer to the correct way would be great.
>>>>> >
>>>>> >       Ben Menchaca
>>>>> >
>>>>> >
>>>>> > _______________________________________________
>>>>> > Linuxppc-dev mailing list
>>>>> > Linuxppc-dev@ozlabs.org
>>>>> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>>>> >
>>>>> >
>>>>>
>>>>
>>>>
>>>
>>
>

--00032557467a7104090464a737fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The only problem host found so far is a newer Asus 970FX motherboard, regar=
dless of OS.<br><br>We are seeing that some time after LTSSM finishes, but =
long before OS load, our PEX_DEVICE_CONTROL register is changed.=A0 On the =
&quot;working&quot; motherboards, NO_SNOOP is enabled; if I read the spec c=
orrectly, this means that TLPs with no-snoop are permitted.=A0 On the non-w=
orking motherboards, NO_SNOOP is disabled; this is supposed to mean that TL=
Ps with no-snoop are not permitted (again, if I understand correctly).=A0 I=
s it possible that there has been another misinterpretation of this bit?=A0=
 Something regarding the generation of snoops on CSB when it is cleared?<br=
>
<br>This bit could be a complete red herring; it was one of the few differe=
nces in the config space, however, so it was my best guess.<br><br>- Ben<br=
><br><div class=3D"gmail_quote">On Sun, Mar 8, 2009 at 9:56 PM, Liu Dave-R6=
3238 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com">DaveLiu=
@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



<div><div class=3D"im">
<div dir=3D"ltr" align=3D"left">
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">Hi Ben,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">The second issue. you told me &quot;some hosts&quot; has=20
problem,</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">and some hosts worked well.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">what is the problem-hosts?</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">The issue seems like the hosts did set the NO SNOOP=20
attribute</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">bit at TLP.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">The PEX_DEVICE_CONTROL is standard PCI configuration=20
space</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">register, it controls the behavior of the initiator&#39;s=20
transaction.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">For 8315, it is outbound, not inbound=20
transaction.</font></span></div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial"></font></span>=A0</div>
<div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D"2" fa=
ce=3D"Arial">Thanks, Dave</font></span></div></div><br>
</div><blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-l=
eft: 5px; margin-left: 5px; margin-right: 0px;">
  <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
  <hr>
  <font size=3D"2" face=3D"Tahoma"><div class=3D"im"><b>From:</b> Ben Mench=
aca=20
  [mailto:<a href=3D"mailto:ben.menchaca@gmail.com" target=3D"_blank">ben.m=
enchaca@gmail.com</a>] <br></div><div class=3D"im"><b>Sent:</b> Saturday, M=
arch 07, 2009=20
  12:30 AM<br></div><div><div></div><div class=3D"h5"><b>To:</b> Liu Dave-R=
63238<br><b>Cc:</b>=20
  <a href=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev=
@ozlabs.org</a><br><b>Subject:</b> Re: 83xx: Marking or Allocating=20
  Pages as Cache-Inhibited<br></div></div></font><br></div><div><div></div>=
<div class=3D"h5">
  <div></div>Thank you for your help!=A0 That bit resolved all of the=20
  RDMA/WDMA coherency issues on the CSB side...except:<br><br>We expose a 1=
MB=20
  region of memory from CSB via a BAR (BAR1, if it matters) to the Host.=A0=
=20
  This region is also not behaving correctly with respect to coherency on S=
OME=20
  hosts; again, disabling our cache makes it work correctly on all hosts.=
=A0=20
  We have set <font style=3D"font-size: 10pt; font-family: Tahoma;"><font s=
tyle=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10=
pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Taho=
ma;"><font style=3D"font-size: 10pt; font-family: Tahoma;">PEX_DEVICE_CONTR=
OL in PCI-E=20
  Config Space (0x54) to </font></font></font></font></font><font style=3D"=
font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font=
-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;"><fo=
nt style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size=
: 10pt; font-family: Tahoma;">0x2010 (sorry about the=20
  endianness below).=A0 We thought that CLEARING the no-snoop bit here woul=
d=20
  indicate that snooping was required for this region...is this a similar=
=20
  issue?<br><br>- Ben<br></font></font></font></font></font><br>
  <div class=3D"gmail_quote">On Fri, Mar 6, 2009 at 10:12 AM, Ben Menchaca =
<span dir=3D"ltr">&lt;<a href=3D"mailto:ben.menchaca@gmail.com" target=3D"_=
blank">ben.menchaca@gmail.com</a>&gt;</span>=20
  wrote:<br>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Testing=20
    now...it looks like it (almost) works, though!=A0 Why does setting=20
    no-snoop cause snooping to work?=A0 More on the effect on setting that=
=20
    bit in a few minutes...need more testing.<br>=A0<br>ACR is=20
    0x00030300.<br><font color=3D"#888888"><br>- Ben</font>
    <div>
    <div></div>
    <div><br><br>
    <div class=3D"gmail_quote">On Fri, Mar 6, 2009 at 12:30 AM, Liu Dave-R6=
3238=20
    <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" target=
=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br>
    <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
      <div>
      <div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" size=3D=
"2" face=3D"Arial">Did=20
      you enable the descriptor bit 3 to have a try?</font></span></div><br=
>
      <blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-l=
eft: 5px; margin-left: 5px; margin-right: 0px;">
        <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
        <hr>
        <font size=3D"2" face=3D"Tahoma">
        <div><b>From:</b> Ben Menchaca [mailto:<a href=3D"mailto:ben.mencha=
ca@gmail.com" target=3D"_blank">ben.menchaca@gmail.com</a>] <br></div><b>Se=
nt:</b> Friday,=20
        March 06, 2009 2:10 PM
        <div>
        <div></div>
        <div><br><b>To:</b> Liu Dave-R63238<br><b>Cc:</b> <a href=3D"mailto=
:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a><br>=
<b>Subject:</b> Re: 83xx:=20
        Marking or Allocating Pages as=20
        Cache-Inhibited<br></div></div></font><br></div>
        <div>
        <div></div>
        <div>
        <div></div>I can look at ACR morning...although I can say with a fa=
ir=20
        amount of certainty that I have not changed it from the POR=20
        value.<br><br>I will try enabling No Snoop for CSB in the descripto=
r=20
        (bit 3, yes?)...this seems a bit counterintuitive to me.<br><br>Wha=
t is=20
        the hope regarding these two?=A0 Some combination I am not=20
        seeing?<br><br><br>
        <div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:40 PM, Liu Dav=
e-R63238=20
        <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@freescale.com" targ=
et=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<br>
        <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid r=
gb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
          <div>
          <div dir=3D"ltr" align=3D"left"><span><font color=3D"#0000ff" siz=
e=3D"2" face=3D"Arial">what is the value of ACR register?</font></span></di=
v><br>
          <blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); paddi=
ng-left: 5px; margin-left: 5px; margin-right: 0px;">
            <div dir=3D"ltr" align=3D"left" lang=3D"en-us">
            <hr>
            <font size=3D"2" face=3D"Tahoma"><b>From:</b> Ben Menchaca [mai=
lto:<a href=3D"mailto:ben.menchaca@gmail.com" target=3D"_blank">ben.menchac=
a@gmail.com</a>] <br><b>Sent:</b> Friday,=20
            March 06, 2009 1:38 PM<br><b>To:</b> Liu Dave-R63238<br><b>Cc:<=
/b>=20
            <a href=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">li=
nuxppc-dev@ozlabs.org</a><br><b>Subject:</b> Re:=20
            83xx: Marking or Allocating Pages as=20
            Cache-Inhibited<br></font><br></div>
            <div>
            <div></div>
            <div>
            <div></div><font style=3D"font-size: 10pt; font-family: Tahoma;=
"><font style=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font=
-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-fam=
ily: Tahoma;"><font style=3D"font-size: 10pt; font-family: Tahoma;">1.=A0 B=
AT2 in linux=20
            is set to WIMG=3D0010, and covers all 64M<br>2.=A0=20
            PEX_DEVICE_CONTROL in PCI-E Config Space (0x54): 0x1020<br>3.=
=A0=20
            PEX_xDMA_CTRL is set to <span></span>0x00000401 at the initiati=
on of=20
            the DMA.<br>4.=A0 OWAR0 is set to 0xFFFFF005, so NSNP is=20
            0.<br>5.=A0 The DMA descriptor (randomly chosen when I hit a=20
            trigger...just ignore the size...) contains 0002AFF3 at offset =
0, so=20
            nosnoops are cleared.</font></font></font></font></font><font s=
tyle=3D"font-size: 10pt; font-family: Tahoma;"><font style=3D"font-size: 10=
pt; font-family: Tahoma;"><font style=3D"font-size: 10pt; font-family: Taho=
ma;"><font style=3D"font-size: 10pt; font-family: Tahoma;">=A0 <br>
<br>Core is=20
            400MHz, and CSB is 133MHz.</font></font></font></font><br><font=
 color=3D"#888888"><br>- Ben<br></font><br>
            <div class=3D"gmail_quote">On Thu, Mar 5, 2009 at 11:27 PM, Liu=
=20
            Dave-R63238 <span dir=3D"ltr">&lt;<a href=3D"mailto:DaveLiu@fre=
escale.com" target=3D"_blank">DaveLiu@freescale.com</a>&gt;</span> wrote:<b=
r>
            <blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">and=
=20
              what settings =A0is DMA description bit 3?<br>
              <div><br>&gt; -----Original Message-----<br>&gt; From:=20
              linuxppc-dev-bounces+daveliu=3D<a href=3D"http://freescale.co=
m" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" target=
=3D"_blank">ozlabs.org</a><br>&gt; [mailto:<a href=3D"mailto:linuxppc-dev-b=
ounces%2Bdaveliu" target=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D<a h=
ref=3D"http://freescale.com" target=3D"_blank">freescale.com</a>@<a href=3D=
"http://ozlabs.org" target=3D"_blank">ozlabs.org</a>]<br>
</div>
              <div>
              <div></div>
              <div>&gt; =A0On Behalf Of Liu Dave-R63238<br>&gt; Sent: Frida=
y,=20
              March 06, 2009 1:22 PM<br>&gt; To: Ben Menchaca; <a href=3D"m=
ailto:linuxppc-dev@ozlabs.org" target=3D"_blank">linuxppc-dev@ozlabs.org</a=
><br>&gt; Subject: RE:=20
              83xx: Marking or Allocating Pages as=20
              Cache-Inhibited<br>&gt;<br>&gt; Did you enable the snoop bit =
at=20
              PEX_WDMA_CTRL[SNOOP] and<br>&gt;=20
              PEX_RDMA_CTRL[SNOOP]?<br>&gt;<br>&gt; What is the freq settin=
gs?=20
              CORE/CSB bus.<br>&gt;<br>&gt; Thanks, Dave<br>&gt;<br>&gt;=20
              ________________________________<br>&gt;<br>&gt; =A0 =A0=20
              =A0 From: linuxppc-dev-bounces+daveliu=3D<a href=3D"http://fr=
eescale.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.o=
rg" target=3D"_blank">ozlabs.org</a><br>&gt;=20
              [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Bdaveliu" tar=
get=3D"_blank">linuxppc-dev-bounces+daveliu</a>=3D<a href=3D"http://freesca=
le.com" target=3D"_blank">freescale.com</a>@<a href=3D"http://ozlabs.org" t=
arget=3D"_blank">ozlabs.org</a>]<br>
&gt;=20
              =A0On Behalf Of Ben Menchaca<br>&gt; =A0 =A0 =A0 Sent:=20
              Friday, March 06, 2009 12:33 PM<br>&gt; =A0 =A0 =A0 To:=20
              <a href=3D"mailto:linuxppc-dev@ozlabs.org" target=3D"_blank">=
linuxppc-dev@ozlabs.org</a><br>&gt; =A0 =A0=20
              =A0 Subject: 83xx: Marking or Allocating Pages as=20
              Cache-Inhibited<br>&gt;<br>&gt;<br>&gt; =A0 =A0 =A0 I am=20
              working on a Freescale 8314e design, and the<br>&gt; embedded=
=20
              device is configured as a PCI-e endpoint running a<br>&gt;=20
              2.6.27-5 kernel. =A0For context, we have written a=20
              kernel<br>&gt; module which, among other things, uses the=20
              RDMA/WDMA engine<br>&gt; in the PCI-e IP block. =A0On the hos=
t=20
              side, these DMAs are<br>&gt; coherent. =A0However, on the=20
              embedded side, things are quite a<br>&gt; bit less rosy; we m=
ust=20
              manually flush/invalidate cache lines<br>&gt; for WDMA/RDMAs =
to=20
              occur successfully. =A0After speaking with<br>&gt; (several)=
=20
              FAEs at Freescale, we believe there is a<br>&gt; configuratio=
n=20
              issue that is the cause, but we have yet to<br>&gt; have anyo=
ne=20
              successfully point to it.<br>&gt;<br>&gt; =A0 =A0 =A0=20
              Disabling the data cache altogether resolves the issue<br>&gt=
;=20
              entirely, but of course, also completely tanks=20
              performance.<br>&gt; As a temporary workaround, I would like =
to=20
              simply mark the<br>&gt; pages (obtained currently via=20
              dma_alloc_coherent) involved as<br>&gt; cache-inhibited. =A0I=
=20
              have attempted to do this via some<br>&gt; snippets remaining=
 in=20
              fec.c (va_to_pte, uncache_pte to set<br>&gt; _PAGE_NO_CACHE,=
=20
              flush_tlb_page, then unmap_pte), but this is<br>&gt; almost=
=20
              certainly braindead; va_to_pte is not a part of the<br>&gt; 8=
3xx=20
              source, as far as I can tell; 8xx only.<br>&gt;<br>&gt; =A0=
=20
              =A0 =A0 A quick pointer in the correct direction for=20
              marking<br>&gt; pages as cache-inhibited on a 2.6.27-5 kernel=
=20
              would be<br>&gt; appreciated, or if my approach to a workarou=
nd is=20
              flawed, a<br>&gt; pointer to the correct way would be=20
              great.<br>&gt;<br>&gt; =A0 =A0 =A0 Ben=20
              Menchaca<br>&gt;<br>&gt;<br></div></div>&gt;=20
              _______________________________________________<br>&gt;=20
              Linuxppc-dev mailing list<br>&gt; <a href=3D"mailto:Linuxppc-=
dev@ozlabs.org" target=3D"_blank">Linuxppc-dev@ozlabs.org</a><br>&gt; <a hr=
ef=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_blank">h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
&gt;<br>&gt;<br></blockquote></div><br></div></div></blockquote></div></blo=
ckquote></div><br></div></div></blockquote></div></blockquote></div><br></d=
iv></div></blockquote></div><br></div></div></blockquote></div>
</blockquote></div><br>

--00032557467a7104090464a737fe--
