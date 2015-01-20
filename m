Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id 9A9C41A0C92
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 01:53:37 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Scott Wood <scottwood@freescale.com>
Subject: How long am I allowed to disable preemption? (was How to make use
 of SPE instructions?)
Date: Tue, 20 Jan 2015 14:53:30 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F913EE6@EXCHANGE.collogia.de>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-3fb24a4f-86bb-45d4-a74f-918f4742218e"
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

------=_NextPartTM-000-3fb24a4f-86bb-45d4-a74f-918f4742218e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Scott Wood [scottwood@freescale.com]=0A=
> Gesendet: Dienstag, 20. Januar 2015 08:38=0A=
> An: Markus Stockhausen=0A=
> Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org=0A=
> Betreff: Re: AW: How to make use of SPE instructions?=0A=
> ...=0A=
> > I did some tests with the tcrypt module and I get a hashing speed of=0A=
> > ~ 46MByte/s for 2K data chunks. Stock module gives 29MByte/s. In=0A=
> > other words ~22,000 hashes per second. Overhead of the tcrypt data=0A=
> > feeder of around 10% included. That are worst case 46us per hash and=0A=
> > therefore 46us inside a non preemptive task.=0A=
> ...=0A=
> It's OK if the worst case is really 46 us, but if you can find a way to=
=0A=
> break it up a bit without affecting throughput too much, I'd do so.=0A=
=0A=
Hi Scott (and all),=0A=
=0A=
with your answer I'm a bit confused about disabling preemption inside the =
=0A=
kernel right now. I understand that the interval between preempt_disable()=
=0A=
and preempt_enable() should not take too long. But when I look at other=0A=
kernel hash crypto modules I see that nobody really cares about that. Take=
=0A=
sha256_ssse3_update() in sha256_ssse3_glue.c for example. It runs=0A=
=0A=
  kernel_fpu_begin();=0A=
  res =3D __sha256_ssse3_update(desc, data, len, partial);=0A=
  kernel_fpu_end();=0A=
=0A=
The kernel_fpu_xxx() enables/disables preemption like I need to do. =0A=
Nevertheless parameter len can be any number of bytes. Just take =0A=
reasonable parameters of 256K of input data, a 3GHz core and 13 =0A=
cycles/byte of SHA256 throughput. That will be a 1ms timeframe.=0A=
=0A=
Can I rely on that implementation, or do I have to take special care =0A=
because I'm only programming for a single core CPU? =0A=
=0A=
With your advice I would place a enable/disable preemption call after =0A=
1K of processed data. But wil that be sufficient if I only reeanble it=0A=
for a short timeframe like this:=0A=
=0A=
  do {=0A=
    disable_preemption()=0A=
    ... calc hashes for 1K of data with 16.000 CPU cycles (or 20us) ...=0A=
    enable_preemption()=0A=
  while (dataleft>0);=0A=
=0A=
Markus=0A=
=0A=
------=_NextPartTM-000-3fb24a4f-86bb-45d4-a74f-918f4742218e
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

------=_NextPartTM-000-3fb24a4f-86bb-45d4-a74f-918f4742218e--
