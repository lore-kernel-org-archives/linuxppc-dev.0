Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4929C33CB3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F93124679
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F93124679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47z9T16RmdzDqcM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 04:01:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=146.101.78.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [146.101.78.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47z9Hf149MzDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 03:53:16 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-254-HXiAV1JzMM-gb_hFxrnbMA-1; Thu, 16 Jan 2020 16:52:01 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 16 Jan 2020 16:52:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Thu, 16 Jan 2020 16:52:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>
Subject: RE: z constraint in powerpc inline assembly ?
Thread-Topic: z constraint in powerpc inline assembly ?
Thread-Index: AQHVzDQOzi0mt2ZyZE2MkIeaLfMNoaftbd2ggAAL2ICAAAJWMA==
Date: Thu, 16 Jan 2020 16:52:00 +0000
Message-ID: <1ebd93a2d006400f998772ec0ae50dd3@AcuMS.aculab.com>
References: <d72263a1-fe17-3192-6930-35ec8394c699@c-s.fr>
 <e9af1690e51a4d89a8a5c0927eb8430a@AcuMS.aculab.com>
 <20200116162151.GR3191@gate.crashing.org>
In-Reply-To: <20200116162151.GR3191@gate.crashing.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: HXiAV1JzMM-gb_hFxrnbMA-1
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Segher Boessenkool
> Sent: 16 January 2020 16:22
...
> > However a loop of 'add with carry' instructions may not be the
> > fastest code by any means.
> > Because the carry flag is needed for every 'adc' you can't do more
> > that one adc per clock.
> > This limits you to 8 bytes/clock on a 64bit system - even one
> > that can schedule multiple memory reads and lots of instructions
> > every clock.
> >
> > I don't know ppc, but on x86 you don't even get 1 adc per clock
> > until very recent (Haswell I think) cpus.
> > Sandy/Ivy bridge will do so if you add to alternate registers.
>=20
> The carry bit is renamed just fine on all modern Power cpus.  On Power9
> there is an extra carry bit, precisely so you can do two interleaved
> chains.  And you can run lots of these insns at once, every cycle.

The limitation on old x86 was that each u-op could only have 2 inputs.
Since adc needs 3 it always took 2 clocks.
The first 'fix' still had an extra delay on the result register.

There is also a big problem of false dependencies against the flags.
PPC may not have this problem, but it makes it very difficult to
loop carry any of the flags.
Using 'dec' (which doesn't affect carry, but does set zero) is really slow.

Even though the latest x86 cpu have ADOX and ADCX (that use the
overflow and carry flags) and can run in parallel the LOOP 'dec jump
non-zero' instruction is microcoded and serialising!
I have got 12 bytes/clock without too much unrolling, but it is hard
work and probably not worth the effort.

...
> Christophe uses a very primitive 32-bit cpu, not even superscalar.  A
> loop doing adde is pretty much optimal, probably wants some unrolling
> though.

Or interleaving so it does read_a, [read_b, adc_a, read_a, adc_b]* adc_a.
That might be enough to get the loop 'for free' if there are memory stalls.

> Do normal 64-bit adds, and in parallel also accumulate the values shifted
> right by 32 bits.  You can add 4G of them this way, and restore the 96-bi=
t
> actual sum from these two accumulators, so that you can fold it to a prop=
er
> ones' complement sum after the loop.

That is probably too many instructions per word - unless you are using
simd ones.

> But you can easily beat 8B/clock using vectors, or doing multiple additio=
n
> chains (interleaved) in parallel.  Not that it helps, your limiting facto=
r
> is the memory bandwidth anyway, if anything in the memory pipeline stalls
> all your optimisations are for nothing.

Yep, if the data isn't in the L1 cache anything complex is a waste of time.

Unrolling too much just makes the top/bottom code take too long and
then it dominates for a lot of 'real world' buffers.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

