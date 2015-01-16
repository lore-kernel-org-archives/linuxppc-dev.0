Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id BF5FA1A0D98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 16:27:56 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Scott Wood <scottwood@freescale.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: AW: How to make use of SPE instructions?
Date: Fri, 16 Jan 2015 05:27:44 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F9132C6@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F90DD25@EXCHANGE.collogia.de>,
 <1421362570.4961.163.camel@freescale.com>
In-Reply-To: <1421362570.4961.163.camel@freescale.com>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-1af9feff-1472-4146-bb8f-2f250f6e8d60"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------=_NextPartTM-000-1af9feff-1472-4146-bb8f-2f250f6e8d60
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Scott Wood [scottwood@freescale.com]=0A=
> Gesendet: Donnerstag, 15. Januar 2015 23:56=0A=
> An: Markus Stockhausen=0A=
> Cc: linuxppc-dev@lists.ozlabs.org=0A=
> Betreff: Re: How to make use of SPE instructions?=0A=
> =0A=
> On Thu, 2015-01-08 at 09:58 +0000, Markus Stockhausen wrote:=0A=
> > Hello,=0A=
> >=0A=
> > I developed a SHA224/256 kernel crypto module with SPE instructions.=0A=
> > The result looks quite promising (~ +50% speedup). Nevertheless the=0A=
> > flooding of kernel messages "SPE used in kernel" makes me feel=0A=
> > uncomfortable.=0A=
> >=0A=
> > My findings so far:=0A=
> >=0A=
> > - I can configure the kernel with "SPE support".=0A=
> > - arch/powerpc/kernel/head_fsl_booke.S suggests that the message is=0A=
> >   triggerd unconditionally whenwever we make use of SPE in kernel.=0A=
> - There exists a function enable_kernel_spe() but I don't know how=0A=
>   this could help me in my work.=0A=
> >=0A=
> > I guess I need some kind of "brackets" around my coding to make sure=0A=
> > the upper 32 bit of the registers are stored correctly during task swit=
ch.=0A=
> > Or is the use of SPE instructions inside the kernel totally forbidden? =
Any=0A=
> > expert with some helpful advise?=0A=
> =0A=
> You need to disable preemption, call enable_kernel_spe(), and finish=0A=
> using SPE before you enable preemption.  This assumes that SPE is never=
=0A=
> used from interrupt context.  Be careful to not disable preemption for=0A=
> too long.=0A=
=0A=
Thanks for your feedback. That did the trick. I'm currently working on=0A=
a (low power) 800 MHz single core P1014 CPU. That should be the=0A=
cheapest and slowest hardware that is available with SPE. My target =0A=
is to use the module for calculating hash values of IPsec packets. So =0A=
we are talking about input data of up to ~1500 bytes. =0A=
=0A=
I did some tests with the tcrypt module and I get a hashing speed of=0A=
~ 46MByte/s for 2K data chunks. Stock module gives 29MByte/s. In =0A=
other words ~22,000 hashes per second. Overhead of the tcrypt data =0A=
feeder of around 10% included. That are worst case 46us per hash and =0A=
therefore 46us inside a non preemptive task.=0A=
=0A=
In beetween I spent some time to do the same for SHA-1. There=0A=
we have ~46,000 hashes per second or 21us per 2K data. That are=0A=
+13% compared to the already available PPC assembler module.=0A=
=0A=
Three questions are left:=0A=
=0A=
- Does the setup conflict with the mentioned interrupt context?=0A=
- Is that a reasonable time interval for disabling preemption?=0A=
- Should I send the patches to this or to the crypto list?=0A=
=0A=
Markus=0A=
------=_NextPartTM-000-1af9feff-1472-4146-bb8f-2f250f6e8d60
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

------=_NextPartTM-000-1af9feff-1472-4146-bb8f-2f250f6e8d60--
