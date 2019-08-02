Return-Path: <SRS0=WT2w=V6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613ADC433FF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56164204EC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56164204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 460W381F21zDr4R
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Aug 2019 01:16:36 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460Vy42ft7zDrBx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2019 01:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 460Vy34sLqz8sfp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2019 01:12:11 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 460Vy32p9hz9sML; Sat,  3 Aug 2019 01:12:11 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.15; helo=mta-05-3.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from MTA-05-3.privateemail.com (mta-05-3.privateemail.com
 [68.65.122.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 460Vy25RXbz9sBF
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Aug 2019 01:12:08 +1000 (AEST)
Received: from MTA-05.privateemail.com (localhost [127.0.0.1])
 by MTA-05.privateemail.com (Postfix) with ESMTP id 1F68E6006D;
 Fri,  2 Aug 2019 11:12:05 -0400 (EDT)
Received: from APP-05 (unknown [10.20.147.155])
 by MTA-05.privateemail.com (Postfix) with ESMTPA id F0B8560065;
 Fri,  2 Aug 2019 15:12:04 +0000 (UTC)
Date: Fri, 2 Aug 2019 10:12:04 -0500 (CDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Message-ID: <850780620.61430.1564758724962@privateemail.com>
In-Reply-To: <877e7vlruk.fsf@concordia.ellerman.id.au>
References: <20190802042233.20835-1-cmr@informatik.wtf>
 <20190802042233.20835-4-cmr@informatik.wtf>
 <877e7vlruk.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH v2 3/3] powerpc/spinlocks: Fix oops in shared-processor
 spinlocks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev59
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
Cc: ajd@linux.ibm.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On August 2, 2019 at 6:38 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> 
> "Christopher M. Riedl" <cmr@informatik.wtf> writes:
> > diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> > index 0a8270183770..6aed8a83b180 100644
> > --- a/arch/powerpc/include/asm/spinlock.h
> > +++ b/arch/powerpc/include/asm/spinlock.h
> > @@ -124,6 +122,22 @@ static inline bool is_shared_processor(void)
> >  #endif
> >  }
> >  
> > +static inline void spin_yield(arch_spinlock_t *lock)
> > +{
> > +	if (is_shared_processor())
> > +		splpar_spin_yield(lock);
> > +	else
> > +		barrier();
> > +}
> ...
> >  static inline void arch_spin_lock(arch_spinlock_t *lock)
> >  {
> >  	while (1) {
> > @@ -132,7 +146,7 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
> >  		do {
> >  			HMT_low();
> >  			if (is_shared_processor())
> > -				__spin_yield(lock);
> > +				spin_yield(lock);
> 
> This leaves us with a double test of is_shared_processor() doesn't it?

Yep, and that's no good. Hmm, executing the barrier() in the non-shared-processor
case probably hurts performance here?
