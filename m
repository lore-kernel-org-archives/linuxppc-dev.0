Return-Path: <wmaxfield@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 30142DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Jan 2007 03:23:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so1879208ana
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 05 Jan 2007 08:23:32 -0800 (PST)
Message-ID: <45a1b53e0701050823y68db3059pcddfa784b39fed66@mail.gmail.com>
Date: Fri, 5 Jan 2007 10:23:31 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: christophe.alayrac@cresitt.com
Subject: Re: System Ace booting (or not) question
In-Reply-To: <1168017290.15530.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_30948_12927195.1168014211685"
References: <45a1b53e0701050720w3e8118aan2edb280ec61c7d5f@mail.gmail.com>
	<1168017290.15530.7.camel@localhost.localdomain>
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

------=_Part_30948_12927195.1168014211685
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Alayrac,

  Thank you for your reply.

  No, there is no bus error.

  The memory map of our design matches the ML403 as regards the DDR ram.  W=
e
are just trying to get the code into external DDR Ram.

  The code start address is specified in the elf file, and lists correctly
on the screen as the genace script executes.

  The code in zImage.elf is compiled to the DDR space, and so should load
there.   The genace script prints out the code will load there when it runs
and places
the .elf file into the system.  The system.ace file is 10 megabytes after
the zImage.elf code is put into it.  when doing only the internal block ram
load, the system.ace
file is only 2.8 megabytes in size.


thanks again,
wade




On 1/5/07, alayrac christophe <christophe.alayrac@cresitt.com> wrote:
>
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
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_30948_12927195.1168014211685
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Alayrac,<br><br>&nbsp; Thank you for your reply.<br><br>&nbsp; No, there=
 is no bus error.<br><br>&nbsp; The memory map of our design matches the ML=
403 as regards the DDR ram.&nbsp; We are just trying to get the code into e=
xternal DDR Ram.<br>
<br>&nbsp; The code start address is specified in the elf file, and lists c=
orrectly on the screen as the genace script executes.<br><br>&nbsp; The cod=
e in zImage.elf is compiled to the DDR space, and so should load there.&nbs=
p;&nbsp; The genace script prints out the code will load there when it runs=
 and places
<br>the .elf file into the system.&nbsp; The system.ace file is 10 megabyte=
s after the zImage.elf code is put into it.&nbsp; when doing only the inter=
nal block ram load, the system.ace<br>file is only 2.8 megabytes in size.<b=
r><br>
<br>thanks again,<br>wade<br><br><br><br><br><div><span class=3D"gmail_quot=
e">On 1/5/07, <b class=3D"gmail_sendername">alayrac christophe</b> &lt;<a h=
ref=3D"mailto:christophe.alayrac@cresitt.com">christophe.alayrac@cresitt.co=
m</a>
&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>High Wade,<br><br>Does systemace comes out with a bus error? (Red led on M=
L403 board)?
<br><br>If yes may be its because the memory map of your design did not fit=
 with<br>ML403 ones and that SystemaAce try to load kernel image in a non r=
am<br>place.<br><br>you may have to specify the code start address to the=
=20
genace.tcl script<br>to generate properly the ace file. (it should be somet=
hing like<br>start_address 0xYOURADDR in the opt file)<br><br>Have you trie=
d to download the kernel image through JTAG?<br><br>You can also try to com=
pile a standalone code in DDR space (not BRAM as
<br>describe in your email) an try to make an ace file with it.<br><br>rega=
rds<br><br>Chris<br><br>Le vendredi 05 janvier 2007 =E0 09:20 -0600, Wade M=
axfield a =E9crit :<br>&gt;<br>&gt;&nbsp;&nbsp; I&#39;m very new to System =
Ace, and this is probably a stupid question.
<br>&gt;<br>&gt;&nbsp;&nbsp; We were able, with the Monta Vista Linux to ge=
t a system.ace with a<br>&gt; zImage.elf linux file to boot on an ml403 boa=
rd.&nbsp;&nbsp;The system ace chip<br>&gt; seemed to copy the zImage.elf in=
to DDR ram, and the system booted.&nbsp;&nbsp;No
<br>&gt; block ram used.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;We created =
a board with an xf60 and a system ace chip on it and<br>&gt; created a syst=
em.ace file.&nbsp;&nbsp;The xilinx loads, but the zImage.elf does<br>&gt; n=
ot copy into ddr ram.&nbsp;&nbsp;We ran the testfatfs code and read from an=
d
<br>&gt; wrote to the compact flash on the system ace chip, verifying the f=
iles<br>&gt; through a compact flash adaptor on a pc.<br>&gt;<br>&gt;&nbsp;=
&nbsp;&nbsp;&nbsp;We created a memory test using the ppc and were able (aft=
er some<br>&gt; wiring changes and other headaches) to prove the ddr ram wo=
rks.&nbsp;&nbsp;There
<br>&gt; is enough of it to support linux (64 meg), and testing all 64 mill=
ion<br>&gt; locations with various fixed and incrementing patterns proves i=
t<br>&gt; works.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;However, we could n=
ot get the external ram to load up with the
<br>&gt; linux zImage.elf file. When this failed, we created a system.ace f=
ile<br>&gt; with two elf&#39;s in it, one for linux, one for a memory read/=
write<br>&gt; tester in block ram.<br>&gt;<br>&gt;&nbsp;&nbsp; It appears t=
he system ace chip loads the info into block ram just
<br>&gt; fine, and our memory test executes.&nbsp;&nbsp;However, our ddr ra=
m has nothing<br>&gt; in it.&nbsp;&nbsp;We reversed the order of the elf fi=
les, and that still did not<br>&gt; help.<br>&gt;<br>&gt;&nbsp;&nbsp; Do we=
 need a helper CPLD on this board to accomplish what the ML403
<br>&gt; accomplishes?&nbsp;&nbsp;Or do we need to do a boot loader in code=
?&nbsp;&nbsp;If we need<br>&gt; to do a boot loader, how come the Monta Vis=
ta linux doesn&#39;t need one<br>&gt; on the ml403 board?&nbsp;&nbsp;I&#39;=
ve been googling and scouring the Xilinx site,
<br>&gt; but I&#39;ve achieved nothing but a few less hairs on my head.<br>=
&gt;<br>&gt;&nbsp;&nbsp; I&#39;ve already asked Monta Vista this question, =
and they quoted<br>&gt; verbatim the page from the xilinx manual, which is =
a generic answer to
<br>&gt; the specific question.&nbsp;&nbsp;Even if the xilinx manual is the=
 answer, we<br>&gt; aren&#39;t seeing the results the manual implies we wil=
l see.<br>&gt;<br>&gt;&nbsp;&nbsp; Can someone give me a clue?<br>&gt;<br>&=
gt; thanks,<br>&gt; wade
<br>&gt;<br>&gt; _______________________________________________<br>&gt; Li=
nuxppc-embedded mailing list<br>&gt; <a href=3D"mailto:Linuxppc-embedded@oz=
labs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt; <a href=3D"https://ozlab=
s.org/mailman/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br></blockquo=
te></div><br>

------=_Part_30948_12927195.1168014211685--
