Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D08C64EBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:58:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B637206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B637206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pzhb67g1zF38l
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 11:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=neuling.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Pzfh0yvTzF38c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 11:57:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 42Pzfg3j5tz9s3T;
 Wed,  3 Oct 2018 11:57:15 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 6F0EFEE78BF; Wed,  3 Oct 2018 11:57:15 +1000 (AEST)
Message-ID: <1c856f829606514986f668af1640e60c1eb54080.camel@neuling.org>
Subject: Re: [PATCH v4] powerpc: Avoid code patching freed init sections
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>, Christophe Leroy
 <christophe.leroy@c-s.fr>
Date: Wed, 03 Oct 2018 11:57:15 +1000
In-Reply-To: <871s98av6p.fsf@igel.home>
References: <20180914011411.3184-1-mikey__14553.8904158913$1536887645$gmane$org@neuling.org>
 <871s98av6p.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
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
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-02 at 23:35 +0200, Andreas Schwab wrote:
> On Sep 14 2018, Michael Neuling <mikey@neuling.org> wrote:
>=20
> > This stops us from doing code patching in init sections after they've
> > been freed.
>=20
> This breaks booting on PowerBook6,7, crashing very early.

Sorry, Can you try?

http://patchwork.ozlabs.org/patch/977195/

Mikey
