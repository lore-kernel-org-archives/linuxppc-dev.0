Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 14:31:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AF720714
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 14:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AF720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BF53k0xgLzDrRs
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 00:31:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF4zD5ZbxzDrhp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 00:27:49 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BF4yz68Hxz9v1qF;
 Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2zRZtQ7hFE-t; Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BF4yz57Pnz9v1qD;
 Sun, 26 Jul 2020 16:27:39 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 1FEAB2487; Sun, 26 Jul 2020 16:29:02 +0200 (CEST)
Received: from 37-166-97-133.coucou-networks.fr
 (37-166-97-133.coucou-networks.fr [37.166.97.133]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sun, 26 Jul 2020 16:29:02 +0200
Date: Sun, 26 Jul 2020 16:29:02 +0200
Message-ID: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Randy Dunlap <rdunlap@infradead.org> a =C3=A9crit=C2=A0:

> Drop duplicated words in arch/powerpc/ header files.

How did you detect them ? Do you have some script for tgat, or you=20=20
just=20read all comments ?

>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

You say you Cc Michael, but in fact you don't ... Allthough he is the=20=20
powerpc=20maintainer

Christophe

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
>
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    2 +-
>  arch/powerpc/include/asm/book3s/64/radix-4k.h |    2 +-
>  arch/powerpc/include/asm/cputime.h            |    2 +-
>  arch/powerpc/include/asm/epapr_hcalls.h       |    4 ++--
>  arch/powerpc/include/asm/hw_breakpoint.h      |    2 +-
>  arch/powerpc/include/asm/ppc_asm.h            |    2 +-
>  arch/powerpc/include/asm/reg.h                |    2 +-
>  arch/powerpc/include/asm/smu.h                |    2 +-
>  arch/powerpc/platforms/powernv/pci.h          |    2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)


