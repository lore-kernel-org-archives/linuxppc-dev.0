Return-Path: <SRS0=KLET=3K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F838C2D0CE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 11:19:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5480E2253D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 11:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5480E2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4825dj0WPNzDqPl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 22:19:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.36; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0036.hostedemail.com
 [216.40.44.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4825bG4J60zDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 22:16:56 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 791E718224D9C;
 Tue, 21 Jan 2020 11:16:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toys51_3bc2dfa430738
X-Filterd-Recvd-Size: 2336
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Tue, 21 Jan 2020 11:16:50 +0000 (UTC)
Message-ID: <24012ba289823e9e38c2f89116a5f61581ef3909.camel@perches.com>
Subject: Re: [PATCH -next] powerpc/maple: fix comparing pointer to 0
From: Joe Perches <joe@perches.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 21 Jan 2020 03:15:49 -0800
In-Reply-To: <20200121074723.GF3191@gate.crashing.org>
References: <20200121013153.9937-1-chenzhou10@huawei.com>
 <618f58cd46f0e4fd619cb2ee3c76665a28e30f4e.camel@perches.com>
 <20200121074723.GF3191@gate.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Chen Zhou <chenzhou10@huawei.com>, linux-kernel@vger.kernel.org,
 nivedita@alum.mit.edu, paulus@samba.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, allison@lohutok.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-01-21 at 01:47 -0600, Segher Boessenkool wrote:
> On Mon, Jan 20, 2020 at 05:52:15PM -0800, Joe Perches wrote:
> > On Tue, 2020-01-21 at 09:31 +0800, Chen Zhou wrote:
> > > Fixes coccicheck warning:
> > > ./arch/powerpc/platforms/maple/setup.c:232:15-16:
> > > 	WARNING comparing pointer to 0
> > 
> > Does anyone have or use these powerpc maple boards anymore?
> > 
> > Maybe the whole codebase should just be deleted instead.
> 
> This is used for *all* non-Apple 970 systems (not running virtualized),
> not just actual Maple.

OK, then likely this Kconfig description should be updated
(and the http://www.970eval.com link is no longer about powerpc)

$ cat arch/powerpc/platforms/maple/Kconfig
# SPDX-License-Identifier: GPL-2.0
config PPC_MAPLE
	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
	bool "Maple 970FX Evaluation Board"
	select FORCE_PCI
	select MPIC
	select U3_DART
	select MPIC_U3_HT_IRQS
	select GENERIC_TBSYNC
	select PPC_UDBG_16550
	select PPC_970_NAP
	select PPC_NATIVE
	select PPC_RTAS
	select MMIO_NVRAM
	select ATA_NONSTANDARD if ATA
	help
	  This option enables support for the Maple 970FX Evaluation Board.
	  For more information, refer to <http://www.970eval.com>



