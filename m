Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:46:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CF320880
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aEhSAnK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CF320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444JmZ22YMzDqCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 00:46:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444JkY19rvzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 00:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="aEhSAnK2"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444JkX5gS0z8svg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 00:44:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444JkX5H5gz9s8m; Thu, 21 Feb 2019 00:44:52 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=amarulasolutions.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=andrea.parri@amarulasolutions.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.b="aEhSAnK2"; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444JkW1HmCz9s71
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 00:44:49 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id y185so4762226wmd.1
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 05:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1FaPtUN6X+te83Y4+p98tzajqlQXdAj23kTLzAX63ks=;
 b=aEhSAnK2erJmewTp6jhY5vt3e1otxe+TDSaednmw+wKbWFU6CSCseVZiUZStaT05wQ
 INjei/6byZ4kktPiXIQAMYJjO2Pg3VA3v8jYiym3ONacJ/wQmldLb6D6G3qk/mx7UG5l
 Ji5qzk28Ii4g2ZNN3ZcL9sNmc8C6QEi7J4/3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1FaPtUN6X+te83Y4+p98tzajqlQXdAj23kTLzAX63ks=;
 b=s5DqPKbyI//6i9WyvsrD9FWeX6+ewByvPpcxXQD7nza17tKYsCaW4RkFbl4LDW6a+f
 dNM1WL3TZB+Oth8qw4wy5RsvixYfzbMR7NG89HNtSzZuyhJgBn0Jht5dWOrImTRJpt3R
 mYDxbwbw9NcMiHVJ/kZlWyE2mfXTLzEQeY8I2o/sy4Ui6LrjzuthVQ7vMGMgELlSp8uP
 BPAEUVqAeDSrPRh/g9OQyvwmmBbwqMTloEv7k3r/LwnYbQzyiXvt2NRGmu1G4lgtBeh0
 fnP9gK67yOKfBcmydmIGEZS/2F1TN+0SbmrPxjzDYgEUDWazCF49u9H/0CY0f+QqaLck
 UBKw==
X-Gm-Message-State: AHQUAuYtuiIH4sYx6roJVCx6ulXMiC2/gfmuvTjBS5VdKygdpGkPGOGm
 7l7unyHGzx/0XxQpUXzlS3OWhA==
X-Google-Smtp-Source: AHgI3Ib+VhzbpsxEz7b0+CW/QnoGf5OfKkLgeRQbLFBmNobRfDSRT3DYWKeg/wV6buNd7DslpMop0Q==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr6823987wmj.120.1550670286974; 
 Wed, 20 Feb 2019 05:44:46 -0800 (PST)
Received: from andrea ([89.22.71.151])
 by smtp.gmail.com with ESMTPSA id f4sm13179422wrx.68.2019.02.20.05.44.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 05:44:45 -0800 (PST)
Date: Wed, 20 Feb 2019 14:44:33 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190220134433.GA4932@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
 <87va1e7pw2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va1e7pw2.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linux-arch@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org, tj@kernel.org,
 akpm@linux-foundation.org, dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> >> > > +		 * Order the stores above in vsnprintf() vs the store of the
> >> > > +		 * space below which joins the two strings. Note this doesn't
> >> > > +		 * make the code truly race free because there is no barrier on
> >> > > +		 * the read side. ie. Another CPU might load the uninitialised
> >> > > +		 * tail of the buffer first and then the space below (rather
> >> > > +		 * than the NULL that was there previously), and so print the
> >> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> >> > > +		 * practice it should just see NULLs.
> >> > 
> >> > The comment doesn't say _why_ we need to order these stores: IOW, what
> >> > will or can go wrong without this order?  This isn't clear to me.
> >> >
> >> > Another good practice when adding smp_*-constructs (as discussed, e.g.,
> >> > at KS'18) is to indicate the matching construct/synch. mechanism.
> >> 
> >> Yes, one barrier without a counter-part is suspicious.
> >
> > As is this silence...,
> >
> > Michael, what happened to this patch? did you submit a new version?
> 
> No, I'm just busy, it's the merge window next week :)

Got it.


> 
> I thought the comment was pretty clear, if the stores are observed out
> of order we might print the uninitialised tail.
> 
> And the barrier on the read side would need to be in printk somewhere,
> which is obviously unpleasant.

Indeed.


> 
> >> If the parallel access is really needed then we could define the
> >> current length as atomic_t and use:
> >> 
> >> 	+ atomic_cmpxchg() to reserve the space for the string
> >> 	+ %*s to limit the printed length
> >> 
> >> In the worst case, we would print an incomplete string.
> >> See below for a sample code.
> >
> > Seems worth exploring, IMO; but I'd like to first hear _clear about
> > the _intended semantics (before digging into alternatives)...
> 
> It is not my intention to support concurrent updates of the string. The
> idea is you setup the string early in boot.

Understood, thanks for the clarification.


> 
> The concern with a concurrent reader is simply that the string is dumped
> in the panic path, and you never really know when you're going to panic.
> Even if you only write to the string before doing SMP bringup you might
> still have another CPU go rogue and panic before then.
> 
> But I probably should have just not added the barrier, it's over
> paranoid and will almost certainly never matter in practice.

Oh, well, I can only echo you: if you don't care about the stores being
_observed_ out of order, you could simply remove the barrier; if you do
care, then you need "more paranoid" on the readers side.  ;-)

  Andrea


> 
> cheers
