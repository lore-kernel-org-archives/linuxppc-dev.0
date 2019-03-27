Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD97C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 21:06:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DFE20700
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 21:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DFE20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44V0sh2lL7zDqMM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 08:06:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aculab.com
 (client-ip=207.82.80.151; helo=eu-smtp-delivery-151.mimecast.com;
 envelope-from=david.laight@aculab.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44V0qb6rbXzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 08:04:25 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-fRGz32CyM7-BOn_PAxkpUg-1; Wed, 27 Mar 2019 17:02:47 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 27 Mar 2019 17:03:52 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Wed, 27 Mar 2019 17:03:52 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>, Sergey Miroshnichenko
 <s.miroshnichenko@yadro.com>
Subject: RE: [PATCH RFC v4 09/21] PCI: Mark immovable BARs with PCI_FIXED
Thread-Topic: [PATCH RFC v4 09/21] PCI: Mark immovable BARs with PCI_FIXED
Thread-Index: AQHU5BKo6oZy4EJXskG+oHCz+gArvaYftIQQ
Date: Wed, 27 Mar 2019 17:03:52 +0000
Message-ID: <3e3e163cbf35446ea575bb7fae1912be@AcuMS.aculab.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-10-s.miroshnichenko@yadro.com>
 <20190326202838.GQ24180@google.com>
In-Reply-To: <20190326202838.GQ24180@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: fRGz32CyM7-BOn_PAxkpUg-1
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux@yadro.com" <linux@yadro.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Bjorn Helgaas
> Sent: 26 March 2019 20:29
>=20
> On Mon, Mar 11, 2019 at 04:31:10PM +0300, Sergey Miroshnichenko wrote:
> > If a PCIe device driver doesn't yet have support for movable BARs,
> > mark device's BARs with IORESOURCE_PCI_FIXED.
>=20
> I'm hesitant about using IORESOURCE_PCI_FIXED for this purpose.  That
> was originally added to describe resources that can not be changed
> because they're hardwired in the device, e.g., legacy resources and
> Enhanced Allocation resources.
>=20
> In general, I think the bits in res->flags should tell us things about
> the hardware.  This particular use would be something about the
> *driver*, and I think we should figure that out by looking at
> dev->driver.

There will also be drivers that don't support BARs being moved,
but may be in a state (ie not actually open) where they can go
through a remove-rescan sequence to allow the BAR be moved.

This might even be true if the open count is non-zero.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

