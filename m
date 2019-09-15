Return-Path: <SRS0=7j1c=XK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6FC4CEC7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Sep 2019 17:16:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565F5214D8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Sep 2019 17:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565F5214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46WbcY05vszF4fb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Sep 2019 03:15:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46WbZd3TvgzF4Vq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Sep 2019 03:14:17 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1i9Y1u-00037s-1D; Sun, 15 Sep 2019 12:09:42 -0500
Message-ID: <fb07c36767c1b4c6bacfd4bb0fddf789d248573e.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, galak@kernel.crashing.org
Date: Sun, 15 Sep 2019 12:09:40 -0500
In-Reply-To: <e9437d8c-564e-cc76-e8fd-54e4000c2349@c-s.fr>
References: <b51b96090138aba1920d2cf7c0e0e348667f9a69.1566564560.git.christophe.leroy@c-s.fr>
 <331759c1bcba5797d30f8eace74afb16ac5f3c36.1566564560.git.christophe.leroy@c-s.fr>
 <b201df6242e7f6cebd525e0a301eef2afdb38f30.camel@buserror.net>
 <e9437d8c-564e-cc76-e8fd-54e4000c2349@c-s.fr>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: christophe.leroy@c-s.fr, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 2/2] powerpc/83xx: map IMMR with a BAT.
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-09-14 at 18:51 +0200, Christophe Leroy wrote:
> 
> Le 14/09/2019 à 16:34, Scott Wood a écrit :
> > On Fri, 2019-08-23 at 12:50 +0000, Christophe Leroy wrote:
> > > On mpc83xx with a QE, IMMR is 2Mbytes.
> > > On mpc83xx without a QE, IMMR is 1Mbytes.
> > > Each driver will map a part of it to access the registers it needs.
> > > Some driver will map the same part of IMMR as other drivers.
> > > 
> > > In order to reduce TLB misses, map the full IMMR with a BAT.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > >   arch/powerpc/platforms/83xx/misc.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/platforms/83xx/misc.c
> > > b/arch/powerpc/platforms/83xx/misc.c
> > > index f46d7bf3b140..1e395b01c535 100644
> > > --- a/arch/powerpc/platforms/83xx/misc.c
> > > +++ b/arch/powerpc/platforms/83xx/misc.c
> > > @@ -18,6 +18,8 @@
> > >   #include <sysdev/fsl_soc.h>
> > >   #include <sysdev/fsl_pci.h>
> > >   
> > > +#include <mm/mmu_decl.h>
> > > +
> > >   #include "mpc83xx.h"
> > >   
> > >   static __be32 __iomem *restart_reg_base;
> > > @@ -145,6 +147,14 @@ void __init mpc83xx_setup_arch(void)
> > >   	if (ppc_md.progress)
> > >   		ppc_md.progress("mpc83xx_setup_arch()", 0);
> > >   
> > > +	if (!__map_without_bats) {
> > > +		int immrsize = IS_ENABLED(CONFIG_QUICC_ENGINE) ? SZ_2M :
> > > SZ_1M;
> > 
> > Any reason not to unconditionally make it 2M?  After all, the kernel being
> > built with CONFIG_QUICC_ENGINE doesn't mean that the hardware you're
> > running
> > on has it...
> > 
> 
> Euh .. ok. I didn't see it that way, but you are right.
> 
> Do you think it is not a problem to map 2M even when the quicc engine is 
> not there ? Or should it check device tree instead ?

It should be OK, since it's a guarded mapping.  Unless the IMMR base is not 2M
aligned...

-Scott


