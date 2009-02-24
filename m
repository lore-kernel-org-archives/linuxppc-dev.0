Return-Path: <sylvain.joyeau@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id E3751DDDA9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 18:54:16 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id k4so992353nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 23:54:14 -0800 (PST)
MIME-Version: 1.0
Sender: sylvain.joyeau@gmail.com
In-Reply-To: <d2b9ccd90902231002m41062108kb36c9ba4e7b70aa4@mail.gmail.com>
References: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
	<85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
	<d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
	<85a5c2010902230648m72b63eeds70b4e7a5ec4d8c51@mail.gmail.com>
	<d2b9ccd90902230904h148827fey293aebd2962c892a@mail.gmail.com>
	<d194b8ce0902230933w2b985134m55b4bf69e8ba20ae@mail.gmail.com>
	<d2b9ccd90902231002m41062108kb36c9ba4e7b70aa4@mail.gmail.com>
Date: Tue, 24 Feb 2009 08:54:14 +0100
Message-ID: <d194b8ce0902232354m513bb164m57800d4f31ca2e0a@mail.gmail.com>
Subject: Re: Problem with decrementer interrupt
From: "sjoyeau@wanadoo.fr" <sjoyeau@wanadoo.fr>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Content-Type: multipart/alternative; boundary=0015174c10a0e65a070463a56c9e
Cc: linuxppc-dev@ozlabs.org
Reply-To: sjoyeau@wanadoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015174c10a0e65a070463a56c9e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sumedh,

I've just noticed you are using the "bla" instruction, which use absolute
target address: are you sure the C code gets even be executed ?
I don't know how the compiler successfully assemble your code because the
binary is supposed to be position independant code (PIC): you should rather
use "bl" instruction (relative branch).

--
sj

2009/2/23 sumedh tirodkar <sumedhtirodkar@gmail.com>

>
> I have initialised to stack pointer(r1) properly...actually...i went
> thru the object dump...bt when i juz use
>
>  bla <function_name_handler>
>
> the link register is not getting pushed on to the stack in the prolog
> of that function...so the stack is basically not coming into the
> picture...
> @IRQ originator, that doesn't seem to be a problem...
>
> The only thing that i am able to think of is that when i do a "bla",
> the return address is not getting stored in link register...and i m
> not able to figure out why...
>
> Regards,
> Sumedh
>
> On Mon, Feb 23, 2009 at 11:03 PM, sjoyeau@wanadoo.fr <sjoyeau@wanadoo.fr>
> wrote:
> > Hi Sumedh,
> >
> > You may check the context in which your CPU in running the C code from
> > interrupt context (ie stack pointer (r1), kernel locks disabling
> > rescheduling etc..) and double check the IRQ originator (the decremente=
r)
> is
> > acknowlegded somewhere your handler before enabling back interrupts, el=
se
> > your handler gets fired.
> >
> > --
> > sj
> >
> > 2009/2/23 sumedh tirodkar <sumedhtirodkar@gmail.com>
> >>
> >> Alright...I am trying to develop a system of my own..
> >> Consider that i am not using any linux kernel...I m writing some
> >> program right from scratch.........
> >> The major steps that i have taken are...
> >>
> >> 1. Started with a assembly file...
> >> 2. Have relocated the interrupt handlers to there respective
> >> positions...The interrupt handlers are written in assembly language...
> >> 3. Initialised Decrementer register to get an interrupt after some
> >> interval...
> >> 4. Jump to some function using
> >>
> >>    bl <function_name_main>
> >>
> >>    function_name_main which will have a infinite while loop..
> >> This works fine i.e. the interrupts(decrementer interrupt to be more
> >> specific) work fine...I have initialised serial port to get the
> >> output...
> >>
> >> Now, the problem that i am facing....
> >>
> >> If in interrupt handler of the decrementer, i make a call to some C
> >> function in some other C file...using the follwing statement...
> >>
> >> Dec_handler:  /* I have relocated this to interrupt vector address of
> >> decrementer interrupt*/
> >>     /*code to print using serial port*/
> >>     bla <function_name_handler> /*code to call some function in C file=
*/
> >>     /*code to print using serial port---but i m never able to see this
> >> output*/
> >>     RFI
> >>
> >> This starts creating a problem...somehow we dont return to this code
> >> after the end of the function_name_handler...
> >> Consider the following code for the function_name_handler:
> >> void function_name_handler(void)
> >> {
> >>   /*Some action*/
> >> }
> >>
> >> So, if its possible for anyone to help me with this...please reply...
> >>
> >> Regards,
> >> Sumedh
> >>
> >>
> >> On Mon, Feb 23, 2009 at 8:18 PM, Matt Gessner <mgessner@gmail.com>
> wrote:
> >> >
> >> >
> >> > On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar
> >> > <sumedhtirodkar@gmail.com>
> >> > wrote:
> >> >>
> >> >> I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...
> >> >
> >> > What I said earlier was: You need to tell people what cpu you're
> using,
> >> > what
> >> > linux kernel, etc etc etc.
> >> >
> >> > Fine, we know the CPU.  What kernel are you using?  Is it ancient?
> >> >
> >> > I doubt the information below is going to be useful...
> >> >
> >> >>
> >> >> I am using
> >> >>
> >> >> bla <function_name>
> >> >>
> >> >> from the assembly code to call the function in C file...This i am
> >> >> doing from interrupt handler of the decrementer...
> >> >> If any more details are required, please let me know...
> >> >
> >> >
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> >
> > --
> > ------------------
> > Sylvain JOYEAU
> > Freelance Engineer
> > Software RT-OS R&D
> > sylvain.joyeau@gmail.com
> > T=E9l: +33-(0)667 477 052
> > "A good idea is one side of the coin. The other side is the practical
> > usefulness". J. Liedke.
> >
>
>
>


--=20
------------------
Sylvain JOYEAU
Freelance Engineer
Software RT-OS R&D
sylvain.joyeau@gmail.com
T=E9l: +33-(0)667 477 052
"A good idea is one side of the coin. The other side is the practical
usefulness". J. Liedke.

--0015174c10a0e65a070463a56c9e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Sumedh,<br><br>I&#39;ve just noticed you are using the &quot;bla&quot; inst=
ruction, which use absolute target address: are you sure the C code gets ev=
en be executed ?<br>I don&#39;t know how the compiler successfully assemble=
 your code because the binary is supposed to be position independant code (=
PIC): you should rather use &quot;bl&quot; instruction (relative branch).<b=
r>
<br>--<br>sj<br><br><div class=3D"gmail_quote">2009/2/23 sumedh tirodkar <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:sumedhtirodkar@gmail.com">sumedhtirod=
kar@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<br>
I have initialised to stack pointer(r1) properly...actually...i went<br>
thru the object dump...bt when i juz use<br>
<br>
 =A0bla &lt;function_name_handler&gt;<br>
<br>
the link register is not getting pushed on to the stack in the prolog<br>
of that function...so the stack is basically not coming into the<br>
picture...<br>
@IRQ originator, that doesn&#39;t seem to be a problem...<br>
<br>
The only thing that i am able to think of is that when i do a &quot;bla&quo=
t;,<br>
the return address is not getting stored in link register...and i m<br>
not able to figure out why...<br>
<br>
Regards,<br>
<font color=3D"#888888">Sumedh<br>
</font><div><div></div><div class=3D"Wj3C7c"><br>
On Mon, Feb 23, 2009 at 11:03 PM, <a href=3D"mailto:sjoyeau@wanadoo.fr">sjo=
yeau@wanadoo.fr</a> &lt;<a href=3D"mailto:sjoyeau@wanadoo.fr">sjoyeau@wanad=
oo.fr</a>&gt; wrote:<br>
&gt; Hi Sumedh,<br>
&gt;<br>
&gt; You may check the context in which your CPU in running the C code from=
<br>
&gt; interrupt context (ie stack pointer (r1), kernel locks disabling<br>
&gt; rescheduling etc..) and double check the IRQ originator (the decrement=
er) is<br>
&gt; acknowlegded somewhere your handler before enabling back interrupts, e=
lse<br>
&gt; your handler gets fired.<br>
&gt;<br>
&gt; --<br>
&gt; sj<br>
&gt;<br>
&gt; 2009/2/23 sumedh tirodkar &lt;<a href=3D"mailto:sumedhtirodkar@gmail.c=
om">sumedhtirodkar@gmail.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Alright...I am trying to develop a system of my own..<br>
&gt;&gt; Consider that i am not using any linux kernel...I m writing some<b=
r>
&gt;&gt; program right from scratch.........<br>
&gt;&gt; The major steps that i have taken are...<br>
&gt;&gt;<br>
&gt;&gt; 1. Started with a assembly file...<br>
&gt;&gt; 2. Have relocated the interrupt handlers to there respective<br>
&gt;&gt; positions...The interrupt handlers are written in assembly languag=
e...<br>
&gt;&gt; 3. Initialised Decrementer register to get an interrupt after some=
<br>
&gt;&gt; interval...<br>
&gt;&gt; 4. Jump to some function using<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0bl &lt;function_name_main&gt;<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0function_name_main which will have a infinite while loop..<=
br>
&gt;&gt; This works fine i.e. the interrupts(decrementer interrupt to be mo=
re<br>
&gt;&gt; specific) work fine...I have initialised serial port to get the<br=
>
&gt;&gt; output...<br>
&gt;&gt;<br>
&gt;&gt; Now, the problem that i am facing....<br>
&gt;&gt;<br>
&gt;&gt; If in interrupt handler of the decrementer, i make a call to some =
C<br>
&gt;&gt; function in some other C file...using the follwing statement...<br=
>
&gt;&gt;<br>
&gt;&gt; Dec_handler: =A0/* I have relocated this to interrupt vector addre=
ss of<br>
&gt;&gt; decrementer interrupt*/<br>
&gt;&gt; =A0 =A0 /*code to print using serial port*/<br>
&gt;&gt; =A0 =A0 bla &lt;function_name_handler&gt; /*code to call some func=
tion in C file*/<br>
&gt;&gt; =A0 =A0 /*code to print using serial port---but i m never able to =
see this<br>
&gt;&gt; output*/<br>
&gt;&gt; =A0 =A0 RFI<br>
&gt;&gt;<br>
&gt;&gt; This starts creating a problem...somehow we dont return to this co=
de<br>
&gt;&gt; after the end of the function_name_handler...<br>
&gt;&gt; Consider the following code for the function_name_handler:<br>
&gt;&gt; void function_name_handler(void)<br>
&gt;&gt; {<br>
&gt;&gt; =A0 /*Some action*/<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; So, if its possible for anyone to help me with this...please reply=
...<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Sumedh<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Feb 23, 2009 at 8:18 PM, Matt Gessner &lt;<a href=3D"mailt=
o:mgessner@gmail.com">mgessner@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar<br>
&gt;&gt; &gt; &lt;<a href=3D"mailto:sumedhtirodkar@gmail.com">sumedhtirodka=
r@gmail.com</a>&gt;<br>
&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I am using PowerPC 7447A...I am trying to port SA-RTL on =
PowerPC...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; What I said earlier was: You need to tell people what cpu you=
&#39;re using,<br>
&gt;&gt; &gt; what<br>
&gt;&gt; &gt; linux kernel, etc etc etc.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Fine, we know the CPU. =A0What kernel are you using? =A0Is it=
 ancient?<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I doubt the information below is going to be useful...<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; I am using<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; bla &lt;function_name&gt;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; from the assembly code to call the function in C file...T=
his i am<br>
&gt;&gt; &gt;&gt; doing from interrupt handler of the decrementer...<br>
&gt;&gt; &gt;&gt; If any more details are required, please let me know...<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Linuxppc-dev mailing list<br>
&gt;&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org=
</a><br>
&gt;&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" targe=
t=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; ------------------<br>
&gt; Sylvain JOYEAU<br>
&gt; Freelance Engineer<br>
&gt; Software RT-OS R&amp;D<br>
&gt; <a href=3D"mailto:sylvain.joyeau@gmail.com">sylvain.joyeau@gmail.com</=
a><br>
&gt; T=E9l: +33-(0)667 477 052<br>
&gt; &quot;A good idea is one side of the coin. The other side is the pract=
ical<br>
&gt; usefulness&quot;. J. Liedke.<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>-----------=
-------<br>Sylvain JOYEAU<br>Freelance Engineer<br>Software RT-OS R&amp;D<b=
r><a href=3D"mailto:sylvain.joyeau@gmail.com">sylvain.joyeau@gmail.com</a><=
br>
T=E9l: +33-(0)667 477 052<br>&quot;A good idea is one side of the coin. The=
 other side is the practical usefulness&quot;. J. Liedke.<br>

--0015174c10a0e65a070463a56c9e--
