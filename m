Return-Path: <SRS0=PW48=IB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC94C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 17:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFFF60202
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 17:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFFF60202
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrLqD6VGBz3cK8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:39:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256 header.s=iport header.b=Myxaj5ms;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cisco.com (client-ip=173.37.86.76; helo=rcdn-iport-5.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.a=rsa-sha256
 header.s=iport header.b=Myxaj5ms; dkim-atps=neutral
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrLpl6Wyhz30N6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 04:39:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1566; q=dns/txt; s=iport;
 t=1614793168; x=1616002768;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HwSDExt/4yEwWWICTamnjrNRGaKwzVnKFGtN23ZY2jQ=;
 b=Myxaj5msoR2SicX5d9au2P7oUe7SRq7TnrQjkGTcvsGjVck/UUkwh9NV
 DWrYlNjpcfoMOBZ68pzMDLgBA2L8+yAB/2u/xJ60GRsgyHG52RQytiSK9
 OoObaDFytTqN/rgdfM6PV5rGlHDUZQURLCGeSxi9mHENr76MIf5wORgta E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BKAwCgyD9g/5BdJa1iHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+CK3ZWATkxlh2PehaMOwsBAQENAQEkEAQBAYRNAoF6AiU?=
 =?us-ascii?q?4EwIDAQELAQEFAQEBAgEGBHGFYQ2GRQEFOj8QCxIGLjwNDgYTG4JWgwcPrUV?=
 =?us-ascii?q?0gTSEPwGEX4E+BiKBFo1DJhyBSUKEKz6KMwSCRoE7gnSQS4JLii2be4MGgR+?=
 =?us-ascii?q?IIJJSMRCDJ4pPlVCgEpZgAgQGBQIWgWsjgVczGggbFYMkHzEZDZcihWYgAy8?=
 =?us-ascii?q?4AgYKAQEDCYwTAQE?=
X-IronPort-AV: E=Sophos;i="5.81,220,1610409600"; d="scan'208";a="598970073"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
 by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 03 Mar 2021 17:39:14 +0000
Received: from zorba ([10.24.1.194])
 by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 123Hd88Y022034
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 3 Mar 2021 17:39:12 GMT
Date: Wed, 3 Mar 2021 09:39:08 -0800
From: Daniel Walker <danielwa@cisco.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/7] Improve boot command line handling
Message-ID: <20210303173908.GG109100@zorba>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <20210302173523.GE109100@zorba>
 <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ7U8QAbJe3zkZiFPJN4PveHz5TZoPk2S8qQWB6cm5e5Q@mail.gmail.com>
X-Outbound-SMTP-Client: 10.24.1.194, [10.24.1.194]
X-Outbound-Node: rcdn-core-8.cisco.com
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
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 devicetree@vger.kernel.org,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 02, 2021 at 08:01:01PM -0600, Rob Herring wrote:
> +Will D
> 
> On Tue, Mar 2, 2021 at 11:36 AM Daniel Walker <danielwa@cisco.com> wrote:
> >
> > On Tue, Mar 02, 2021 at 05:25:16PM +0000, Christophe Leroy wrote:
> > > The purpose of this series is to improve and enhance the
> > > handling of kernel boot arguments.
> > >
> > > It is first focussed on powerpc but also extends the capability
> > > for other arches.
> > >
> > > This is based on suggestion from Daniel Walker <danielwa@cisco.com>
> > >
> >
> >
> > I don't see a point in your changes at this time. My changes are much more
> > mature, and you changes don't really make improvements.
> 
> Not really a helpful comment. What we merge here will be from whomever
> is persistent and timely in their efforts. But please, work together
> on a common solution.
> 
> This one meets my requirements of moving the kconfig and code out of
> the arches, supports prepend/append, and is up to date.


Maintainers are capable of merging whatever they want to merge. However, I
wouldn't make hasty choices. The changes I've been submitting have been deployed
on millions of router instances and are more feature rich.

I believe I worked with you on this change, or something like it,

https://lkml.org/lkml/2019/3/19/970

I don't think Christophe has even addressed this. I've converted many
architectures, and Cisco uses my changes on at least 4 different
architecture. With products deployed and tested.

I will resubmit my changes as soon as I can.

Daniel
