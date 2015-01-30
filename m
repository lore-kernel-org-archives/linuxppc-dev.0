Return-Path: <stockhausen@collogia.de>
Received: from mailrelay.collogia.de (mailrelay.collogia.de [194.8.207.98])
 by lists.ozlabs.org (Postfix) with SMTP id EC1A21A0DD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 20:39:49 +1100 (AEDT)
From: Markus Stockhausen <stockhausen@collogia.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: AW: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
Date: Fri, 30 Jan 2015 09:39:41 +0000
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735F916DA3@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 <1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
 <1422578995.10544.138.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>,
 <20150130084945.GA27784@visitor2.iram.es>
In-Reply-To: <20150130084945.GA27784@visitor2.iram.es>
Content-Type: multipart/mixed;
 boundary="----=_NextPartTM-000-32702551-5da8-40c7-b46f-45b86a6ad5c2"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

------=_NextPartTM-000-32702551-5da8-40c7-b46f-45b86a6ad5c2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Von: Gabriel Paubert [paubert@iram.es]=0A=
> Gesendet: Freitag, 30. Januar 2015 09:49=0A=
> An: Markus Stockhausen=0A=
> Cc: Scott Wood; linuxppc-dev@lists.ozlabs.org; Herbert Xu=0A=
> Betreff: Re: AW: SPE & Interrupt context (was how to make use of SPE inst=
ructions)=0A=
>=0A=
> > ...=0A=
> > - I must already save several non-volatile registers. Putting the 64 bi=
t values=0A=
> > into them would require me to save their contents with evstdd instead o=
f=0A=
> > stw. Of course stack alignment to 8 bytes required. So only a few align=
ment=0A=
> > instructions needed additionally during initialization.=0A=
> =0A=
> On most PPC ABI the stack is guaranteed to be aligned to a 16 byte=0A=
> boundary. In some it may be only 8, but I can't remember any 4 byte=0A=
> only alignment.=0A=
> =0A=
> I checked my 32 bit kernel images with:=0A=
> =0A=
> objdump -d vmlinux |awk '/stwu.*r1,/{print $6,$7}'|sort -u=0A=
> =0A=
> and the stack seems to always be 16 byte aligned.=0A=
> For 64 bit, use stdu instead of stwu.=0A=
> =0A=
> I've also found a few stwux/stdux which are hopefully known=0A=
> to be harmless.=0A=
>=0A=
> Gabriel=0A=
=0A=
A helpful annotation. But now I'm unsure about function usage. SPE seems to=
 be=0A=
32bit only and I would use their evxxx instructions. Do you think the follo=
wing=0A=
sequence will be the right way? =0A=
=0A=
_GLOBAL(ppc_spe_sha256_transform)=0A=
  stwu            r1,-128(r1);    /* create stack frame           */=0A=
  stw             r24,8(r1);      /* save normal registers        */=0A=
  stw             r25,12(r1);                                       =0A=
  evstdw          r14,16(r1);     /* We must save non volatile    */=0A=
  evstdw          r15,24(r1);    /* registers. Take the chance   */=0A=
  evstdw          r16,32(r12);    /* and save the SPE part too    */ \=0A=
  ...=0A=
  lwz             r24,8(r1);      /* restore normal registers     */ \=0A=
  lwz             r25,12(r1);=0A=
  evldw           r14,16(r12);     /* restore non-v. + SPE registers      *=
/=0A=
  evldw           r15,24(r12);=0A=
  evldw           r16,32(r12);=0A=
  addi            r1,r1,128;      /* cleanup stack frame          */=0A=
=0A=
Or must I use the kernel provided defines with PPC_STLU r1,-INT_FRAME_SIZE(=
r1) =0A=
plus SAVE_GPR/SAVE_EVR/REST_GPR/REST_EVR?=0A=
=0A=
Markus=
------=_NextPartTM-000-32702551-5da8-40c7-b46f-45b86a6ad5c2
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

------=_NextPartTM-000-32702551-5da8-40c7-b46f-45b86a6ad5c2--
