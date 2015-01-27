Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id E09E51A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 16:09:36 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Scott Wood <scottwood@freescale.com>
Subject: SPE & Interrupt context (was how to make use of SPE instructions)
Date: Tue, 27 Jan 2015 05:09:29 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-fcd59052-7878-48be-bf03-9c9bbf9a8d4f"
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

------=_NextPartTM-000-fcd59052-7878-48be-bf03-9c9bbf9a8d4f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-01-20 at 14:53 +0000, Markus Stockhausen wrote:=0A=
> > Von: Scott Wood [scottwood@freescale.com]=0A=
> > Gesendet: Dienstag, 20. Januar 2015 08:38=0A=
> > An: Markus Stockhausen=0A=
> > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org=0A=
> > Betreff: Re: AW: How to make use of SPE instructions?=0A=
> > ...=0A=
> > With your advice I would place a enable/disable preemption call after=
=0A=
> > 1K of processed data. But wil that be sufficient if I only reeanble it=
=0A=
> > for a short timeframe like this:=0A=
> >=0A=
> >   do {=0A=
> >     disable_preemption()=0A=
> >     ... calc hashes for 1K of data with 16.000 CPU cycles (or 20us) ...=
=0A=
> >     enable_preemption()=0A=
> >   while (dataleft>0);=0A=
> =0A=
> Yes, it's sufficient.  When you enable preemption it will check to see=0A=
> whether there is a pending reschedule.=0A=
> =0A=
=0A=
Hi Scott,=0A=
=0A=
thanks for your helpful feedback. As you might have seen I sent a first=0A=
patch for the sha256 kernel module that takes care about preemption.=0A=
=0A=
Herbert Xu noticed that my module won't run in for IPsec as all=0A=
work will be done from interrupt context. Do you have a tip how I can=0A=
mitigate the check I implemented:=0A=
=0A=
static bool spe_usable(void)=0A=
{=0A=
  return !in_interrupt();=0A=
}=0A=
=0A=
Intel guys have something like that=0A=
=0A=
bool irq_fpu_usable(void)=0A=
{=0A=
  return !in_interrupt() ||=0A=
    interrupted_user_mode() ||=0A=
    interrupted_kernel_fpu_idle();=0A=
}=0A=
=0A=
But I have no idea how to transfer it to the PPC/SPE case.=0A=
=0A=
Thanks in advance.=0A=
=0A=
Markus=0A=
------=_NextPartTM-000-fcd59052-7878-48be-bf03-9c9bbf9a8d4f
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

------=_NextPartTM-000-fcd59052-7878-48be-bf03-9c9bbf9a8d4f--
