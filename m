Return-Path: <jonandia@aotek.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id A6D4C689C0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 21:02:57 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id ED4D21332
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Feb 2006 10:44:24 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: Floating point math in kernel interrupt -- am I doing
	thisright?(repost)
Date: Tue, 7 Feb 2006 10:44:22 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F387464F@correo.fagorautomation.net>
From: "Josu Onandia" <jonandia@aotek.es>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

In the RTAI scheduler there are routines (save_fpenv, restore_fpenv) =
that are very similar to your functions. I'd suggest to look in more =
detail if there are any subtle difference.

I think also that Sylvain can be right about the stack, so it could be a =
good idea to place saved_fpr in static storage, not in the stack.

My 2 cents

Josu

-----Mensaje original-----
De: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org]En nombre de Joyeau Sylvain
Enviado el: martes, 07 de febrero de 2006 8:20
Para: Jeremy Friesner
CC: linuxppc-embedded@ozlabs.org
Asunto: RE: Floating point math in kernel interrupt -- am I doing
thisright?(repost)


Jeremy,

What about kernel stack overflow ?
You mention that the occurrence of the crash is proportional to the =
amount of embraced code, which generally use more stack space too... but =
you aren't very accurate about the call context of your DoMix() =
function: it can be called depth enough to tickle the interrupted thread =
control block and issue indirect spurious behavior is userland.
Hope this help.

--
sj

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Jeremy =
Friesner
> Sent: lundi 6 f=E9vrier 2006 17:55
> To: Dan Malek
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Floating point math in kernel interrupt -- am I doing =
this right?(repost)
>=20
> >
> > On Feb 5, 2006, at 9:29 PM, Jeremy Friesner wrote:
> >
> > > ....   and the mixing is done inside an
> > > interrupt routine that runs 6000 times per second, and calculates =
8
> > > samples
> > > per interrupt.
> >
> > Bad news.  No Floating Point allowed in the kernel.
>=20
> I'm aware of that rule, and also why -- because the Linux kernel =
doesn't want to have to save and restore the state of the
> floating point registers on every context switch.  I'm also aware that =
it is nonetheless possible to use floating point in
> the kernel if you are careful to manually save and restore the proper =
state yourself, and that in fact floating point is
> sometimes used in the kernel as a means of doing 64-bit writes, as =
mentioned here:
>=20
> http://www.tldp.org/LDP/cpg/html/x295.html
>=20
> So it seems to me that it is possible to do floating point in the =
kernel, if you are careful to save and restore the proper
> context/state before and afterwards.  But if it isn't, can you explain =
to me why it can't be made to work?
>=20
> > > In order to do the necessary floating point math, without =
corrupting
> > > the state
> > > of any other processes that might be using the FPU, the interrupt
> > > routine
> > > first saves the state of the FPU registers to the stack, then does =
the
> > > math,
> > > then restores FPU registers again, before returning.
> >
> > Not on 82xx.  All floating point is done in hardware.
>=20
> Right; it is the hardware registers' state that I am saving to the =
stack, and then restoring afterwards.
>=20
> > > So my question is, is there some minor detail that my
> > > FPU-state-save/restore
> > > code is missing, that would cause these sort of symptoms?
> >
> > Just get all of this out of the kernel.  If you used the standard =
ALSA
> > drivers and framework, lots of mixing features are available to you.
> > If you need some custom mixing, just write a plug-in to do it.
> > Your data rates are so low they don't justify making any hacks
> > like this.
>=20
> I suppose that is an option, but I'd rather understand why my hack =
isn't working before I give up and redesign my
> application, which is already working the way I want it to, 99.9999% =
of the time.
>=20
> Jeremy
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
