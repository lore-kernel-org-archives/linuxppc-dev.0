Return-Path: <linuxppc-dev+bounces-28722-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBACCA5FD9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:54:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx1JN2Jrfz2yPG;
	Fri, 02 Oct 2026 17:54:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790927652;
	cv=none; b=mcIuaQtS75CfEUZEqLcSDaB7KzVJ1GV1V7h35MAZl4Fq3KMwMwVep2tQMI6XUagiU8TeeG+xIdJF2344/xyRlpqXi+IUz4XZyiMLVO9iKCAANGTCg8NMIh9jG3CXVXRItCuo+JGT3KzmvXBRkR9EiWg9xuzQO+yYnttBe3/MpslBxzKtazrE4ViFgTZCZgkIQ+7vPM4o/LGkMnoigxYUGNOSb28it1tNLSO6nX9oEzH4GXr/UzSj1gs+4fsTzEaP9WKMrfgonMiWhbe2QIYXr0uoRcFXqgLDF31ltwPMT4509HYpICDEP3Sv5I6z6rXH9NxkngFVP4AWEnIj6vbq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790927652; c=relaxed/relaxed;
	bh=Lylx5gDUOY6P1xwCQDD9XcktxCTPN9JgKrsv7vw4XOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBJ8J+nzZ3gF1HlNOllgnxfKTMLae0Ntqrs2U0dSqZ4UZp43+jYP7hru7duqEE42sDSn/u3vh5OpOX9NUuqB5K1/8PaTC0vYC4zDf+HKVR/Y7m9/A/AeskBDEVz7RHRGdJbwS0THY/FQJk9SKh0v9XqOhtRo85KrVYoY7TkLD2QEvmkXRRWbEvO/WxbXeAwrAlw9OTge1DkqZgwNp0ghziHxkqGeQXZV2IIvk3yB0o12sLVkEPe8idWTgAZvO3dxzAdRxAjGo3KCJjNQTUn3bJerKjWQSG/SJu7ssaFVhYvzzPcYaPTY02WMvehdWGi68i3meYUZjmcyX1OToeI1eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V48V3ZpY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V48V3ZpY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx1JM4TnJz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 17:54:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C78454385A;
	Fri,  2 Oct 2026 07:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84BE1F000FF;
	Fri,  2 Oct 2026 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790927649;
	bh=Lylx5gDUOY6P1xwCQDD9XcktxCTPN9JgKrsv7vw4XOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V48V3ZpY6Nbf9/Eq+1C6S8cLK5FswtynAkSnBtswQ4KXSPOvO99YIvwDpbkMLCPUC
	 3GRSfcaNCer7Tdwm0yl2tOpBVirzLHftHfGMTqDPB1UpDBMnidhyAPVqm70/qm0pmP
	 ssY5KA1LybHe6wBuAmLa9BL1BU6IXPD0z/E1D5orn1Qqx1CZwYLCi2cgfKAPJeVO4m
	 unyR75NCzxPEyaMtBt7KXuMWPnBH8/B72yLXVh5zgCuO95XMmlZATZT5JKQzEzJJzK
	 Z7s4sgoHahSzyyL8KLR4nGiPpybcsW63J1NqnmnaUh9vgdpJ5sHsGnthEBrGbphXX8
	 8tfdvKp/0PoeA==
Date: Fri, 2 Oct 2026 00:54:09 -0700
From: Kees Cook <kees@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Bill Wendling <morbo@google.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 09/11] powerpc/papr_scm: Return the string length from
 the sysfs show functions
Message-ID: <202610020052.9EAB79E@keescook>
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-9-kees@kernel.org>
 <9af9f47d-b99e-46d4-bb6c-06d28b037a34@linux.ibm.com>
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
In-Reply-To: <9af9f47d-b99e-46d4-bb6c-06d28b037a34@linux.ibm.com>

On Thu, Oct 01, 2026 at 09:47:56AM +0530, Madhavan Srinivasan wrote:
> 
> On 10/1/26 5:22 AM, Kees Cook wrote:
> > perf_stats_show() and flags_show() build their output with a seq_buf
> > and return seq_buf_used(), which may include the trailing NUL byte
> > when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> > 
> > Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> > 16.1.0:
> > arch/powerpc/platforms/pseries/papr_scm.o
> > 
> > Assisted-by: LLM
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> > index 75da96c08cdd..b03cfd8528f5 100644
> > --- a/arch/powerpc/platforms/pseries/papr_scm.c
> > +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> > @@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
> >   free_stats:
> >   	kfree(stats);
> > -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> > +	return rc ?: (ssize_t)seq_buf_strlen(&s);
> >   }
> >   static DEVICE_ATTR_ADMIN_RO(perf_stats);
> > @@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
> >   	if (seq_buf_used(&s))
> 
> this can also be seq_buf_strlen instead

It could be, yeah. I left it because it seemed be more about "did we
touch this at all?" But it's honestly all the same. I will respin with
it changed too.

> 
> >   		seq_buf_printf(&s, "\n");
> > -	return seq_buf_used(&s);
> > +	return seq_buf_strlen(&s);
> >   }
> >   DEVICE_ATTR_RO(flags);

-- 
Kees Cook

