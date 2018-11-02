Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E91C32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 14:29:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81CA2081F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 14:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81CA2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mkx74Kw9zF38H
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 01:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aculab.com
 (client-ip=207.82.80.151; helo=eu-smtp-delivery-151.mimecast.com;
 envelope-from=david.laight@aculab.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mkv63YtJzF377
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 01:28:00 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-28-3tnnkrJ8MnmBPBS98eu-lg-1;
 Fri, 02 Nov 2018 10:26:52 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 2 Nov 2018 10:26:57 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Fri, 2 Nov 2018 10:26:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <patch-notifications@ellerman.id.au>, Joel Stanley
 <joel@jms.id.au>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: powerpc/xmon: Relax frame size for clang
Thread-Topic: powerpc/xmon: Relax frame size for clang
Thread-Index: AQHUceIwsoXZkywSTUKDCmftdFvEuqU8SGKg
Date: Fri, 2 Nov 2018 10:26:57 +0000
Message-ID: <1d9525b6fc9b48c0971201ddb5f5dc12@AcuMS.aculab.com>
References: <20181031010934.3627-1-joel@jms.id.au> <42m4hs6PHXzB4XV@ozlabs.org>
In-Reply-To: <42m4hs6PHXzB4XV@ozlabs.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 3tnnkrJ8MnmBPBS98eu-lg-1
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Linuxppc-dev [mailto:linuxppc-dev-bounces+david.laight=3Daculab.com@l=
ists.ozlabs.org] On Behalf Of
> Michael Ellerman
> Subject: Re: powerpc/xmon: Relax frame size for clang
>=20
> On Wed, 2018-10-31 at 01:09:34 UTC, Joel Stanley wrote:
> > When building with clang (8 trunk, 7.0 release) the frame size limit is
> > hit:
> >
> >  arch/powerpc/xmon/xmon.c:452:12: warning: stack frame size of 2576
> >  bytes in function 'xmon_core' [-Wframe-larger-than=3D]
> >
> > Some investigation by Naveen indicates this is due to clang saving the
> > addresses to printf format strings on the stack.
> >
> > While this issue is investigated, bump up the frame size limit for xmon
> > when building with clang.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/252
> > Signed-off-by: Joel Stanley <joel@jms.id.au>

Would it be better to stop some of the functions being inlined?

Clearly clang shouldn't be using separate on-stack temporaries
for every printf() call.
That is indicative of a bigger problem.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

