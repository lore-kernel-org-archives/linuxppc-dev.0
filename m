Return-Path: <hunter.cobbs@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id DD2B1DE074
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 22:44:27 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1293402qwe.15
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 05:44:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A17E7FD.1070905@mindspring.com>
References: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
	<4A17E7FD.1070905@mindspring.com>
Date: Sat, 23 May 2009 07:44:26 -0500
Message-ID: <ad84a70a0905230544m42bc2ce1o8c3d9a240f83fcc8@mail.gmail.com>
Subject: Re: PPC405EX based irq flooding with USB-OTG and usbserial device
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016364272b5c0d057046a93bc2b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016364272b5c0d057046a93bc2b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Egads!  Forgot to respond to the list!

My git checkout failed last night, so I'm downloading the resource cd, but I
can tell you what I did before I get the actual patch done, and you can tell
me if my logic is sound.

First thing I thought when I saw this is WHY use IRQ based methods to access
a USB controller with internal DMA transfers?  I tried in vain to enable
this with the driver module parameters(which I dug up how to specify module
parameters to built-in drivers from an old 2.2-series kernel discussion).
So, then I put on my boots and started slogging throught the driver.

Getting frustrated with that line of execution, I turned up the verbosity on
the kernel compile and noticed a warning in the dwc_otg compilation.
Specifically that a left and right shift go out of bounds of the variables
used.  The only place this occurs is in a section of code that is wrapped
with DMA_64BIT.  Which made absolutely no sense because the DMA controller
on the 405EX is only 32 bits wide.  On tracking this define down, I come to
find out that someone made the assumption that the 44x and the 405EX/r all
have the same DMA controller.  Which is incorrect, they both have the same
control register definitions(the offset of 1 due to the MSBit being reserved
and the register being in Big Endian mode); however, the 44x is 64bits and
the 405 is 32bits.  So, I broke the DMA control down into two areas,
data-width and control register offsets.

When this still didn't fix the problem, I found yet another section that can
force you to operate in slave(irq) mode only wrapped in yet another define.
When I search out that define (DWC_SLAVE I believe), I find it in the
dwc_otg Makefile.

Correcting both of these has enabled full DMA access to the USB, and I'm
doing much better with my sierra wireless dev kit.

On Sat, May 23, 2009 at 7:11 AM, Chuck Meade <chuckmeade@mindspring.com>wrote:

> Hunter Cobbs wrote:
> > Hello everyone,
> >
> > This is my first post to the PPC dev list as my company has just started
> > developing a new project based on Linux.  The good news is, this post is
> > not debug-related as much as it is an introduction and query while I
> > download the latest DENX kernel(only place I know that has the DWC_OTG
> > driver).
> >
> > I've been working with a Kilauea dev board and have had lots of trouble
> > when I plug in a sierra-wireless modem dev kit on the USB.  It goes fine
> > untill I actually try to communicate(pppd or minicom) with the little
> > bugger and then my IRQs go through the roof.  And they only calm back
> > down after I shut down my communicaiton channel.
> >
> > I've solved this issue with our board, and was wondering if it has since
> > been fixed (I'm running 2.6.25-DENX).  I don't want to waste the board's
> > time with a patch that is no longer necesarry.
> >
> > --
> > Hunter Cobbs
>
> Hello Hunter,
>
> It would absolutely *not* be a waste of anyone's time.  I for one would
> like
> to see how you solved this.  I am dealing with the same problem, with the
> same
> setup.
>
> The underlying cause for this problem is the PPC405EX CPU's erratum USBO_9.
> The USB 2.0 PING protocol is supposed to handle a PING transaction in
> the hardware -- note that in USB 2.0, a PING is the method used by the
> sender to
> determine if it can send.  If I remember correctly, erratum USBO_9 is
> caused when
> a NAK response from the PING transaction is handled not in hardware, but
> instead
> as an interrupt in software, and that NAK leads to a lot of processing.  In
> the
> 2.6.25 Denx Linux tree that I used, that processing ends up trying to
> restart the
> channel, restart the send, which leads to yet another PING/NAK sequence,
> yet another
> interrupt...
>
> The end result is that you get over 100,000 interrupts (with significant
> interrupt
> handling logic) per second, and the target can't do anything else.  I was
> able
> to get this interrupt count by looking at /proc/interrupts, then causing
> this problem
> for 20 seconds, then pulling out the USB modem physically (mine is on a
> Express card)
> to stop the interrupt storm, then checking /proc/interrupts again.
>  Averaged over
> 100,000 ints/sec.
>
> In contact with AMCC, they told us they are not respinning the CPU (at
> least not
> at this time) to fix this erratum.
>
> I have tried to solve the problem as suggested by the erratum, by not
> allowing the
> NAK interrupt handling to *directly* cause a retry of the send, but rather
> to wait
> until the next SOF interrupt (start of microframe, which happens 8,000
> times per sec)
> to restart it.  "Breaking the chain" like this does allow the board to
> proceed, but
> I think it is suboptimal, or at least unfortunate.
>
> One painful side effect of this workaround is that you cannot disable the
> 8,000 SOF
> interrupts/second, or at least some of them, since they are being used now
> for another
> purpose -- recovery from the erratum.
>
> The 8000 SOF ints being handled per second do cause a measurable drain on
> the
> CPU.  In some cursory testing we see a 10% slowdown of certain transactions
> in
> lmbench.
>
> So please send me your patch for the dwc_otg driver.  I am very interested
> in what
> you did, and if it perhaps is a better solution for the problem we both are
> seeing
> than what I implemented.
>
> Thanks in advance,
> Chuck
>
>


-- 
Hunter Cobbs

--0016364272b5c0d057046a93bc2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Egads!=A0 Forgot to respond to the list!<br><br>My git checkout failed last=
 night, so I&#39;m downloading the resource cd,
but I can tell you what I did before I get the actual patch done, and
you can tell me if my logic is sound.<br><br>First thing I thought when
I saw this is WHY use IRQ based methods to access a USB controller with
internal DMA transfers?=A0 I tried in vain to enable this with the driver
module parameters(which I dug up how to specify module parameters to
built-in drivers from an old 2.2-series kernel discussion).=A0 So, then I
put on my boots and started slogging throught the driver.<br>
<br>Getting frustrated with that line of execution, I turned up the
verbosity on the kernel compile and noticed a warning in the dwc_otg
compilation.=A0 Specifically that a left and right shift go out of bounds
of the variables used.=A0 The only place this occurs is in a section of
code that is wrapped with DMA_64BIT.=A0 Which made absolutely no sense
because the DMA controller on the 405EX is only 32 bits wide.=A0 On
tracking this define down, I come to find out that someone made the
assumption that the 44x and the 405EX/r all have the same DMA
controller.=A0 Which is incorrect, they both have the same control
register definitions(the offset of 1 due to the MSBit being reserved
and the register being in Big Endian mode); however, the 44x is 64bits
and the 405 is 32bits.=A0 So, I broke the DMA control down into two
areas, data-width and control register offsets.<br>
<br>When this still didn&#39;t fix the problem, I found yet another section
that can force you to operate in slave(irq) mode only wrapped in yet
another define.=A0 When I search out that define (DWC_SLAVE I believe), I
find it in the dwc_otg Makefile.<br>
<br>Correcting both of these has enabled full DMA access to the USB, and I&=
#39;m doing much better with my sierra wireless dev kit.<br><br><div class=
=3D"gmail_quote">On Sat, May 23, 2009 at 7:11 AM, Chuck Meade <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chuckmeade@mindspring.com">chuckmeade@mindspring=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Hunter Cobbs wrote:<br>
&gt; Hello everyone,<br>
&gt;<br>
&gt; This is my first post to the PPC dev list as my company has just start=
ed<br>
&gt; developing a new project based on Linux. =A0The good news is, this pos=
t is<br>
&gt; not debug-related as much as it is an introduction and query while I<b=
r>
&gt; download the latest DENX kernel(only place I know that has the DWC_OTG=
<br>
&gt; driver).<br>
&gt;<br>
&gt; I&#39;ve been working with a Kilauea dev board and have had lots of tr=
ouble<br>
&gt; when I plug in a sierra-wireless modem dev kit on the USB. =A0It goes =
fine<br>
&gt; untill I actually try to communicate(pppd or minicom) with the little<=
br>
&gt; bugger and then my IRQs go through the roof. =A0And they only calm bac=
k<br>
&gt; down after I shut down my communicaiton channel.<br>
&gt;<br>
&gt; I&#39;ve solved this issue with our board, and was wondering if it has=
 since<br>
&gt; been fixed (I&#39;m running 2.6.25-DENX). =A0I don&#39;t want to waste=
 the board&#39;s<br>
&gt; time with a patch that is no longer necesarry.<br>
&gt;<br>
&gt; --<br>
&gt; Hunter Cobbs<br>
<br>
</div></div>Hello Hunter,<br>
<br>
It would absolutely *not* be a waste of anyone&#39;s time. =A0I for one wou=
ld like<br>
to see how you solved this. =A0I am dealing with the same problem, with the=
 same<br>
setup.<br>
<br>
The underlying cause for this problem is the PPC405EX CPU&#39;s erratum USB=
O_9.<br>
The USB 2.0 PING protocol is supposed to handle a PING transaction in<br>
the hardware -- note that in USB 2.0, a PING is the method used by the send=
er to<br>
determine if it can send. =A0If I remember correctly, erratum USBO_9 is cau=
sed when<br>
a NAK response from the PING transaction is handled not in hardware, but in=
stead<br>
as an interrupt in software, and that NAK leads to a lot of processing. =A0=
In the<br>
2.6.25 Denx Linux tree that I used, that processing ends up trying to resta=
rt the<br>
channel, restart the send, which leads to yet another PING/NAK sequence, ye=
t another<br>
interrupt...<br>
<br>
The end result is that you get over 100,000 interrupts (with significant in=
terrupt<br>
handling logic) per second, and the target can&#39;t do anything else. =A0I=
 was able<br>
to get this interrupt count by looking at /proc/interrupts, then causing th=
is problem<br>
for 20 seconds, then pulling out the USB modem physically (mine is on a Exp=
ress card)<br>
to stop the interrupt storm, then checking /proc/interrupts again. =A0Avera=
ged over<br>
100,000 ints/sec.<br>
<br>
In contact with AMCC, they told us they are not respinning the CPU (at leas=
t not<br>
at this time) to fix this erratum.<br>
<br>
I have tried to solve the problem as suggested by the erratum, by not allow=
ing the<br>
NAK interrupt handling to *directly* cause a retry of the send, but rather =
to wait<br>
until the next SOF interrupt (start of microframe, which happens 8,000 time=
s per sec)<br>
to restart it. =A0&quot;Breaking the chain&quot; like this does allow the b=
oard to proceed, but<br>
I think it is suboptimal, or at least unfortunate.<br>
<br>
One painful side effect of this workaround is that you cannot disable the 8=
,000 SOF<br>
interrupts/second, or at least some of them, since they are being used now =
for another<br>
purpose -- recovery from the erratum.<br>
<br>
The 8000 SOF ints being handled per second do cause a measurable drain on t=
he<br>
CPU. =A0In some cursory testing we see a 10% slowdown of certain transactio=
ns in<br>
lmbench.<br>
<br>
So please send me your patch for the dwc_otg driver. =A0I am very intereste=
d in what<br>
you did, and if it perhaps is a better solution for the problem we both are=
 seeing<br>
than what I implemented.<br>
<br>
Thanks in advance,<br>
<font color=3D"#888888">Chuck<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Hunter Cobbs<br>

--0016364272b5c0d057046a93bc2b--
