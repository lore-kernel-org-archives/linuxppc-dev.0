Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FCCA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A77F21D71
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 08:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A77F21D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zygB6sj1zDqgp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 19:57:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zyZl1hVlzDqgn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 19:53:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46zyZk5p2cz8syF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 19:53:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 46zyZk3KXYz9sPk; Fri, 25 Oct 2019 19:53:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=146.101.78.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ACULAB.COM
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [146.101.78.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46zyZj127Qz9sP4
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Oct 2019 19:53:46 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-hYgq86BhMk6iXIyMzCRhrA-1; Fri, 25 Oct 2019 09:53:38 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 25 Oct 2019 09:53:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Fri, 25 Oct 2019 09:53:38 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: RE: [PATCH] powerpc/tools: Don't quote $objdump in scripts
Thread-Topic: [PATCH] powerpc/tools: Don't quote $objdump in scripts
Thread-Index: AQHVipx7TtzJo0qWL0+BNkH0FwwAH6drDA5A
Date: Fri, 25 Oct 2019 08:53:37 +0000
Message-ID: <f4e5bea10c914c9386da946f46606492@AcuMS.aculab.com>
References: <20191024004730.32135-1-mpe@ellerman.id.au>
 <20191024172857.GS28442@gate.crashing.org>
In-Reply-To: <20191024172857.GS28442@gate.crashing.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: hYgq86BhMk6iXIyMzCRhrA-1
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
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Segher Boessenkool
> Sent: 24 October 2019 18:29
> On Thu, Oct 24, 2019 at 11:47:30AM +1100, Michael Ellerman wrote:
> > Some of our scripts are passed $objdump and then call it as
> > "$objdump". This doesn't work if it contains spaces because we're
> > using ccache, for example you get errors such as:
> >
> >   ./arch/powerpc/tools/relocs_check.sh: line 48: ccache ppc64le-objdump=
: No such file or directory
> >   ./arch/powerpc/tools/unrel_branch_check.sh: line 26: ccache ppc64le-o=
bjdump: No such file or directory
> >
> > Fix it by not quoting the string when we expand it, allowing the shell
> > to do the right thing for us.
>=20
> This breaks things for people with spaces in their paths.  Why doesn't yo=
ur
> user use something like  alias objdump=3D"ccache ppc64le-objdump"  , inst=
ead?

Given that make doesn't handle spaces in filenames it is likely that a buil=
d
will have terrible issues is there are spaces in any directory names.
(It is a right PITA running make on a certain OS.)
For command paths, spaces can be replaced by ? relying on shell globbing
to restore the space.

OTOH rather than alias, put the name of a script containing:
    #! /bin/sh
    exec ccache ppc64le-objdump "$@"
into $objdump.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

