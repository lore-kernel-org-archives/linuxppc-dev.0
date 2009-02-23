Return-Path: <sylvain.joyeau@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 8E6EADDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 04:33:12 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so273836eyd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 09:33:10 -0800 (PST)
MIME-Version: 1.0
Sender: sylvain.joyeau@gmail.com
In-Reply-To: <d2b9ccd90902230904h148827fey293aebd2962c892a@mail.gmail.com>
References: <d2b9ccd90902222354o2e42db77h2f86fda45b5483b6@mail.gmail.com>
	<85a5c2010902230439n1096196dr519462513bc3910d@mail.gmail.com>
	<d2b9ccd90902230503i4c2535d5lbd05b7ddeddf3192@mail.gmail.com>
	<85a5c2010902230648m72b63eeds70b4e7a5ec4d8c51@mail.gmail.com>
	<d2b9ccd90902230904h148827fey293aebd2962c892a@mail.gmail.com>
Date: Mon, 23 Feb 2009 18:33:10 +0100
Message-ID: <d194b8ce0902230933w2b985134m55b4bf69e8ba20ae@mail.gmail.com>
Subject: Re: Problem with decrementer interrupt
From: "sjoyeau@wanadoo.fr" <sjoyeau@wanadoo.fr>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Content-Type: multipart/alternative; boundary=0015174c14167488b00463996510
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

--0015174c14167488b00463996510
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sumedh,

You may check the context in which your CPU in running the C code from
interrupt context (ie stack pointer (r1), kernel locks disabling
rescheduling etc..) and double check the IRQ originator (the decrementer) i=
s
acknowlegded somewhere your handler before enabling back interrupts, else
your handler gets fired.

--
sj

2009/2/23 sumedh tirodkar <sumedhtirodkar@gmail.com>

> Alright...I am trying to develop a system of my own..
> Consider that i am not using any linux kernel...I m writing some
> program right from scratch.........
> The major steps that i have taken are...
>
> 1. Started with a assembly file...
> 2. Have relocated the interrupt handlers to there respective
> positions...The interrupt handlers are written in assembly language...
> 3. Initialised Decrementer register to get an interrupt after some
> interval...
> 4. Jump to some function using
>
>    bl <function_name_main>
>
>    function_name_main which will have a infinite while loop..
> This works fine i.e. the interrupts(decrementer interrupt to be more
> specific) work fine...I have initialised serial port to get the
> output...
>
> Now, the problem that i am facing....
>
> If in interrupt handler of the decrementer, i make a call to some C
> function in some other C file...using the follwing statement...
>
> Dec_handler:  /* I have relocated this to interrupt vector address of
> decrementer interrupt*/
>     /*code to print using serial port*/
>     bla <function_name_handler> /*code to call some function in C file*/
>     /*code to print using serial port---but i m never able to see this
> output*/
>     RFI
>
> This starts creating a problem...somehow we dont return to this code
> after the end of the function_name_handler...
> Consider the following code for the function_name_handler:
> void function_name_handler(void)
> {
>   /*Some action*/
> }
>
> So, if its possible for anyone to help me with this...please reply...
>
> Regards,
> Sumedh
>
>
> On Mon, Feb 23, 2009 at 8:18 PM, Matt Gessner <mgessner@gmail.com> wrote:
> >
> >
> > On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar <
> sumedhtirodkar@gmail.com>
> > wrote:
> >>
> >> I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC...
> >
> > What I said earlier was: You need to tell people what cpu you're using,
> what
> > linux kernel, etc etc etc.
> >
> > Fine, we know the CPU.  What kernel are you using?  Is it ancient?
> >
> > I doubt the information below is going to be useful...
> >
> >>
> >> I am using
> >>
> >> bla <function_name>
> >>
> >> from the assembly code to call the function in C file...This i am
> >> doing from interrupt handler of the decrementer...
> >> If any more details are required, please let me know...
> >
> >
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
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

--0015174c14167488b00463996510
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sumedh,<br><br>You may check the context in which your CPU in running th=
e C code from interrupt context (ie stack pointer (r1), kernel locks disabl=
ing rescheduling etc..) and double check the IRQ originator (the decremente=
r) is acknowlegded somewhere your handler before enabling back interrupts, =
else your handler gets fired.<br>
<br>--<br>sj<br><br><div class=3D"gmail_quote">2009/2/23 sumedh tirodkar <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:sumedhtirodkar@gmail.com">sumedhtirod=
kar@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
Alright...I am trying to develop a system of my own..<br>
Consider that i am not using any linux kernel...I m writing some<br>
program right from scratch.........<br>
The major steps that i have taken are...<br>
<br>
1. Started with a assembly file...<br>
2. Have relocated the interrupt handlers to there respective<br>
positions...The interrupt handlers are written in assembly language...<br>
3. Initialised Decrementer register to get an interrupt after some interval=
...<br>
4. Jump to some function using<br>
<br>
 &nbsp; &nbsp;bl &lt;function_name_main&gt;<br>
<br>
 &nbsp; &nbsp;function_name_main which will have a infinite while loop..<br=
>
This works fine i.e. the interrupts(decrementer interrupt to be more<br>
specific) work fine...I have initialised serial port to get the<br>
output...<br>
<br>
Now, the problem that i am facing....<br>
<br>
If in interrupt handler of the decrementer, i make a call to some C<br>
function in some other C file...using the follwing statement...<br>
<br>
Dec_handler: &nbsp;/* I have relocated this to interrupt vector address of<=
br>
decrementer interrupt*/<br>
 &nbsp; &nbsp; /*code to print using serial port*/<br>
 &nbsp; &nbsp; bla &lt;function_name_handler&gt; /*code to call some functi=
on in C file*/<br>
 &nbsp; &nbsp; /*code to print using serial port---but i m never able to se=
e this output*/<br>
 &nbsp; &nbsp; RFI<br>
<br>
This starts creating a problem...somehow we dont return to this code<br>
after the end of the function_name_handler...<br>
Consider the following code for the function_name_handler:<br>
void function_name_handler(void)<br>
{<br>
 &nbsp; /*Some action*/<br>
}<br>
<br>
So, if its possible for anyone to help me with this...please reply...<br>
<br>
Regards,<br>
<font color=3D"#888888">Sumedh<br>
</font><div><div></div><div class=3D"Wj3C7c"><br>
<br>
On Mon, Feb 23, 2009 at 8:18 PM, Matt Gessner &lt;<a href=3D"mailto:mgessne=
r@gmail.com">mgessner@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Feb 23, 2009 at 8:03 AM, sumedh tirodkar &lt;<a href=3D"mailto=
:sumedhtirodkar@gmail.com">sumedhtirodkar@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; I am using PowerPC 7447A...I am trying to port SA-RTL on PowerPC..=
.<br>
&gt;<br>
&gt; What I said earlier was: You need to tell people what cpu you&#39;re u=
sing, what<br>
&gt; linux kernel, etc etc etc.<br>
&gt;<br>
&gt; Fine, we know the CPU. &nbsp;What kernel are you using? &nbsp;Is it an=
cient?<br>
&gt;<br>
&gt; I doubt the information below is going to be useful...<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; I am using<br>
&gt;&gt;<br>
&gt;&gt; bla &lt;function_name&gt;<br>
&gt;&gt;<br>
&gt;&gt; from the assembly code to call the function in C file...This i am<=
br>
&gt;&gt; doing from interrupt handler of the decrementer...<br>
&gt;&gt; If any more details are required, please let me know...<br>
&gt;<br>
&gt;<br>
</div></div><div><div></div><div class=3D"Wj3C7c">_________________________=
______________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>-----------=
-------<br>Sylvain JOYEAU<br>Freelance Engineer<br>Software RT-OS R&amp;D<b=
r><a href=3D"mailto:sylvain.joyeau@gmail.com">sylvain.joyeau@gmail.com</a><=
br>
T=E9l: +33-(0)667 477 052<br>&quot;A good idea is one side of the coin. The=
 other side is the practical usefulness&quot;. J. Liedke.<br>

--0015174c14167488b00463996510--
