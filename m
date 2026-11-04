Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BC606A326
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpACE688
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKVD15fbrz2xSF;
	Thu, 05 Nov 2026 02:46:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793807185;
	cv=none; b=ZFJka5YLJGNAH8oAK4lutnAZZIFjVuXmNS8ViIaRPCtxm57RcQycd6GpaLEIuB/1g8pCnOZcLzG/ssq/L9a3Hi/mRRpRHUv73U8mFcJSZxfy4Cco97B80Pl8VLZdOOXrb4OggUDyQDmD7kBir4EANEJ4fQMBiDd6JkhoYqa1iuBIVlcZpK/X35ln0KViuRtNXbFVa9aJ36SEUGYjuz9/ZuiDl9l22prqanhZaNbbhLJkmQn1R/HZkVxpofKShMkzHLl4I8DukpDRJXgzCkCSBUVqStmdqo/lD9//GFkxcJJXH0cP07Un9hXcnyGLTqmpvP7jFYV+1xoC0NVI5p/btw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793807185; c=relaxed/relaxed;
	bh=xyHstetzZu4XQvPCwnk3jp13Xb8802ZUHS/kaqfC9G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJCH3PuXRJe8D2vweEK9ruAgNpkbjnE/EAzRVoHrJrJNiptnD2qzp8gGHwM2Owq3RwCCb/VsF7YTfqh/kxsGeWrB6IoFyxvGYJSYRJ1LmBst40ubtSVQZ/Z/06MmZ608YM/ixNvs9Cck6Kgwm2Jzo0DrVTIkPYrHAE8BA8vTvRFq/BtpmBHXo0dFO8aFv+ch/VqHCmbKJ85y5/3ZEEA+4vJEObxNubYcPT/vWCeD80TBnlvQoFrz8Zg1idjHO57uPP9zsiLKSoY6vF14I38svZBDCL9+wbkGm2hs2SqbcfCv++7/hUMfcJpX4wLWCXNYGEbqNJZE7Lb3f+Az45Kmmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpACE688; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IpACE688;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKVD03Ywtz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:46:23 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1438d9363fbso645416c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793807180; x=1794411980; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyHstetzZu4XQvPCwnk3jp13Xb8802ZUHS/kaqfC9G0=;
        b=IpACE688Rdqz8HBOspKRQ0E9Jhkyfvzuqxe7Q1bVsoKHu4GaCrEIIpHA0MwEszK4tG
         WM6YHM/GDhGM+xn6tOSsDhX8ZG8gRC8gDE6kvV3JQp8aPinh0QkY0AbEe65lH5SmYbrY
         L+SZo74VHcUX03Sq3ZjQ9OKsmeceulreQTNkaYMZmxzGJPw09IcM3hAySu3CKgilvqpz
         BHyqOOWL2ItTJvJJ6uKpkdYgxEaiCQ1NpFQl0m8lgzcBcNcLdy+we9T24eme7Gh+gGSh
         FI8T7CokOV/8P4chVG8ogzFlciAYeJd6AioDt9Q4kPK3QqqKvc8eiHd8uAIPIDsMG5ME
         2p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793807180; x=1794411980;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyHstetzZu4XQvPCwnk3jp13Xb8802ZUHS/kaqfC9G0=;
        b=wEYrgrIAB+WZw5wO0L2t15fQKPOtIcq1wKab/uUZstfQaWyhVHf3bmAOAJQBH8pIOo
         aM9eJ6vM9oI17zJVjyXB6Wq2ltleNFkFMNgBUFXP4Z/J90t569MNM7shBPHd4MGFeNLD
         9iPweuahJ8a9dbKtgAnmMLi6GEetSOIAPg9T3lAWxecvpB+8NSLtzJ78HWbMzHQL8zfm
         7bteaTmW7d9bN83diBzhRWDs2kb87YhXP3scGv1P+TKsqt8dqVaZ4VDdC+ScfqKF2VVI
         WBoMjhp9LlHji01RZfu4j+lz1Igcw3uUF/gNJvA4Wpoh6iauoB7zSdHn5+tGbyENgFbe
         8/CA==
X-Forwarded-Encrypted: i=1; AKwUvBxDRDTSEqvwTbTvX83LuUWF22SWMawrLEfFphKPxwKhhZFveBlStGIr36ABvuMLYI4k7zSNcWyJH4t5des=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+gTX2/1dQMyfl1U/QNpcENjF2SVJ7yuv3QIsY+S23HuvA6GgG0
	Bdy4nNE6qy0GCBf8jJNWCHGzRTjW3fs0go00rwXq++NZSWhufe2KW0+a
X-Gm-Gg: AYBFou0s5kh2L5Mx0d9iURoex6w04HkTLWY6KBghUtIj5EVSzD9qvOFH5keK8wAasU3
	ppbsKEzby3ySuflJKRNilFQq1zSnY0EL3aJqv6245HzzmElr+ld8mejJSlptj1PN4Jim8IRbVQu
	phFIFj5ygLfpmNjchgXwQ6vezKW0heLA+nq64MEyRYmBGOc8KEXckHvX4kYIKuwlIO94h0uHu3n
	R/J44uHJhJ+Tfs02opng1+Lvv9KpG/CXo3/43Z3GCGp77UvXIlLn4KdYNtNrxua6AuW95JMafZT
	IV3af25baMwBQnK9Vhb2H0vGmd4MO/EhgqOg23lMePBGodvOqmwURbD/XH6ysZbb8gTRSbQ5pmu
	dTV5Kl3P8oMu4xaQs/y0JXd+Skc+BeH/z+pL3I1j+N8tYUSHKoI4cJhxZszrNfutNLO2sUxZoTA
	PoNXnPAYwdb9r0Df9FmECKYGwLv677HQrLfi57maT2yIwFjCCcbWR6YBs/xhTJvHzUFL1S32nXK
	9g9sh+dIroaj0uDRtPWSjwsp43e7oILJwOn8jdd6V1xMPpwzrzvMkwWLX4BJ/VX7xKVeO4E0Aq7
	yqFIKC+BsQ47BHKJrT6mprmjH9FdwYsI7TDly2/5cHP0dC3zoR/Y7KxyA7cDsgy9iTf3pylL/md
	QZzk4REiyKZqG7s9rIpQ=
X-Received: by 2002:a05:7022:c85:b0:14e:d0ba:75af with SMTP id a92af1059eb24-1ac599f5132mr23755659c88.6.1793807180104;
        Wed, 04 Nov 2026 07:46:20 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm12682332c88.17.2026.11.04.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:46:19 -0800 (PST)
Date: Wed, 4 Nov 2026 21:16:11 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de, Vishal Chourasia <vishalc@linux.ibm.com>, 
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH 2/2] KVM: PPC: Replay pending interrupts before entering
 the guest
Message-ID: <autQn0FHsAql9W8l@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-3-sshegde@linux.ibm.com>
 <zevvup51.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zevvup51.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 10:00:50PM +0530, Ritesh Harjani wrote:
> 
> Hi Shrikanth,
> 
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
> > After applying preempt disable patch, i.e PATCH 1/2, Christian reported
> > a subsequent warning stopping his board to boot properly.
> >
> > WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
> > CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
> > Tainted: [W]=WARN
> > Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
> > NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
> > LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
> > Call Trace:
> > [c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
> > [c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c
> >
> > It triggers below warning...
> >
> > static inline void kvmppc_fix_ee_before_entry(void)
> > {
> >         trace_hardirqs_on();
> >
> >         /*
> >          * To avoid races, the caller must have gone directly from having
> >          * interrupts fully-enabled to hard-disabled.
> >          */
> >         WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
> >
> > This happens since kvmppc_prepare_to_enter does first local_irq_disable
> > followed by hard_irq_disable. This leaves a small window where interrupt
> > may occur and it could set the irq pending bit in PACA. When that
> > happens replay that interrupt before entering the guest.
> >
> > Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 9194cf492d1c..847ff07c364b 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
> >  			continue;
> >  		}
> >  
> > +#ifdef CONFIG_PPC64
> > +		/*
> > +		 * Interrupt arrived between the soft and hard
> > +		 * disable. Replay it and retry guest entry.
> > +		 */
> > +		if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
> > +			local_irq_enable();
> > +			local_irq_disable();
> > +			hard_irq_disable();
> > +			continue;
> > +		}
> > +#endif
> > +
> 
> I looked at the commit which causes this regression, I see there are few
> more call sites which can hit the same WARN in kvmppc_fix_ee_before_entry().
> 
> So what I was thinking was - while we are at it - do you think we could
> use the following helper instead of {local|hard}_irq_{disable|enable}()
> pair and ...
> 
> 
> /*
>  * Hard disable interrupts before entering the guest.
>  *
>  * On 64-bit don't use local_irq_disable() here. It only soft-masks, so
>  * an interrupt can still come in before we hard disable. That interrupt
>  * gets marked pending in irq_happened and kvmppc_fix_ee_before_entry()
>  * then throws it away. hard_irq_disable() clears MSR[EE] first and does
>  * the irq tracing itself, so there's no such window.
>  *
>  * On 32-bit there is no soft mask and hard_irq_disable() doesn't do the
>  * irq tracing, so use local_irq_disable().
>  */
> static inline void kvmppc_irq_disable_for_entry(void)
> {
> #ifdef CONFIG_PPC64
>         hard_irq_disable();
> #else
>         local_irq_disable();
> #endif
> }
> 
> ... and then update the other call sites too which the following commit
> added - which can cause the WARN.
>    Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> 
> Thoughts?
> 
Yeah, i also feel this is better to have.
Personally i don't want this ifdef all around the code, It's better to
have it in one place.
There's one more case like this here[1].

[1]https://lore.kernel.org/all/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/

Regards,
Mukesh
> -ritesh
> 
> >  		guest_enter_irqoff();
> >  		return 1;
> >  	}
> > -- 
> > 2.52.0

