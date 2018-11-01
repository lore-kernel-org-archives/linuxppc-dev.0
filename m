Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68861C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 15:31:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41992081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 15:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew7C/SFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41992081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m8Ll4n3qzF3Nv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 02:31:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew7C/SFJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew7C/SFJ"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m8Hn5xfPzF3N8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 02:28:53 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id h4-v6so9490429pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 08:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UQwNdyZs7+NarOfK+icn1dwEf9p2K/3ed2HnMcVT/yY=;
 b=ew7C/SFJ6Ri3Bz6CSG3sxAVqWNf/agXmhpiWebq1zpcRYkwr7tp3dIZQVLRK6OPw1a
 WRMbhYedqjfYTTyn98qQkOyOkfk6t4GlxAu/KFTHCzsiqTslIFFXHqc83+iBxCD5zjhl
 u3h0Qo+EIYaoZ0HxHNf8IWFBQm6Kz8CUixslkxk5KedqD/dGrxqD9K/UsfRudc0H5veq
 05dUpHAjG9s5EvkLwE6RJF3+d4W8bfhgXYGBx4qChVRv3vmE3bJqOPhVpfqbzvPvnp3X
 MTkiJE7E80Is3fAMQWDEQtDQLZeT4OByi4H0ePAPkaFOoruc6sEeWUh0e+FJ3T6ePOd0
 nvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=UQwNdyZs7+NarOfK+icn1dwEf9p2K/3ed2HnMcVT/yY=;
 b=S07uu/+xS2GR6vzmdlBI7HWOpsA114oLT2ANP2m7sDHngLdnVFOKS6VY/51g04V7im
 uVPVKS6Z80a20b6K54O+5JRmU3ntZBGzieyDUWQ2jk/ebUMWlNRPxsTJ3P6AAyQNqPTP
 86O2Rp5iVFJ5RvAA4d1DYMWqk9vXpCqTu9PfYqaKG2TbV7DScg91G9SOPVmeUA/zjNKb
 M/2bGfZ3tupACb2BD//JFbovpEu2ILxat5HLa2y6csmTZPoi66qH4U2amAy6aZYwbBeX
 0olaQ5snkRaOB0NgwwPw9Xv7PFo1mgYzktkOhtbOwNWCIDLQcJxf0Dy6lrC/732RhRLm
 yHEQ==
X-Gm-Message-State: AGRZ1gJcQQG9ecCop5IXr22hxfBWZpKSL1NZI4ORqe8N6Ya4yRPlJeQ4
 fSbi1xy1byYmQimJSteV1Lo=
X-Google-Smtp-Source: AJdET5fmhmqkDC08+8WPv32oJZpErebY8qH/BIp2xCnqI/AxX/IZq4kpeLpsLQtf3LQwsCQQNvGbTg==
X-Received: by 2002:a63:cc51:: with SMTP id
 q17-v6mr7483905pgi.291.1541086131442; 
 Thu, 01 Nov 2018 08:28:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id n65-v6sm1848713pfi.185.2018.11.01.08.28.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Nov 2018 08:28:50 -0700 (PDT)
Date: Thu, 1 Nov 2018 08:28:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181101152849.GC25346@roeck-us.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <291af20b-820e-e848-cf75-730024612117@roeck-us.net>
 <d7fe095d8d1f848b5742a5b3e8cce9f89e0c1c8d.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fe095d8d1f848b5742a5b3e8cce9f89e0c1c8d.camel@hammerspace.com>
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
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "jhogan@kernel.org" <jhogan@kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 01, 2018 at 06:30:08AM +0000, Trond Myklebust wrote:
[ ... ]
> > 
> > For my part I agree that this would be a much better solution. The
> > argument
> > that it is not always absolutely guaranteed that atomics don't wrap
> > doesn't
> > really hold for me because it looks like they all do. On top of that,
> > there
> > is an explicit atomic_dec_if_positive() and
> > atomic_fetch_add_unless(),
> > which to me strongly suggests that they _are_ supposed to wrap.
> > Given the cost of adding a comparison to each atomic operation to
> > prevent it from wrapping, anything else would not really make sense
> > to me.
> 
> That's a hypothesis, not a proven fact. There are architectures out
> there that do not wrap signed integers, hence my question.
> 

If what you say is correct, the kernel is in big trouble on those architectures.
atomic_inc_return() is used all over the place in the kernel with the assumption
that each returned value differs from the previous value (ie the value is used
as cookie, session ID, or for similar purposes).

Guenter
