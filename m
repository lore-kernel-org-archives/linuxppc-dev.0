Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3510BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:06:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5EA7218D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="Teg+wvZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EA7218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448Sth4LP9zDqHx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 19:06:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=d-silva.org
 (client-ip=167.160.173.127; helo=ushosting.nmnhosting.com;
 envelope-from=alastair@d-silva.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=d-silva.org
Authentication-Results: lists.ozlabs.org; dkim=pass (4096-bit key;
 unprotected) header.d=d-silva.org header.i=@d-silva.org header.b="Teg+wvZ9"; 
 dkim-atps=neutral
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com
 [167.160.173.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 448Srm5pZwzDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 19:04:40 +1100 (AEDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
 by ushosting.nmnhosting.com (Postfix) with ESMTPS id DDEF32F20623;
 Wed, 27 Feb 2019 03:04:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
 s=201810a; t=1551254679;
 bh=5nxfGKmy+SJcDA8+PxCHqY/BGj+VxsQw1eIjlqX5nJk=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
 b=Teg+wvZ94Z6oVvJ4t/lHT7QMinz9Lkno20coct/anGPoPeWwoOJYS+r6ejCxNS1j2
 Y7mS8TCtaAyNuR4abrKyBS3LzxaGeYO2L6paPLxrT1uKuNRff5cp9RsIvotKKT0oWk
 FXfrWjNLgXqna4mr/jKLWoeShxwe5fWitDc/EdujX276QiqQjmlhKF0ePjp0ZinHCh
 jriOTn5CvEkKzdh32wPg8RNKgK6EydRtrEiEmQ7BZ/65rxlKKCDMc44WpKCIcN867J
 Isv6wD9CtcbUUq47kW7KZQdyDJvlhTGYsO1fPpsb7TjlPhViKvx3OuLrVfvwL/FtM+
 oxaHFLt7a0OA+ojVSvNzK5RJwZKLZUaxtc28OsGsqadFaZH+gHSiSW1+n9aNH5E9P8
 7geqqwyq8HspTkGjogHxr3kHgHGO6Y05KapjTbcVX49QMKmybNqAIg/Ce6ypkl5Hs1
 g/9hM6PsrVEEkC78ErkG6iEazCH9rvnnT+2wp+8R+xIGJm5GDo6JEZAGEX7FYfJIlq
 KWs48w77Hoo0nCQIeNLB+oKL291xPyLT7PpzHbKFUFOMtILl2gG3rJm6Siig+5XIgp
 2mDYQX4IilHYznZblqEsIlpRrWg10r8LLfNUH9RXXZ6gbyoepXiOd8qDKIZ3Ml8wbM
 Y4pRBwtJNxrVRFGXQDqSZJn4=
Received: from Hawking (ntp.lan [10.0.1.1]) (authenticated bits=0)
 by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x1R84X59085499
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 27 Feb 2019 19:04:33 +1100 (AEDT)
 (envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Andrew Donnellan'" <andrew.donnellan@au1.ibm.com>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
 <20190227045741.21412-2-alastair@au1.ibm.com>
 <8c0300fc-4319-bd66-a47e-4ffda6ac795c@au1.ibm.com>
 <156e01d4ce6e$ee42d9f0$cac88dd0$@d-silva.org>
 <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
In-Reply-To: <a36b088b-b8d7-8725-50db-6aad58672784@au1.ibm.com>
Subject: RE: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
Date: Wed, 27 Feb 2019 19:04:31 +1100
Message-ID: <158101d4ce73$11ff4550$35fdcff0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHHd7z5h6oO3uW69oxVqiBFDB4gBAHhAfo8A1gpEmwCDmo8kwH9d6PwpcPNgSA=
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2
 (mail2.nmnhosting.com [10.0.1.20]); Wed, 27 Feb 2019 19:04:33 +1100 (AEDT)
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
> Sent: Wednesday, 27 February 2019 6:55 PM
> To: Alastair D'Silva <alastair@d-silva.org>; 'Alastair D'Silva'
> <alastair@au1.ibm.com>
> Cc: 'Greg Kurz' <groug@kaod.org>; 'Frederic Barrat'
> <fbarrat@linux.ibm.com>; 'Arnd Bergmann' <arnd@arndb.de>; 'Greg Kroah-
> Hartman' <gregkh@linuxfoundation.org>; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
>=20
> On 27/2/19 6:34 pm, Alastair D'Silva wrote:>>> diff --git
> a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c index
> >>> e6a607488f8a..16eb8a60d5c7 100644
> >>> --- a/drivers/misc/ocxl/file.c
> >>> +++ b/drivers/misc/ocxl/file.c
> >>> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct
> >>> ocxl_context *ctx,
> >>>
> >>>    		if (status =3D=3D ATTACHED) {
> >>>    			int rc;
> >>> -			struct link *link =3D ctx->afu->fn->link;
> >>> +			void *link =3D ctx->afu->fn->link;
> >>
> >> This doesn't look like a rename...
> >
> > That corrects the type to what the member (and prototype for
> ocxl_link_update_pe) declare it as.
> >
> > The struct link there is bogus, it shouldn't even compile (since the =
intended
> struct link is defined in a different compilation unit), but instead =
picks up a
> different definition of 'struct link' from elsewhere.
> >
>=20
> Given there's only a handful of struct links defined across the entire =
kernel,
> I'm going to guess that the definition it's picking up is in fact the =
ocxl one.
>=20

Unlikely, since that's never in a header. It wasn't caught since it was =
assigned to/from a void*.

> I think the better solution here is to move struct ocxl_link into
> ocxl_internal.h, change ocxl_fn::link to be struct ocxl_link * rather =
than void
> *, and update the function signature for ocxl_link_update_pe() as =
well.
=20
Not move it, but we could have an opaque declaration there.

--=20
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece

