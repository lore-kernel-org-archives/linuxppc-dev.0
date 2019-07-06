Return-Path: <SRS0=RFqx=VD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B798C0650E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2019 11:49:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B95213F2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2019 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOTYigO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B95213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45gqkN1pwTzDqgX
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jul 2019 21:49:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45gqhc2Ty3zDqDd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2019 21:47:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6y676QYR/iHJJ649Hu4pguKBc+26wcukAE46ESMMlo=; b=dOTYigO14yG8pQxnEPFBC19DX
 /Ww8mAJLwcfe1SJqp/NylfCiIiI9REBU4NBiWe4dYMw9xdQP6lV0y+pUltL/gztWxW7BxkiF1kRXE
 w6XA7g9pa5LjIsiEu0S8st2kB2gzhI15q6uEUzs4XQgoqkyabISla1WvfKEt7LUVcsysRFNZryzy2
 Vt4rLjvEjd+OfhIGQpJR1++ZVceLUOM/+IRXvzm2znfchAZwwCauZYISTmjywQAOsgIR2YmU3+vzt
 0KvSoXLLqm4bOXutzWmOhE1jpX4jFMrPYVTRcXNwmtfs/ro27ahj9vrDH17GltUK57PchaGmotAd6
 Zh3YctvFg==;
Received: from 177.205.70.5.dynamic.adsl.gvt.net.br ([177.205.70.5]
 helo=coco.lan)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hjj9S-0002M7-Qh; Sat, 06 Jul 2019 11:46:47 +0000
Date: Sat, 6 Jul 2019 08:46:38 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 18/39] docs: admin-guide: add kdump documentation into it
Message-ID: <20190706084638.7dc875f2@coco.lan>
In-Reply-To: <20190705055904.GB2790@localhost.localdomain>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <654e7591c044632c06257e0f069a52c0bb993554.1561724493.git.mchehab+samsung@kernel.org>
 <6911b74c-848f-0060-3db5-b5d7e8061cb5@linux.alibaba.com>
 <20190705055904.GB2790@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
Cc: Rich Felker <dalias@libc.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jerry Hoemann <jerry.hoemann@hpe.com>, Harry Wei <harryxiyou@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>,
 linux-sh@vger.kernel.org, x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, 5 Jul 2019 13:59:04 +0800
Dave Young <dyoung@redhat.com> escreveu:

> On 07/05/19 at 11:43am, Alex Shi wrote:
> >=20
> >=20
> > =E5=9C=A8 2019/6/28 =E4=B8=8B=E5=8D=888:30, Mauro Carvalho Chehab =E5=
=86=99=E9=81=93: =20
> > > The Kdump documentation describes procedures with admins use
> > > in order to solve issues on their systems.
> > >=20
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  Documentation/admin-guide/bug-hunting.rst            | 4 ++--
> > >  Documentation/admin-guide/index.rst                  | 1 +
> > >  Documentation/{ =3D> admin-guide}/kdump/gdbmacros.txt  | 0
> > >  Documentation/{ =3D> admin-guide}/kdump/index.rst      | 1 -
> > >  Documentation/{ =3D> admin-guide}/kdump/kdump.rst      | 0
> > >  Documentation/{ =3D> admin-guide}/kdump/vmcoreinfo.rst | 0 =20
> >=20
> > I am not sure if it's convenience for people to have more levels in doc=
s.
> >=20
> > But I guess, move archs into a Documentation/arch/ dir should be fine. =
like Documentation/arch/{x86,arm,arm64,ia64,m68k,s390,powerpc,...} =20
>=20
> Alex, moving kdump to admin-guide sounds reasonable to me.  I also agree
> with you for those arch dependent files can be moved to
> Documentation/arch/, maybe you are talking about some other patches in
> the series for the arch/?=20

Alex,

It makes sense for me to have a Documentation/arch directory, and place
the arch-specific docs over there.

There's actually a technical advantage on doing that: Sphinx is dumb
with regards to PDF/LaTeX output: it requires all top documents to be
listed at Documentation/conf.py, under this var:

	latex_documents =3D [
		...
	]

As it creates one runtime Makefile at Documentation/output per listed
document there. So, the more we group such documents, the less merge
conflicts we'll have at Documentation/conf.py.

Btw, there's a [TECH TOPIC] proposal for KS/2019 meant to discuss=20
Documentation.

I suspect we could discuss the pros/cons of doing such change there.

My personal view is that we should keep the Documentation/ root dir as
clean as possible as a long term goal.

On the other hand, it makes the path bigger and harder to rename.

On a side note, last time we discussed documentation at KS I remember
I proposed to shortcut "Documentation/" to just "docs/". The consensus
on that time were to keep the big name. I still think that a shorter
one could help people to remind where documentation will be located.

Thanks,
Mauro
