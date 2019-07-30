Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EDFC32750
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 23:33:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6C8206E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 23:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6C8206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ytCw2plwzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 09:33:32 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yt9s4tH6zDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 09:31:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45yt9s1XFzz8sy4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 09:31:45 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45yt9s1LgKz9sDQ; Wed, 31 Jul 2019 09:31:45 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=131.153.2.44; helo=h3.fbrelay.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from h3.fbrelay.privateemail.com (h3.fbrelay.privateemail.com
 [131.153.2.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45yt9r3BgQz9s00
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Jul 2019 09:31:43 +1000 (AEST)
Received: from MTA-09-4.privateemail.com (mta-09.privateemail.com
 [198.54.127.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 8EEDF80649
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jul 2019 19:31:39 -0400 (EDT)
Received: from MTA-09.privateemail.com (localhost [127.0.0.1])
 by MTA-09.privateemail.com (Postfix) with ESMTP id 0D1AD6004F;
 Tue, 30 Jul 2019 19:31:33 -0400 (EDT)
Received: from APP-04 (unknown [10.20.147.154])
 by MTA-09.privateemail.com (Postfix) with ESMTPA id D5D676003F;
 Tue, 30 Jul 2019 23:31:32 +0000 (UTC)
Date: Tue, 30 Jul 2019 18:31:32 -0500 (CDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <1271264633.409807.1564529492813@privateemail.com>
In-Reply-To: <87ef27us38.fsf@morokweng.localdomain>
References: <20190728125438.1550-1-cmr@informatik.wtf>
 <20190728125438.1550-2-cmr@informatik.wtf>
 <87ef27us38.fsf@morokweng.localdomain>
Subject: Re: [PATCH 1/3] powerpc/spinlocks: Refactor SHARED_PROCESSOR
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
Cc: linuxppc-dev@ozlabs.org, ajd@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> On July 30, 2019 at 4:31 PM Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
> 
> 
> 
> Christopher M. Riedl <cmr@informatik.wtf> writes:
> 
> > Determining if a processor is in shared processor mode is not a constant
> > so don't hide it behind a #define.
> >
> > Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
> > ---
> >  arch/powerpc/include/asm/spinlock.h | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> > index a47f827bc5f1..8631b0b4e109 100644
> > --- a/arch/powerpc/include/asm/spinlock.h
> > +++ b/arch/powerpc/include/asm/spinlock.h
> > @@ -101,15 +101,24 @@ static inline int arch_spin_trylock(arch_spinlock_t *lock)
> >
> >  #if defined(CONFIG_PPC_SPLPAR)
> >  /* We only yield to the hypervisor if we are in shared processor mode */
> > -#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
> >  extern void __spin_yield(arch_spinlock_t *lock);
> >  extern void __rw_yield(arch_rwlock_t *lock);
> >  #else /* SPLPAR */
> >  #define __spin_yield(x)	barrier()
> >  #define __rw_yield(x)	barrier()
> > -#define SHARED_PROCESSOR	0
> >  #endif
> >
> > +static inline bool is_shared_processor(void)
> > +{
> > +/* Only server processors have an lppaca struct */
> > +#ifdef CONFIG_PPC_BOOK3S
> > +	return (IS_ENABLED(CONFIG_PPC_SPLPAR) &&
> > +		lppaca_shared_proc(local_paca->lppaca_ptr));
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> 
> CONFIG_PPC_SPLPAR depends on CONFIG_PPC_PSERIES, which depends on
> CONFIG_PPC_BOOK3S so the #ifdef above is unnecessary:
> 
> if CONFIG_PPC_BOOK3S is unset then CONFIG_PPC_SPLPAR will be unset as
> well and the return expression should short-circuit to false.
> 

Agreed, but the #ifdef is necessary to compile platforms which include
this header but do not implement lppaca_shared_proc(...) and friends.
I can reword the comment if that helps.

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
