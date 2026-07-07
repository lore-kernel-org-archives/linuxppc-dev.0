Return-Path: <linuxppc-dev+bounces-23722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ADFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvnQT6sXKz2xWY;
	Wed, 08 Jul 2026 02:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783443297;
	cv=none; b=PCB8rcWJ4rRFB+Z2/m3s1HrYDvHTcy8+0Ozly7RMrPBKmHh1V9+CtQTQP+AzA/N1il/Z+4fmELpOzARsaE/mMZBVtxrkAJIReGiuue1dTNNbmbf+ZmkzcmG1NKvYVTkDjuERLEkAijpQLBRTcHMuaM6JoZHU+ROTqCVa5Px9vzWnITFPR1aCIjHPN20DSj3gkhjovSWGBzWyG6dAL3dogxjBDvfC+JxWQl9YV0fVdjQAp+qj8Pw4hxdmVLrFjjNfGM9M5myaf0vMCG+5+DFVfYUO4YavMhndkpnrXvYPJLbEolFwp+bB9j9YK7t/sKM+TP4J7z+EYofSQrivJuamzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783443297; c=relaxed/relaxed;
	bh=Ye5iP6eplO6JuSV8wFxL2hD0xSHZS9cJ58szEj1AXLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfO7bUm9lrFF9yrkk2jzp9GoGhF2w/UdBCOht08U7DaDMOIBQ9BanzTO1kdt+DcjITa1DRrJbcl/o63/kmlBRGqdlekboedJ2OgM203B0fGwmd381Gw7qNYs8ht4j6whPWtGF5JoxJ9W6zNiNATWIroOBUpuHM7MqZu0OB0QYOjNaFrhBfJs1viOQAsWOZAcPEXJWwA+aA3M7krOB/WTkEcJvOswS0CVkCLhGjmHOhEaxsITrh21JvynlPJmWMHHSDcU78pJKUJb4j6TN3nPJqAZvlHGRpfQTszkYp9iWueX7zUphjXkp+oM8moyL564Npr8ovpjvi0lp6JLE4qmGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3C2K/Z9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3C2K/Z9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvnQS5J5Yz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:54:56 +1000 (AEST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so4545671a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443294; x=1784048094; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ye5iP6eplO6JuSV8wFxL2hD0xSHZS9cJ58szEj1AXLg=;
        b=F3C2K/Z9RShccnUAZkm4En1pnP+mzA7gRdyc8WGsQ+gckHy76Yhf+Q0gue8luXGpVe
         sxT3CI1+i4AqwkdM8n7M5n6S+0lAPLJVSgeX1Sw7zL7jS6njM2DQ/A9p0RNfsdKWY+qW
         ml5/39lHiFPv/45RIfv4T97OayvNDADsJIXvF+zgxFOPY/1yq9hZzwL/15JVRH4s0yFh
         fhqC7kG+RPGDPh2D+RGr8/vDT1D7NV4Zw6BAIoSRufWS+/cTA4WW2RHqtOGMTZ7b5L04
         s6BPrj/yIEtutAijl6ImAFfwrx9koI8+NLid/HcMwUfQebPkuzYDlo3a6Iw6+YNMif2T
         rdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443294; x=1784048094;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ye5iP6eplO6JuSV8wFxL2hD0xSHZS9cJ58szEj1AXLg=;
        b=egjiqp1/S2gBAC5Ow3xZIpY0t8hUgW/ReygoJ8D4nW0HZWxG/OUJQ58KopfKu4v32e
         dt53lweyS00ddqGXTa1E9zzMX1/rxDq3TOIpTvzhUj4QdD2jnQyuNEXDDyYbT3CN+anY
         o0QhlSdMf0PHWlqeDhbznK60iVpCT343ZBJHgdLXlMDP9BfEQWmafmzRn8m0VP8pcFkv
         gsGcY+zGcQ4wbN7E5bwm/+SneIF02aM7Qe0fDL0VgqRBeqAMruAAe8oZJcSsCiVLFIy/
         43K+1rCJdw4sC47ZkhIsuqRY91TLLrCxZtrcK6MV/W+djEItxA0auqT7kCD085kGf3LU
         8OQA==
X-Forwarded-Encrypted: i=1; AHgh+RrIQ+8PEkL487Y1Hro9s3c1AHFCun+IjF1VNI2Iq75KCaRm6nwwiq+VxIOFIxYbJ8gDy9BZxh815zW/wzc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxl30gFuiaoGskTVUQo2vh+kDM8L9kmPZbqUEW4yANX1wUZ5e9g
	XCU6MhDLAfIntNjgShOmrFgHSy9q21PyqJZP9axUiMgrE+eQXSGgRM+H
X-Gm-Gg: AfdE7cnXgFVU9cI9zdatCPLUIMGvcLnDQr1BfJNLPgslCbSmxnzUjoUmTaqgoK71Jx/
	DUPxG9UTygqY3+4K3khxfdm4UAk1fkvIlM1KVmmKxAG87XqPsOEgucR+MkOc5cSTd/jmmp08s/W
	54GVEwtQ6Pxih7boYSYq01Grv0Pe5mRb/nu/UEDILKVyS+c9pO9MymYSuuLJAuv2j4ugycqvH1s
	/igw1flMmK6oPGodweIo23kuu0oZ00iyxiWfcQpa4PcbdJjppTE8jyK6D30PaNdC1jb+ax3BjOT
	m4uBKMn9ra23nqIFcYSftLK5liE+MqALAkx4ezrfMBTs9MKSYJOwsBS1q5JDcokCp1wqO6AWevJ
	KFvHC6d8mcqJLfURVtUCC148ykIGfe8b5sMBzbb6hnrqVzeF+I1wwzKqNwP+8ziaoNwPbvkSXNi
	U588g0E+cgtWZb3l3KMAISmwjPQzLo3E6LVLHZ98Yj7ZsIvjosO11yz9T2A18A
X-Received: by 2002:a17:90b:540e:b0:37f:ee23:e44d with SMTP id 98e67ed59e1d1-387568018dcmr6219142a91.3.1783443293671;
        Tue, 07 Jul 2026 09:54:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3d66036sm1439058a91.17.2026.07.07.09.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:54:53 -0700 (PDT)
Date: Tue, 7 Jul 2026 22:24:40 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, ryabinin.a.a@gmail.com, 
	glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, thuth@redhat.com, 
	ruanjinjie@huawei.com, akpm@linux-foundation.org, macro@orcam.me.uk, ldv@strace.io, 
	charlie@rivosinc.com, deller@gmx.de, kevin.brodsky@arm.com, ritesh.list@gmail.com, 
	yeoreum.yun@arm.com, agordeev@linux.ibm.com, segher@kernel.crashing.org, 
	mark.rutland@arm.com, ryan.roberts@arm.com, pmladek@suse.com, 
	feng.tang@linux.alibaba.com, peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <ak0uuO-rhItbx9uw@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <87wlvazrdy.fsf@igel.home>
 <1693b268-ee26-4764-871a-5a067ae96080@kernel.org>
 <87wlv9tiyy.fsf@igel.home>
 <akyWi0a69Az59X5Z@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <875x2qu5ay.fsf@igel.home>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x2qu5ay.fsf@igel.home>

On Tue, Jul 07, 2026 at 06:34:45PM +0200, Andreas Schwab wrote:
> On Jul 07 2026, Mukesh Kumar Chaurasiya wrote:
> 
> > diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> > index fc636c42e89a..b6373bae4524 100644
> > --- a/arch/powerpc/include/asm/entry-common.h
> > +++ b/arch/powerpc/include/asm/entry-common.h
> > @@ -286,14 +286,6 @@ static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> >  
> >  static inline void arch_interrupt_async_exit_prepare(struct pt_regs *regs)
> >  {
> > -       /*
> > -        * Adjust at exit so the main handler sees the true NIA. This must
> > -        * come before irq_exit() because irq_exit can enable interrupts, and
> > -        * if another interrupt is taken before nap_adjust_return has run
> > -        * here, then that interrupt would return directly to idle nap return.
> > -        */
> > -       nap_adjust_return(regs);
> > -
> >         arch_interrupt_exit_prepare(regs);
> >  }
> >  
> > diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> > index fb42a664ae54..1b45a49e9bed 100644
> > --- a/arch/powerpc/include/asm/interrupt.h
> > +++ b/arch/powerpc/include/asm/interrupt.h
> > @@ -246,6 +246,7 @@ interrupt_handler void func(struct pt_regs *regs)                   \
> >         instrumentation_begin();                                        \
> >         irq_enter_rcu();                                                \
> >         ____##func (regs);                                              \
> > +       nap_adjust_return(regs);                                        \
> >         irq_exit_rcu();                                                 \
> >         instrumentation_end();                                          \
> >         arch_interrupt_async_exit_prepare(regs);                        \
> 
> This allows the system to boot normally.
> 
Thanks for testing this. I am assuming you tried this without
"powersave=off" command line option.

I'll send out a fix for this.

Regards,
Mukesh
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

