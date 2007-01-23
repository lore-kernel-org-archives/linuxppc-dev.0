Return-Path: <wmaxfield@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id C69C9DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 07:07:17 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so783256ana
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 12:07:16 -0800 (PST)
Message-ID: <45a1b53e0701231207n548d64d6v66e02097ad3c70be@mail.gmail.com>
Date: Tue, 23 Jan 2007 14:07:14 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: "linux-ppc@eurotel.it" <linux-ppc@eurotel.it>
Subject: Re: System Ace booting (or not) question
In-Reply-To: <OFCEF3DE70.B954AC89-ONC125726C.00347491-C125726C.003548C4@eurotel.it>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_201634_14514354.1169582834413"
References: <45a1b53e0701050823y68db3059pcddfa784b39fed66@mail.gmail.com>
	<OFCEF3DE70.B954AC89-ONC125726C.00347491-C125726C.003548C4@eurotel.it>
Cc: ppc <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_201634_14514354.1169582834413
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

  We got it to load into DDR ram, based on a comment you made earlier about
how the system ace works.

  In our  genace.opt file (the one we made ourselves), an engineer had put
-debugdevice devicenr 1 cpunr 2

  It turns out that the last "debugdevice" being used is the one that the
system ace chip uses to gain control of to download the elf file into ram.
We had picked the cpu that was not tied to the plb bus, so it could not
write to ram.  The system ace did not care and did not error out.

  Once we set it to
-debugdevice devicenr 1 cpunr 1

  then it loaded into ram and tried. to execute.  We are now having DDR ram
problems, we are trying to solve those problems.

thanks again for your help!

wade


On 1/23/07, linux-ppc@eurotel.it <linux-ppc@eurotel.it> wrote:
>
>
> Hi Wade,
> we made our board from scratch, there are two FPGA, one FX12 and one SX35=
,
> loaded with system ace,Montavista Linux and everything is ok.
> Is the JTAG chain in the correct sequence?
> are there in your board only one fpga or there is a chain with two fpga?
> if yes the Xilinx documentation with genace.tcl fails to concatenate two
> fpga files.
> also verify the tools errors manually executing the genace.tcl commands;
> they are not so difficult to understand.
> also verify that bootlloop code is loaded into the fabric ram.
> keep in mind that your memory is to be loaded via JTAG command, so if FPG=
A
> load correctly and DDR is working, then there is no reason to have DDR lo=
ad
> failure.
> regards
>
>
>  *"Wade Maxfield" <wmaxfield@gmail.com>*
> Sent by: linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org
>
> 05/01/2007 17.23
>   To
> christophe.alayrac@cresitt.com  cc
> ppc <linuxppc-embedded@ozlabs.org>  Subject
> Re: System Ace booting (or not) question
>
>
>
>
>
>
> Hi Alayrac,
>
>  Thank you for your reply.
>
>  No, there is no bus error.
>
>  The memory map of our design matches the ML403 as regards the DDR ram.
>  We are just trying to get the code into external DDR Ram.
>
>  The code start address is specified in the elf file, and lists correctly
> on the screen as the genace script executes.
>
>  The code in zImage.elf is compiled to the DDR space, and so should load
> there.   The genace script prints out the code will load there when it ru=
ns
> and places
> the .elf file into the system.  The system.ace file is 10 megabytes after
> the zImage.elf code is put into it.  when doing only the internal block
> ram load, the system.ace
> file is only 2.8 megabytes in size.
>
>
> thanks again,
> wade
>
>
>
>
> On 1/5/07, *alayrac christophe* <*christophe.alayrac@cresitt.com*<christo=
phe.alayrac@cresitt.com>> wrote:
> High Wade,
>
> Does systemace comes out with a bus error? (Red led on ML403 board)?
>
> If yes may be its because the memory map of your design did not fit with
> ML403 ones and that SystemaAce try to load kernel image in a non ram
> place.
>
> you may have to specify the code start address to the genace.tcl script
> to generate properly the ace file. (it should be something like
> start_address 0xYOURADDR in the opt file)
>
> Have you tried to download the kernel image through JTAG?
>
> You can also try to compile a standalone code in DDR space (not BRAM as
> describe in your email) an try to make an ace file with it.
>
> regards
>
> Chris
>
> Le vendredi 05 janvier 2007 =E0 09:20 -0600, Wade Maxfield a =E9crit :
> >
> >   I'm very new to System Ace, and this is probably a stupid question.
> >
> >   We were able, with the Monta Vista Linux to get a system.ace with a
> > zImage.elf linux file to boot on an ml403 board.  The system ace chip
> > seemed to copy the zImage.elf into DDR ram, and the system booted.  No
> > block ram used.
> >
> >    We created a board with an xf60 and a system ace chip on it and
> > created a system.ace file.  The xilinx loads, but the zImage.elf does
> > not copy into ddr ram.  We ran the testfatfs code and read from and
> > wrote to the compact flash on the system ace chip, verifying the files
> > through a compact flash adaptor on a pc.
> >
> >    We created a memory test using the ppc and were able (after some
> > wiring changes and other headaches) to prove the ddr ram works.  There
> > is enough of it to support linux (64 meg), and testing all 64 million
> > locations with various fixed and incrementing patterns proves it
> > works.
> >
> >    However, we could not get the external ram to load up with the
> > linux zImage.elf file. When this failed, we created a system.ace file
> > with two elf's in it, one for linux, one for a memory read/write
> > tester in block ram.
> >
> >   It appears the system ace chip loads the info into block ram just
> > fine, and our memory test executes.  However, our ddr ram has nothing
> > in it.  We reversed the order of the elf files, and that still did not
> > help.
> >
> >   Do we need a helper CPLD on this board to accomplish what the ML403
> > accomplishes?  Or do we need to do a boot loader in code?  If we need
> > to do a boot loader, how come the Monta Vista linux doesn't need one
> > on the ml403 board?  I've been googling and scouring the Xilinx site,
> > but I've achieved nothing but a few less hairs on my head.
> >
> >   I've already asked Monta Vista this question, and they quoted
> > verbatim the page from the xilinx manual, which is a generic answer to
> > the specific question.  Even if the xilinx manual is the answer, we
> > aren't seeing the results the manual implies we will see.
> >
> >   Can someone give me a clue?
> >
> > thanks,
> > wade
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > *Linuxppc-embedded@ozlabs.org* <Linuxppc-embedded@ozlabs.org>
> > *https://ozlabs.org/mailman/listinfo/linuxppc-embedded*<https://ozlabs.=
org/mailman/listinfo/linuxppc-embedded>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_201634_14514354.1169582834413
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>&nbsp;<br>&nbsp; We got it to load into DDR ram, based on a comment =
you made earlier about how the system ace works.<br>&nbsp;<br>&nbsp; In our=
&nbsp; genace.opt file (the one we made ourselves), an engineer had put<br>=
-debugdevice devicenr 1 cpunr 2
<br><br>&nbsp; It turns out that the last &quot;debugdevice&quot; being use=
d is the one that the system ace chip uses to gain control of to download t=
he elf file into ram.&nbsp; We had picked the cpu that was not tied to the =
plb bus, so it could not write to ram.&nbsp; The system ace did not care an=
d did not error out.
<br><br>&nbsp; Once we set it to <br>-debugdevice devicenr 1 cpunr 1<br><br=
>&nbsp; then it loaded into ram and tried. to execute.&nbsp; We are now hav=
ing DDR ram problems, we are trying to solve those problems.<br><br>thanks =
again for your help!
<br><br>wade<br><br><br><div><span class=3D"gmail_quote">On 1/23/07, <b cla=
ss=3D"gmail_sendername"><a href=3D"mailto:linux-ppc@eurotel.it">linux-ppc@e=
urotel.it</a></b> &lt;<a href=3D"mailto:linux-ppc@eurotel.it">linux-ppc@eur=
otel.it
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
<br><font face=3D"sans-serif" size=3D"2">Hi Wade,</font>
<br><font face=3D"sans-serif" size=3D"2">we made our board from scratch, th=
ere
are two FPGA, one FX12 and one SX35, loaded with system ace,Montavista
Linux and everything is ok.</font>
<br><font face=3D"sans-serif" size=3D"2">Is the JTAG chain in the correct s=
equence?</font>
<br><font face=3D"sans-serif" size=3D"2">are there in your board only one f=
pga
or there is a chain with two fpga? if yes the Xilinx documentation with
genace.tcl fails to concatenate two fpga files.</font>
<br><font face=3D"sans-serif" size=3D"2">also verify the tools errors manua=
lly
executing the genace.tcl commands; they are not so difficult to understand.=
</font>
<br><font face=3D"sans-serif" size=3D"2">also verify that bootlloop code is=
 loaded
into the fabric ram.</font>
<br><font face=3D"sans-serif" size=3D"2">keep in mind that your memory is t=
o
be loaded via JTAG command, so if FPGA load correctly and DDR is working,
then there is no reason to have DDR load failure.</font>
<br><font face=3D"sans-serif" size=3D"2">regards</font>
<br>
<br>
<br>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"40%"><font face=3D"sans-serif" size=3D"1"><b>&quot;Wade Maxfie=
ld&quot;
&lt;<a href=3D"mailto:wmaxfield@gmail.com" target=3D"_blank" onclick=3D"ret=
urn top.js.OpenExtLink(window,event,this)">wmaxfield@gmail.com</a>&gt;</b> =
</font>
<br><font face=3D"sans-serif" size=3D"1">Sent by: linuxppc-embedded-bounces=
+linux-ppc=3D<a href=3D"mailto:eurotel.it@ozlabs.org" target=3D"_blank" onc=
lick=3D"return top.js.OpenExtLink(window,event,this)">eurotel.it@ozlabs.org=
</a></font>

<p><font face=3D"sans-serif" size=3D"1">05/01/2007 17.23</font>
</p></td><td width=3D"59%">
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">To</font></div>
</td><td><font face=3D"sans-serif" size=3D"1"><a href=3D"mailto:christophe.=
alayrac@cresitt.com" target=3D"_blank" onclick=3D"return top.js.OpenExtLink=
(window,event,this)">christophe.alayrac@cresitt.com</a></font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">cc</font></div>
</td><td><font face=3D"sans-serif" size=3D"1">ppc &lt;<a href=3D"mailto:lin=
uxppc-embedded@ozlabs.org" target=3D"_blank" onclick=3D"return top.js.OpenE=
xtLink(window,event,this)">linuxppc-embedded@ozlabs.org</a>&gt;</font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">Subject</font></d=
iv>
</td><td><font face=3D"sans-serif" size=3D"1">Re: System Ace booting (or no=
t) question</font></td></tr></tbody></table>
<br>
<table>
<tbody><tr valign=3D"top">
<td>
<br></td><td><br></td></tr></tbody></table>
<br></td></tr></tbody></table><div><span class=3D"e" id=3D"q_1104e5cf8d66e1=
68_1">
<br>
<br>
<br><font size=3D"3">Hi Alayrac,<br>
<br>
 &nbsp;Thank you for your reply.<br>
<br>
 &nbsp;No, there is no bus error.<br>
<br>
 &nbsp;The memory map of our design matches the ML403 as regards the DDR
ram. &nbsp;We are just trying to get the code into external DDR Ram.<br>
<br>
 &nbsp;The code start address is specified in the elf file, and lists corre=
ctly
on the screen as the genace script executes.<br>
<br>
 &nbsp;The code in zImage.elf is compiled to the DDR space, and so should
load there. &nbsp; The genace script prints out the code will load there
when it runs and places <br>
the .elf file into the system. &nbsp;The system.ace file is 10 megabytes
after the zImage.elf code is put into it. &nbsp;when doing only the interna=
l
block ram load, the system.ace<br>
file is only 2.8 megabytes in size.<br>
<br>
<br>
thanks again,<br>
wade<br>
<br>
<br>
<br>
</font>
<br><font size=3D"3">On 1/5/07, <b>alayrac christophe</b> &lt;</font><a hre=
f=3D"mailto:christophe.alayrac@cresitt.com" target=3D"_blank" onclick=3D"re=
turn top.js.OpenExtLink(window,event,this)"><font color=3D"blue" size=3D"3"=
><u>christophe.alayrac@cresitt.com
</u></font></a><font size=3D"3">
&gt; wrote:</font>
<br><font size=3D"3">High Wade,<br>
<br>
Does systemace comes out with a bus error? (Red led on ML403 board)? <br>
<br>
If yes may be its because the memory map of your design did not fit with<br=
>
ML403 ones and that SystemaAce try to load kernel image in a non ram<br>
place.<br>
<br>
you may have to specify the code start address to the genace.tcl script<br>
to generate properly the ace file. (it should be something like<br>
start_address 0xYOURADDR in the opt file)<br>
<br>
Have you tried to download the kernel image through JTAG?<br>
<br>
You can also try to compile a standalone code in DDR space (not BRAM as
<br>
describe in your email) an try to make an ace file with it.<br>
<br>
regards<br>
<br>
Chris<br>
<br>
Le vendredi 05 janvier 2007 =E0 09:20 -0600, Wade Maxfield a =E9crit :<br>
&gt;<br>
&gt; &nbsp; I&#39;m very new to System Ace, and this is probably a stupid q=
uestion.
<br>
&gt;<br>
&gt; &nbsp; We were able, with the Monta Vista Linux to get a system.ace
with a<br>
&gt; zImage.elf linux file to boot on an ml403 board. &nbsp;The system
ace chip<br>
&gt; seemed to copy the zImage.elf into DDR ram, and the system booted.
&nbsp;No <br>
&gt; block ram used.<br>
&gt;<br>
&gt; &nbsp; &nbsp;We created a board with an xf60 and a system ace chip
on it and<br>
&gt; created a system.ace file. &nbsp;The xilinx loads, but the zImage.elf
does<br>
&gt; not copy into ddr ram. &nbsp;We ran the testfatfs code and read from
and <br>
&gt; wrote to the compact flash on the system ace chip, verifying the files=
<br>
&gt; through a compact flash adaptor on a pc.<br>
&gt;<br>
&gt; &nbsp; &nbsp;We created a memory test using the ppc and were able
(after some<br>
&gt; wiring changes and other headaches) to prove the ddr ram works. &nbsp;=
There
<br>
&gt; is enough of it to support linux (64 meg), and testing all 64 million<=
br>
&gt; locations with various fixed and incrementing patterns proves it<br>
&gt; works.<br>
&gt;<br>
&gt; &nbsp; &nbsp;However, we could not get the external ram to load up
with the <br>
&gt; linux zImage.elf file. When this failed, we created a system.ace file<=
br>
&gt; with two elf&#39;s in it, one for linux, one for a memory read/write<b=
r>
&gt; tester in block ram.<br>
&gt;<br>
&gt; &nbsp; It appears the system ace chip loads the info into block ram
just <br>
&gt; fine, and our memory test executes. &nbsp;However, our ddr ram has
nothing<br>
&gt; in it. &nbsp;We reversed the order of the elf files, and that still
did not<br>
&gt; help.<br>
&gt;<br>
&gt; &nbsp; Do we need a helper CPLD on this board to accomplish what the
ML403 <br>
&gt; accomplishes? &nbsp;Or do we need to do a boot loader in code? &nbsp;I=
f
we need<br>
&gt; to do a boot loader, how come the Monta Vista linux doesn&#39;t need o=
ne<br>
&gt; on the ml403 board? &nbsp;I&#39;ve been googling and scouring the Xili=
nx
site, <br>
&gt; but I&#39;ve achieved nothing but a few less hairs on my head.<br>
&gt;<br>
&gt; &nbsp; I&#39;ve already asked Monta Vista this question, and they quot=
ed<br>
&gt; verbatim the page from the xilinx manual, which is a generic answer
to <br>
&gt; the specific question. &nbsp;Even if the xilinx manual is the answer,
we<br>
&gt; aren&#39;t seeing the results the manual implies we will see.<br>
&gt;<br>
&gt; &nbsp; Can someone give me a clue?<br>
&gt;<br>
&gt; thanks,<br>
&gt; wade <br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-embedded mailing list<br>
&gt; </font><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blan=
k" onclick=3D"return top.js.OpenExtLink(window,event,this)"><font color=3D"=
blue" size=3D"3"><u>Linuxppc-embedded@ozlabs.org</u></font></a><font size=
=3D"3"><br>

&gt; </font><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedde=
d" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this=
)"><font color=3D"blue" size=3D"3"><u>https://ozlabs.org/mailman/listinfo/l=
inuxppc-embedded
</u></font></a><font size=3D"3"><br>
</font>
<br><tt><font size=3D"2">_______________________________________________<br=
>
Linuxppc-embedded mailing list<br>
<a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blank" onclick=
=3D"return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlabs.=
org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target=3D=
"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">https://o=
zlabs.org/mailman/listinfo/linuxppc-embedded</a></font></tt>
<br>
</span></div></blockquote></div><br>

------=_Part_201634_14514354.1169582834413--
