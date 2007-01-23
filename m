Return-Path: <massimiliano.patriarca@eurotel.it>
Received: from smtp02.kpnqwest.it (smtp02.kpnqwest.it [212.97.32.23])
	by ozlabs.org (Postfix) with ESMTP id 8E5F5DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 22:18:38 +1100 (EST)
Received: from mail.eurotel.it (212-97-63-130.dcpool.ip.kpnqwest.it
	[212.97.63.130])
	by smtp02.kpnqwest.it (Postfix) with ESMTP id B91571083F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 11:51:30 +0100 (CET)
Received: from [192.168.0.16] (helo=as520.master.eurotel.it)
	by lissone.master.eurotel.it with esmtp (Exim 4.43)
	id 1H9JC5-0004ng-SZ
	for linuxppc-embedded@ozlabs.org; Tue, 23 Jan 2007 11:48:02 +0100
From: linux-ppc@eurotel.it
To: linuxppc-embedded@ozlabs.org
Subject: In: Re: System Ace booting (or not) question
MIME-Version: 1.0
Message-ID: <OF2FBBE734.40EB8DF4-ONC125726C.003B022C-C125726C.003B1242@eurotel.it>
Sender: Massimiliano.Patriarca@eurotel.it
Date: Tue, 23 Jan 2007 11:45:12 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 003B1233C125726C_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Questo Š un messaggio multiparte in formato MIME.
--=_alternative 003B1233C125726C_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

linux-ppc linux-ppc/eurotel
Sent by: Massimiliano Patriarca
23/01/2007 10.42

To
"Wade Maxfield" <wmaxfield@gmail.com>
cc

Subject
Re: System Ace booting (or not) question





Hi Wade,
we made our board from scratch, there are two FPGA, one FX12 and one SX35, =

loaded with system ace,Montavista Linux and everything is ok.
Is the JTAG chain in the correct sequence?
are there in your board only one fpga or there is a chain with two fpga?=20
if yes the Xilinx documentation with genace.tcl fails to concatenate two=20
fpga files.
also verify the tools errors manually executing the genace.tcl commands;=20
they are not so difficult to understand.
also verify that bootlloop code is loaded into the fabric ram.
keep in mind that your memory is to be loaded via JTAG command, so if FPGA =

load correctly and DDR is working, then there is no reason to have DDR=20
load failure.
regards



"Wade Maxfield" <wmaxfield@gmail.com>=20
Sent by: linuxppc-embedded-bounces+linux-ppc=3Deurotel.it@ozlabs.org
05/01/2007 17.23

To
christophe.alayrac@cresitt.com
cc
ppc <linuxppc-embedded@ozlabs.org>
Subject
Re: System Ace booting (or not) question






Hi Alayrac,

  Thank you for your reply.

  No, there is no bus error.

  The memory map of our design matches the ML403 as regards the DDR ram.=20
We are just trying to get the code into external DDR Ram.

  The code start address is specified in the elf file, and lists correctly =

on the screen as the genace script executes.

  The code in zImage.elf is compiled to the DDR space, and so should load=20
there.   The genace script prints out the code will load there when it=20
runs and places=20
the .elf file into the system.  The system.ace file is 10 megabytes after=20
the zImage.elf code is put into it.  when doing only the internal block=20
ram load, the system.ace
file is only 2.8 megabytes in size.


thanks again,
wade




On 1/5/07, alayrac christophe <christophe.alayrac@cresitt.com > wrote:
High Wade,

Does systemace comes out with a bus error? (Red led on ML403 board)?=20

If yes may be its because the memory map of your design did not fit with
ML403 ones and that SystemaAce try to load kernel image in a non ram
place.

you may have to specify the code start address to the genace.tcl script
to generate properly the ace file. (it should be something like
start=5Faddress 0xYOURADDR in the opt file)

Have you tried to download the kernel image through JTAG?

You can also try to compile a standalone code in DDR space (not BRAM as=20
describe in your email) an try to make an ace file with it.

regards

Chris

Le vendredi 05 janvier 2007 =E0 09:20 -0600, Wade Maxfield a =E9crit :
>
>   I'm very new to System Ace, and this is probably a stupid question.=20
>
>   We were able, with the Monta Vista Linux to get a system.ace with a
> zImage.elf linux file to boot on an ml403 board.  The system ace chip
> seemed to copy the zImage.elf into DDR ram, and the system booted.  No=20
> block ram used.
>
>    We created a board with an xf60 and a system ace chip on it and
> created a system.ace file.  The xilinx loads, but the zImage.elf does
> not copy into ddr ram.  We ran the testfatfs code and read from and=20
> wrote to the compact flash on the system ace chip, verifying the files
> through a compact flash adaptor on a pc.
>
>    We created a memory test using the ppc and were able (after some
> wiring changes and other headaches) to prove the ddr ram works.  There=20
> is enough of it to support linux (64 meg), and testing all 64 million
> locations with various fixed and incrementing patterns proves it
> works.
>
>    However, we could not get the external ram to load up with the=20
> linux zImage.elf file. When this failed, we created a system.ace file
> with two elf's in it, one for linux, one for a memory read/write
> tester in block ram.
>
>   It appears the system ace chip loads the info into block ram just=20
> fine, and our memory test executes.  However, our ddr ram has nothing
> in it.  We reversed the order of the elf files, and that still did not
> help.
>
>   Do we need a helper CPLD on this board to accomplish what the ML403=20
> accomplishes?  Or do we need to do a boot loader in code?  If we need
> to do a boot loader, how come the Monta Vista linux doesn't need one
> on the ml403 board?  I've been googling and scouring the Xilinx site,=20
> but I've achieved nothing but a few less hairs on my head.
>
>   I've already asked Monta Vista this question, and they quoted
> verbatim the page from the xilinx manual, which is a generic answer to=20
> the specific question.  Even if the xilinx manual is the answer, we
> aren't seeing the results the manual implies we will see.
>
>   Can someone give me a clue?
>
> thanks,
> wade=20
>
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=_alternative 003B1233C125726C_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br>
<table width=3D100%>
<tr valign=3Dtop>
<td width=3D40%><font size=3D1 face=3D"sans-serif"><b>linux-ppc linux-ppc/e=
urotel</b></font>
<br><font size=3D1 face=3D"sans-serif">Sent by: Massimiliano Patriarca</fon=
t>
<p><font size=3D1 face=3D"sans-serif">23/01/2007 10.42</font>
<td width=3D59%>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">To</font></div>
<td><font size=3D1 face=3D"sans-serif">&quot;Wade Maxfield&quot; &lt;wmaxfi=
eld@gmail.com&gt;</font>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">cc</font></div>
<td>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">Subject</font></div>
<td><font size=3D1 face=3D"sans-serif">Re: System Ace booting (or not) ques=
tion</font><a href=3DNotes://lnseur01/C12571E40031FF50/DABA975B9FB113EB8525=
64B5001283EA/6166664DBE2CE5E4C125725A0059CA63>Collegamento</a></table>
<br>
<table>
<tr valign=3Dtop>
<td>
<td></table>
<br></table>
<br>
<br><font size=3D2 face=3D"sans-serif">Hi Wade,</font>
<br><font size=3D2 face=3D"sans-serif">we made our board from scratch, there
are two FPGA, one FX12 and one SX35, loaded with system ace,Montavista
Linux and everything is ok.</font>
<br><font size=3D2 face=3D"sans-serif">Is the JTAG chain in the correct seq=
uence?</font>
<br><font size=3D2 face=3D"sans-serif">are there in your board only one fpga
or there is a chain with two fpga? if yes the Xilinx documentation with
genace.tcl fails to concatenate two fpga files.</font>
<br><font size=3D2 face=3D"sans-serif">also verify the tools errors manually
executing the genace.tcl commands; they are not so difficult to understand.=
</font>
<br><font size=3D2 face=3D"sans-serif">also verify that bootlloop code is l=
oaded
into the fabric ram.</font>
<br><font size=3D2 face=3D"sans-serif">keep in mind that your memory is to
be loaded via JTAG command, so if FPGA load correctly and DDR is working,
then there is no reason to have DDR load failure.</font>
<br><font size=3D2 face=3D"sans-serif">regards</font>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td width=3D40%><font size=3D1 face=3D"sans-serif"><b>&quot;Wade Maxfield&q=
uot;
&lt;wmaxfield@gmail.com&gt;</b> </font>
<br><font size=3D1 face=3D"sans-serif">Sent by: linuxppc-embedded-bounces+l=
inux-ppc=3Deurotel.it@ozlabs.org</font>
<p><font size=3D1 face=3D"sans-serif">05/01/2007 17.23</font>
<td width=3D59%>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">To</font></div>
<td><font size=3D1 face=3D"sans-serif">christophe.alayrac@cresitt.com</font>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">cc</font></div>
<td><font size=3D1 face=3D"sans-serif">ppc &lt;linuxppc-embedded@ozlabs.org=
&gt;</font>
<tr valign=3Dtop>
<td>
<div align=3Dright><font size=3D1 face=3D"sans-serif">Subject</font></div>
<td><font size=3D1 face=3D"sans-serif">Re: System Ace booting (or not) ques=
tion</font></table>
<br>
<table>
<tr valign=3Dtop>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=3D3>Hi Alayrac,<br>
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
after the zImage.elf code is put into it. &nbsp;when doing only the internal
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
<br><font size=3D3>On 1/5/07, <b>alayrac christophe</b> &lt;</font><a href=
=3Dmailto:christophe.alayrac@cresitt.com><font size=3D3 color=3Dblue><u>chr=
istophe.alayrac@cresitt.com</u></font></a><font size=3D3>
&gt; wrote:</font>
<br><font size=3D3>High Wade,<br>
<br>
Does systemace comes out with a bus error? (Red led on ML403 board)? <br>
<br>
If yes may be its because the memory map of your design did not fit with<br>
ML403 ones and that SystemaAce try to load kernel image in a non ram<br>
place.<br>
<br>
you may have to specify the code start address to the genace.tcl script<br>
to generate properly the ace file. (it should be something like<br>
start=5Faddress 0xYOURADDR in the opt file)<br>
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
&gt; &nbsp; I'm very new to System Ace, and this is probably a stupid quest=
ion.
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
&gt; with two elf's in it, one for linux, one for a memory read/write<br>
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
&gt; accomplishes? &nbsp;Or do we need to do a boot loader in code? &nbsp;If
we need<br>
&gt; to do a boot loader, how come the Monta Vista linux doesn't need one<b=
r>
&gt; on the ml403 board? &nbsp;I've been googling and scouring the Xilinx
site, <br>
&gt; but I've achieved nothing but a few less hairs on my head.<br>
&gt;<br>
&gt; &nbsp; I've already asked Monta Vista this question, and they quoted<b=
r>
&gt; verbatim the page from the xilinx manual, which is a generic answer
to <br>
&gt; the specific question. &nbsp;Even if the xilinx manual is the answer,
we<br>
&gt; aren't seeing the results the manual implies we will see.<br>
&gt;<br>
&gt; &nbsp; Can someone give me a clue?<br>
&gt;<br>
&gt; thanks,<br>
&gt; wade <br>
&gt;<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; Linuxppc-embedded mailing list<br>
&gt; </font><a href=3D"mailto:Linuxppc-embedded@ozlabs.org"><font size=3D3 =
color=3Dblue><u>Linuxppc-embedded@ozlabs.org</u></font></a><font size=3D3><=
br>
&gt; </font><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedde=
d"><font size=3D3 color=3Dblue><u>https://ozlabs.org/mailman/listinfo/linux=
ppc-embedded</u></font></a><font size=3D3><br>
</font>
<br><tt><font size=3D2>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</font></tt>
<br>
--=_alternative 003B1233C125726C_=--
