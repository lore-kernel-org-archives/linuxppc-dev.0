Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB8C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 00:18:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BBA216FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 00:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldb2U3SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BBA216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LsjW591LzF368
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 10:18:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldb2U3SZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldb2U3SZ"; 
 dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lsfm22bpzF2R7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 10:16:31 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id p12-v6so3028001pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 17:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4dTJtLeJSXHln8UoeTCph4jxFW2rLUZ0D9j6Q9gaBrU=;
 b=ldb2U3SZtzh4VMvPpjEU3aSfMVof/YErPV3EJP62E7qOhazR0neHNrGVu77tKodeZu
 zwOz2QHjVOK9SCdEJf940OOgm7pP7VbZhm/wSSQUyFf3EcQBekl7vYtA0M4FxeH9nik6
 GPh6AJezbZbffHiWpOI30Yrr8UWJts416S9/2nf+J79p39wKpuEtBykbYl2Wt9BOC0L6
 IECjpVl5pTwWTW+7fyqDiwR6kskSJ187UpcH73063RehAQFlgIRLY0VFkc/kN0Gi2IYs
 d7ln9rwbMCol3QW+ECynxGlMkjom29UwK/0Hc367K7y5+PVWnDcUCMGmYhaEseZbbCKC
 vaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4dTJtLeJSXHln8UoeTCph4jxFW2rLUZ0D9j6Q9gaBrU=;
 b=HqYWqeA4FF4L2CPMU8qyjakr/2C1aolawgWeDyzZi4kpVIK8mgK9Kdtp0EW070/Gpf
 r4hl1LdXyzAR4lYJM7fZRLXRQAV86XowXZ3KDa28NAv3+WDEhIQ8pxUXFJ2WGTnw0kjT
 hkH434pOHXp9ZgvYLq4xejjZdN/bM/WZ82pnfLfiH+SGCiDcb8WfHHOTJi+4y5+x1/u4
 qKUfIYEv5PjEzxt18vgSbIqq/aWur75kYBAhCu1uDereTZ7KTTwePn7jpQ+DfNvQHSZn
 cmPjPEUeIfypl2xu+GO32y4oai2PFMa60dm/KV+9iOZeC9wK8fc79BgJi582xe6h5Qxj
 vuRA==
X-Gm-Message-State: ABuFfoiJev2cS+PQTHIs9CCiqJl6UH0Hf19xXk1Q0CQQd1ovQQvQFt2G
 +MjtWl/uYg6zLeonB+R+LWE=
X-Google-Smtp-Source: ACcGV63ZDSHBrLyclDWaPMyuZ/orFo2/yCwEoiJmp/gs33E5t+wR9hghugBV8LHGlkmeRLz2lL68rQ==
X-Received: by 2002:a63:2218:: with SMTP id
 i24-v6mr12634333pgi.238.1538093789975; 
 Thu, 27 Sep 2018 17:16:29 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id t84-v6sm5719376pfj.7.2018.09.27.17.16.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Sep 2018 17:16:29 -0700 (PDT)
Date: Fri, 28 Sep 2018 10:16:14 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/64s: reimplement book3s idle code in C
Message-ID: <20180928101614.2ae641e8@roar.ozlabs.ibm.com>
In-Reply-To: <20180926140914.GA2442@aks.ibm>
References: <20180914015240.1506-1-npiggin@gmail.com>
 <20180926140914.GA2442@aks.ibm>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: "Gautham R .
 Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 26 Sep 2018 19:39:14 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> On Fri, Sep 14, 2018 at 11:52:40AM +1000, Nicholas Piggin wrote:
> > +
> > +	/*
> > +	 * On POWER9, SRR1 bits do not match exactly as expected.
> > +	 * SRR1_WS_GPRLOSS (10b) can also result in SPR loss, so
> > +	 * always test PSSCR if there is any state loss.
> > +	 */
> > +	if (likely((psscr & PSSCR_RL_MASK) < pnv_first_hv_loss_level)) {  
> 
> Shouldn't we check PLS field to see if the cpu/core woke up from hv loss ?
> 
> Currently, a cpu requested stop4 (RL=4) and exited from a shallower state
> (PLS=2), SPR's are unecessarily restored.
> 
> We can do something like : 
> 
> #define	PSSCR_PLS_SHIFT		60
> if (likely((psscr & PSSCR_PLS) >> PSSCR_PLS_SHIFT) < pnv_first_hv_loss_level)


Ah, that corresponds with the following existing code?

        /*
         * POWER ISA 3. Use PSSCR to determine if we
         * are waking up from deep idle state
         */
        LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
        ld      r4,ADDROFF(pnv_first_deep_stop_state)(r5)

        /*
         * 0-3 bits correspond to Power-Saving Level Status
         * which indicates the idle state we are waking up from
         */
        mfspr   r5, SPRN_PSSCR
        rldicl  r5,r5,4,60
        li      r0, 0           /* clear requested_psscr to say we're awake */
        std     r0, PACA_REQ_PSSCR(r13)
        cmpd    cr4,r5,r4
        bge     cr4,pnv_wakeup_tb_loss /* returns to caller */

Yes I didn't get that right, good catch.

Thanks,
Nick
