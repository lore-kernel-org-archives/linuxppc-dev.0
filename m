Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C99C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 03:53:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7F620674
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 03:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7F620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YsdB5wSmzDqR1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 14:53:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YsbJ2cbRzDqPy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 14:52:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44YsbJ0MJpz8tD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 14:52:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44YsbH6Wkbz9sSP; Wed,  3 Apr 2019 14:52:11 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
X-Greylist: delayed 797 seconds by postgrey-1.36 at bilbo;
 Wed, 03 Apr 2019 14:52:11 AEDT
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44YsbH107bz9sPC
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 14:52:10 +1100 (AEDT)
Received: from MTA-07-1.privateemail.com (unknown [10.20.147.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 7C4C760093;
 Wed,  3 Apr 2019 03:38:50 +0000 (UTC)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 60FDF60050;
 Tue,  2 Apr 2019 23:38:50 -0400 (EDT)
Received: from APP-07 (unknown [10.20.147.157])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id 406A16004F;
 Wed,  3 Apr 2019 03:38:50 +0000 (UTC)
Date: Tue, 2 Apr 2019 23:38:50 -0400 (EDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Message-ID: <184679822.6025.1554262730223@privateemail.com>
In-Reply-To: <14aa7671-fc0b-1cbc-da19-004299b304a2@c-s.fr>
References: <20190329042153.25698-1-cmr@informatik.wtf>
 <14aa7671-fc0b-1cbc-da19-004299b304a2@c-s.fr>
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
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
Reply-To: Christopher M Riedl <cmr@informatik.wtf>
Cc: andonnel@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> On March 29, 2019 at 3:41 AM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>=20
>=20
>=20
>=20
> Le 29/03/2019 =C3=A0 05:21, cmr a =C3=A9crit=C2=A0:
> > Operations which write to memory should be restricted on secure systems
> > and optionally to avoid self-destructive behaviors.
> >=20
> > Add a config option, XMON_RO, to control default xmon behavior along
> > with kernel cmdline options xmon=3Dro and xmon=3Drw for explicit contro=
l.
> > The default is to enable read-only mode.
> >=20
> > The following xmon operations are affected:
> > memops:
> > =09disable memmove
> > =09disable memset
> > memex:
> > =09no-op'd mwrite
> > super_regs:
> > =09no-op'd write_spr
> > bpt_cmds:
> > =09disable
> > proc_call:
> > =09disable
> >=20
> > Signed-off-by: cmr <cmr@informatik.wtf>
>=20
> A Fully qualified name should be used.

What do you mean by fully-qualified here? PPC_XMON_RO? (PPC_)XMON_READONLY?

>=20
> > ---
> >   arch/powerpc/Kconfig.debug |  7 +++++++
> >   arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> >=20
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index 4e00cb0a5464..33cc01adf4cb 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
> >   =09  to say Y here, unless you're building for a memory-constrained
> >   =09  system.
> >  =20
> > +config XMON_RO
> > +=09bool "Set xmon read-only mode"
> > +=09depends on XMON
> > +=09default y
>=20
> Should it really be always default y ?
> I would set default 'y' only when some security options are also set.
>=20

This is a good point, I based this on an internal Slack suggestion but givi=
ng this more thought, disabling read-only mode by default makes more sense.=
 I'm not sure what security options could be set though?
