Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85432C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46082084B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DE+OlkdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46082084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Y0Pb5F5GzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 04:55:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=synopsys.com
 (client-ip=198.182.47.9; helo=smtprelay.synopsys.com;
 envelope-from=vineet.gupta1@synopsys.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=synopsys.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="DE+OlkdH";
 dkim-atps=neutral
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com
 [198.182.47.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Y0M83cVLzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 04:53:37 +1100 (AEDT)
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com
 [10.192.0.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtprelay.synopsys.com (Postfix) with ESMTPS id A006A24E296F;
 Mon,  1 Apr 2019 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1554141214; bh=+6jPDjKFQ9sJW2gKGb9LUdktY1skiJXwXVZDLw2X0Jg=;
 h=From:To:CC:Subject:Date:References:From;
 b=DE+OlkdHKslsSbVtU2kSEJ0CQOEks0NDbyt9Dv8XCuWBfu1Y95HBwzvSRKK4o0rAj
 6CbRgjY2ZuOXpNINVDglDuq+6qKPqfhLh5D+Y5VjOibV2/dKgftBwrBnD35YqmQhAn
 rZlz3acIi8rk14rDbOF9SBJcayOosSDtF77O8hh6SKAjnWoJNBwEDyJ0pukGYKrm6D
 jGSfv//9amToUJ3PNU8nOS5xWNPnnEG9NE7mdJQJKSQYZ01h2hjBVzYX40uijID+Om
 jdFP0PIQSyPLg/L/MYOdEK6lD+OVYwRu1UtEk3Ps5t3oWGFAp9wu08rr0xR+kSyvgb
 MmUqL7HQ4yeoQ==
Received: from US01WEHTC3.internal.synopsys.com
 (us01wehtc3.internal.synopsys.com [10.15.84.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailhost.synopsys.com (Postfix) with ESMTPS id 81EF7A0069;
 Mon,  1 Apr 2019 17:53:20 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id
 14.03.0415.000; Mon, 1 Apr 2019 10:53:20 -0700
From: Vineet Gupta <vineet.gupta1@synopsys.com>
To: Andrey Abramov <st5pub@yandex.ru>, benh <benh@kernel.crashing.org>, paulus
 <paulus@samba.org>, mpe <mpe@ellerman.id.au>, tglx <tglx@linutronix.de>,
 mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa <hpa@zytor.com>, x86
 <x86@kernel.org>, mark <mark@fasheh.com>, jlbec <jlbec@evilplan.org>, richard
 <richard@nod.at>, dedekind1 <dedekind1@gmail.com>, adrian.hunter
 <adrian.hunter@intel.com>, gregkh <gregkh@linuxfoundation.org>, naveen.n.rao
 <naveen.n.rao@linux.vnet.ibm.com>, jpoimboe <jpoimboe@redhat.com>, "Dave
 Chinner" <dchinner@redhat.com>, darrick.wong <darrick.wong@oracle.com>,
 ard.biesheuvel <ard.biesheuvel@linaro.org>, George Spelvin <lkml@sdf.org>,
 linux-snps-arc <linux-snps-arc@lists.infradead.org>, "Linux Kernel Mailing
 List" <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, ocfs2-devel <ocfs2-devel@oss.oracle.com>,
 linux-mtd <linux-mtd@lists.infradead.org>, sfr <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 1/5] arch/arc: unwind.c: replace swap function with
 built-in one
Thread-Topic: [PATCH v2 1/5] arch/arc: unwind.c: replace swap function with
 built-in one
Thread-Index: AQHU6LPJnnREyZHcl02YdFJlzGBU3g==
Date: Mon, 1 Apr 2019 17:53:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643F9C4@US01WEMBX2.internal.synopsys.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>
 <23405591554057090@iva8-b333b7f98ab0.qloud-c.yandex.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: mhocko <mhocko@suse.com>, rppt <rppt@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/31/19 11:31 AM, Andrey Abramov wrote:=0A=
> Replace swap_eh_frame_hdr_table_entries with built-in one, because=0A=
> swap_eh_frame_hdr_table_entries does a simple byte to byte swap.=0A=
>=0A=
> Since Spectre mitigations have made indirect function calls more=0A=
> expensive, and the default simple byte copies swap is implemented=0A=
> without them, an "optimized" custom swap function is now=0A=
> a waste of time as well as code.=0A=
>=0A=
> Signed-off-by: Andrey Abramov <st5pub@yandex.ru>=0A=
> Reviewed by: George Spelvin <lkml@sdf.org>=0A=
>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
