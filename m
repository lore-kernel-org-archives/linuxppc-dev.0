Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id F1ACF1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:37:35 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Scott Wood <scottwood@freescale.com>
Subject: AW: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
Date: Fri, 30 Jan 2015 05:37:29 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 ,<1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>,
 <1422578995.10544.138.camel@freescale.com>
In-Reply-To: <1422578995.10544.138.camel@freescale.com>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-631fdeb7-e224-455d-a422-bd334526e405"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------=_NextPartTM-000-631fdeb7-e224-455d-a422-bd334526e405
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Scott Wood [scottwood@freescale.com]=0A=
> Gesendet: Freitag, 30. Januar 2015 01:49=0A=
> An: Markus Stockhausen=0A=
> Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org; Herbert Xu=0A=
> Betreff: Re: AW: SPE & Interrupt context (was how to make use of SPE inst=
ructions)=0A=
> =0A=
> On Wed, 2015-01-28 at 05:00 +0000, Markus Stockhausen wrote:=0A=
> > > > Von: Scott Wood [scottwood@freescale.com]=0A=
> > > > Gesendet: Mittwoch, 28. Januar 2015 05:21=0A=
> > > > An: Markus Stockhausen=0A=
> > > > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org; Herbert Xu=0A=
> > > > Betreff: Re: SPE & Interrupt context (was how to make use of SPE in=
structions)=0A=
> > > >=0A=
> > > > Hi Scott,=0A=
> > > >=0A=
> > > > thanks for your helpful feedback. As you might have seen I sent a f=
irst=0A=
> > > > patch for the sha256 kernel module that takes care about preemption=
.=0A=
> > > >=0A=
> > > > Herbert Xu noticed that my module won't run in for IPsec as all=0A=
> > > > work will be done from interrupt context. Do you have a tip how I c=
an=0A=
> > > > mitigate the check I implemented:=0A=
> > > >=0A=
> > > > static bool spe_usable(void)=0A=
> > > > {=0A=
> > > >   return !in_interrupt();=0A=
> > > > }=0A=
> > > >=0A=
> > > > Intel guys have something like that=0A=
> > > >=0A=
> > > > bool irq_fpu_usable(void)=0A=
> > > > {=0A=
> > > >   return !in_interrupt() ||=0A=
> > > >     interrupted_user_mode() ||=0A=
> > > >     interrupted_kernel_fpu_idle();=0A=
> > > > }=0A=
> > > >=0A=
> > > > But I have no idea how to transfer it to the PPC/SPE case.=0A=
> > >=0A=
> > > I'm not sure what sort of tip you're looking for, other than=0A=
> > > implementing it myself. :-)=0A=
> >=0A=
> > Hi Scott,=0A=
> >=0A=
> > maybe I did not explain it correctly. interrupted_kernel_fpu_idle()=0A=
> > is x86 specific. The same applies to interrupted_user_mode().=0A=
> > I'm just searching for a similar feature in the PPC/SPE world.=0A=
> =0A=
> There isn't one.=0A=
> =0A=
> > I can see that enable_kernel_spe() does something with the=0A=
> > MSR_SPE flag, but I have no idea  how to determine if I'm allowed=0A=
> > to enable SPE although I'm inside an interrupt context.=0A=
> =0A=
> As with x86, you'd want to check whether the kernel interrupted=0A=
> userspace.  I don't know what x86 is doing with TS, but on PPC you might=
=0A=
> check whether the interrupted thread had MSR_FP enabled.=0A=
> =0A=
> > I'm asking because from the previous posts I conclude that=0A=
> > running SPE instructions inside an interrupt might be critical.=0A=
> > Because of registers not being saved?=0A=
> =0A=
> Yes.  Currently callers of enable_kernel_spe() only need to disable=0A=
> preemption, not interrupts.=0A=
> =0A=
> > Or can I just save the register contents myself and interrupt=0A=
> > context is no longer a showstopper?=0A=
> =0A=
> If you only need a small number of registers that might be reasonable,=0A=
> but if you need a bunch then you don't want to save them when you don't=
=0A=
> have to.=0A=
> =0A=
> Another option is to change enable_kernel_spe() to require interrupts to=
=0A=
> be disabled.=0A=
=0A=
Phew, that is going deeper than I expected. =0A=
=0A=
I'm a newbie in the topic of interrupts and FPU/SPE registers. Nevertheless=
=0A=
enforcing enable_kernel_spe() to only be available outside of interrupt=0A=
context sounds too restrictive for me. Also checking for thread/CPU flags =
=0A=
of an interrupted process is nothing I can or want to implement. There=0A=
might be the risk that I'm starting something that will be too complex=0A=
for me.=0A=
=0A=
BUT! Given the fact that SPE registers are only extended GPRs and my=0A=
algorithm needs just 10 of them I can live with the following design.=0A=
=0A=
- I must already save several non-volatile registers. Putting the 64 bit va=
lues =0A=
into them would require me to save their contents with evstdd instead of =
=0A=
stw. Of course stack alignment to 8 bytes required. So only a few alignment=
=0A=
instructions needed additionally during initialization.=0A=
=0A=
- During function cleanup I will restore the registers the same way.=0A=
=0A=
- In case I interrupted myself, I might have saved sensitive data of anothe=
r =0A=
thread on my stack. So I will zero that area after I restored the registers=
.=0A=
That needs an additional 10 instructions. In contrast to ~2000 instructions=
=0A=
for one sha256 round that should be neglectable.=0A=
=0A=
This little overhead will save me lots of trouble at other locations:=0A=
=0A=
- I can avoid checking for an interrupt context.=0A=
=0A=
- I don't need a fallback to the generic implementation. =0A=
=0A=
Thinking about it more and more I think I performance will stay the same. =
=0A=
Can you confirm that this will work? If yes I will send a v2 patch.=0A=
=0A=
Markus=0A=
------=_NextPartTM-000-631fdeb7-e224-455d-a422-bd334526e405
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

****************************************************************************
Diese E-Mail enthält vertrauliche und/oder rechtlich geschützte
Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail
irrtümlich erhalten haben, informieren Sie bitte sofort den Absender und
vernichten Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte
Weitergabe dieser Mail ist nicht gestattet.

Über das Internet versandte E-Mails können unter fremden Namen erstellt oder
manipuliert werden. Deshalb ist diese als E-Mail verschickte Nachricht keine
rechtsverbindliche Willenserklärung.

Collogia
Unternehmensberatung AG
Ubierring 11
D-50678 Köln

Vorstand:
Kadir Akin
Dr. Michael Höhnerbach

Vorsitzender des Aufsichtsrates:
Hans Kristian Langva

Registergericht: Amtsgericht Köln
Registernummer: HRB 52 497

This e-mail may contain confidential and/or privileged information. If you
are not the intended recipient (or have received this e-mail in error)
please notify the sender immediately and destroy this e-mail. Any
unauthorized copying, disclosure or distribution of the material in this
e-mail is strictly forbidden.

e-mails sent over the internet may have been written under a wrong name or
been manipulated. That is why this message sent as an e-mail is not a
legally binding declaration of intention.

Collogia
Unternehmensberatung AG
Ubierring 11
D-50678 Köln

executive board:
Kadir Akin
Dr. Michael Höhnerbach

President of the supervisory board:
Hans Kristian Langva

Registry office: district court Cologne
Register number: HRB 52 497

****************************************************************************

------=_NextPartTM-000-631fdeb7-e224-455d-a422-bd334526e405--
