Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26657C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:42:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69035217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69035217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443NlR6QcWzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 12:42:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ley.foon.tan@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443NjW3GrRzDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 12:40:40 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2019 17:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; d="scan'208";a="134531155"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.88])
 by FMSMGA003.fm.intel.com with SMTP; 18 Feb 2019 17:40:35 -0800
Received: by ubuntu (sSMTP sendmail emulation); Tue, 19 Feb 2019 09:40:33 +0800
Message-ID: <1550540432.2534.1.camel@intel.com>
Subject: Re: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT
 symbol
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Christoph Hellwig
 <hch@lst.de>
Date: Tue, 19 Feb 2019 09:40:32 +0800
In-Reply-To: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-6-hch@lst.de>
 <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
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
Cc: linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 nios2-dev@lists.rocketboards.org, Ley Foon Tan <lftan@altera.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-15 at 16:55 +0900, Masahiro Yamada wrote:
> +CC: Ley Foon Tan <lftan@altera.com>
> +CC: nios2-dev@lists.rocketboards.org
>=20
>=20
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>=20
> >=20
> > diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> > index 715e6c09b4a5..3b50689007f5 100644
> > --- a/arch/nios2/Kconfig
> > +++ b/arch/nios2/Kconfig
> > @@ -20,6 +20,7 @@ config NIOS2
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select OF_EARLY_FLATTRE=
E
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SOC_BUS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SPARSE_IRQ
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select TRACE_IRQFLAGS_SUPPOR=
T
>=20
> This is a behavior change of nios2.
>=20
> TRACE_IRQFLAGS_SUPPORT was previously 'n',
> and this commit is changing it to 'y'.
>=20
>=20
>=20
>=20
> Strangely, nios2 defines TRACE_IRQFLAGS_SUPPORT twice
> with different default values.
>=20
> In Kconfig, the first one becomes effective.
>=20
> In this case, 'def_bool n' in arch/nios2/Kconfig is used.
> 'def_bool y' in arch/nios2/Kconfig.debug is dead code.
>=20
>=20
> I think this select should be dropped
> to keep the current behavior,
> but I hope the NIOS2 maintainer will give us
> some comments just in case.
>=20
Yes, please drop this patch to keep original behavior.
Thanks.

Regards
Ley Foon
>=20
>=20
>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select USB_ARCH_HAS_HCD=
 if USB_SUPPORT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CPU_NO_EFFICIENT=
_FFS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select ARCH_DISCARD_MEM=
BLOCK
> > @@ -39,9 +40,6 @@ config NO_IOPORT_MAP
> > =C2=A0config FPU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def_bool n
> >=20
> > -config TRACE_IRQFLAGS_SUPPORT
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def_bool n
> > -
> > =C2=A0menu "Kernel features"
> >=20
> > =C2=A0source "kernel/Kconfig.hz"
> > diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> > index f1da8a7b17ff..a8bc06e96ef5 100644
> > --- a/arch/nios2/Kconfig.debug
> > +++ b/arch/nios2/Kconfig.debug
> > @@ -1,8 +1,5 @@
> > =C2=A0# SPDX-License-Identifier: GPL-2.0
> >=20
> > -config TRACE_IRQFLAGS_SUPPORT
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0def_bool y
> > -
> > =C2=A0config EARLY_PRINTK
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Activate early ke=
rnel debugging"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> --
> Best Regards
> Masahiro Yamada
>=20
> ________________________________
>=20
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
