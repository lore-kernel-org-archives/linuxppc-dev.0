Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D6C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:40:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA3C2087C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 12:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA3C2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xHrC2HrXzF3hQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 23:40:11 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xHmY3DS8zF3mq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 23:36:59 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-110-sHBmeO1DNEmY3fg_B1RTqw-1; Fri, 16 Nov 2018 12:36:54 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 16 Nov 2018 12:37:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Fri, 16 Nov 2018 12:37:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexandru Gagniuc' <mr.nuke.me@gmail.com>, "helgaas@google.com"
 <helgaas@google.com>
Subject: RE: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk7lFmreXBXOEO6S+wDoXDgXaVSVjAw
Date: Fri, 16 Nov 2018 12:37:00 +0000
Message-ID: <ab363e80d45e4c3d91770c1b1010d1ce@AcuMS.aculab.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: sHBmeO1DNEmY3fg_B1RTqw-1
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
Cc: "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Shyam_Iyer@Dell.com" <Shyam_Iyer@Dell.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "lukas@wunner.de" <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "austin_bolen@dell.com" <austin_bolen@dell.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alexandru Gagniuc
> Sent: 15 November 2018 23:16
...
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER.

This is all very well, but we have systems (they might be Dell ones)
where failure of a PCIe link (even when all the drivers are removed)
causes an NMI - and crashes the kernel.

There are other systems which have AER registers available for
some of the PCIe devices, but the BIOS ignores them and _OSC
doesn't let the kernel take control.
In this case the AER registers can contain useful information
after a read returns ~0u.
It would be useful to be able to get this information without
having to grovel through all the PCIe config space.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

