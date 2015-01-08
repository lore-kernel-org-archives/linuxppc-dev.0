Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id 125FC1A0F74
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 21:03:57 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: How to make use of SPE instructions?
Date: Thu, 8 Jan 2015 09:58:45 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F90DD25@EXCHANGE.collogia.de>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-d799b1ca-45bb-4cd0-9eeb-d3cb1dde1d61"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------=_NextPartTM-000-d799b1ca-45bb-4cd0-9eeb-d3cb1dde1d61
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,=0A=
=0A=
I developed a SHA224/256 kernel crypto module with SPE instructions.=0A=
The result looks quite promising (~ +50% speedup). Nevertheless the=0A=
flooding of kernel messages "SPE used in kernel" makes me feel =0A=
uncomfortable.=0A=
=0A=
My findings so far:=0A=
=0A=
- I can configure the kernel with "SPE support". =0A=
- arch/powerpc/kernel/head_fsl_booke.S suggests that the message is=0A=
  triggerd unconditionally whenwever we make use of SPE in kernel.=0A=
- There exists a function enable_kernel_spe() but I don't know how=0A=
  this could help me in my work.=0A=
=0A=
I guess I need some kind of "brackets" around my coding to make sure =0A=
the upper 32 bit of the registers are stored correctly during task switch. =
=0A=
Or is the use of SPE instructions inside the kernel totally forbidden? Any =
=0A=
expert with some helpful advise?=0A=
=0A=
Thanks in advance.=0A=
=0A=
Markus=0A=
------=_NextPartTM-000-d799b1ca-45bb-4cd0-9eeb-d3cb1dde1d61
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

------=_NextPartTM-000-d799b1ca-45bb-4cd0-9eeb-d3cb1dde1d61--
