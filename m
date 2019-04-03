Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB904C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:17:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094E42084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094E42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z67H6b0CzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:17:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z65Y2FBtzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:15:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Z65X4cvSz8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:15:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Z65X3vjLz9sSP; Thu,  4 Apr 2019 00:15:44 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Z65X0BRYz9sPp
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2019 00:15:43 +1100 (AEDT)
Received: from MTA-09.privateemail.com (unknown [10.20.147.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id B7C34603B7;
 Wed,  3 Apr 2019 13:15:41 +0000 (UTC)
Received: from MTA-09.privateemail.com (localhost [127.0.0.1])
 by MTA-09.privateemail.com (Postfix) with ESMTP id 9347D60047;
 Wed,  3 Apr 2019 09:15:41 -0400 (EDT)
Received: from APP-04 (unknown [10.20.147.154])
 by MTA-09.privateemail.com (Postfix) with ESMTPA id 799C66003F;
 Wed,  3 Apr 2019 13:15:41 +0000 (UTC)
Date: Wed, 3 Apr 2019 09:15:41 -0400 (EDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Message-ID: <1310218751.18777.1554297341318@privateemail.com>
In-Reply-To: <ee41455c-0ef8-2b5b-2f61-16bcf5f45d3f@c-s.fr>
References: <20190329042153.25698-1-cmr@informatik.wtf>
 <14aa7671-fc0b-1cbc-da19-004299b304a2@c-s.fr>
 <184679822.6025.1554262730223@privateemail.com>
 <ee41455c-0ef8-2b5b-2f61-16bcf5f45d3f@c-s.fr>
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
Cc: andonnel@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> On April 3, 2019 at 12:15 AM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>=20
>=20
>=20
>=20
> Le 03/04/2019 =C3=A0 05:38, Christopher M Riedl a =C3=A9crit=C2=A0:
> >> On March 29, 2019 at 3:41 AM Christophe Leroy <christophe.leroy@c-s.fr=
> wrote:
> >>
> >>
> >>
> >>
> >> Le 29/03/2019 =C3=A0 05:21, cmr a =C3=A9crit=C2=A0:
> >>> Operations which write to memory should be restricted on secure syste=
ms
> >>> and optionally to avoid self-destructive behaviors.
> >>>
> >>> Add a config option, XMON_RO, to control default xmon behavior along
> >>> with kernel cmdline options xmon=3Dro and xmon=3Drw for explicit cont=
rol.
> >>> The default is to enable read-only mode.
> >>>
> >>> The following xmon operations are affected:
> >>> memops:
> >>> =09disable memmove
> >>> =09disable memset
> >>> memex:
> >>> =09no-op'd mwrite
> >>> super_regs:
> >>> =09no-op'd write_spr
> >>> bpt_cmds:
> >>> =09disable
> >>> proc_call:
> >>> =09disable
> >>>
> >>> Signed-off-by: cmr <cmr@informatik.wtf>
> >>
> >> A Fully qualified name should be used.
> >=20
> > What do you mean by fully-qualified here? PPC_XMON_RO? (PPC_)XMON_READO=
NLY?
>=20
> I mean it should be
>=20
> Signed-off-by: Christopher M Riedl <cmr@informatik.wtf>
>=20
> instead of
>=20
> Signed-off-by: cmr <cmr@informatik.wtf>
>=20

Hehe, thanks :)

> >=20
> >>
> >>> ---
> >>>    arch/powerpc/Kconfig.debug |  7 +++++++
> >>>    arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
> >>>    2 files changed, 31 insertions(+)
> >>>
> >>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> >>> index 4e00cb0a5464..33cc01adf4cb 100644
> >>> --- a/arch/powerpc/Kconfig.debug
> >>> +++ b/arch/powerpc/Kconfig.debug
> >>> @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
> >>>    =09  to say Y here, unless you're building for a memory-constraine=
d
> >>>    =09  system.
> >>>   =20
> >>> +config XMON_RO
> >>> +=09bool "Set xmon read-only mode"
> >>> +=09depends on XMON
> >>> +=09default y
> >>
> >> Should it really be always default y ?
> >> I would set default 'y' only when some security options are also set.
> >>
> >=20
> > This is a good point, I based this on an internal Slack suggestion but =
giving this more thought, disabling read-only mode by default makes more se=
nse. I'm not sure what security options could be set though?
> >=20
>=20
> Maybe starting with CONFIG_STRICT_KERNEL_RWX
>=20
> Another point that may also be addressed by your patch is the definition=
=20
> of PAGE_KERNEL_TEXT:
>=20
> #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) ||=20
> defined(CONFIG_BDI_SWITCH) ||\
> =09defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> #define PAGE_KERNEL_TEXT=09PAGE_KERNEL_X
> #else
> #define PAGE_KERNEL_TEXT=09PAGE_KERNEL_ROX
> #endif
>=20
> The above let me think that it would be better if you add a config=20
> XMON_RW instead of XMON_RO, with default !STRICT_KERNEL_RWX
>=20
> Christophe

Thanks! I like that a lot better, this, along with your other suggestions
in the initial review, will be in the next version.
