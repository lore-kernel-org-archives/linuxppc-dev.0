Return-Path: <SRS0=tA1z=TJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739CC04AB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 13:28:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E7621479
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E7621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450Dgy5krCzDqR5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 23:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450Ddp6vqLzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2019 23:26:54 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 110F2AC5C;
 Thu,  9 May 2019 13:26:51 +0000 (UTC)
Date: Thu, 9 May 2019 15:26:49 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build failure in v4.4.y.queue (ppc:allmodconfig)
Message-ID: <20190509152649.2e3ef94d@kitsune.suse.cz>
In-Reply-To: <e8aa590e-a02f-19de-96df-6728ded7aab3@roeck-us.net>
References: <20190508202642.GA28212@roeck-us.net>
 <20190509065324.GA3864@kroah.com> <20190509114923.696222cb@naga>
 <e8aa590e-a02f-19de-96df-6728ded7aab3@roeck-us.net>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 9 May 2019 06:07:31 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 5/9/19 2:49 AM, Michal Such=C3=A1nek wrote:
> > On Thu, 9 May 2019 08:53:24 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> >> On Wed, May 08, 2019 at 01:26:42PM -0700, Guenter Roeck wrote: =20
> >>> I see multiple instances of:
> >>>
> >>> arch/powerpc/kernel/exceptions-64s.S:839: Error:
> >>> 	attempt to move .org backwards
> >>>
> >>> in v4.4.y.queue (v4.4.179-143-gc4db218e9451).
> >>>
> >>> This is due to commit 9b2d4e06d7f1 ("powerpc/64s: Add support for a s=
tore
> >>> forwarding barrier at kernel entry/exit"), which is part of a large p=
atch
> >>> series and can not easily be reverted.
> >>>
> >>> Guess I'll stop doing ppc:allmodconfig builds in v4.4.y ? =20
> >>
> >> Michael, I thought this patch series was supposed to fix ppc issues, n=
ot
> >> add to them :)
> >>
> >> Any ideas on what to do here? =20
> >=20
> > What exact code do you build?
> > =20
> $ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-linux- allmodconfig
> $ powerpc64-linux-gcc --version
> powerpc64-linux-gcc (GCC) 8.3.0
>

Gcc should not see this file. I am asking because I do not see an .org
directive at line 839 of 4.4.179. I probably need some different repo
or extra patches to see the same code as you do.

Thanks

Michal
