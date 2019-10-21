Return-Path: <SRS0=jKXk=YO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81FCA9EB5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 09:07:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7815B20873
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 09:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7815B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46xW3r6vHHzDqLG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Oct 2019 20:07:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46xW192v9HzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2019 20:04:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46xW183t1Dz8tT3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2019 20:04:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 46xW183PpLz9sPZ; Mon, 21 Oct 2019 20:04:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=146.101.78.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
X-Greylist: delayed 65 seconds by postgrey-1.36 at bilbo;
 Mon, 21 Oct 2019 20:04:43 AEDT
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [146.101.78.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46xW170Lfzz9sPV
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Oct 2019 20:04:42 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-171-uGtm_dBTNdCnS9293JavzQ-1; Mon, 21 Oct 2019 10:03:26 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 21 Oct 2019 10:03:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Mon, 21 Oct 2019 10:03:25 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thomas Gleixner' <tglx@linutronix.de>, Andreas Schwab
 <schwab@linux-m68k.org>
Subject: RE: passing NULL to clock_getres (VDSO): terminated by unexpected
 signal 11
Thread-Topic: passing NULL to clock_getres (VDSO): terminated by unexpected
 signal 11
Thread-Index: AQHVh4A5YsvPzgBKm0ejirKJi/sfpKdkzSyg
Date: Mon, 21 Oct 2019 09:03:25 +0000
Message-ID: <9530114b895a41d293c27af76cc47302@AcuMS.aculab.com>
References: <0fc22a08-31d9-e4d1-557e-bf5b482a9a20__6444.28012180782$1571503753$gmane$org@c-s.fr>
 <87v9skcznp.fsf@igel.home> <ed65e4c6-2fe0-2f5c-f667-5a81b19eb073@c-s.fr>
 <87tv83zqt1.fsf@hase.home> <b64c367b-d1e5-bf26-d452-145c0be6e30a@c-s.fr>
 <alpine.DEB.2.21.1910201243580.2090@nanos.tec.linutronix.de>
 <875zkjipra.fsf@igel.home>
 <alpine.DEB.2.21.1910201731070.2090@nanos.tec.linutronix.de>
 <87r237h01a.fsf@igel.home>
 <alpine.DEB.2.21.1910202145160.2090@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910202145160.2090@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: uGtm_dBTNdCnS9293JavzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Thomas Gleixner
> Sent: 20 October 2019 20:53
> On Sun, 20 Oct 2019, Andreas Schwab wrote:
> > On Okt 20 2019, Thomas Gleixner wrote:
> >
> > > POSIX does not mention anything about the validity of the pointer han=
ded to
> > > clock_getres().
> >
> > Sure it does: "If the argument res is not NULL, the resolution of the
> > specified clock shall be stored in the location pointed to by res.  If
> > res is NULL, the clock resolution is not returned.".
>=20
> Sigh, that makes a lot of sense - NOT.
>=20
> But for the sake of making a non-sensical specification happy we can add =
a
> NULL pointer check for this. The interesting question is what should be
> returned in this case. The kernel returns EFAULT which is probably not
> POSIX compliant either.

The application won't see errno =3D=3D EFAULT.
EFAULT gets converted to SIGSEGV (probably) in the return-to-user code path=
.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

