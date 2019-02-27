Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85458C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 07:42:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51D721852
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 07:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="WJPJTNyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51D721852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448SM71b74zDqPG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 18:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=d-silva.org
 (client-ip=167.160.173.127; helo=ushosting.nmnhosting.com;
 envelope-from=alastair@d-silva.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: lists.ozlabs.org; dkim=pass (4096-bit key;
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.b="WJPJTNyb"; 
 dkim-atps=neutral
X-Greylist: delayed 347 seconds by postgrey-1.36 at bilbo;
 Wed, 27 Feb 2019 18:40:52 AEDT
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com
 [167.160.173.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 448SKJ2fWszDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 18:40:52 +1100 (AEDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
 by ushosting.nmnhosting.com (Postfix) with ESMTPS id 8E07F2F20623;
 Wed, 27 Feb 2019 02:35:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
 s=201810a; t=1551252901;
 bh=xa+h4X+54kh9XEOJk4sDO8SsZmCrhjEVj8J/32pTkFA=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
 b=WJPJTNybOC/N+0RsXNc7I1lUz53ZEA0+NZnnSp4U7g9eu+K6uWrCTaoTVus02k441
 UAxO1QyPq5fWCiEX1R7cGQMJ7H/jl+BN0abSp0J9Pm42oi8mlnXFSJM4MQc7fZYqD7
 WKkW2mCgP4WSrB9wXx9VDMFQRd/LQFK9Yxb4HIM7VVKkJlgYDyjERbI05CGge46lF+
 nr/NN3/i9zqZJZ0KQMQTcROaFyho6IYHfUK/AGCZtrY633+X+ccyP11l/3nuDv08Ga
 qjIpUKmFAa36LIqqB+VXgHZQ3oVYzxw4B2TbprLDSMJWq7JKUMmCs0mWPtW5qQOr3Z
 V4k5gb7Z4uXjvSItNKFoj2bWSq1uvCatIK+xf1gKhA76Ii0hrE1d0IpWZ+XNoYvydO
 BLTHD0zPADVAgqq4biqwdxSnJohqmo7Ep1badldGyOzkwwGCvtvxM9wqHXh8Fmh4+R
 m65PP/uQbVrAmXNq/OLIUK3NCp3mZmBqrVYl5DOyNuMLA9V3vFN4j+4GlZNmBocvzq
 ba8oUxlrM1z5Uv3ZEsN9rZRmk/UCrmN2+kN55I0WJzSwXb6vKnyEh0IPYqhO06tFra
 WUMz4rYktiUXQOwoh9nuSkeRDFKB0IgiLNY42zWqWIxugmOEadkojoz0b++FGnAfka
 yXhmJ0DqbaV4RGNBxUfRqWg0=
Received: from Hawking (ntp.lan [10.0.1.1]) (authenticated bits=0)
 by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x1R7Ysec085383
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 27 Feb 2019 18:34:54 +1100 (AEDT)
 (envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Andrew Donnellan'" <andrew.donnellan@au1.ibm.com>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
In-Reply-To: <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
Subject: RE: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
Date: Wed, 27 Feb 2019 18:34:53 +1100
Message-ID: <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHHd7z5h6oO3uW69oxVqiBFDB4gBAHhAfo8A1gpEmyl5CQc4A==
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2
 (mail2.nmnhosting.com [10.0.1.20]); Wed, 27 Feb 2019 18:34:55 +1100 (AEDT)
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
Cc: 'Arnd Bergmann' <arnd@arndb.de>,
 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
 'Greg Kurz' <groug@kaod.org>, linux-kernel@vger.kernel.org,
 'Frederic Barrat' <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> -----Original Message-----
> From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Sent: Wednesday, 27 February 2019 6:16 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>; alastair@d-silva.org
> Cc: Greg Kurz <groug@kaod.org>; Frederic Barrat =
<fbarrat@linux.ibm.com>;
> Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
>=20
> On 27/2/19 3:57 pm, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > The term 'link' is ambiguous (especially when the struct is used for =
a
> > list), so rename it for clarity.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >   drivers/misc/ocxl/file.c |  2 +-
> >   drivers/misc/ocxl/link.c | 36 ++++++++++++++++++------------------
> >   2 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c =
index
> > e6a607488f8a..16eb8a60d5c7 100644
> > --- a/drivers/misc/ocxl/file.c
> > +++ b/drivers/misc/ocxl/file.c
> > @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
> > ocxl_context *ctx,
> >
> >   		if (status =3D=3D ATTACHED) {
> >   			int rc;
> > -			struct link *link =3D ctx->afu->fn->link;
> > +			void *link =3D ctx->afu->fn->link;
>=20
> This doesn't look like a rename...

That corrects the type to what the member (and prototype for =
ocxl_link_update_pe) declare it as.

The struct link there is bogus, it shouldn't even compile (since the =
intended struct link is defined in a different compilation unit), but =
instead picks up a different definition of 'struct link' from elsewhere.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece

